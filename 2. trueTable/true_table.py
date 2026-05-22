from itertools import product

# Prioridade dos conectivos (quanto maior, resolve primeiro)
PRIORIDADE = {
    '(': -1,
    '<->': 0,
    '->': 1,
    'or': 2,
    'and': 3,
    'XOR': 3,
    'not': 4,
}


def calcular(op, b, a=None):
    if op == 'not': return not b
    if op == 'and': return a and b
    if op == 'or':  return a or b
    if op == '->':  return (not a) or b
    if op == 'XOR': return a != b
    if op == '<->': return a == b


def para_posfixo(formula):
    """Converte 'A and B' para ['A', 'B', 'and'] (notação posfixa)."""
    tokens = formula.replace('(', ' ( ').replace(')', ' ) ').split()
    pilha = []
    saida = []

    for t in tokens:
        if t.isupper() and t not in PRIORIDADE:
            saida.append(t)
        elif t == '(':
            pilha.append(t)
        elif t == ')':
            while pilha[-1] != '(':
                saida.append(pilha.pop())
            pilha.pop()
        else:
            while pilha and PRIORIDADE.get(pilha[-1], -1) >= PRIORIDADE[t]:
                saida.append(pilha.pop())
            pilha.append(t)

    while pilha:
        saida.append(pilha.pop())

    return saida


def avaliar(posfixo, valores):
    """Resolve a expressão posfixa usando os valores V/F das variáveis."""
    pilha = []

    for t in posfixo:
        if t in valores:
            pilha.append(valores[t])
        elif t == 'not':
            pilha.append(calcular('not', pilha.pop()))
        else:
            b = pilha.pop()
            a = pilha.pop()
            pilha.append(calcular(t, b, a))

    return pilha[0]


def tabela_verdade():
    print("\nConectivos: not | and | or | -> | XOR | <->")
    print("Exemplo:    ( A and B ) -> C\n")
    formula = input("Fórmula: ")

    letras = sorted(set(c for c in formula if c.isupper() and c not in ('X', 'O', 'R')))
    posfixo = para_posfixo(formula)

    # Cabeçalho
    cabecalho = " | ".join(letras) + " | RESULTADO"
    print("\n" + cabecalho)
    print("-" * len(cabecalho))

    # Gera todas as combinações de V e F
    for combo in product([True, False], repeat=len(letras)):
        valores = dict(zip(letras, combo))
        resultado = avaliar(posfixo, valores)

        linha = " | ".join("V" if valores[l] else "F" for l in letras)
        print(f"{linha} | {'V' if resultado else 'F'}")


while True:
    tabela_verdade()
    if input("\nOutra? (s/n): ") != 's':
        break
