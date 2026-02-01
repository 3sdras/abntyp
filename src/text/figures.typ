// Figuras e ilustrações conforme NBR 14724:2024 e IBGE

/// Configuração de figuras conforme ABNT
/// - Legenda na parte superior: tipo, número, traço, título
/// - Fonte na parte inferior
/// - Centralizadas
#let abnt-figure-setup() = {
  show figure: it => {
    set align(center)
    it
  }

  show figure.caption: it => {
    set text(size: 10pt)
    it
  }
}

/// Figura com formatação ABNT
/// - caption: título da figura (aparece acima)
/// - source: fonte da figura (aparece abaixo)
/// - body: conteúdo da figura (imagem)
#let abnt-figure(
  body,
  caption: none,
  source: none,
  label: none,
) = {
  figure(
    body,
    caption: if caption != none { caption },
    kind: image,
    supplement: "Figura",
  )

  if source != none {
    set align(center)
    set text(size: 10pt)
    [Fonte: #source]
  }
}

/// Quadro (informações textuais tabuladas)
/// Similar à figura, mas com bordas fechadas
#let abnt-quadro(
  body,
  caption: none,
  source: none,
) = {
  figure(
    kind: "quadro",
    supplement: "Quadro",
    caption: if caption != none { caption },
  )[
    #box(stroke: 0.5pt)[
      #body
    ]
  ]

  if source != none {
    set align(center)
    set text(size: 10pt)
    [Fonte: #source]
  }
}

/// Gráfico
#let abnt-grafico(
  body,
  caption: none,
  source: none,
) = {
  figure(
    body,
    caption: if caption != none { caption },
    kind: "gráfico",
    supplement: "Gráfico",
  )

  if source != none {
    set align(center)
    set text(size: 10pt)
    [Fonte: #source]
  }
}

/// Fonte da figura (para usar abaixo da figura)
#let fonte(content) = {
  align(center)[
    #text(size: 10pt)[Fonte: #content]
  ]
}

/// Nota da figura
#let nota-figura(content) = {
  align(left)[
    #text(size: 10pt)[Nota: #content]
  ]
}
