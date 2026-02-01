// Tabelas conforme IBGE e NBR 14724:2024

/// Configuração de tabelas conforme ABNT/IBGE
/// - Bordas apenas superior, inferior e separando cabeçalho
/// - Legenda na parte superior
/// - Fonte na parte inferior
#let abnt-table-setup() = {
  show figure.where(kind: table): it => {
    set align(center)
    it
  }
}

/// Tabela com formatação ABNT/IBGE
/// - caption: título da tabela (aparece acima)
/// - source: fonte dos dados (aparece abaixo)
/// - columns: especificação das colunas
/// - header: conteúdo do cabeçalho
/// - body: conteúdo da tabela
#let abnt-table(
  caption: none,
  source: none,
  columns: auto,
  ..args,
) = {
  // Título
  if caption != none {
    set align(center)
    set text(size: 10pt)
    [*Tabela* #counter(figure.where(kind: table)).display() -- #caption]
    v(0.5em)
  }

  // Tabela com estilo IBGE
  set align(center)
  table(
    columns: columns,
    stroke: none,
    inset: 5pt,
    // Linha superior
    table.hline(stroke: 1pt),
    ..args,
  )

  // Fonte
  if source != none {
    v(0.3em)
    set align(left)
    set text(size: 10pt)
    [Fonte: #source]
  }
}

/// Tabela IBGE completa com figure
#let tabela(
  body,
  caption: none,
  source: none,
) = {
  figure(
    kind: table,
    supplement: "Tabela",
    caption: if caption != none { caption },
  )[
    #set table(stroke: none)
    #body
  ]

  if source != none {
    set align(center)
    set text(size: 10pt)
    [Fonte: #source]
  }
}

/// Estilo de tabela IBGE (linhas horizontais apenas)
#let ibge-table(
  columns: auto,
  header: (),
  body-rows: (),
) = {
  table(
    columns: columns,
    stroke: none,
    inset: 6pt,
    align: left,

    // Linha superior
    table.hline(stroke: 1.5pt),

    // Cabeçalho
    ..header.map(h => strong(h)),

    // Linha abaixo do cabeçalho
    table.hline(stroke: 0.75pt),

    // Corpo
    ..body-rows.flatten(),

    // Linha inferior
    table.hline(stroke: 1.5pt),
  )
}

/// Nota de tabela
#let nota-tabela(content) = {
  align(left)[
    #text(size: 10pt)[Nota: #content]
  ]
}
