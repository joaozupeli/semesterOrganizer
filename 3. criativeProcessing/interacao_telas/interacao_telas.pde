int svar = 1;
boolean mouseClick = false;

void setup(){
  size(400,400);
}

void draw(){
  if (svar==1) tela1(); // principal
  if (svar==2) tela2(); // 1º nível
  if (svar==3) tela3(); // 1º nível
  if (svar==4) tela4(); // 1º nível
  
  if (svar==21) tela21(); // 2º nível, associada a tela 2
  if (svar==22) tela22(); // 2º nível, associada a tela 2
  
  if (svar==31) tela31(); // 3º nível, associada a tela 31
  if (svar==32) tela32(); // 3º nível, associada a tela 32
  if (svar==33) tela33(); // 3º nível, associada a tela 33
  if (svar==34) tela34(); // 3º nível, associada a tela 34
}

void tela1(){
  // botões tela 1
  fill(255,0,0);     rect(0,360, 100,40);    fill(0);   text("01",  10,390);
  fill(0,255,0);     rect(100,360,100,40);   fill(0);   text("02", 110,390);
  fill(0,0,255);     rect(200,360,100,40);   fill(0);   text("03", 210,390);
  fill(255,128,128); rect(300,360,100,40);   fill(0);   text("04", 310,390);
  // fundo tela 1
  fill(255,0,0);   rect(0,0,width, height-40); fill(0); text("TELA 1", 100,50);
  // interação válida na tela 1, 2, 3 e 4
  if(mousePressed) {
    if((mouseX<100)&&(mouseY>360)) svar=1;
    if((mouseX>100)&&(mouseX<200)&&(mouseY>360)) svar=2;
    if((mouseX>200)&&(mouseX<300)&&(mouseY>360)) svar=3;
    if((mouseX>300)&&(mouseX<400)&&(mouseY>360)) svar=4;   
  }
}

void tela2(){
  // fundo tela 2
  fill(0,255,0);       rect(0,0,width, height-40); fill(0);   text("TELA 2", 100,50);
  // botões tela 2
  fill(255,255,0);     rect(0,320, 100,40);        fill(0);   text("02.01",  10,350);
  fill(0,255,255);     rect(100,320,100,40);       fill(0);   text("02.02", 110,350); 
  fill(255,0,0);       rect(200,320, 100,40);      fill(0);   text("Voltar",  210,350);
  // cobre o menu anterior
  fill(0,255,0);       rect(0,360,width, 40);  
  // interação válida na tela 2 - é preciso mudar as coordendas, pois como o processo é rápido, o botão 
  // da tela seguinte nas mesmas coordendas continuna valendo.
  if(mousePressed) {
    if((mouseX<100)&&(mouseY>320)&&(mouseY>320)&&(mouseY<360)) svar=21;
    if((mouseX>100)&&(mouseX<200)&&(mouseY>320)&&(mouseY<360)) svar=22; 
    if((mouseX>200)&&(mouseX<300)&&(mouseY>320)&&(mouseY<360)) svar=1; // volta um nível, de 2 para 1
  }
}

void tela3(){
  // fundo tela 3
  fill(0,0,255);   rect(0,0,width, height-40); fill(0); text("TELA 3", 100,50);
  // interação válida na tela 1, 3 e 4
  if(mousePressed) {
    if((mouseX<100)&&(mouseY>360)) svar=31;

  }
}

// as funções para as subtelas 2.x usam o mesmo código da função tela2()
// a única mudança é na atribuição do valor específico para a variável svar
void tela31(){
  fill(0,0,255);       rect(0,0,width, height-40); fill(0);   text("TELA 3.1", width/2,height/2);
  fill(255,0,0);       rect(0,360, 100,40);     fill(0);   text("<<",  10,380);
  fill(255,128,128);   rect(300,360,100,40);    fill(0);   text(">>", 310,380);
    if(mouseClick) {
    mouseClick = false;
    if((mouseX<100)&&(mouseY>360)) svar=3;
    if((mouseX>300)&&(mouseY>360)) svar=32;   
  }
}
void tela32(){
  fill(0,0,255);       rect(0,0,width, height-40); fill(0);   text("TELA 3.2", width/2,height/2);
  fill(255,0,0);       rect(0,360, 100,40);     fill(0);   text("<<",  10,380);
  fill(255,128,128);   rect(300,360,100,40);    fill(0);   text(">>", 310,380);
    if(mouseClick) {
    mouseClick = false;
    if((mouseX<100)&&(mouseY>360)) svar=31;
    if((mouseX>300)&&(mouseY>360)) svar=33;   
  }
}
void tela33(){
  fill(0,0,255);       rect(0,0,width, height-40); fill(0);   text("TELA 3.3", width/2,height/2);
  fill(255,0,0);       rect(0,360, 100,40);     fill(0);   text("<<",  10,380);
  fill(255,128,128);   rect(300,360,100,40);    fill(0);   text(">>", 310,380);
    if(mouseClick) {
    mouseClick = false;
    if((mouseX<100)&&(mouseY>360)) svar=32;
    if((mouseX>300)&&(mouseY>360)) svar=34;   
  }
}
void tela34(){
  fill(0,0,255);       rect(0,0,width, height-40); fill(0);   text("TELA 3.4", width/2,height/2);
  fill(255,0,0);       rect(0,360, 100,40);     fill(0);   text("<<",  10,380);
  fill(255,128,128);   rect(300,360,100,40);    fill(0);   text(">>", 310,380);
    if(mouseClick) {
    mouseClick = false;
    if((mouseX<100)&&(mouseY>360)) svar=33;
    if((mouseX>300)&&(mouseY>360)) svar=3;   
  }
}
void tela4(){
  // fundo tela 4
  fill(255,128,128);   rect(0,0,width, height-40); fill(0); text("TELA 4", 100,50);
  // interação válida na tela 1, 3 e 4
  if(mousePressed) {
    if((mouseX<100)&&(mouseY>360)) svar=1;
    if((mouseX>100)&&(mouseX<200)&&(mouseY>360)) svar=2;
    if((mouseX>200)&&(mouseX<300)&&(mouseY>360)) svar=3;
    if((mouseX>300)&&(mouseX<400)&&(mouseY>360)) svar=4;   
  }
}

void tela21(){
  // fundo tela 2.1
  fill(255,255,0);   rect(0,0,width, height-40); fill(0); text("TELA 2.1.", 100,50);
  // botões tela 2.1
  fill(255,0,0);   rect(300,320, 400,40);    fill(0);   text("Voltar",  310,350);
  // interação válida na tela 2.1
  if(mousePressed) {
    if((mouseX>300)&&(mouseY>320)&&(mouseY<360)) svar=2; // volta um nível, de 2.1. para 2.
  }
}

void tela22(){
  // fundo tela 22
  fill(0,255,255);   rect(0,0,width, height-40); fill(0); text("TELA 2.2.", 100,50);
  // botões tela 2.2
  fill(255,0,0);   rect(300,320, 400,40);    fill(0);   text("Voltar",  310,350);
  // interação válida na tela 2.1
  if(mousePressed) {
    if((mouseX>300)&&(mouseY>320)&&(mouseY<360)) svar=2; // volta um nível, de 2.1. para 2.
  }
}

void mouseClicked() {
  // com esta função podemos utilizar as mesmas coordenadas para botões diferentes
  // retorna verdadeiro quando um botão do mouse é pressionado e liberado
  mouseClick = true;
}
