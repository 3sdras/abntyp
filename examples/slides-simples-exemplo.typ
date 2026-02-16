// Exemplo de Apresentacao de Slides Simples
//
// ============================================================================
// IMPORTANTE: NAO EXISTE NORMA ABNT PARA SLIDES
// ============================================================================
//
// A ABNT nao possui norma especifica para apresentacoes de slides.
// Este template segue boas praticas academicas, nao exigencias normativas.
//
// Normas ABNT aplicaveis apenas quando relevante:
// - NBR 6023:2018 - Referencias bibliograficas
// - NBR 10520:2023 - Citacoes em documentos
// ============================================================================

#import "../lib.typ": *

// Template simples para apresentacao academica
#show: slides.with(
  titulo: "Introducao ao Machine Learning",
  subtitulo: "Conceitos Fundamentais",
  autor: "Prof. Dr. Carlos Eduardo Silva",
  instituicao: "Universidade Federal de Exemplo",
  departamento: "Departamento de Ciencia da Computacao",
  data: datetime(year: 2025, month: 8, day: 20),
  proporcao: "16-9",
  cor-primaria: cores-clean.primary,
  cor-secundaria: cores-clean.secondary,
)

// ============================================================================
// SUMARIO
// ============================================================================

#slide-sumario(
  titulo: "Roteiro",
  itens: (
    "O que e Machine Learning?",
    "Tipos de Aprendizado",
    "Aplicacoes Praticas",
    "Desafios e Limitacoes",
  ),
)

// ============================================================================
// CONTEUDO
// ============================================================================

== O que e Machine Learning?

#nota-sem-norma-abnt()

#v(1em)

*Definicao:* Campo da Inteligencia Artificial que permite que sistemas aprendam e melhorem a partir de experiencia sem serem explicitamente programados.

#pause

=== Componentes Fundamentais

- *Dados:* Materia-prima do aprendizado
- *Algoritmo:* Metodo de aprendizado
- *Modelo:* Resultado do treinamento
- *Predicao:* Aplicacao do modelo

== Tipos de Aprendizado

#slide-comparativo(
  titulo: "",
  titulo-esquerda: "Supervisionado",
  conteudo-esquerda: [
    Dados rotulados

    - Classificacao
    - Regressao

    _Exemplo: Spam vs. Nao-spam_
  ],
  titulo-direita: "Nao Supervisionado",
  conteudo-direita: [
    Dados sem rotulos

    - Clustering
    - Reducao de dimensionalidade

    _Exemplo: Segmentacao de clientes_
  ],
)

== Exemplo: Regressao Linear

#align(center)[
  #box(
    width: 70%,
    inset: 1em,
    fill: rgb("#f0f0f0"),
    radius: 5pt,
  )[
    $ y = beta_0 + beta_1 x + epsilon $

    Onde:
    - $y$ = variavel dependente
    - $x$ = variavel independente
    - $beta_0, beta_1$ = coeficientes
    - $epsilon$ = erro
  ]
]

#pause

O algoritmo ajusta os coeficientes para minimizar o erro quadratico medio (MSE).

// Citacao formatada conforme NBR 10520:2023
#slide-citacao(
  quote: "Machine learning is the field of study that gives computers the ability to learn without being explicitly programmed.",
  autor: "Samuel",
  ano: "1959",
)

== Aplicacoes Praticas

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    *Industria*
    - Manutencao preditiva
    - Controle de qualidade
    - Otimizacao de processos
  ],
  [
    *Saude*
    - Diagnostico por imagem
    - Descoberta de farmacos
    - Medicina personalizada
  ],
  [
    *Financas*
    - Deteccao de fraudes
    - Analise de credito
    - Trading algoritmico
  ],
  [
    *Tecnologia*
    - Reconhecimento de voz
    - Traducao automatica
    - Recomendacao de conteudo
  ],
)

#slide-resultado-numerico(
  titulo: "ML em Numeros",
  itens: (
    ("$15.7 tri", "Mercado global de IA em 2030"),
    ("77%", "Empresas usando ou explorando IA"),
    ("2.3M", "Empregos em IA/ML ate 2025"),
  ),
)

== Desafios

+ *Qualidade dos dados*
  - Dados incompletos ou ruidosos
  - Vieses nos dados de treinamento

#pause

+ *Interpretabilidade*
  - Modelos "caixa-preta"
  - Necessidade de explicabilidade

#pause

+ *Questoes eticas*
  - Privacidade
  - Discriminacao algoritmica

== Conclusao

#align(center)[
  #box(
    width: 80%,
    inset: 1.5em,
    stroke: 2pt + cores-clean.primary,
    radius: 10pt,
  )[
    Machine Learning esta transformando todas as areas do conhecimento.

    #v(0.5em)

    *O futuro pertence a quem souber extrair conhecimento dos dados.*
  ]
]

// ============================================================================
// REFERENCIAS (seguindo NBR 6023:2018)
// ============================================================================

#slide-referencias(
  itens: (
    [MITCHELL, T. M. *Machine Learning*. New York: McGraw-Hill, 1997.],
    [SAMUEL, A. L. Some studies in machine learning using the game of checkers. *IBM Journal of Research and Development*, v. 3, n. 3, p. 210-229, 1959.],
    [GERON, A. *Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow*. 2. ed. Sebastopol: O'Reilly Media, 2019.],
  ),
)

// Slide final
#touying-slide-wrapper(self => {
  touying-slide(self: self, setting: body => {
    set align(center + horizon)
    body
  })[
    #text(size: 36pt, weight: "bold", fill: cores-clean.primary)[
      Obrigado!
    ]

    #v(1em)

    #text(size: 18pt)[Duvidas e discussao]

    #v(2em)

    #text(size: 14pt, fill: gray)[
      carlos.silva\@exemplo.edu.br
    ]
  ]
})
