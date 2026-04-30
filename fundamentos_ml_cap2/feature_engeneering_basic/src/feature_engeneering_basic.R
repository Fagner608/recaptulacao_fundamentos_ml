## EATURE ENGENEERING - PARA VARIÁVEIS CATEGÓRICAS - BÁSICO
## Abaixo, tecnicas mais comuns (em nível básico) para engenharia de atributos em variáveis categõricas
## Fonte dos dados: Moro, S., Rita, P., & Cortez, P. (2014). Bank Marketing [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5K306.

# definindo o diretõrio
root = "/home/fagner/Documents/recaptulacao_fundamentos_ml/fundamentos_ml_cap2/feature_engeneering_basic" 
setwd(root)

# Carregando os dados
dataset_bank = read.table("./inputs/bank-full.csv", sep = ';', header = TRUE)

# Visualizando amostra
View(dataset_bank)


## OBS: Toda decisão (após a exploração, deve ser documentada)

## Explorando o atributo job
table(dataset_bank$job)
