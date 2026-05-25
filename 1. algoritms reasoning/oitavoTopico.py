# Tópico 05 - Exercícios de Fixação - Funções

# 1. Crie as funções:

#    1. max_():
#       maior elemento de um vetor

# def max_number(vetor):
#     numero_maximo = 0
#     for i in vetor:
#         if i > numero_maximo:
#             numero_maximo = i
#     return numero_maximo

# print(max_number([1,2,3,4,5,6,7,8,9,10]))

# #    2. min_():
# #       menor elemento de um vetor

# def min_number(vetor):
#     numero_minimo = vetor[0]
#     for i in vetor:
#         if i < numero_minimo:
#             numero_minimo = i
#     return numero_minimo

# print(min_number([1,2,3,4,5,6,7,8,9,10]))


#    3. invert_():
#       inverte um vetor

# def invert_vetor(vet):
#     vetor_novo = []
#     t = len(vet)
#     for i in range(t-1,-1, -1):
#         vetor_novo.append(vet[i])
#     return vetor_novo
        
# print(invert_vetor([1,2,3,4,5,6,7,8,9,10]))

#    4. lower_():
#       todos os caracteres para minúsculo

# def lower_(frase):
#     resultado = ""
#     for i in frase:
#         letra = ord(i)
#         resultado += chr(letra + 32)
#     return resultado

# print(lower_("JULIA"))


#    5. upper_():
#       todos os caracteres para maiúsculo

# def upper_(frase):
#     resultado = ""
#     for i in frase:
#         letra = ord(i)
#         resultado += chr(letra - 32)
#     return resultado

# print(upper_("julia"))

#    6. isdigit_():
#       verifica se é um digito

# def isdigit_(input):
#     for i in input:
#         digito = ord(i)
#         if (48 <= digito <= 57):
#             return True
#         return False

# print(isdigit_("A"))


#    7. ischar_():
#       verifica se é um char

# def ischar_(input):
#     for i in input:
#         letra = ord(i)
#         if (65 <= letra <= 90):
#             return True
#         return False

# print(ischar_("1"))

#    8. sort_():
#       ordena um vetor

def sort_(vetor):
    for i in range(len(vetor)):
        for j in range(len(vetor)- 1):
            if(vetor[j] > vetor[j + 1]):
                temp = vetor[j]
                vetor[j] = vetor[j + 1]
                vetor[j + 1] = temp
    return vetor

#    9. exist_():
#       recebe um vetor e determina se um valor existe no vetor

# def exist_(vetor, valor):
#     for i in vetor:
#         if i == valor:
#             return True
#         return False

#    10. dev_padrao():
#        recebe um vetor e retorna a média e o desvio padrão

def dev_padrao(vetor):
    soma = 0

    for i in vetor:
        soma += i
    media = soma / len(vetor)

    soma_diferencas = 0

    for i in vetor:
        soma_diferencas += (i - media) ** 2
    desvio = (soma_diferencas / len(vetor)) ** 0.5

    return media, desvio


#    11. concatena_():
#        recebe um vetor e concatena um vetor

def concatena_(vetor1, vetor2):
    resultado = []
    for i in vetor1:
        resultado.append(i)
    for i in vetor2:
        resultado.append(i)
    return resultado

# 2. Crie uma função que dado um vetor, retorna todos os **índices** que contenham números **pares**

#         Ex:  [10,11,12,13,14] -> [0,2,4]

def indices_pares(vetor):
    resultado = []
    for i in range(len(vetor)):
        if vetor[i] % 2 == 0:
            resultado.append(i)
    return resultado

# 3. Crie uma função que retorna à frequência dos elementos. Dica, o
#    retorno é uma matriz

#           [1,2,1,3,3,4,3,1,2,1,1] -> [[1,5], [2,2], [3,3], [4,1]]

def frequencia(vetor):
    resultado = []
    for i in vetor:
        encontrou = False
        for par in resultado:
            if par[0] == i:
                par[1] += 1
                encontrou = True
        if not encontrou:
            resultado.append([i, 1])
    return resultado

# 4. Crie uma função que valida um CPF:

def valida_cpf(cpf):
    digitos = []
    for i in cpf:
        if 48 <= ord(i) <= 57:
            digitos.append(int(i))

    if len(digitos) != 11:
        return False

    soma = 0
    for i in range(9):
        soma += digitos[i] * (10 - i)
    resto = soma % 11
    if resto < 2:
        d1 = 0
    else:
        d1 = 11 - resto

    soma = 0
    for i in range(10):
        soma += digitos[i] * (11 - i)
    resto = soma % 11
    if resto < 2:
        d2 = 0
    else:
        d2 = 11 - resto

    return digitos[9] == d1 and digitos[10] == d2
