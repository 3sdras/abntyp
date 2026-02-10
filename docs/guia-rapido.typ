// Guia Rápido do ABNTypst

#set document(title: "Guia Rápido - ABNTypst")
#set page(paper: "a4", margin: 2cm)
#set text(font: "Times New Roman", size: 11pt, lang: "pt")
#set par(justify: true)

#align(center)[
  #text(size: 18pt, weight: "bold")[Guia Rápido do ABNTypst]
  #v(0.5em)
  #text(size: 11pt)[Formatação ABNT para Typst]
]

#v(1em)

#columns(2, gutter: 1cm)[

== Instalação

Coloque a pasta `abntypst` no seu projeto e importe:

```typst
#import "abntypst/lib.typ": *
```

== Documento Básico

```typst
#show: abntcc.with(
  title: "Título",
  author: "Seu Nome",
  institution: "Universidade",
  location: "Cidade",
  year: 2026,
  advisor: "Prof. Dr. Nome",
)

#capa(
  institution: "Universidade",
  author: "Seu Nome",
  title: "Título",
  location: "Cidade",
  year: 2026,
)

#folha-rosto(
  author: "Seu Nome",
  title: "Título",
  nature: "Dissertação...",
  advisor: "Prof. Dr. Nome",
  location: "Cidade",
  year: 2026,
)

#resumo(keywords: ("A", "B"))[
  Texto do resumo...
]

#sumario()

#counter(page).update(1)
#set page(numbering: "1",
          number-align: top + right)

= Introdução

Texto...
```

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
Conforme o autor,
#citacao-curta("texto",
  author: "SILVA",
  year: "2023",
  page: "42").
```

*Citação longa (mais de 3 linhas):*
```typst
#citacao-longa(
  author: "SILVA",
  year: "2023",
)[
  Texto longo da citação
  com mais de três linhas...
]
```

*Sistema autor-data:*
```typst
// No texto
Segundo #citar-autor("Silva", "2023")

// Entre parênteses
#citar("SILVA", "2023", page: "42")
```

== Figuras

```typst
#figure(
  image("fig.png", width: 80%),
  caption: [Título da figura],
)
#fonte[Elaborado pelo autor.]
```

== Tabelas (IBGE)

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
  "Autor"
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
#show: abntcc.with(
  font: "Arial",
  // ...
)
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
