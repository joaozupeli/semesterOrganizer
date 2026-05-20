PImage alfabeto;
String tela = "inicio"; // "inicio", "alfabeto", "quiz"

// --- Botões da tela inicial ---
float btn1X = 300, btn1Y = 400, btnW = 200, btnH = 60;
float btn2X = 300, btn2Y = 500;

void setup() {
  size(1000, 1000);
  alfabeto = loadImage("alfabeto.png");
}

void draw() {
  background(255);
  
  if (tela.equals("inicio"))   desenhaInicio();
  if (tela.equals("alfabeto")) desenhaAlfabeto();
  if (tela.equals("quiz"))     desenhaQuiz();
}

// ---- TELA INICIAL ----
void desenhaInicio() {
  textAlign(CENTER);
  textSize(40);
  fill(0);
  text("Aprenda o Alfabeto!", width / 2, 200);

  // Botão Alfabeto
  fill(100, 180, 100);
  rect(btn1X, btn1Y, btnW, btnH, 10);
  fill(255);
  textSize(22);
  text("Alfabeto", btn1X + btnW / 2, btn1Y + btnH / 2 + 8);

  // Botão Quiz
  fill(100, 100, 200);
  rect(btn2X, btn2Y, btnW, btnH, 10);
  fill(255);
  text("Quiz", btn2X + btnW / 2, btn2Y + btnH / 2 + 8);
}

// ---- TELA ALFABETO ----
void desenhaAlfabeto() {
  image(alfabeto, 0, 0, width, height); // imagem ocupa a tela toda
  
  // Botão voltar
  fill(200, 80, 80);
  rect(20, 20, 120, 45, 8);
  fill(255);
  textSize(18);
  textAlign(CENTER);
  text("Voltar", 80, 48);
}

// ---- TELA QUIZ ----
void desenhaQuiz() {
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("Quiz em construção!", width / 2, height / 2);

  fill(200, 80, 80);
  rect(20, 20, 120, 45, 8);
  fill(255);
  textSize(18);
  text("Voltar", 80, 48);
}

// ---- CLIQUES ----
void mousePressed() {
  if (tela.equals("inicio")) {
    if (clicouEm(btn1X, btn1Y, btnW, btnH)) tela = "alfabeto";
    if (clicouEm(btn2X, btn2Y, btnW, btnH)) tela = "quiz";
  }
  
  if (tela.equals("alfabeto") || tela.equals("quiz")) {
    if (clicouEm(20, 20, 120, 45)) tela = "inicio"; // botão voltar
  }
}

// Função auxiliar de detecção de clique
boolean clicouEm(float x, float y, float w, float h) {
  return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
}
