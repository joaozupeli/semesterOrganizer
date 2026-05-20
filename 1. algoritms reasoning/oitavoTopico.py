# Tópico 05 - Exercícios de Fixação - Funções

# 1. Crie as funções:

#    1. max_():
#       maior elemento de um vetor

#    2. min_():
#       menor elemento de um vetor

#    3. invert_():
#       inverte um vetor

#    4. lower_():
#       todos os caracteres para minúsculo

#    5. upper_():
#       todos os caracteres para maiúsculo

#    6. isdigit_():
#       verifica se é um digito

def isdigit_(inpt):
    for elemento in inpt:
        for char in elemento:
            n_ascii = ord(char)
            if ord('0') <= n_ascii <= ord('9'):
                return True
            else:
                return False

print(isdigit_(['100', '2', '3', '4', '543', '6', '7', '8', '9', '0']))

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
