// Exemplo de Apresentacao de Slides para Defesa de TCC
//
// ============================================================================
// IMPORTANTE: NAO EXISTE NORMA ABNT PARA SLIDES
// ============================================================================
//
// A ABNT (Associacao Brasileira de Normas Tecnicas) NAO possui nenhuma norma
// especifica para apresentacoes de slides. Isso significa que:
//
// - Nao ha regras oficiais para fonte, tamanho ou espacamento em slides
// - Nao ha exigencia normativa para layout ou estrutura
// - Nao ha padrao ABNT para cores ou elementos visuais
//
// Este template segue BOAS PRATICAS academicas comuns no Brasil, mas NAO
// representa uma exigencia normativa da ABNT.
//
// As UNICAS normas ABNT aplicaveis em slides sao:
// - NBR 6023:2018 - Referencias (se houver slide de referencias)
// - NBR 10520:2023 - Citacoes (formato autor-data para citacoes no texto)
//
// ============================================================================

#import "../lib.typ": *

// Usar o template de defesa
#show: slides-defesa.with(
  title: "Sistema de Recomendacao de Filmes Baseado em Aprendizado de Maquina",
  subtitle: "Uma abordagem usando filtragem colaborativa",
  author: "Maria Silva Santos",
  advisor: "Prof. Dr. Joao Carlos Oliveira",
  co-advisor: "Profa. Dra. Ana Paula Costa",
  institution: "Universidade Federal de Exemplo",
  department: "Departamento de Ciencia da Computacao",
  program: none, // Deixar none para TCC de graduacao
  degree: "Bacharel em Ciencia da Computacao",
  committee: (
    "Prof. Dr. Joao Carlos Oliveira (Orientador)",
    "Profa. Dra. Maria Lucia Ferreira",
    "Prof. Dr. Pedro Henrique Lima",
  ),
  date: datetime(year: 2025, month: 3, day: 15),
  primary-color: cores-academico.primary,
  secondary-color: cores-academico.secondary,
)

// ============================================================================
// SUMARIO DA APRESENTACAO
// ============================================================================

#slide-sumario(
  items: (
    "Introducao e Motivacao",
    "Objetivos",
    "Fundamentacao Teorica",
    "Metodologia",
    "Resultados",
    "Conclusao",
  ),
)

// ============================================================================
// SECAO 1: INTRODUCAO
// ============================================================================

#slide-secao(
  title: "Introducao",
  subtitle: "Contexto e Motivacao",
)

== Contexto

- Crescimento exponencial de conteudo digital
- Dificuldade dos usuarios em encontrar conteudo relevante
- Sistemas de recomendacao como solucao

#pause

- Netflix: 80% do conteudo assistido vem de recomendacoes
- Amazon: 35% das vendas originam de recomendacoes

== Problema de Pesquisa

#align(center)[
  #box(
    width: 80%,
    inset: 1em,
    stroke: 2pt + rgb("#003366"),
    radius: 5pt,
  )[
    #text(size: 20pt)[
      *Como desenvolver um sistema de recomendacao de filmes que seja eficiente e preciso, utilizando tecnicas de filtragem colaborativa?*
    ]
  ]
]

// ============================================================================
// SECAO 2: OBJETIVOS
// ============================================================================

#slide-secao(title: "Objetivos")

== Objetivo Geral

Desenvolver um sistema de recomendacao de filmes baseado em filtragem colaborativa utilizando o dataset MovieLens.

#pause

== Objetivos Especificos

+ Analisar as principais tecnicas de sistemas de recomendacao
+ Implementar algoritmo de filtragem colaborativa
+ Avaliar a precisao do sistema usando metricas padrao
+ Comparar resultados com abordagens existentes

// ============================================================================
// SECAO 3: FUNDAMENTACAO TEORICA
// ============================================================================

#slide-secao(
  title: "Fundamentacao Teorica",
  subtitle: "Conceitos e Trabalhos Relacionados",
)

== Sistemas de Recomendacao

#slide-comparativo(
  title: "Tipos de Sistemas de Recomendacao",
  left-title: "Filtragem Colaborativa",
  left-content: [
    - Baseada em similaridade entre usuarios
    - Nao requer conhecimento do conteudo
    - Problema do "cold start"
  ],
  right-title: "Filtragem por Conteudo",
  right-content: [
    - Baseada em caracteristicas dos itens
    - Requer metadados detalhados
    - Limitada a itens similares
  ],
)

// Exemplo de citacao em slide (segue NBR 10520:2023)
#slide-citacao(
  quote: "A filtragem colaborativa e uma das tecnicas mais bem-sucedidas para construir sistemas de recomendacao, baseando-se na premissa de que usuarios com comportamentos similares no passado terao preferencias similares no futuro.",
  author: "Ricci",
  year: "2015",
  page: "35",
)

== Trabalhos Relacionados

#table(
  columns: (auto, 1fr, auto),
  inset: 8pt,
  align: horizon,
  [*Autor*], [*Contribuicao*], [*Ano*],
  [Koren], [Fatoracao de matrizes para Netflix Prize], [2009],
  [He et al.], [Neural Collaborative Filtering], [2017],
  [Zhang et al.], [Deep Learning para recomendacao], [2019],
)

#v(0.5em)
#text(size: 12pt, fill: gray)[
  _Citacoes formatadas conforme NBR 10520:2023_
]

// ============================================================================
// SECAO 4: METODOLOGIA
// ============================================================================

#slide-metodologia(
  tipo-pesquisa: "Pesquisa aplicada, de natureza quantitativa",
  abordagem: "Experimental",
  procedimentos: (
    "Revisao bibliografica",
    "Implementacao do algoritmo",
    "Experimentos computacionais",
    "Analise estatistica dos resultados",
  ),
  instrumentos: (
    "Python + bibliotecas (NumPy, Pandas, Scikit-learn)",
    "Dataset MovieLens 100K",
    "Metricas: RMSE, MAE, Precisao\@K",
  ),
)

== Dataset MovieLens

#slide-resultado-numerico(
  title: "Dataset MovieLens 100K",
  items: (
    ("100K", "Avaliacoes"),
    ("943", "Usuarios"),
    ("1.682", "Filmes"),
    ("1-5", "Escala de notas"),
  ),
)

// ============================================================================
// SECAO 5: RESULTADOS
// ============================================================================

#slide-secao(
  title: "Resultados",
  subtitle: "Experimentos e Analise",
)

== Metricas de Avaliacao

#slide-resultado-numerico(
  title: "Resultados Obtidos",
  items: (
    ("0.89", "RMSE"),
    ("0.71", "MAE"),
    ("78%", "Precisao\@10"),
  ),
)

== Comparacao com Literatura

#table(
  columns: (1fr, auto, auto, auto),
  inset: 10pt,
  align: (left, center, center, center),
  [*Metodo*], [*RMSE*], [*MAE*], [*Precisao\@10*],
  [Baseline (media)], [1.12], [0.94], [52%],
  [SVD classico], [0.93], [0.74], [71%],
  [*Nossa abordagem*], [*0.89*], [*0.71*], [*78%*],
  [Estado da arte], [0.85], [0.68], [82%],
)

#pause

#align(center)[
  #text(fill: rgb("#006600"), weight: "bold", size: 18pt)[
    Melhoria de 4.3% em relacao ao SVD classico!
  ]
]

// ============================================================================
// SECAO 6: CONCLUSAO
// ============================================================================

#slide-secao(title: "Conclusao")

== Contribuicoes

- Implementacao funcional de sistema de recomendacao
- Resultados competitivos com estado da arte
- Codigo disponibilizado como software livre

#pause

== Limitacoes

- Avaliado apenas em dataset padrao (MovieLens)
- Nao considera aspectos temporais
- Problema do cold start nao tratado

#pause

== Trabalhos Futuros

- Incorporar deep learning (NCF)
- Avaliar em datasets maiores
- Implementar sistema hibrido

// ============================================================================
// REFERENCIAS (NBR 6023:2018)
// ============================================================================

#slide-referencias(
  items: (
    [KOREN, Y.; BELL, R.; VOLINSKY, C. Matrix factorization techniques for recommender systems. *Computer*, v. 42, n. 8, p. 30-37, 2009.],
    [HE, X. et al. Neural collaborative filtering. In: *WWW '17*, p. 173-182, 2017.],
    [RICCI, F. et al. *Recommender Systems Handbook*. 2. ed. New York: Springer, 2015.],
    [ZHANG, S. et al. Deep learning based recommender system: a survey and new perspectives. *ACM Computing Surveys*, v. 52, n. 1, p. 1-38, 2019.],
  ),
)

// O slide final de "Obrigado! Perguntas?" e gerado automaticamente
// pelo template slides-defesa
