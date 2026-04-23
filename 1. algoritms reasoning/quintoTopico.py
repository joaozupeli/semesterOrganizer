# Tópico 05 - Exercícios de Fixação

### 1. Imprima os números de -100 a 100 utilizando 'for'
def imprimir() :
    number = 100
    for i in range(number) :
        print(i)

        

## 2. Imprima os números pares de 0 a 1000

def imprimir_pares():
    for i in range(0,1000):
        if(i % 2 == 0):
            return i

print(imprimir_pares())

## 3.Calcule o fatorial de um número N

## 4. Juros compostos: Calcule quanto um investimento X deve render em Y anos.

def calcular_juros_compostos():
montante = 0
capital = float(input("Digite o capital investido: "))
taxa_juros = float(input("Digite a taxa de juros: "))
tempo = int(input("Digite o tempo de investimento: "))
juros_compostos = montante - capital

## 5. Informe o N-ésimo elemento de uma P.A de razão X.

## 6. Informe o N-ésimo elemento de uma P.G de razão X.

###


