def remover_parentese_externo(txt):
    txt = txt.replace('(', ' ( ').replace(')', ' ) ')
    return txt.split()


def operador_principal(partes):
    peso = {'<->': 0, '->': 1, 'or': 2, 'and': 3, 'XOR': 3, 'not': 4}
    nivel = 0
    melhor = -1
    melhor_peso = 999
    pos_not = -1

    for i in range(len(partes)):
        if partes[i] == '(':
            nivel += 1
        elif partes[i] == ')':
            nivel -= 1
        elif nivel == 0 and partes[i] in peso:
            if partes[i] == 'not':
                if pos_not == -1:
                    pos_not = i
            elif peso[partes[i]] <= melhor_peso:
                melhor = i
                melhor_peso = peso[partes[i]]

    if melhor != -1:
        return melhor
    return pos_not


def tirar_parenteses(p):
    while p[0] == '(' and p[-1] == ')':
        nivel = 0
        pode = True
        for i in range(len(p)):
            if p[i] == '(':
                nivel += 1
            elif p[i] == ')':
                nivel -= 1
            if nivel == 0 and i < len(p) - 1:
                pode = False
                break
        if pode:
            p = p[1:-1]
        else:
            break
    return p


def calcular(partes, vals):
    partes = tirar_parenteses(partes)

    if len(partes) == 1:
        return vals[partes[0]]

    pos = operador_principal(partes)
    op = partes[pos]
    dir = partes[pos + 1:]

    if op == 'not':
        return not calcular(dir, vals)

    esq = partes[:pos]
    e = calcular(esq, vals)
    d = calcular(dir, vals)

    if op == 'and':
        return e and d
    if op == 'or':
        return e or d
    if op == '->':
        return (not e) or d
    if op == 'XOR':
        return e != d
    if op == '<->':
        return e == d


def rodar():
    print("\nOperadores: not | and | or | -> | XOR | <->")
    formula = input("Formula: ")

    partes = remover_parentese_externo(formula)
    vars = sorted(set(p for p in partes if len(p) == 1 and p.isupper()))

    n = len(vars)
    total = 2 ** n

    print()
    for i in range(total):
        vals = {}
        bits = bin(i)[2:].zfill(n)
        for j in range(n):
            vals[vars[j]] = bits[j] == '0'

        r = calcular(partes[:], vals)
        print("V" if r else "F")


while True:
    rodar()
    if input("\nOutra? (s/n): ") != 's':
        break
