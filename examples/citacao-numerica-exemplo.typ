// Exemplo de Uso do Sistema Numerico de Citacoes
//
// ============================================================================
// SOBRE O SISTEMA NUMERICO (NBR 10520:2023, secao 4.2)
// ============================================================================
//
// A NBR 10520:2023 PERMITE dois sistemas de chamada para citacoes:
// 1. Sistema autor-data (mais comum no Brasil)
// 2. Sistema numerico (permitido pela norma)
//
// Este exemplo demonstra o uso do sistema numerico, inspirado no
// abntex2-num.bst do projeto abntex2 para LaTeX.
//
// IMPORTANTE: O sistema numerico NAO pode ser usado quando houver notas
// de rodape no documento (NBR 10520:2023, secao 4.2).
//
// ============================================================================

#import "../lib.typ": *

// Configuracao do documento
#set document(
  title: "Exemplo de Citacao Numerica",
  author: "Autor Exemplo",
)

#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm),
)

#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "pt",
  region: "BR",
)

#set par(
  leading: 1.5em * 0.65,
  justify: true,
  first-line-indent: 1.25cm,
)

// Configurar sistema numerico
#show: numeric-cite-setup

// ============================================================================
// TITULO
// ============================================================================

#align(center)[
  #text(size: 14pt, weight: "bold")[
    EXEMPLO DE CITACAO NO SISTEMA NUMERICO
  ]

  #v(1em)

  #text(size: 12pt)[
    Demonstracao do sistema numerico de citacoes conforme NBR 10520:2023
  ]
]

#v(2em)

// ============================================================================
// CONTEUDO
// ============================================================================

= INTRODUCAO

#aviso-sistema-numerico()

#v(1em)

Este documento demonstra o uso do sistema numerico de citacoes, conforme permitido pela NBR 10520:2023, secao 4.2. O sistema numerico utiliza numeros arabicos consecutivos para indicar as fontes, que sao listadas ao final do documento na ordem em que foram citadas.

A principal vantagem do sistema numerico e a limpeza visual do texto, sem a interrupcao de nomes e datas. Porem, conforme a norma, *este sistema nao pode ser usado quando houver notas de rodape*, pois haveria conflito na numeracao.

= EXEMPLOS DE CITACAO

== Citacao Simples

A metodologia utilizada foi baseada em estudos anteriores #cite-num("silva2023"). Os resultados foram consistentes com a literatura #cite-num("santos2022").

== Citacao com Pagina

Conforme demonstrado na pesquisa #cite-num("silva2023", page: "45"), "os resultados indicam uma correlacao positiva entre as variaveis analisadas".

== Citacao com Volume e Pagina

O conceito foi originalmente proposto #cite-num("enciclopedia2020", volume: "2", page: "123-125") e posteriormente expandido por outros autores.

== Citacoes Multiplas

Diversos estudos confirmam esta hipotese #cite-num-multiple(("silva2023", "santos2022", "costa2021")).

== Citacao no Texto (Autor Mencionado)

Segundo Silva #cite-num-inline("silva2023", page: "78"), a abordagem proposta apresenta vantagens significativas em relacao aos metodos tradicionais.

== Citacao de Citacao (Apud)

Freire afirmou que a educacao e um ato politico #cite-num-apud("freire1994", "streck2017", original-page: "13", consulted-page: "25").

= CITACOES DIRETAS

== Citacao Curta (ate 3 linhas)

#quote-num-short("santos2022", page: "67")[
  A tecnologia transformou profundamente as relacoes sociais no seculo XXI
]

== Citacao Longa (mais de 3 linhas)

#quote-num-long("silva2023", page: "89-90")[
  A teleconferencia permite ao individuo participar de um encontro nacional ou regional sem a necessidade de deixar seu local de origem. Tipos comuns de teleconferencia incluem o uso de televisao, telefone e computador. Atraves de audio-Loss conferencia, utilizando a companhia local de telefone, um sinal de audio pode ser emitido em um salao de qualquer dimensao
]

= FORMATO SOBRESCRITO

A NBR 10520:2023 tambem permite o formato sobrescrito (expoente) para citacoes numericas. Veja exemplos:

O estudo comprovou a hipotese#cite-num("costa2021", style: "superscript"). Outros autores#cite-num("oliveira2020", page: "34", style: "superscript") chegaram a conclusoes similares.

*Nota:* No formato sobrescrito, nao deve haver espaco entre o texto e o numero.

= COMPARACAO DOS FORMATOS

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: left,
  [*Formato Parenteses (padrao)*], [*Formato Sobrescrito*],
  [O resultado foi positivo (1).], [O resultado foi positivo¹.],
  [Conforme Silva (1, p. 45).], [Conforme Silva¹, p. 45.],
  [(1; 2; 3)], [¹ ² ³],
)

#pagebreak()

// ============================================================================
// REFERENCIAS
// ============================================================================

#numeric-bibliography(
  (
    ("silva2023", [SILVA, Joao Carlos. *Metodologia de pesquisa aplicada*. 2. ed. Sao Paulo: Editora Academica, 2023.]),
    ("santos2022", [SANTOS, Maria Helena. Transformacoes sociais na era digital. *Revista Brasileira de Sociologia*, Brasilia, v. 10, n. 2, p. 45-78, 2022.]),
    ("costa2021", [COSTA, Pedro Henrique. *Fundamentos de estatistica*. Rio de Janeiro: LTC, 2021.]),
    ("oliveira2020", [OLIVEIRA, Ana Paula. Analise de dados qualitativos. *Cadernos de Pesquisa*, Sao Paulo, v. 50, n. 175, p. 30-52, jan./mar. 2020.]),
    ("enciclopedia2020", [ENCICLOPEDIA Brasileira de Ciencias. Sao Paulo: Companhia das Letras, 2020. 5 v.]),
    ("freire1994", [FREIRE, Paulo. *Pedagogia do oprimido*. 17. ed. Rio de Janeiro: Paz e Terra, 1994.]),
    ("streck2017", [STRECK, Danilo R.; REDIN, Euclides; ZITKOSKI, Jaime Jose (org.). *Dicionario Paulo Freire*. 3. ed. Belo Horizonte: Autentica, 2017.]),
  ),
)

#v(2em)

// ============================================================================
// NOTAS SOBRE A IMPLEMENTACAO
// ============================================================================

#line(length: 100%)

#text(size: 10pt, fill: gray)[
  *Notas sobre esta implementacao:*

  1. O sistema numerico foi implementado inspirado no `abntex2-num.bst` do projeto abntex2 para LaTeX.

  2. Conforme NBR 10520:2023, secao 4.2, o sistema numerico e *permitido* pela norma, mas nao pode ser usado simultaneamente com notas de rodape.

  3. A numeracao nao reinicia a cada pagina (conforme a norma).

  4. Referencias repetidas recebem o mesmo numero da primeira ocorrencia.

  5. As referencias sao listadas na ordem de citacao no texto (mais intuitivo para o sistema numerico).
]
