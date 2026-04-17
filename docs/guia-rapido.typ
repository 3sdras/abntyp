// Guia Rápido do ABNTyp

#set document(title: "Guia Rápido - ABNTyp")
#set page(paper: "a4", margin: 2cm)
#set text(font: "Times New Roman", size: 11pt, lang: "pt")
#set par(justify: true)

#align(center)[
  #text(size: 18pt, weight: "bold")[Guia Rápido do ABNTyp]
  #v(0.5em)
  #text(size: 11pt)[Formatação ABNT para Typst]
]

#v(1em)

#columns(2, gutter: 1cm)[

== Instalação

Coloque a pasta `abntyp` no seu projeto e importe:

```typst
#import "abntyp/lib.typ": *
```

== Documento Básico

```typst
#show: dados.with(
  titulo: "Título",
  autor: "Seu Nome",
  instituicao: "Universidade",
  local: "Cidade",
  ano: 2026,
  orientador: "Prof. Dr. Nome",
  palavras-chave: ("A", "B"),
)

#show: normasABNT.with()

#capa()
#folha-rosto()

#resumo[Texto do resumo...]

#sumario()

#counter(page).update(1)
#set page(numbering: "1",
          number-align: top + right)

= Introdução

Texto...
```

A função `dados()` armazena os metadados
e `normasABNT()` aplica a formatação ABNT.
Os elementos `capa()`, `folha-rosto()` e
`resumo()` leem tudo automaticamente.

== Seções (NBR 6024)

```typst
= Seção Primária      // NEGRITO
== Seção Secundária   // MAIÚSCULAS
=== Seção Terciária   // negrito
==== Seção Quaternária // normal
===== Seção Quinária  // itálico
```

== Citações (NBR 10520)

*Citação curta (até 3 linhas):*
```typst
// Posicional (ano e página sem aspas):
#citacao-curta("SILVA", 2023, 42)[
  texto da citação].

// Nomeado:
#citacao-curta(autor: "SILVA",
  ano: 2023)[texto da citação].

// Sem referência:
#citacao-curta()[sic transit gloria mundi]
```

*Citação longa (mais de 3 linhas):*
```typst
#citacao-longa("SILVA", 2023)[
  Texto longo da citação
  com mais de três linhas...
]
```

*Sistema autor-data:*
```typst
// No texto
Segundo #citar-autor("Silva", 2023)

// Entre parênteses
#citar("SILVA", 2023, pagina: 45)
```

== Figuras, tabelas e quadros

A função `#figure()` é nativa do Typst e serve como contêiner genérico para qualquer elemento com título e numeração --- figuras, tabelas, quadros, etc. O parâmetro `kind` diferencia o tipo.

=== Figura

```typst
#figure(
  image("fig.png", width: 80%),
  caption: [Título da figura],
)
#fonte[Elaborado pelo autor.]
```

=== Tabela (padrão IBGE)

```typst
#figure(
  table(
    columns: 3,
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Col 1*], [*Col 2*], [*Col 3*],
    table.hline(stroke: 0.75pt),
    [Dado], [Dado], [Dado],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Título da tabela],
  kind: table,
)
#fonte[Fonte dos dados.]
```

== Elementos Pré-textuais

```typst
// Dedicatória
#dedicatoria[
  Dedico este trabalho...
]

// Agradecimentos
#agradecimentos[
  Agradeço a...
]

// Epígrafe
#epigrafe(
  "Citação inspiradora",
  "Autor",
)

// Listas
#lista-ilustracoes()
#lista-tabelas()
#lista-siglas((
  "ABNT": "Associação...",
))
```

== Referências

```typst
#heading(level: 1,
  numbering: none,
  "REFERÊNCIAS")

#set par(
  hanging-indent: 1.25cm,
  first-line-indent: 0pt,
)

SILVA, João. *Título*.
São Paulo: Editora, 2023.
```

== Configurações

*Fonte Arial:*
```typst
#show: normasABNT.with(fonte: "Arial")
```

*Margens padrão:*
- Superior: 3 cm
- Inferior: 2 cm
- Esquerda: 3 cm
- Direita: 2 cm

*Espaçamento:*
- Texto: 1,5 entre linhas
- Citação longa: simples
- Recuo parágrafo: 1,25 cm
- Citação longa: 4 cm

== Aliases (nomes curtos)

Todas as funções principais possuem aliases curtos. Use qualquer uma das formas:

```
citacao-curta → ccurta
citacao-longa → clonga
citar-autor   → cautor
citar-apud    → capud
citar-multiplos → cmultiplos
citar-etal    → cetal
folha-rosto   → rosto
ficha-catalografica → ficha
dedicatoria   → dedica
agradecimentos → agradece
lista-siglas  → siglas
lista-simbolos → simbolos
citar-num     → cnum
citar-num-multiplos → cnmultiplos
citacao-num-curta → cncurta
citacao-num-longa → cnlonga
bibliografia-numerica → bibnum
```

== Normas Implementadas

- NBR 14724:2024 - Trabalhos
- NBR 6023:2018 - Referências
- NBR 10520:2023 - Citações
- NBR 6024:2012 - Seções
- NBR 6027:2012 - Sumário
- NBR 6028:2021 - Resumo
- NBR 6022:2018 - Artigo
- IBGE - Tabelas

]
