## Processar

Durante a fase de processamento dos dados, foram realizadas diversas etapas de limpeza e manipulação para garantir a qualidade e integridade dos dados. Abaixo está a documentação dessas etapas:

### Conversão de Tipos de Dados

Para garantir a consistência e a precisão das análises, foram convertidos tipos de dados quando necessário. As seguintes conversões foram realizadas:

- Convertidos tipos de dados quando necessário (e.g., de string para datetime).

### Adição de Colunas Derivadas

Para uma análise mais aprofundada dos dados, foram adicionadas colunas derivadas. Estas incluem:

- **Dia da Semana**: Para analisar o uso de bicicletas ao longo dos dias da semana.
- **Mês do Ano**: Para identificar padrões sazonais.
- **Período do Dia**: Para categorizar os trajetos em períodos (e.g., manhã, tarde, noite).

### Identificação e Tratamento de Problemas nos Dados

Durante o processo de preparação, foram identificados e tratados diversos problemas nos dados, incluindo:

- **Valores Ausentes na Coluna "end_station_name"**: A coluna end_station_name continha valores em branco. Valores ausentes podem comprometer a análise, especialmente se a localização final da viagem for relevante para entender o comportamento dos ciclistas.
  
- **Durações de Viagem Negativas**: Foram encontradas durações de viagem negativas, indicando possíveis erros nos registros de tempo de início (start_time) e término (end_time). Viagens com durações negativas são inviáveis e podem distorcer a análise dos dados.

- **Valores Ausentes em Campos Críticos**: Verificou-se a necessidade de garantir que campos críticos como ride_id, start_time, end_time, e member_casual não tivessem valores ausentes. Campos obrigatórios incompletos podem resultar em uma análise incorreta ou inválida.

