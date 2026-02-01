// Sumário conforme NBR 6027:2012

/// Configura sumário conforme ABNT
/// - Título "SUMARIO" centralizado, negrito
/// - Indicativos de seção alinhados à esquerda
/// - Títulos alinhados à margem do indicativo mais extenso
/// - Páginas ligadas por linha pontilhada
#let abnt-outline() = {
  // Título
  align(center)[
    #text(weight: "bold", size: 12pt, "SUMÁRIO")
  ]

  v(1.5em)

  // Configuração do outline
  show outline.entry: it => {
    // Seções primárias em negrito e maiúsculas
    if it.level == 1 {
      v(0.5em)
      strong(it)
    } else {
      it
    }
  }

  outline(
    title: none,
    indent: auto,
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

  outline(
    title: none,
    depth: depth,
    indent: auto,
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
