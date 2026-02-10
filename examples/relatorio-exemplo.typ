// Exemplo de Relatório Técnico e/ou Científico conforme NBR 10719:2015
//
// ============================================================================
// Este exemplo demonstra o uso do template technical-report do ABNTypst para
// criar relatórios técnicos em conformidade com a NBR 10719:2015.
//
// Elementos demonstrados:
// - report-cover() - Capa
// - report-title-page() - Folha de rosto (anverso)
// - report-title-page-verso() - Verso com equipe técnica
// - errata() - Errata (exemplo)
// - agradecimentos-relatorio() - Agradecimentos
// - resumo-relatorio() - Resumo com palavras-chave
// - Sumário
// - Seções numeradas
// - formulario-identificacao() - Formulário de identificação
// - Referências automáticas
//
// ============================================================================

#import "../lib.typ": *

// Configuração do documento usando o template technical-report
#show: relatorio.with(
  title: "Análise de Desempenho de Sistemas de Banco de Dados NoSQL",
  subtitle: "estudo comparativo entre MongoDB, Cassandra e Redis",
  report-number: 15,
  report-code: "UFE-CPD-2026-BD-015",
  institution: "Universidade Federal de Exemplo",
  institution-address: "Av. Principal, 1000 - Campus Universitário - CEP 12345-678 - Cidade/UF",
  project-title: "Projeto de Modernização da Infraestrutura de Dados",
  authors: (
    (name: "Dr. Fernando Henrique Alves", qualification: "Coordenador do Projeto"),
    (name: "MSc. Roberta Cristina Lima", qualification: "Pesquisadora"),
    (name: "BSc. Gabriel Santos Oliveira", qualification: "Analista de Sistemas"),
  ),
  classification: none,
  issn: none,
  location: "Cidade",
  year: 2026,
  font: "Times New Roman",
  // Para usar bibliografia automática, o caminho deve ser relativo à raiz:
  // bibliography-file: "examples/referencias.bib",
)

// ============================================================================
// ELEMENTOS PRÉ-TEXTUAIS
// ============================================================================

// Capa
#report-cover(
  institution: "Universidade Federal de Exemplo",
  institution-address: "Av. Principal, 1000 - Campus Universitário - Cidade/UF",
  report-number: 15,
  title: "Análise de Desempenho de Sistemas de Banco de Dados NoSQL",
  subtitle: "estudo comparativo entre MongoDB, Cassandra e Redis",
  year: 2026,
)

// Folha de rosto - anverso
#report-title-page(
  institution: "Universidade Federal de Exemplo",
  project-title: "Projeto de Modernização da Infraestrutura de Dados",
  title: "Análise de Desempenho de Sistemas de Banco de Dados NoSQL",
  subtitle: "estudo comparativo entre MongoDB, Cassandra e Redis",
  report-code: "UFE-CPD-2026-BD-015",
  authors: (
    (name: "Dr. Fernando Henrique Alves", qualification: "Coordenador do Projeto"),
    (name: "MSc. Roberta Cristina Lima", qualification: "Pesquisadora"),
    (name: "BSc. Gabriel Santos Oliveira", qualification: "Analista de Sistemas"),
  ),
  location: "Cidade",
  year: 2026,
)

// Folha de rosto - verso (equipe técnica e ficha catalográfica)
#report-title-page-verso(
  technical-team: (
    (role: "Coordenação Geral", name: "Dr. Fernando Henrique Alves"),
    (role: "Coordenação Técnica", name: "MSc. Roberta Cristina Lima"),
    (role: "Desenvolvimento", name: "BSc. Gabriel Santos Oliveira"),
    (role: "Infraestrutura", name: "Téc. Carlos Eduardo Martins"),
    (role: "Revisão", name: "Profa. Dra. Ana Paula Ferreira"),
  ),
  cataloging-data: [
    #set text(size: 9pt)
    #set par(leading: 0.8em)
    Alves, Fernando Henrique.

    #h(1em) Análise de desempenho de sistemas de banco de dados NoSQL: estudo comparativo entre MongoDB, Cassandra e Redis / Fernando Henrique Alves, Roberta Cristina Lima, Gabriel Santos Oliveira. -- Cidade: UFE/CPD, 2026.

    #h(1em) 45 p. : il. -- (Relatório Técnico; n. 15)

    #h(1em) 1. Banco de dados. 2. NoSQL. 3. Desempenho. I. Lima, Roberta Cristina. II. Oliveira, Gabriel Santos. III. Título.

    #align(right)[CDD 005.74]
  ],
)

// Errata (opcional - incluída como demonstração)
#errata(
  reference: [ALVES, F. H.; LIMA, R. C.; OLIVEIRA, G. S. *Análise de desempenho de sistemas de banco de dados NoSQL*: estudo comparativo entre MongoDB, Cassandra e Redis. Cidade: UFE/CPD, 2026. 45 p. (Relatório Técnico, n. 15).],
  items: (
    (page: 12, line: 5, wrong: "throughput de 15.000", correct: "throughput de 150.000"),
    (page: 23, line: 18, wrong: "latência média de 5ms", correct: "latência média de 0,5ms"),
  ),
)

// Agradecimentos
#agradecimentos-relatorio[
  A equipe técnica agradece ao Centro de Processamento de Dados da Universidade Federal de Exemplo pelo apoio na disponibilização da infraestrutura necessária para a realização dos testes de desempenho.

  Agradecemos também ao Núcleo de Tecnologia da Informação pelo suporte técnico e pela configuração do ambiente de testes.

  Este trabalho foi parcialmente financiado pela Fundação de Amparo à Pesquisa do Estado (FAPE) através do Edital 005/2025 de apoio à modernização de infraestrutura de TI em instituições públicas.
]

// Resumo
#resumo-relatorio(
  keywords: ("Banco de dados NoSQL", "MongoDB", "Cassandra", "Redis", "Análise de desempenho", "Benchmarking"),
)[
  Este relatório apresenta uma análise comparativa de desempenho entre três sistemas de banco de dados NoSQL amplamente utilizados: MongoDB, Apache Cassandra e Redis. O estudo foi conduzido no contexto do Projeto de Modernização da Infraestrutura de Dados da Universidade Federal de Exemplo, com o objetivo de subsidiar a decisão sobre qual tecnologia adotar para o novo sistema de gestão acadêmica. A metodologia envolveu a execução de benchmarks padronizados utilizando o framework YCSB (Yahoo! Cloud Serving Benchmark) em ambiente controlado, com cargas de trabalho representativas de operações típicas do sistema acadêmico. Os resultados indicam que o MongoDB apresenta melhor desempenho para operações de leitura complexas, enquanto o Cassandra demonstra superioridade em cenários de escrita intensiva e alta disponibilidade. O Redis destaca-se para operações de cache e consultas simples de baixa latência. Recomenda-se a adoção de arquitetura híbrida combinando MongoDB para dados principais e Redis para cache, considerando os requisitos específicos do sistema acadêmico.
]

// Sumário
#sumario()

// ============================================================================
// ELEMENTOS TEXTUAIS
// ============================================================================

// Inicia numeração arábica
#counter(page).update(1)
#set page(numbering: "1", number-align: top + right)

= Introdução

O crescimento exponencial do volume de dados nas instituições de ensino superior tem imposto desafios significativos para os sistemas de gerenciamento de banco de dados tradicionais. Os sistemas relacionais, embora maduros e confiáveis, frequentemente apresentam limitações de escalabilidade e desempenho quando confrontados com cargas de trabalho caracterizadas por alto volume de transações, dados semiestruturados e necessidade de disponibilidade contínua.

Neste contexto, os sistemas de banco de dados NoSQL (Not Only SQL) emergiram como alternativas viáveis, oferecendo diferentes modelos de dados e características de desempenho adequadas a cenários específicos. Conforme destacam Silva e Santos (2023), a escolha do sistema de banco de dados adequado pode impactar significativamente o desempenho e a escalabilidade de aplicações corporativas.

== Objetivo do Relatório

Este relatório técnico tem como objetivo apresentar os resultados da análise comparativa de desempenho realizada entre três sistemas de banco de dados NoSQL selecionados para avaliação: MongoDB, Apache Cassandra e Redis. A análise visa subsidiar a tomada de decisão sobre a tecnologia a ser adotada no novo sistema de gestão acadêmica da Universidade Federal de Exemplo.

== Escopo

O escopo deste estudo compreende:

- Avaliação de desempenho em operações CRUD (Create, Read, Update, Delete);
- Análise de escalabilidade horizontal;
- Medição de latência e throughput sob diferentes cargas de trabalho;
- Avaliação de consumo de recursos (CPU, memória, disco);
- Análise de comportamento em cenários de falha.

= Referencial Técnico

== Bancos de Dados NoSQL

Os bancos de dados NoSQL constituem uma categoria heterogênea de sistemas que compartilham a característica de não utilizar exclusivamente o modelo relacional e a linguagem SQL como interface principal. Segundo Cormen et al. (2012), estes sistemas podem ser classificados em quatro grandes categorias:

+ *Orientados a documentos:* armazenam dados em documentos semiestruturados (JSON, BSON), como MongoDB e CouchDB;
+ *Chave-valor:* armazenam pares chave-valor simples, otimizados para alta velocidade, como Redis e DynamoDB;
+ *Orientados a colunas:* organizam dados em famílias de colunas, como Cassandra e HBase;
+ *Grafos:* modelam dados como nós e arestas, como Neo4j e ArangoDB.

== Tecnologias Avaliadas

=== MongoDB

O MongoDB é um banco de dados orientado a documentos que armazena dados em formato BSON (Binary JSON). Suas principais características incluem:

- Modelo de dados flexível sem esquema fixo;
- Suporte a índices secundários;
- Replicação nativa (replica sets);
- Sharding para escalabilidade horizontal;
- Aggregation framework para consultas complexas.

=== Apache Cassandra

O Apache Cassandra é um banco de dados distribuído orientado a colunas, projetado para alta disponibilidade e escalabilidade linear. Características principais:

- Arquitetura peer-to-peer sem ponto único de falha;
- Consistência configurável (eventual a strong);
- Modelo de dados wide-column;
- Otimizado para escritas intensivas;
- Suporte nativo a datacenters múltiplos.

=== Redis

O Redis é um banco de dados em memória do tipo chave-valor, conhecido por sua extrema velocidade. Características:

- Armazenamento primário em memória;
- Estruturas de dados ricas (strings, hashes, lists, sets);
- Persistência opcional em disco;
- Suporte a pub/sub e scripts Lua;
- Clustering para escalabilidade.

= Metodologia

== Ambiente de Testes

Os testes foram executados em ambiente de cluster virtualizado com as seguintes especificações:

#figure(
  table(
    columns: (auto, 1fr),
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Componente*], [*Especificação*],
    table.hline(stroke: 0.75pt),
    [Servidores], [3 nós (cluster) + 1 servidor de benchmark],
    [CPU], [AMD EPYC 7742 (16 vCPUs por nó)],
    [Memória], [64 GB RAM por nó],
    [Armazenamento], [NVMe SSD 1TB por nó],
    [Rede], [10 Gbps entre nós],
    [Sistema Operacional], [Ubuntu Server 22.04 LTS],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Especificações do ambiente de testes],
  kind: table,
)

#fonte[Elaborado pela equipe técnica (2026).]

== Framework de Benchmark

Foi utilizado o Yahoo! Cloud Serving Benchmark (YCSB), framework padrão da indústria para avaliação de bancos de dados NoSQL. O YCSB permite a execução de cargas de trabalho padronizadas que simulam diferentes padrões de acesso a dados.

As cargas de trabalho utilizadas foram:

- *Workload A (Update Heavy):* 50% leitura, 50% atualização;
- *Workload B (Read Heavy):* 95% leitura, 5% atualização;
- *Workload C (Read Only):* 100% leitura;
- *Workload D (Read Latest):* 95% leitura de registros recentes, 5% inserção;
- *Workload F (Read-Modify-Write):* 50% leitura, 50% read-modify-write.

== Procedimento de Testes

O procedimento de testes seguiu as etapas:

+ Preparação do ambiente e instalação das versões mais recentes de cada banco de dados;
+ Configuração otimizada de cada sistema conforme documentação oficial;
+ Carga inicial de 10 milhões de registros;
+ Execução de warm-up de 5 minutos;
+ Execução de cada workload por 30 minutos;
+ Coleta de métricas a cada 10 segundos;
+ Repetição de cada teste 3 vezes para validação estatística.

= Resultados

== Throughput

O throughput (operações por segundo) foi medido para cada workload:

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Workload*], [*MongoDB*], [*Cassandra*], [*Redis*],
    table.hline(stroke: 0.75pt),
    [A (Update Heavy)], [42.350], [58.720], [125.400],
    [B (Read Heavy)], [78.900], [45.600], [198.500],
    [C (Read Only)], [95.200], [52.100], [245.800],
    [D (Read Latest)], [68.400], [61.200], [189.300],
    [F (Read-Modify-Write)], [35.600], [48.900], [98.700],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Throughput (operações/segundo) por workload],
  kind: table,
)

#fonte[Dados coletados pela equipe técnica (2026).]

#nota-figura[Valores representam a média de 3 execuções. Redis operando em modo cluster com 3 nós.]

== Latência

A latência média (em milissegundos) para operações de leitura e escrita:

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    stroke: none,
    table.hline(stroke: 1.5pt),
    [], table.cell(colspan: 2)[*MongoDB*], table.cell(colspan: 2)[*Cassandra*], table.cell(colspan: 2)[*Redis*],
    [], [Leitura], [Escrita], [Leitura], [Escrita], [Leitura], [Escrita],
    table.hline(stroke: 0.75pt),
    [Média], [1,2], [2,8], [2,5], [1,8], [0,3], [0,4],
    [P95], [3,5], [8,2], [6,8], [4,2], [0,8], [1,1],
    [P99], [12,4], [25,6], [18,9], [12,5], [2,1], [2,8],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Latência (ms) por tipo de operação],
  kind: table,
)

#fonte[Dados coletados pela equipe técnica (2026).]

== Escalabilidade

Os testes de escalabilidade horizontal demonstraram:

- *MongoDB:* escalabilidade linear até 5 nós, com degradação gradual após;
- *Cassandra:* escalabilidade linear até 10 nós testados, conforme esperado pela arquitetura;
- *Redis:* escalabilidade limitada pelo modelo de dados, mas excelente para particionamento por chave.

== Consumo de Recursos

O consumo médio de recursos durante os testes:

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Recurso*], [*MongoDB*], [*Cassandra*], [*Redis*],
    table.hline(stroke: 0.75pt),
    [CPU (%)], [45], [62], [28],
    [Memória (GB)], [32], [48], [58],
    [Disco I/O (MB/s)], [180], [220], [45],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Consumo médio de recursos],
  kind: table,
)

#fonte[Dados coletados pela equipe técnica (2026).]

= Análise e Discussão

== Comparativo Geral

Os resultados obtidos confirmam as características arquiteturais de cada sistema:

*MongoDB* demonstrou excelente desempenho em cenários de leitura complexa, especialmente quando as consultas utilizam índices secundários. A flexibilidade do modelo de documentos e o aggregation framework tornam-no adequado para dados semiestruturados e consultas analíticas ad-hoc.

*Cassandra* destacou-se em cenários de escrita intensiva e alta disponibilidade. A arquitetura peer-to-peer elimina pontos únicos de falha, tornando-o ideal para aplicações que requerem disponibilidade contínua e tolerância a partições de rede.

*Redis* apresentou latências significativamente menores que os demais sistemas, confirmando sua adequação para cenários que exigem tempo de resposta ultra-baixo. Entretanto, o modelo de dados simplificado e o armazenamento primário em memória impõem limitações para casos de uso que requerem persistência garantida ou consultas complexas.

== Aplicabilidade ao Sistema Acadêmico

Considerando os requisitos do sistema de gestão acadêmica:

- *Dados de matrícula e histórico:* padrão de leitura predominante, consultas complexas → MongoDB adequado;
- *Logs de acesso e auditoria:* escrita intensiva, alta disponibilidade → Cassandra adequado;
- *Cache de sessão e dados temporários:* baixa latência, dados efêmeros → Redis adequado.

= Conclusões e Recomendações

== Conclusões

Com base nos resultados obtidos, conclui-se que:

+ Não existe uma solução única que atenda otimamente a todos os requisitos do sistema acadêmico;
+ Cada tecnologia avaliada possui características que a tornam mais adequada para cenários específicos;
+ Uma arquitetura híbrida, combinando diferentes sistemas NoSQL, pode oferecer o melhor equilíbrio entre desempenho, escalabilidade e custo.

== Recomendações

Recomenda-se a adoção da seguinte arquitetura:

+ *MongoDB* como banco de dados principal para dados acadêmicos estruturados (alunos, disciplinas, matrículas, histórico);
+ *Redis* como camada de cache para sessões de usuário, dados temporários e consultas frequentes;
+ Manutenção do banco de dados relacional existente para dados financeiros e integração com sistemas legados;
+ Implementação gradual com migração piloto de módulos não críticos.

== Próximas Etapas

As próximas etapas do projeto incluem:

- Detalhamento da arquitetura proposta;
- Prova de conceito com módulo piloto;
- Definição de plano de migração;
- Capacitação da equipe técnica.

// ============================================================================
// ELEMENTOS PÓS-TEXTUAIS
// ============================================================================

// Referências são inseridas automaticamente pelo template

// Apêndice
#pagebreak()
#heading(level: 1, numbering: none, "APÊNDICE A -- SCRIPTS DE CONFIGURAÇÃO")

Os scripts de configuração utilizados para cada banco de dados estão disponíveis no repositório interno do projeto:

`git.ufe.edu.br/cpd/nosql-benchmark`

Arquivos principais:

- `mongodb/mongod.conf` -- Configuração do MongoDB
- `cassandra/cassandra.yaml` -- Configuração do Cassandra
- `redis/redis.conf` -- Configuração do Redis
- `ycsb/workloads/` -- Definição das cargas de trabalho

// Formulário de identificação
#formulario-identificacao(
  title: "Análise de Desempenho de Sistemas de Banco de Dados NoSQL: estudo comparativo entre MongoDB, Cassandra e Redis",
  classification: "Ostensivo",
  report-number: "15",
  report-type: "Relatório Técnico de Pesquisa Aplicada",
  date: "Janeiro de 2026",
  authors: (
    (name: "Dr. Fernando Henrique Alves"),
    (name: "MSc. Roberta Cristina Lima"),
    (name: "BSc. Gabriel Santos Oliveira"),
  ),
  institutions: (
    "Universidade Federal de Exemplo",
    "Centro de Processamento de Dados",
  ),
  abstract-text: [
    Análise comparativa de desempenho entre MongoDB, Cassandra e Redis para subsidiar decisão tecnológica do novo sistema de gestão acadêmica. Testes realizados com YCSB em ambiente controlado. Recomenda-se arquitetura híbrida com MongoDB para dados principais e Redis para cache.
  ],
  keywords: ("Banco de dados NoSQL", "MongoDB", "Cassandra", "Redis", "Benchmarking"),
  edition: "1ª edição",
  pages: "45",
  distribution: "Irrestrita",
  distributor: "Centro de Processamento de Dados - UFE",
  notes: "Relatório produzido no âmbito do Projeto de Modernização da Infraestrutura de Dados.",
)
