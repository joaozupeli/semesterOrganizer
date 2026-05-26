PRECEDENCIA = {
    '<->': 0,
    '->':  1,
    'or':  2,
    'and': 3,
    'XOR': 3,
    'not': 4,
}


def separar_formula(formula):
    formula = formula.replace('(', ' ( ').replace(')', ' ) ')
    return formula.split()


def tem_parenteses_externos(partes):
    if partes[0] != '(' or partes[-1] != ')':
        return False

    nivel = 0
    for i in range(len(partes)):
        if partes[i] == '(':
            nivel = nivel + 1
        if partes[i] == ')':
            nivel = nivel - 1
        if nivel == 0 and i < len(partes) - 1:
            return False

    return True


def encontrar_operador_principal(partes):
    nivel_parenteses = 0
    posicao_binario = -1
    posicao_not = -1
    menor_precedencia = 999

    for i in range(len(partes)):
        if partes[i] == '(':
            nivel_parenteses = nivel_parenteses + 1
            continue
        if partes[i] == ')':
            nivel_parenteses = nivel_parenteses - 1
            continue

        if nivel_parenteses > 0:
            continue

        if partes[i] not in PRECEDENCIA:
            continue

        if partes[i] == 'not':
            if posicao_not == -1:
                posicao_not = i
            continue

        if PRECEDENCIA[partes[i]] <= menor_precedencia:
            posicao_binario = i
            menor_precedencia = PRECEDENCIA[partes[i]]

    if posicao_binario != -1:
        return posicao_binario
    return posicao_not


def avaliar(partes, valores):
    while tem_parenteses_externos(partes):
        partes = partes[1:-1]

    if len(partes) == 1:
        return valores[partes[0]]

    posicao = encontrar_operador_principal(partes)
    operador = partes[posicao]
    lado_direito = partes[posicao + 1:]

    if operador == 'not':
        resultado_direito = avaliar(lado_direito, valores)
        return not resultado_direito

    lado_esquerdo = partes[:posicao]
    resultado_esquerdo = avaliar(lado_esquerdo, valores)
    resultado_direito = avaliar(lado_direito, valores)

    if operador == 'and':
        return resultado_esquerdo and resultado_direito
    if operador == 'or':
        return resultado_esquerdo or resultado_direito
    if operador == '->':
        return (not resultado_esquerdo) or resultado_direito
    if operador == 'XOR':
        return resultado_esquerdo != resultado_direito
    if operador == '<->':
        return resultado_esquerdo == resultado_direito


def pegar_variaveis(formula):
    partes = separar_formula(formula)
    variaveis = []
    for parte in partes:
        eh_variavel = len(parte) == 1 and parte.isupper()
        if eh_variavel and parte not in variaveis:
            variaveis.append(parte)
    return sorted(variaveis)


def gerar_combinacoes(quantidade):
    total = 2 ** quantidade
    combinacoes = []

    for numero in range(total):
        combinacao = []
        resto = numero
        for _ in range(quantidade):
            if resto % 2 == 0:
                combinacao.append(True)
            else:
                combinacao.append(False)
            resto = resto // 2
        combinacao.reverse()
        combinacoes.append(combinacao)

    return combinacoes


def tabela_verdade():
    print("\nOperadores: not | and | or | -> | XOR | <->")
    print("Exemplo: ( A and B ) -> C\n")
    formula = input("Digite a formula: ")

    variaveis = pegar_variaveis(formula)
    partes = separar_formula(formula)
    combinacoes = gerar_combinacoes(len(variaveis))

    cabecalho = " | ".join(variaveis) + " | RESULTADO"
    print("\n" + cabecalho)
    print("-" * len(cabecalho))

    for combinacao in combinacoes:
        valores = {}
        for i in range(len(variaveis)):
            valores[variaveis[i]] = combinacao[i]

        resultado = avaliar(partes[:], valores)

        pedacos = []
        for v in variaveis:
            if valores[v]:
                pedacos.append("V")
            else:
                pedacos.append("F")

        linha = " | ".join(pedacos)

        if resultado:
            linha = linha + " | V"
        else:
            linha = linha + " | F"

        print(linha)


while True:
    tabela_verdade()
    continuar = input("\nDeseja fazer outra tabela? (s/n): ")
    if continuar != 's':
        break
