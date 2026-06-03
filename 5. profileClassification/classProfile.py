import math

dados = [[120, 10, 3, 250, 'P1'],
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
         [270, 40, 6, 590, 'P3']]

novos_usuarios = [[110, 9, 3, 220],
                  [190, 17, 4, 380],
                  [275, 36, 6, 540],
                  [140, 13, 3, 300],
                  [230, 20, 5, 430]]


# MENTORIA PARA IMPLEMENTAÇÃO DO CLASSIFICADOR DE PERFIL

# 1. Função para calcular a distância euclidiana entre dois usuários
#    - Entender o que é uma distância euclidiana (métrica de proximidade).
#    - Implementar uma função que recebe dois vetores (listas) de características numéricas e retorna a distância entre eles.
#    - Lembre-se: somar o quadrado das diferenças de cada atributo, ao final tirar a raiz quadrada.

# 2. Função para classificar um novo usuário com base nos dados existentes
#    - Percorrer todos os registros existentes (os dados de perfil dos usuários conhecidos).
#    - Para cada registro, extrair os valores dos atributos (colunas numéricas) e o perfil (rótulo).
#    - Calcular a distância do novo usuário para cada usuário do banco usando a função do passo 1.
#    - Acompanhar o “perfil” do usuário mais próximo (menor distância).

# 3. Processo para prever o perfil de usuários novos
#    - Para cada usuário novo (somente atributos numéricos), usar a função de classificação para prever seu perfil mais provável.
#    - Imprimir ou retornar o resultado da classificação de cada novo usuário (exibir a entrada e a saída da classificação).

# EXTRA: Pontos importantes para garantir qualidade e entendimento
#    - Verificar se os dados estão corretamente formatados (listas de números, perfis como strings).
#    - Validar se as funções estão testadas em casos simples antes de rodar nos exemplos maiores.
#    - Explicar, se necessário, porque estamos usando distância euclidiana (existem outras opções para métricas).
#    - Explorar possíveis melhorias no futuro (usar mais de um vizinho? normalizar dados?).

# Com esses passos, você terá um miniclassificador baseado em similaridade.
