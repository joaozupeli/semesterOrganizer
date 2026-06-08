base_dados = [
 [120, 10, 3, 250, 'P1'],
 [200, 25, 5, 400, 'P2'],
 [80, 5, 2, 180, 'P1'],
 [300, 30, 6, 500, 'P3'],
 [250, 40, 7, 600, 'P3'],
 [150, 12, 4, 320, 'P2'],
 [90, 8, 3, 200, 'P1'],
 [310, 35, 6, 520, 'P3'],
 [170, 15, 4, 350, 'P2'],
 [85, 6, 2, 190, 'P1'],
 [220, 18, 5, 410, 'P2'],
 [305, 38, 6, 510, 'P3'],
 [130, 11, 3, 270, 'P1'],
 [260, 42, 7, 580, 'P3'],
 [160, 14, 4, 330, 'P2'],
 [100, 9, 2, 210, 'P1'],
 [240, 28, 6, 460, 'P3'],
 [180, 16, 4, 370, 'P2'],
 [95, 7, 2, 195, 'P1'],
 [270, 40, 6, 590, 'P3']
 ]


def distancia_euclidiana(novo_registro, dados):
    soma = 0
    for i in range(len(novo_registro)):
        soma += (novo_registro[i] - dados[i]) ** 2
    return soma ** 0.5


def calcular_min_max(base):
    # Calcula os valores mínimos e máximos de cada atributo (coluna), ignorando a última coluna (rótulo/classe)
    
    num_atributos = len(base[0]) - 1
    minimos = []
    maximos = []

    for coluna in range(num_atributos):
        valores = [linha[coluna] for linha in base]
        menor_valor = float("inf")
        maior_valor = float("-inf")
        for valor in valores:
            if valor < menor_valor:
                menor_valor = valor
            elif valor > maior_valor:
                maior_valor = valor
        minimos.append(menor_valor)
        maximos.append(maior_valor)

    return minimos, maximos

def normalizar(registro, minimos, maximos):
    normalizado = []
    for i in range(len(registro)):
        intervalo = maximos[i] - minimos[i]
        if intervalo == 0:
            normalizado.append(0.0)
        else:
            normalizado.append(10 * (registro[i] - minimos[i]) / intervalo)
            # Agora, os atributos normalizados estarão entre 0 e 10
    return normalizado


def classificar(novos_registros, base):
    menor_distancia = float("inf")
    perfil_mais_proximo = None

    for registro in base:
        atributos = registro[:-1]
        perfil = registro[-1]

        distancia_atual = distancia_euclidiana(novos_registros, atributos)

        if distancia_atual < menor_distancia:
            menor_distancia = distancia_atual
            perfil_mais_proximo = perfil

    return perfil_mais_proximo

novos_registros = [
[110, 9, 3, 220],
[190, 17, 4, 380],
[275, 36, 6, 540],
[140, 13, 3, 300],
[230, 20, 5, 430]
]

minimos, maximos = calcular_min_max(base_dados)

base_normalizada = []
for registro in base_dados:
    atributos = registro[:-1]
    perfil = registro[-1]
    atributos_normalizados = normalizar(atributos, minimos, maximos)
    base_normalizada.append(atributos_normalizados + [perfil])

for registro in novos_registros:
    registro_normalizado = normalizar(registro, minimos, maximos)
    perfil = classificar(registro_normalizado, base_normalizada)
    print(f"Usuário {registro} → Perfil: {perfil}")