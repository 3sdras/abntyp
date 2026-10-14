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

// COMO COMPILAR: este exemplo importa ../lib.typ, que fica FORA da pasta
// examples/; por isso o Typst precisa saber onde está a raiz do pacote:
//   da raiz do pacote:        typst compile --root . examples/slides-simples-exemplo.typ
//   de dentro de examples/:   typst compile --root .. slides-simples-exemplo.typ
// (sem --root, o Typst recusa o import: "cannot read file outside of project root")
// Se você COPIAR este arquivo para o seu projeto, troque o import abaixo por
//   #import "@preview/abntyp:0.6.0": *
// e compile com `typst compile slides-simples-exemplo.typ`. Arquivos que o exemplo lê (referencias.bib,
// imagens de ../docs/figuras/), se houver, precisam ir junto, com os caminhos ajustados.

#import "../lib.typ": *

// Template simples para apresentacao academica
#show: slides.with(
  titulo: "Introdução ao Machine Learning",
  subtitulo: "Conceitos Fundamentais",
  autor: "Prof. Dr. Carlos Eduardo Silva",
  instituicao: "Universidade Federal de Exemplo",
  departamento: "Departamento de Ciência da Computação",
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
    "O que é Machine Learning?",
    "Tipos de Aprendizado",
    "Aplicações Práticas",
    "Desafios e Limitações",
  ),
)

// ============================================================================
// CONTEUDO
// ============================================================================

== O que é Machine Learning?

*Definição:* Campo da Inteligência Artificial que permite que sistemas aprendam e melhorem a partir de experiência sem serem explicitamente programados.

#pause

- *Dados:* Matéria-prima do aprendizado
- *Algoritmo:* Método de aprendizado
- *Modelo:* Resultado do treinamento
- *Predição:* Aplicação do modelo

== Tipos de Aprendizado

#slide-comparativo(
  titulo: "",
  titulo-esquerda: "Supervisionado",
  conteudo-esquerda: [
    Dados rotulados

    - Classificação
    - Regressão

    _Exemplo: Spam vs. Não-spam_
  ],
  titulo-direita: "Não Supervisionado",
  conteudo-direita: [
    Dados sem rotulos

    - Clustering
    - Redução de dimensionalidade

    _Exemplo: Segmentação de clientes_
  ],
)

== Exemplo: Regressão Linear

#align(center)[
  #box(
    width: 70%,
    inset: 1em,
    fill: rgb("#f0f0f0"),
    radius: 5pt,
  )[
    #set text(size: 20pt)
    #set align(left)
    $ y = beta_0 + beta_1 x + epsilon $

    Onde:
    - $y$ = variável dependente
    - $x$ = variável independente
    - $beta_0, beta_1$ = coeficientes
    - $epsilon$ = erro
  ]
]

#pause

O algoritmo ajusta os coeficientes para minimizar o erro quadrático médio (MSE).

// Citação em slide: sobrenome só com a inicial maiúscula (NBR 10520:2023). A citação
// direta é literal e leva a página: copie a frase exatamente como está na fonte.
#slide-citacao(
  quote: "A computer program is said to learn from experience E with respect to some class of tasks T and performance measure P, if its performance at tasks in T, as measured by P, improves with experience E.",
  autor: "Mitchell",
  ano: "1997",
  pagina: "2",
)

== Aplicações Práticas

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    *Indústria*
    - Manutenção preditiva
    - Controle de qualidade
    - Otimização de processos
  ],
  [
    *Saúde*
    - Diagnóstico por imagem
    - Descoberta de fármacos
    - Medicina personalizada
  ],
  [
    *Finanças*
    - Detecção de fraudes
    - Análise de crédito
    - Trading algorítmico
  ],
  [
    *Tecnologia*
    - Reconhecimento de voz
    - Tradução automática
    - Recomendação de conteúdo
  ],
)

#slide-resultado-numerico(
  titulo: "ML em Datas e Números",
  itens: (
    ("1959", "Arthur Samuel cunha o termo \"machine learning\""),
    ("1997", "Definição formal de aprendizado, de Tom Mitchell"),
    ("3", "Paradigmas: supervisionado, não supervisionado e por reforço"),
  ),
)

== Desafios

// Cada slide precisa caber numa página, inclusive o que ainda está oculto por #pause

+ *Qualidade dos dados*
  - Vieses nos dados de treinamento

#pause

+ *Interpretabilidade*
  - Modelos "caixa-preta"

#pause

+ *Questões éticas*
  - Privacidade e discriminação algorítmica

== Conclusão

#align(center)[
  #box(
    width: 80%,
    inset: 1.5em,
    stroke: 2pt + cores-clean.primary,
    radius: 10pt,
  )[
    Machine Learning está transformando todas as áreas do conhecimento.

    #v(0.5em)

    *O futuro pertence a quem souber extrair conhecimento dos dados.*
  ]
]

// ============================================================================
// REFERENCIAS (digitadas por voce; formate pela NBR 6023:2018)
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

    #text(size: 18pt)[Dúvidas e discussão]

    #v(2em)

    #text(size: 16pt, fill: luma(90))[
      carlos.silva\@exemplo.edu.br
    ]

    #v(1em)

    #nota-sem-norma-abnt()
  ]
})
