/* =======================================================================
   CONFIGURAÇÃO MQTT (para receber dados reais do ESP-32 no Wokwi)
   -----------------------------------------------------------------------
   Como funciona:
   - O ESP-32 publica o nível de água (0 a 100) em um tópico MQTT.
   - Esta página se inscreve nesse tópico e atualiza os bueiros em tempo real.
   - Tópico por bueiro: smartcity/bueiro/1, smartcity/bueiro/2, smartcity/bueiro/3
   - Payload esperado: apenas o número do nível, ex: "75"
   Troque o broker/tópico abaixo conforme o seu projeto.
   ======================================================================= */
const MQTT_BROKER = "wss://broker.hivemq.com:8884/mqtt"; // broker público de teste
const MQTT_TOPICO_BASE = "smartcity/bueiro"; // .../1 .../2 .../3

// Acima deste nível o bueiro mostra o alerta amarelo "!" no mapa.
const LIMITE_ATENCAO = 50;

// Nível de cada bueiro (0 a 100). Começa em 0.
const niveis = { 1: 0, 2: 0, 3: 0 };

let bueiroSelecionado = null; // id do bueiro aberto no popup

/* ----------------- ESCALA DA CIDADE (preencher a tela) ----------------- */
// A cidade tem tamanho-base 560x560. Aqui calculamos um "scale" para que ela
// ocupe o máximo possível do espaço disponível, mantendo-se quadrada.
const CIDADE_BASE = 700;
const cidadeEl = document.getElementById("cidade");
const cidadeWrapper = document.getElementById("cidadeWrapper");

function ajustarEscalaCidade() {
  const espacoPainel = 320 + 40; // largura do painel + gap entre eles
  const margem = 60;             // respiro nas bordas
  const disponivelLargura = window.innerWidth - espacoPainel - margem;
  const disponivelAltura = window.innerHeight - 150; // desconta título/padding

  let escala = Math.min(disponivelLargura / CIDADE_BASE, disponivelAltura / CIDADE_BASE);
  escala = Math.max(0.5, escala); // nunca menor que isso

  cidadeEl.style.transform = "scale(" + escala + ")";
  cidadeWrapper.style.width = CIDADE_BASE * escala + "px";
  cidadeWrapper.style.height = CIDADE_BASE * escala + "px";
}

window.addEventListener("resize", ajustarEscalaCidade);
ajustarEscalaCidade();

/* ----------------- ATUALIZAÇÃO VISUAL ----------------- */
function atualizarBueiro(id, valor) {
  valor = Math.max(0, Math.min(100, Math.round(valor)));
  niveis[id] = valor;

  const el = document.querySelector('.bueiro[data-id="' + id + '"]');
  if (el) {
    el.classList.toggle("cheio", valor > 0);               // anel azul quando tem água
    el.classList.toggle("atencao", valor >= LIMITE_ATENCAO); // "!" amarelo de 50% pra cima
  }

  atualizarListaPainel(id, valor);

  // se o popup deste bueiro estiver aberto, atualiza em tempo real
  if (bueiroSelecionado === id) renderizarPopup(id);
}

function atualizarListaPainel(id, valor) {
  const item = document.querySelector('.lista-item[data-id="' + id + '"]');
  if (!item) return;
  item.querySelector(".valor").textContent = valor + "%";
  const ponto = item.querySelector(".ponto");
  ponto.classList.toggle("cheio", valor > 0 && valor < LIMITE_ATENCAO);
  ponto.classList.toggle("atencao", valor >= LIMITE_ATENCAO);
}

function renderizarPopup(id) {
  const valor = niveis[id];
  document.getElementById("popupTitulo").textContent = "Bueiro " + id;
  document.getElementById("popupNivel").textContent = valor + "%";
  document.getElementById("popupAgua").style.height = valor + "%";

  // posiciona a knob horizontal de acordo com o nível
  document.getElementById("knobPreenchido").style.width = valor + "%";
  document.getElementById("knobPuxador").style.left = valor + "%";

  const alerta = document.getElementById("popupAlerta");
  if (valor >= 80) {
    alerta.className = "alerta perigo";
    alerta.textContent = "Risco de alagamento! Nível crítico.";
  } else if (valor <= 30) {
    alerta.className = "alerta ok";
    alerta.textContent = "Nível normal.";
  } else {
    alerta.className = "alerta";
    alerta.textContent = "";
  }
}

/* ----------------- POPUP (abrir/fechar) ----------------- */
document.querySelectorAll(".bueiro").forEach(function (b) {
  b.addEventListener("click", function () {
    bueiroSelecionado = parseInt(b.dataset.id, 10);
    renderizarPopup(bueiroSelecionado);
    document.getElementById("overlay").classList.add("aberto");
  });
});

document.getElementById("btnFechar").addEventListener("click", fecharPopup);
document.getElementById("overlay").addEventListener("click", function (e) {
  if (e.target.id === "overlay") fecharPopup();
});
function fecharPopup() {
  document.getElementById("overlay").classList.remove("aberto");
  bueiroSelecionado = null;
}

/* ----------------- KNOB HORIZONTAL (controla só o bueiro aberto) ----------------- */
const knobH = document.getElementById("knobH");
let arrastandoKnob = false;

function setNivelPelaPosicao(clientX) {
  if (bueiroSelecionado === null) return;
  const rect = knobH.getBoundingClientRect();
  let pct = ((clientX - rect.left) / rect.width) * 100;
  pct = Math.max(0, Math.min(100, pct));
  atualizarBueiro(bueiroSelecionado, pct);
}

knobH.addEventListener("pointerdown", function (e) {
  arrastandoKnob = true;
  knobH.setPointerCapture(e.pointerId);
  setNivelPelaPosicao(e.clientX);
});
knobH.addEventListener("pointermove", function (e) {
  if (arrastandoKnob) setNivelPelaPosicao(e.clientX);
});
knobH.addEventListener("pointerup", function () { arrastandoKnob = false; });
knobH.addEventListener("pointercancel", function () { arrastandoKnob = false; });

/* ----------------- CONEXÃO MQTT (ESP-32) ----------------- */
const bolinha = document.getElementById("bolinhaStatus");
const textoStatus = document.getElementById("textoStatus");

try {
  const client = mqtt.connect(MQTT_BROKER);

  client.on("connect", function () {
    bolinha.classList.add("online");
    textoStatus.textContent = "ESP-32: conectado (recebendo sensor)";
    client.subscribe(MQTT_TOPICO_BASE + "/+");
  });

  client.on("message", function (topico, mensagem) {
    // topico ex: smartcity/bueiro/2  | mensagem ex: "75"
    const partes = topico.split("/");
    const id = parseInt(partes[partes.length - 1], 10);
    const valor = parseFloat(mensagem.toString());
    if ([1, 2, 3].includes(id) && !isNaN(valor)) {
      atualizarBueiro(id, valor);
    }
  });

  client.on("error", function () {
    bolinha.classList.remove("online");
    textoStatus.textContent = "ESP-32: erro de conexão (modo manual)";
  });

  client.on("close", function () {
    bolinha.classList.remove("online");
    textoStatus.textContent = "ESP-32: desconectado (modo manual)";
  });
} catch (e) {
  textoStatus.textContent = "ESP-32: MQTT indisponível (modo manual)";
}
