import processing.video.*;
import processing.sound.*;
import java.io.File;


Movie videoAcerto;
Movie videoErro;
PImage som;
PImage[] imgsLetras = new PImage[26];
PImage alfabeto;
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


void setup() {
  size(700, 700);
  alfabeto = loadImage("alfabeto.png");
  som = loadImage("som.png");
  videoAcerto = new Movie(this,"videoAcerto.mov");
  videoErro = new Movie(this,"videoErro.mov");
  
  for (int i = 0; i < 26; i++) {
    imgsLetras[i] = loadImage(letras[i] + letras[i] + ".png");
  }
  
  for (int i = 0; i < 26; i++) {
    String path = dataPath(letras[i] + ".mp3");
    if (new File(path).exists()) {
      sons[i] = new SoundFile(this, path);
    } else {
      println("Aviso: " + letras[i] + ".mp3 não encontrado.");
    }
  }

  botoes[0]  = new BotaoLetra(120, 50,  95, 105, 0);  // A
  botoes[1]  = new BotaoLetra(217, 50,  81, 105, 1);  // B
  botoes[2]  = new BotaoLetra(302, 50,  93, 105, 2);  // C
  botoes[3]  = new BotaoLetra(405, 50,  80, 105, 3);  // D
  botoes[4]  = new BotaoLetra(495, 50,  77, 105, 4);  // E
  botoes[5]  = new BotaoLetra(103, 168, 68, 110, 5);  // F
  botoes[6]  = new BotaoLetra(175, 168, 95, 110, 6);  // G
  botoes[7]  = new BotaoLetra(278, 168, 80, 110, 7);  // H
  botoes[8]  = new BotaoLetra(360, 168, 51, 110, 8);  // I
  botoes[9]  = new BotaoLetra(417, 168, 72, 110, 9);  // J
  botoes[10] = new BotaoLetra(500, 168, 90, 110, 10); // K
  botoes[11] = new BotaoLetra(87,  285, 82, 102, 11); // L
  botoes[12] = new BotaoLetra(170, 285, 118, 102, 12); // M
  botoes[13] = new BotaoLetra(290, 285, 110, 102, 13); // N
  botoes[14] = new BotaoLetra(405, 285, 95, 102, 14); // O
  botoes[15] = new BotaoLetra(509, 285, 74, 102, 15); // P
  botoes[16] = new BotaoLetra(68,  390, 97, 125, 16); // Q
  botoes[17] = new BotaoLetra(168, 390, 89, 125, 17); // R
  botoes[18] = new BotaoLetra(254, 390, 94, 125, 18); // S
  botoes[19] = new BotaoLetra(351, 390, 76, 125, 19); // T
  botoes[20] = new BotaoLetra(437, 390, 85, 125, 20); // U
  botoes[21] = new BotaoLetra(532, 390, 86, 125, 21); // V
  botoes[22] = new BotaoLetra(120, 522, 150, 114, 22); // W
  botoes[23] = new BotaoLetra(274, 522, 92, 114, 23); // X
  botoes[24] = new BotaoLetra(377, 522, 95, 114, 24); // Y
  botoes[25] = new BotaoLetra(477, 522, 90, 114, 25); // Z
  botquiz[0] = new BotaoLetra(125, 400, 144, 200, 0); // Botão 1
  botquiz[1] = new BotaoLetra(279, 400, 144, 200, 1); // Botão 2
  botquiz[2] = new BotaoLetra(433, 400, 144, 200, 2); // Botão 3
}



void draw() {
  background(255);
 
  if (tela.equals("inicio")) {
    desenhaInicio();
  } else if (tela.equals("alfabeto")) {
    desenhaAlfabeto();
  } else if (tela.equals("quiz")) {
    desenhaQuiz();
  } else if (tela.equals("resultado")){
    desenhaResultado();
  }
  
  if (tempoAnimacao > 0){
  tempoAnimacao--;
  if (resultadoQuiz.equals("acerto")){
  image(videoAcerto, 0, 0, width, height);;
  } else{
  image(videoErro, 0, 0, width, height);
   }
  
  }
  
   fill(0);
  textSize(12);
  textAlign(LEFT);
  text(mouseX + ", " + mouseY, mouseX + 5, mouseY - 5);
  
}

void desenhaInicio() {
  textAlign(CENTER, CENTER);
  fill(50, 50, 200);
  textSize(50);
  text("ALFABETO MONSTRUOSO", width/2, height/3);
 
  // Botão Começar
  fill(100, 200, 100);
  rect(width/2 - 100, 450, 200, 60, 20);
  fill(255);
  textSize(25);
  text("COMEÇAR", width/2, 480);
  
  // Botão Quiz
  fill(200,100,200);
  rect(width/2 - 100, 530, 200, 60, 20);
  fill(255);
  textSize(25);
  text("Quiz", width/2, 560);
  
}

void mostrarGradesAL(){
  noFill();
  stroke(255,0,0,155);
  
  for (int i = 0; i<26; i ++){ 
    if (botoes[i] != null){
      rect(botoes[i].x, botoes[i].y, botoes[i].w, botoes[i].h);
    
    
    }
   }
}


void mostrarGradesQU(){
  noFill();
  stroke(255,0,0,155);
  
  for (int i = 0; i<3; i ++){ 
    if (botquiz[i] != null){
      rect(botquiz[i].x, botquiz[i].y, botquiz[i].w, botquiz[i].h);
    
    
    }
   }
}

void desenhaAlfabeto() {
  image(alfabeto, 0, 0, width, height);
 
  // Botão Voltar
  fill(255, 100, 100);
  rect(10, 10, 80, 35, 10);
  fill(255);
  textSize(15);
  text("VOLTAR", 23, 32);
  //mostrarGradesQU();
  

}

void desenhaQuiz() {
  image (som, 260, 110, 150,150);
  
  // Botão Voltar
  fill(255, 100, 100);
  rect(10, 10, 80, 35, 10);
  fill(255);
  textSize(15);
  text("VOLTAR", 23, 32);
  
  //mostrarGradesQU();
  
  image(imgsLetras[opcoes[0]], botquiz[0].x, botquiz[0].y, botquiz[0].w, botquiz[0].h);
  image(imgsLetras[opcoes[1]], botquiz[1].x, botquiz[1].y, botquiz[1].w, botquiz[1].h);
  image(imgsLetras[opcoes[2]], botquiz[2].x, botquiz[2].y, botquiz[2].w, botquiz[2].h);
  
  
  
} 

void sortearOpcoes(){
   
  opcoes[0] = ordemQuiz[perguntaAtual];
  do {
    opcoes[1] = int(random(26));
  } while (opcoes[1] == opcoes [0]);
  
  do {
    opcoes[2] = int(random(26));
  } while (opcoes[2] == opcoes[1] || opcoes[2] == opcoes[0]);
    
    int i = int(random(3));
    int temp = opcoes[0];
    opcoes[0] = opcoes[i];
    opcoes[i] = temp;
    
    int k = int(random(3));
    int tempk = opcoes[1];
    opcoes[1] = opcoes[k];
    opcoes[k] = tempk;
    
    int m = int(random(3));
    int tempm = opcoes[2];
    opcoes[2] = opcoes[m];
    opcoes[m] = tempm;
    
  } 
  
  


void iniciarQuiz(){
  
  for (int i = 0; i < 26; i++){
    ordemQuiz[i] = i;
  }
  
  for (int i = 25; i >0; i--){
    int j = int (random(i+1));
    int temp = ordemQuiz[i];
    ordemQuiz[i] = ordemQuiz[j];
    ordemQuiz[j] = temp;
    }
    perguntaAtual = 0;
    acertos = 0;
  sortearOpcoes();
}

void desenhaResultado(){
  fill(0);
  textSize(30);
  text("Você acertou: " + acertos + " respostas!", 50, 70);
  text("Você errou:" + (26 - acertos) + " respostas", 50, 110);
  
  //Botão voltar ao inicio
  fill(100, 200, 100);
  rect(width/2 - 100, 450, 200, 60, 20);
  fill(255);
  textSize(22);
  text("Voltar ao inicio", 265, 485);
  
  // Botão jogar novamente
  fill(200,100,200);
  rect(width/2 - 100, 530, 200, 60, 20);
  fill(255);
  textSize(22);
  text("Jogar novamente", 265, 565);

}
  


void mousePressed() {
  if (tela.equals("inicio")) {
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > 450 && mouseY < 510) {
      tela = "alfabeto";
    } else if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > 530 && mouseY < 560) {
      tela = "quiz";
      iniciarQuiz();
    }
  } else if (tela.equals("alfabeto")) {
    if (mouseX > 10 && mouseX < 90 && mouseY > 10 && mouseY < 45) {
      tela = "inicio";
    } else {
      verificarCliqueLetra();
    }
  } else if (tela.equals("quiz")) {
    if (mouseX > 10 && mouseX < 90 && mouseY > 10 && mouseY < 45) {
      tela = "inicio";
    } else if (mouseX > 260 && mouseX < 410 && mouseY > 110 && mouseY < 260) {
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
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > 450 && mouseY < 510) {
      tela = "inicio";
    } else if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > 530 && mouseY < 560) {
      tela = "quiz";
      iniciarQuiz();
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



void movieEvent(Movie m){
    m.read();
}


class BotaoLetra {
  float x, y, w, h;
  int indice;
  
  BotaoLetra(float x, float y, float w, float h, int indice){
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.indice = indice;
}

    
  boolean foiClicado(float mx, float my){
    
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}
