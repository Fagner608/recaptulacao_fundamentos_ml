## EATURE ENGENEERING - PARA VARIÁVEIS CATEGÓRICAS - BÁSICO
## Abaixo, tecnicas mais comuns (em nível básico) para engenharia de atributos em variáveis categõricas
## Fonte dos dados: Moro, S., Rita, P., & Cortez, P. (2014). Bank Marketing [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5K306.


# libraryes
library(ggplot2)
library(dplyr)

# definindo o diretõrio
root = "/home/fagner/Documents/recaptulacao_fundamentos_ml/fundamentos_ml_cap2/feature_engeneering_basic" 
setwd(root)

# Carregando os dados
dataset_bank = read.table("./inputs/bank-full.csv", sep = ';', header = TRUE)

# Visualizando amostra
View(dataset_bank)


## OBS: Toda decisão (após a exploração, deve ser documentada)

## Explorando o atributo job para a criação de uma nova coluna (nível de tecnologia exigido)
table(dataset_bank$job)
## Representando a tabela acima num gráfico

dataset_bank %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  ggplot() + geom_bar(aes(x = reorder(job, desc(n)), y = n), stat = "identity") + 
  theme(axis.text.x  = element_text(angle = 70, hjust = 1))

## Criando nova coluna com mutate (dplyr) e case_when
## Vamos criar as seguintes classes para uso de tecnologia
# baixo
# medio
# alto
dataset_bank <- dataset_bank %>%
  mutate(
    use_tecnology = case_when(
      job == "admin." ~ "medio",
      job == "blue-collar" ~ "baixo",
      job == "entrepreneur" ~ "alto",
      job == "housemaid" ~ "baixo",
      job == "management" ~ "alto",
      job == "retired" ~ "baixo",
      job == "self-employed" ~ "medio",
      job == "services" ~ "medio",
      job == "student" ~ "medio",
      job == "technician" ~ "alto",
      job == "unemployed" ~ "baixo",
      job == "unknowm" ~ "baixo"
    )
  )

# Calculando proporções por uso de tecnologia
table(dataset_bank$use_tecnology)

# Visualizando em proporções
round(prop.table(table(dataset_bank$use_tecnology))*100, 2)

## Criando variável dummy - aplicando encoding em variáveis categóricas
## Codificando a variável default (entrou ou não no cheque-especial)
## one-hot-encoding - converte cada categoria numa variável binãria {0,1} - criando uma matrix (com vetores one-hot)
## label encoding - codifica os rótulos atribuindo um número para cada (aconselhada quando possuímos uma ordenação intrínseca)
## o pacote caret possui a função dummyvars


# Aplicando label-encoding (para apenas uma categoria)
dataset_bank <- dataset_bank %>%
  mutate(defaulted = ifelse(default == "yes", 1, 0))



## Aplicando dummyVars do pacote caret
library(caret)
# construindo fórmula
dmy <- dummyVars('~ .', data = dataset_bank)
# aplicando
dataset_bank_dummyes <- as.data.frame(predict(dmy, dataset_bank))
# Visualizando
View(dataset_bank_dummyes)



## Combinação de recursos (atributos)
## Vamos combinar recursos (atributos) para visualizar o relacionamento

dados %>%
  group_by(job, marital) %>%
  summarise(n = n())


# Criando uma matrix (seria necessário para aplicar testes de hipótese - como chi-quadrado)
table(dados$job, dados$marital)

# Visualizando
dados %>%
  group_by(job, marital) %>%
  summarise(n = n()) %>% ggplot() + geom_bar(aes(y = n, x = job, fill = marital), # camada estética - coordenada dos dados
                                             stat = "identity",
                                             position = "dodge"
                                             )

# Codigicando variáveis combinadas
dmy <- dummyVars(data = dados, formula = " ~ job:marital")
predict(dmy, dados)
