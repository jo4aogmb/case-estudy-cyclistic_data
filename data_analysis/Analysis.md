# Análise de Dados

## Fontes de Dados
Os dados utilizados nesta análise são os registros de viagens da Cyclistic dos meses de agosto e setembro de 2020. Os arquivos CSV utilizados são:

- [2020_aug_cyclistic_data.csv](./data/data%20sheets/2020_aug_cyclistic_data.csv)
- [2020_sept_cyclistic_data - 202004-sept-divvy-tripdata.csv](./data/2020_sept_cyclistic_data - 202004-sept-divvy-tripdata.csv)
- [2020_inner_join_cyclistic_data.csv](./data/2020_inner_join_cyclistic_data.csv)

## Análise Descritiva

### Duração Média das Viagens

#### Setembro
- **Passageiros casuais:** 72,49 minutos
- **Membros:** 21,37 minutos

#### Agosto
- **Passageiros casuais:** 72,49 minutos
- **Membros:** 21,37 minutos

#### Inner Join Dataset
- **Passageiros casuais:** 71,72 minutos
- **Membros:** 21,03 minutos

### Observações
- A duração média das viagens para passageiros casuais é significativamente maior do que para membros anuais em todos os conjuntos de dados analisados.
- As médias de duração das viagens são consistentes entre os dados de agosto e setembro, indicando um padrão estável.

## Análise da Distribuição das Viagens ao Longo dos Dias da Semana

#### Setembro
- A distribuição das viagens varia ao longo da semana, com picos em determinados dias.
- Membros anuais tendem a usar mais as bicicletas durante a semana, enquanto passageiros casuais têm maior utilização nos fins de semana.

#### Agosto
- Padrões semelhantes aos observados em setembro, confirmando a consistência no comportamento dos usuários.

#### Inner Join Dataset
- Tendências consistentes com os meses individuais, reforçando as observações sobre os padrões de uso ao longo da semana.

## Conclusões
- Os passageiros casuais têm uma duração média de viagem significativamente maior em comparação com os membros anuais.
- Os membros anuais utilizam mais as bicicletas durante a semana, enquanto os passageiros casuais tendem a usar mais nos fins de semana.

O script R fornecido é projetado para realizar as seguintes etapas:

[Download do Script R](./data/R%20analysis/R%20Script.R)

1. **Coleta de Dados:** O script coleta dados de viagens da Divvy de vários arquivos CSV correspondentes a diferentes trimestres.
   
2. **Tratamento e Combinarção dos Dados:** Os dados coletados são padronizados e combinados em um único arquivo de dados. Isso é feito garantindo que todas as colunas tenham nomes consistentes e os tipos de dados corretos.

3. **Limpeza e Preparação dos Dados:** Durante esta etapa, o script realiza as seguintes operações:
   - Renomeia as colunas para garantir consistência entre os diferentes conjuntos de dados.
   - Adiciona novas colunas derivadas, como o dia da semana, mês do ano e período do dia.
   - Identifica e lida com problemas nos dados, como valores ausentes, durações de viagem negativas e campos críticos com valores ausentes.

4. **Análise Descritiva dos Dados:** O script realiza uma análise descritiva dos dados, incluindo:
   - Cálculo da duração média das viagens para membros e passageiros casuais em diferentes conjuntos de dados.
   - Análise da distribuição das viagens ao longo dos dias da semana.

5. **Exportação de um Sumário dos Dados:** Por fim, o script exporta um arquivo CSV com um resumo das análises realizadas para uma análise mais aprofundada em outras ferramentas, como Excel ou Tableau.

Este script automatiza várias etapas do processo de análise de dados, garantindo a consistência e integridade dos resultados. Ele fornece uma base sólida para investigar e entender melhor os padrões de uso das bicicletas Divvy por membros e ciclistas casuais.

## Recomendações
1. **Converter Passageiros Casuais em Membros:**
   - Desenvolver campanhas de marketing destacando os benefícios de ser um membro, como economia em viagens frequentes e menor custo por minuto.

2. **Ajustar a Estrutura de Preços:**
   - Oferecer descontos ou incentivos para passageiros casuais que optarem por planos anuais, especialmente aqueles com alta frequência de uso.

3. **Promoções Sazonais:**
   - Implementar promoções em períodos de menor uso para atrair mais membros, como descontos em meses específicos ou durante eventos especiais.

