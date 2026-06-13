# Lista de Exercícios - Recursividade

## 1. Imprimir números de N até 0

# Implemente uma função recursiva que imprime todos os números de `N` até `0`.


## 2. Imprimir números de 0 até N

# Implemente uma função recursiva que imprime todos os números de `0` até `N`.


## 3. Soma dos números de N até 0

# Desenvolva uma função recursiva que retorna a soma de todos os números inteiros de `N` até `0`.


## 4. Soma dos dígitos de um número inteiro

# Crie uma função recursiva que calcula a soma dos dígitos de um número inteiro.

# Exemplo:

4871

# Saída esperada:

20


## 5. Soma dos elementos de um vetor

# Implemente uma função recursiva que retorna a soma dos elementos de um vetor de inteiros.



## 6. Fatorial de N

# Escreva uma função recursiva para calcular o fatorial de `N`.

## 7. Sequência de Fibonacci

# Desenvolva uma função recursiva para calcular o `N`-ésimo termo da sequência de Fibonacci.

# Considere:

# fibo(0) = 0
# fibo(1) = 1


## 8. Selection Sort recursivo

# Implemente o algoritmo Selection Sort para ordenar um vetor de inteiros usando recursividade.

def selection_sort(vet, i=0):
    if i == len(vet) - 1:
        return vet

    min_index = i

    for j in range(i + 1, len(vet)):
        if vet[j] < vet[min_index]:
            min_index = j

    temp = vet[i]
    vet[i] = vet[min_index]
    vet[min_index] = temp

    return selection_sort(vet, i + 1)
