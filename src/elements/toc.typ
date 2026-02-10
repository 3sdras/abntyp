// Sumário conforme NBR 6027:2012

/// Configura sumário conforme ABNT
/// - Título "SUMARIO" centralizado, negrito
/// - Indicativos de seção alinhados à esquerda
/// - Entradas espelham a formatação dos headings (NBR 6027/6024)
/// - Páginas ligadas por linha pontilhada
#let abnt-outline() = {
  // Título
  align(center)[
    #text(weight: "bold", size: 12pt, "SUMÁRIO")
  ]

  v(1.5em)

  // Nível 1: MAIÚSCULAS + negrito
  show outline.entry.where(level: 1): it => {
    v(0.5em)
    block[
      #link(it.element.location())[
        #text(weight: "bold")[#upper(it.body())]
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 2: MAIÚSCULAS, regular
  show outline.entry.where(level: 2): it => {
    block[
      #link(it.element.location())[
        #h(1em)
        #upper(it.body())
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 3: Minúsculas + negrito
  show outline.entry.where(level: 3): it => {
    block[
      #link(it.element.location())[
        #h(2em)
        #text(weight: "bold")[#it.body()]
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 4: Minúsculas, regular
  show outline.entry.where(level: 4): it => {
    block[
      #link(it.element.location())[
        #h(3em)
        #it.body()
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 5: Minúsculas, itálico
  show outline.entry.where(level: 5): it => {
    block[
      #link(it.element.location())[
        #h(4em)
        #text(style: "italic")[#it.body()]
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  outline(
    title: none,
    indent: 0pt,
  )
}

/// Sumário customizado com mais controle
#let sumario(
  title: "SUMÁRIO",
  depth: 3,
) = {
  align(center)[
    #text(weight: "bold", size: 12pt, title)
  ]

  v(1.5em)

  // Nível 1: MAIÚSCULAS + negrito (NBR 6027)
  show outline.entry.where(level: 1): it => {
    v(0.5em)
    block[
      #link(it.element.location())[
        #text(weight: "bold")[#upper(it.body())]
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 2: MAIÚSCULAS, regular
  show outline.entry.where(level: 2): it => {
    block[
      #link(it.element.location())[
        #h(1em)
        #upper(it.body())
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 3: Minúsculas + negrito
  show outline.entry.where(level: 3): it => {
    block[
      #link(it.element.location())[
        #h(2em)
        #text(weight: "bold")[#it.body()]
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 4: Minúsculas, regular
  show outline.entry.where(level: 4): it => {
    block[
      #link(it.element.location())[
        #h(3em)
        #it.body()
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Nível 5: Minúsculas, itálico
  show outline.entry.where(level: 5): it => {
    block[
      #link(it.element.location())[
        #h(4em)
        #text(style: "italic")[#it.body()]
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  outline(
    title: none,
    depth: depth,
    indent: 0pt,
  )

  pagebreak()
}

/// Lista de ilustrações
#let lista-ilustracoes() = {
  align(center)[
    #text(weight: "bold", size: 12pt, "LISTA DE ILUSTRAÇÕES")
  ]

  v(1.5em)

  outline(
    title: none,
    target: figure.where(kind: image),
      )

  pagebreak()
}

/// Lista de tabelas
#let lista-tabelas() = {
  align(center)[
    #text(weight: "bold", size: 12pt, "LISTA DE TABELAS")
  ]

  v(1.5em)

  outline(
    title: none,
    target: figure.where(kind: table),
      )

  pagebreak()
}

/// Lista de abreviaturas e siglas
/// - items: dicionário de sigla -> significado
#let lista-siglas(items) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "LISTA DE ABREVIATURAS E SIGLAS")
  ]

  v(1.5em)

  set par(first-line-indent: 0pt)

  for (sigla, significado) in items {
    [#sigla #h(1em) #significado \ ]
  }

  pagebreak()
}

/// Lista de símbolos
/// - items: dicionário de símbolo -> significado
#let lista-simbolos(items) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "LISTA DE SÍMBOLOS")
  ]

  v(1.5em)

  set par(first-line-indent: 0pt)

  for (simbolo, significado) in items {
    [#simbolo #h(1em) #significado \ ]
  }

  pagebreak()
}
