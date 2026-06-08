import processing.video.*;
import processing.sound.*;
import java.io.File;

Movie videoAcerto;
Movie videoErro;
PImage som;
PImage[] imgsLetras = new PImage[26];
PImage alfabeto;
PImage wallpaper;
String tela = "inicio";
String resultadoQuiz = "";
BotaoLetra[] botoes = new BotaoLetra[26];
BotaoLetra[] botquiz = new BotaoLetra[3];

String[] letras = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};
SoundFile[] sons = new SoundFile[26];

int[] ordemQuiz = new int[26];
int perguntaAtual = 0;
int acertos = 0;
int[] opcoes = new int[3];
int tempoAnimacao = 0;

// Carregamento
boolean carregando = false;
int tempoCarregamento = 0;
int totalCarregamento = 120; // 2 segundos a 60fps

// Cores vibrantes
color COR_AMARELO   = color(255, 220, 0);
color COR_VERDE     = color(60, 200, 80);
color COR_VERDE_ESC = color(30, 160, 50);
color COR_ROXO      = color(160, 80, 220);
color COR_ROXO_ESC  = color(120, 50, 180);
color COR_VERMELHO  = color(230, 60, 60);
color COR_VERM_ESC  = color(180, 30, 30);
color COR_AZUL      = color(60, 130, 255);
color COR_AZUL_ESC  = color(30, 90, 210);
color COR_BRANCO    = color(255);
color COR_TEXTO_ESC = color(30, 20, 60);

void setup() {
  size(700, 700);
  wallpaper = loadImage("wallpaper_appmultimidea.jpg");
  alfabeto  = loadImage("alfabeto.png");
  som       = loadImage("som.png");
  videoAcerto = new Movie(this, "videoAcerto.mov");
  videoErro   = new Movie(this, "videoErro.mov");

  for (int i = 0; i < 26; i++) {
    imgsLetras[i] = loadImage(letras[i] + letras[i] + ".png");
  }

  for (int i = 0; i < 26; i++) {
    String path = dataPath(letras[i] + ".mp3");
    if (new File(path).exists()) {
      sons[i] = new SoundFile(this, path);
    } else {
      println("Aviso: " + letras[i] + ".mp3 nao encontrado.");
    }
  }

  botoes[0]  = new BotaoLetra(120, 50,  95, 105, 0);
  botoes[1]  = new BotaoLetra(217, 50,  81, 105, 1);
  botoes[2]  = new BotaoLetra(302, 50,  93, 105, 2);
  botoes[3]  = new BotaoLetra(405, 50,  80, 105, 3);
  botoes[4]  = new BotaoLetra(495, 50,  77, 105, 4);
  botoes[5]  = new BotaoLetra(103, 168, 68, 110, 5);
  botoes[6]  = new BotaoLetra(175, 168, 95, 110, 6);
  botoes[7]  = new BotaoLetra(278, 168, 80, 110, 7);
  botoes[8]  = new BotaoLetra(360, 168, 51, 110, 8);
  botoes[9]  = new BotaoLetra(417, 168, 72, 110, 9);
  botoes[10] = new BotaoLetra(500, 168, 90, 110, 10);
  botoes[11] = new BotaoLetra(87,  285, 82, 102, 11);
  botoes[12] = new BotaoLetra(170, 285, 118, 102, 12);
  botoes[13] = new BotaoLetra(290, 285, 110, 102, 13);
  botoes[14] = new BotaoLetra(405, 285, 95, 102, 14);
  botoes[15] = new BotaoLetra(509, 285, 74, 102, 15);
  botoes[16] = new BotaoLetra(68,  390, 97, 125, 16);
  botoes[17] = new BotaoLetra(168, 390, 89, 125, 17);
  botoes[18] = new BotaoLetra(254, 390, 94, 125, 18);
  botoes[19] = new BotaoLetra(351, 390, 76, 125, 19);
  botoes[20] = new BotaoLetra(437, 390, 85, 125, 20);
  botoes[21] = new BotaoLetra(532, 390, 86, 125, 21);
  botoes[22] = new BotaoLetra(120, 522, 150, 114, 22);
  botoes[23] = new BotaoLetra(274, 522, 92, 114, 23);
  botoes[24] = new BotaoLetra(377, 522, 95, 114, 24);
  botoes[25] = new BotaoLetra(477, 522, 90, 114, 25);
  botquiz[0] = new BotaoLetra(125, 400, 144, 200, 0);
  botquiz[1] = new BotaoLetra(279, 400, 144, 200, 1);
  botquiz[2] = new BotaoLetra(433, 400, 144, 200, 2);
}

// Wallpaper com fade escuro — overlay uniforme + gradiente no topo
void desenhaFundo() {
  image(wallpaper, 0, 0, width, height);
  // camada escura uniforme pra reduzir poluicao
  noStroke();
  fill(15, 8, 35, 170);
  rect(0, 0, width, height);
  // gradiente extra no topo
  for (int y = 0; y < 200; y++) {
    float alpha = map(y, 0, 200, 120, 0);
    fill(10, 5, 25, alpha);
    rect(0, y, width, 1);
  }
}

// Botao generico com hover, sombra e texto destacado
void desenhaBotao(float x, float y, float w, float h, String label,
                  color cor, color corHover, color corTexto) {
  boolean hover = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  noStroke();
  fill(0, 90);
  rect(x + 5, y + 5, w, h, 16);
  fill(hover ? corHover : cor);
  rect(x, y, w, h, 16);
  // sombra do texto
  fill(0, 120);
  textAlign(CENTER, CENTER);
  text(label, x + w / 2 + 2, y + h / 2 + 2);
  // texto principal
  fill(corTexto);
  text(label, x + w / 2, y + h / 2);
}

// Botao VOLTAR padrao
void botaoVoltar() {
  textSize(14);
  desenhaBotao(10, 10, 90, 35, "< VOLTAR", COR_VERMELHO, COR_VERM_ESC, COR_BRANCO);
}

void draw() {
  background(30, 20, 60);

  if (carregando) {
    desenhaCarregamento();
    tempoCarregamento++;
    if (tempoCarregamento >= totalCarregamento) {
      carregando = false;
      tempoCarregamento = 0;
      tela = "quiz";
      iniciarQuiz();
    }
    return;
  }

  if (tela.equals("inicio")) {
    desenhaInicio();
  } else if (tela.equals("alfabeto")) {
    desenhaAlfabeto();
  } else if (tela.equals("quiz")) {
    desenhaQuiz();
  } else if (tela.equals("resultado")) {
    desenhaResultado();
  }

  if (tempoAnimacao > 0) {
    tempoAnimacao--;
    if (resultadoQuiz.equals("acerto")) {
      image(videoAcerto, 0, 0, width, height);
    } else {
      image(videoErro, 0, 0, width, height);
    }
    // botao pular video — vermelho grande e destacado
    textSize(20);
    desenhaBotao(width/2 - 90, 360, 180, 50, ">> PULAR",
                 color(200, 40, 40, 240), color(230, 60, 60, 255), COR_BRANCO);
  }
}

// TELA: CARREGAMENTO
void desenhaCarregamento() {
  desenhaFundo();
  float prog = (float) tempoCarregamento / totalCarregamento;

  fill(COR_AMARELO);
  textAlign(CENTER, CENTER);
  textSize(38);
  text("ALFABETO MONSTRUOSO", width / 2, 200);

  // estrelinhas girando
  pushMatrix();
  translate(width / 2, 340);
  for (int i = 0; i < 8; i++) {
    float angulo = TWO_PI / 8 * i + (frameCount * 0.08);
    float raio = 45;
    float px = cos(angulo) * raio;
    float py = sin(angulo) * raio;
    float tamanho = map(i, 0, 7, 8, 18);
    fill(lerpColor(COR_ROXO, COR_AMARELO, (float) i / 7));
    noStroke();
    ellipse(px, py, tamanho, tamanho);
  }
  popMatrix();

  fill(COR_BRANCO);
  textSize(20);
  text("Preparando o quiz...", width / 2, 420);

  float barW = 400;
  float barH = 22;
  float barX = width / 2 - barW / 2;
  float barY = 460;
  noStroke();
  fill(255, 255, 255, 60);
  rect(barX, barY, barW, barH, 11);
  fill(COR_VERDE);
  rect(barX, barY, barW * prog, barH, 11);
}

// TELA: INICIO
void desenhaInicio() {
  desenhaFundo();

  textAlign(CENTER, CENTER);
  textSize(48);
  fill(COR_TEXTO_ESC, 180);
  text("ALFABETO MONSTRUOSO", width / 2 + 3, height / 3 + 3);
  fill(COR_AMARELO);
  text("ALFABETO MONSTRUOSO", width / 2, height / 3);

  fill(COR_BRANCO);
  textSize(18);
  text("Aprenda as letras brincando!", width / 2, height / 3 + 55);

  textSize(22);
  desenhaBotao(width / 2 - 110, 430, 220, 58, "COMECAR",
               COR_VERDE, COR_VERDE_ESC, COR_BRANCO);

  desenhaBotao(width / 2 - 110, 505, 220, 58, "QUIZ",
               COR_ROXO, COR_ROXO_ESC, COR_BRANCO);
}

// TELA: ALFABETO
void desenhaAlfabeto() {
  image(alfabeto, 0, 0, width, height);
  textSize(14);
  botaoVoltar();
}

// TELA: QUIZ
void desenhaQuiz() {
  desenhaFundo();

  fill(COR_BRANCO, 180);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Pergunta " + (perguntaAtual + 1) + " de 26", width / 2, 30);

  float barW = 500;
  float barX = width / 2 - barW / 2;
  noStroke();
  fill(255, 255, 255, 40);
  rect(barX, 45, barW, 10, 5);
  fill(COR_AMARELO);
  rect(barX, 45, barW * ((float) perguntaAtual / 26), 10, 5);

  // botao de som circular maior
  boolean hoverSom = mouseX > 240 && mouseX < 460 && mouseY > 70 && mouseY < 320;
  noStroke();
  fill(0, 70);
  ellipse(width / 2 + 5, 197, 210, 210);
  fill(hoverSom ? COR_AZUL_ESC : COR_AZUL);
  ellipse(width / 2, 192, 205, 205);
  image(som, 252, 105, 165, 165);

  fill(COR_BRANCO);
  textSize(14);
  text("Clique para ouvir", width / 2, 295);

  // opcoes
  for (int i = 0; i < 3; i++) {
    boolean hov = botquiz[i] != null &&
      mouseX > botquiz[i].x && mouseX < botquiz[i].x + botquiz[i].w &&
      mouseY > botquiz[i].y && mouseY < botquiz[i].y + botquiz[i].h;

    noStroke();
    fill(0, 60);
    rect(botquiz[i].x + 4, botquiz[i].y + 4, botquiz[i].w, botquiz[i].h, 18);
    fill(hov ? color(200, 230, 255) : color(255, 255, 255, 220));
    rect(botquiz[i].x, botquiz[i].y, botquiz[i].w, botquiz[i].h, 18);
    image(imgsLetras[opcoes[i]], botquiz[i].x + 4, botquiz[i].y + 4,
          botquiz[i].w - 8, botquiz[i].h - 8);
  }

  textSize(14);
  botaoVoltar();
}

// TELA: RESULTADO
void desenhaResultado() {
  desenhaFundo();

  noStroke();
  fill(255, 255, 255, 30);
  rect(60, 80, 580, 300, 24);

  textAlign(CENTER, CENTER);

  fill(COR_AMARELO);
  textSize(38);
  text("Resultado!", width / 2, 145);

  fill(COR_VERDE);
  textSize(26);
  text("Acertos: " + acertos + " / 26", width / 2, 210);

  fill(COR_VERMELHO);
  textSize(26);
  text("Erros: " + (26 - acertos) + " / 26", width / 2, 260);

  fill(COR_BRANCO);
  textSize(18);
  if (acertos == 26) {
    text("Incrivel! Voce acertou tudo!", width / 2, 330);
  } else if (acertos >= 20) {
    text("Muito bem! Continue assim!", width / 2, 330);
  } else if (acertos >= 13) {
    text("Bom trabalho! Pratique mais um pouco!", width / 2, 330);
  } else {
    text("Nao desista! Tente de novo!", width / 2, 330);
  }

  textSize(20);
  desenhaBotao(width / 2 - 120, 400, 240, 56, "JOGAR NOVAMENTE",
               COR_ROXO, COR_ROXO_ESC, COR_BRANCO);

  desenhaBotao(width / 2 - 120, 472, 240, 56, "VOLTAR AO INICIO",
               COR_AZUL, COR_AZUL_ESC, COR_BRANCO);
}

// LOGICA
void sortearOpcoes() {
  opcoes[0] = ordemQuiz[perguntaAtual];
  do { opcoes[1] = int(random(26)); } while (opcoes[1] == opcoes[0]);
  do { opcoes[2] = int(random(26)); } while (opcoes[2] == opcoes[1] || opcoes[2] == opcoes[0]);

  int i = int(random(3)); int temp = opcoes[0]; opcoes[0] = opcoes[i]; opcoes[i] = temp;
  int k = int(random(3)); int tempk = opcoes[1]; opcoes[1] = opcoes[k]; opcoes[k] = tempk;
  int m = int(random(3)); int tempm = opcoes[2]; opcoes[2] = opcoes[m]; opcoes[m] = tempm;
}

void iniciarQuiz() {
  for (int i = 0; i < 26; i++) ordemQuiz[i] = i;
  for (int i = 25; i > 0; i--) {
    int j = int(random(i + 1));
    int temp = ordemQuiz[i]; ordemQuiz[i] = ordemQuiz[j]; ordemQuiz[j] = temp;
  }
  perguntaAtual = 0;
  acertos = 0;
  sortearOpcoes();
}

// MOUSE
void mousePressed() {
  // bloqueia cliques durante o video, exceto no botao pular
  if (tempoAnimacao > 0) {
    if (mouseX > width/2 - 90 && mouseX < width/2 + 90 && mouseY > 360 && mouseY < 410) {
      tempoAnimacao = 0;
      if (resultadoQuiz.equals("acerto")) {
        videoAcerto.stop();
      } else {
        videoErro.stop();
      }
    }
    return;
  }

  if (tela.equals("inicio")) {
    if (mouseX > width/2 - 110 && mouseX < width/2 + 110 && mouseY > 430 && mouseY < 488) {
      tela = "alfabeto";
    } else if (mouseX > width/2 - 110 && mouseX < width/2 + 110 && mouseY > 505 && mouseY < 563) {
      carregando = true;
      tempoCarregamento = 0;
    }

  } else if (tela.equals("alfabeto")) {
    if (mouseX > 10 && mouseX < 100 && mouseY > 10 && mouseY < 45) {
      tela = "inicio";
    } else {
      verificarCliqueLetra();
    }

  } else if (tela.equals("quiz")) {
    if (mouseX > 10 && mouseX < 100 && mouseY > 10 && mouseY < 45) {
      tela = "inicio";
    } else if (mouseX > 240 && mouseX < 460 && mouseY > 70 && mouseY < 320) {
      sons[ordemQuiz[perguntaAtual]].stop();
      sons[ordemQuiz[perguntaAtual]].play();
    } else {
      for (int i = 0; i < 3; i++) {
        if (botquiz[i] != null && botquiz[i].foiClicado(mouseX, mouseY)) {
          if (opcoes[i] == ordemQuiz[perguntaAtual]) {
            acertos++;
            resultadoQuiz = "acerto";
            tempoAnimacao = 40;
            videoAcerto.jump(0);
            videoAcerto.play();
          } else {
            resultadoQuiz = "erro";
            tempoAnimacao = 60;
            videoErro.jump(0);
            videoErro.play();
          }
          perguntaAtual++;
          if (perguntaAtual >= 26) {
            tela = "resultado";
            perguntaAtual = 0;
            return;
          }
          sortearOpcoes();
          break;
        }
      }
    }

  } else if (tela.equals("resultado")) {
    if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > 400 && mouseY < 456) {
      carregando = true;
      tempoCarregamento = 0;
    } else if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > 472 && mouseY < 528) {
      tela = "inicio";
    }
  }
}

void verificarCliqueLetra() {
  for (int i = 0; i < 26; i++) {
    if (botoes[i] != null && botoes[i].foiClicado(mouseX, mouseY)) {
      if (sons[i] != null) {
        sons[i].stop();
        sons[i].play();
      }
      println("Letra: " + letras[i].toUpperCase());
      break;
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}


class BotaoLetra {
  float x, y, w, h;
  int indice;

  BotaoLetra(float x, float y, float w, float h, int indice) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.indice = indice;
  }

  boolean foiClicado(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}
