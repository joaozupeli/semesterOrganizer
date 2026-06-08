# Tópico 05 - Exercícios de Fixação - Arrays (Vetores)

# Para estes exercícios, é importante que você não utilize funções built-in do Python, ou seja, aquelas que já vem pré-definidas na linguagem (max, mean, min, sort, etc). O objetivo é praticar a manipulação de vetores 1D em Python utilizando apenas as estruturas de controle, como laços de repetição e estruturas condicionais. Assim você irá aprimorar sua habilidade em programação

# 1. Crie um vetor de 20 elementos aleatórios
# import random

# vetor = []

# for i in range(0,20):
#   aleatorio = random.randint(0,100)
#   vetor.append(aleatorio)

# print(vetor)


# 2. Crie um vetor de 20 elementos incrementando-os de 5 em 5

# vetor = []
# numero = 0

# for i in range(0,20):
#   numero += 5
#   vetor.append(numero)

# print(vetor)

# 3. Crie um vetor contendo N elementos digitados pelo usuário

# vetor = []
# nElementos = int(input("Digite o numero de elementos: "))

# for i in range(0, nElementos):
#   numero = int(input("Digite os numeros vão compor o vetor: "))
#   vetor.append(numero)

# print(vetor)

# 4. Crie um vetor contendo N elementos pares digitados pelo usuário

# vetor = []
# nElementos = int(input("Digite a quantidade de elementos que vão compor o vetor: "))

# if(nElementos % 2 == 0):
#   for i in range(0,nElementos):
#     numero = int(input("Digite o numero para compor o vetor: "))
#     vetor.append(numero)
# else:
#   print("Numero para quantidade de de elementos não é par")

# print(vetor)

# 5. Para cada posição [i] do vetor, imprima o valor atual, seu antecessor e sucessor
# vetor = [1,2,3,4,5,6]

# for i in range(0, len(vetor)-1):
#   print(f"Posição {i}: {vetor[i]}, Antecessor: {vetor[i-1]}, Sucessor: {vetor[i+1]}")


# 6. Apresente a soma dos elementos opostos de um vetor de 100 elementos

# vetor = [1,2,3,4,5,6,7,8,9,10]
# soma = 0
# for i in range(0, len(vetor)):
#   soma += vetor[i]
# print(soma)

# 7. Compute a média e o desvio padrão de um vetor
# vetor = [1,2,3,4,5,6,7,8,9,10]
# media = 0
# for i in range(0, len(vetor)):
#   media += vetor[i]
# media = media / len(vetor)
# print(media)

# desvio = 0
# for i in range(0, len(vetor)):
#   desvio += (vetor[i] - media) ** 2
# desvio = (desvio / len(vetor)) ** 0.5
# print(desvio)


# 8. Crie um vetor aleatorio. Posteriormente apresente a soma dos pares e depois dos múltiplos de 5. Também, crie um vetor com os múltiplos de 10 do vetor original.

# vetor = [1,2,3,4,5,6,7,8,9,10]
# soma_pares = 0
# soma_multiplos_5 = 0
# vetor_multiplos_10 = []
# for i in range(0, len(vetor)):
#   if vetor[i] % 2 == 0:
#     soma_pares += vetor[i]
#   if vetor[i] % 5 == 0:
#     soma_multiplos_5 += vetor[i]
#   if vetor[i] % 10 == 0:
#     vetor_multiplos_10.append(vetor[i])
# print(soma_pares)
# print(soma_multiplos_5)
# print(vetor_multiplos_10)


# 9. Crie dois vetores de 5 elementos cada, e posteriormente crie um terceiro resultante da soma deste dois

# vetor1 = [1,2,3,4,5]
# vetor2 = [6,7,8,9,10]
# vetor3 = []
# for i in range(0, len(vetor1)):
#   vetor3.append(vetor1[i] + vetor2[i])
# print(vetor3)

# 10. Dado um vetor de 20 elementos, divida este em dois sub-vetores de 10 elementos

# vetor = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
# vetor1 = vetor[:10]
# vetor2 = vetor[10:]
# print(vetor1)
# print(vetor2)

# 11. Encontre o maior elemento de um vetor

# vetor = [1,2,3,4,5,6,7,8,9,10]
# maior = vetor[0]
# for i in range(0, len(vetor)):
#   if vetor[i] > maior:
#     maior = vetor[i]
# print(maior)

# 12. Encontre os dois maiores elementos de um vetor

# vetor = [1,2,3,4,5,6,7,8,9,10]
# maior1 = vetor[0]
# maior2 = vetor[0]
# for i in range(0, len(vetor)):
#   if vetor[i] > maior1:
#     maior1 = vetor[i]
#   if vetor[i] > maior2 and vetor[i] != maior1:
#     maior2 = vetor[i]
# print(maior1)
# print(maior2)

# vetor = [30,10,40,50,20]
# media = sum(vetor) / len(vetor)
# vetor_rotulado = []
# for i in range(0, len(vetor)):
#   if vetor[i] > media:
#     vetor_rotulado.append(1)
#   else:
#     vetor_rotulado.append(-1)
# print(vetor_rotulado)

# 13. Dado um vetor, crie um segundo vetor rotulando os indices do primeiro que contem valores acima (-1) e abaixo da média (-1):

# vetor = [30,10,40,50,20]
# media = sum(vetor) / len(vetor)
# vetor_rotulado = []
# for i in range(0, len(vetor)):
#   if vetor[i] > media:
#     vetor_rotulado.append(1)
#   else:
#     vetor_rotulado.append(-1)
# print(vetor_rotulado)

# 14. Dado um vetor de 20 elementos, imprima o vetor como se fosse uma piramide:

# vetor = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
# for i in range(0, len(vetor)):
#   print(vetor[:i+1])


# 15. Imprima na ordem inversa o exercício 14.

# vetor = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
# for i in range(len(vetor)-1, -1, -1):
#   print(vetor[:i+1])

# 16. Contrua e descontrua a pirâmide (dos exercícios 14 e 15)

# vetor = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
# for i in range(0, len(vetor)):
#   print(vetor[:i+1])
# for i in range(len(vetor)-1, -1, -1):
#   print(vetor[:i+1])

# 17. Dado um vetor qualquer, apresente os elementos em forma de 'X'.

vetor = [5,2,1,3,4]
for i in range(0, len(vetor)):
  print(vetor[i], end=" ")
for i in range(len(vetor)-1, -1, -1):
  print(vetor[i], end=" ")

# 18. Dado um vetor qualquer , apresente este vetor de forma ordenada

#     [5,2,1,3,4] ==> [1,2,3,4,5]

# 19. Maior sequência de '0' em um vetor

#     [1,0,0,1,1,0,1,**0,0,0,0**,1,1,0,0,0] ==> 4

# 20. Maior sequência de um vetor

#     [64,65,12,13,14,15,21,**33,34,35,36,37**,100,91,9,93,94]

#     valores = [33,34,35,36,37]

#     idxs = [7,8,9,10,11]

# 21. Implemente um validador de CPF. Pesquise na internet como o cálculo é realizado

# Strings:

# 21.   A partir de uma frase digitada pelo usuário, determine:

#     a. Quantidade de espaços em branco

#     b. Quantidade de letras maiúsculas

#     c. Quantidade de caracteres especiais

# 22. Faça um algoritmo que converte letra maiúscula em minúscula e vice-versa.

# 23. Validador de Senha

#     a. 10 caractereses

#     b. Não contem números em sequência

#     c. 2 Caracteres Especiais

#     d. 2 Letras maiúsculas

# 24. Código Morse: Converta um string morse (' ', '.', '-') em uma string alpha-númerica

#     
