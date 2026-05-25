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

def lower_case(frase):
    vetor = []
    for i in frase:
        vetor.append(ord(i))
    return vetor
print(lower_case("DOIDO"))




#    5. upper_():
#       todos os caracteres para maiúsculo

#    6. isdigit_():
#       verifica se é um digito


#    7. ischar_():
#       verifica se é um char

#    8. sort_():
#       ordena um vetor

#    9. exist_():
#       recebe um vetor e determina se um valor existe no vetor

#    10. dev_padrao():
#        recebe um vetor e retorna a média e o desvio padrão

#    11. concatena_():
#        recebe um vetor e concatena um vetor

# 2. Crie uma função que dado um vetor, retorna todos os **índices** que contenham números **pares**

#         Ex:  [10,11,12,13,14] -> [0,2,4]

# 3. Crie uma função que retorna à frequência dos elementos. Dica, o
#    retorno é uma matriz

#           [1,2,1,3,3,4,3,1,2,1,1] -> [[1,5], [2,2], [3,3], [4,1]]

# 4. Crie uma função que valida um CPF:


# def triple_number(numero):
#     return numero * 3

# print(triple_number(10))


# def soma(a,b,c):
#     return a + b + c

# print(soma(10,20,30))