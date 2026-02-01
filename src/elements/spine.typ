// Lombada conforme NBR 12225:2004
//
// Estrutura da Lombada:
// 1. Nome(s) do(s) autor(es) - quando houver
// 2. Titulo
// 3. Elementos alfanumericos de identificacao (volume, fasciculo, data)
// 4. Logomarca da editora
//
// Recomendacao: Reservar 30mm na borda inferior para elementos de identificacao
//
// Tipos de lombada:
// - Horizontal: titulo impresso horizontalmente quando o documento esta em posicao vertical
// - Descendente: titulo impresso longitudinalmente, legivel do alto para o pe

/// Gera uma pagina de lombada para impressao separada
///
/// Parametros:
/// - author: nome do autor (pode ser abreviado)
/// - title: titulo do trabalho (pode ser abreviado)
/// - volume: numero do volume (opcional)
/// - year: ano (opcional)
/// - institution: sigla da instituicao (opcional)
/// - logo: imagem da logomarca (opcional)
/// - orientation: "descendente" ou "horizontal" (padrao: "descendente")
/// - spine-width: largura da lombada (padrao: 2cm)
/// - spine-height: altura da lombada (padrao: 29.7cm - A4)
/// - reserved-space: espaco reservado na base (padrao: 30mm)
///
/// Nota: Esta funcao gera uma pagina separada com a lombada.
/// Para impressao, a lombada deve ser cortada e aplicada ao dorso do trabalho.
#let lombada(
  author: none,
  title: none,
  volume: none,
  year: none,
  institution: none,
  logo: none,
  orientation: "descendente",
  spine-width: 2cm,
  spine-height: 29.7cm,
  reserved-space: 30mm,
) = {
  set page(
    width: spine-height,
    height: spine-width,
    margin: 3mm,
  )

  if orientation == "descendente" {
    // Lombada descendente - legivel do alto para o pe
    // O texto e rotacionado 90 graus
    set align(left + horizon)

    box(
      width: 100%,
      height: 100%,
    )[
      #set text(size: 10pt)

      // Layout horizontal (sera rotacionado na impressao)
      #grid(
        columns: (auto, 1fr, auto, auto),
        gutter: 1em,
        align: horizon,

        // Autor
        if author != none {
          text(weight: "bold", upper(author))
        },

        // Titulo (centralizado, ocupa espaco restante)
        align(center)[
          #if title != none {
            text(weight: "bold", upper(title))
          }
        ],

        // Elementos alfanumericos
        {
          let elements = ()
          if volume != none { elements.push("v. " + str(volume)) }
          if year != none { elements.push(str(year)) }
          if institution != none { elements.push(institution) }
          elements.join(" ")
        },

        // Espaco reservado (30mm) + logo
        box(width: reserved-space)[
          #if logo != none {
            align(center + horizon, logo)
          }
        ],
      )
    ]
  } else {
    // Lombada horizontal - para lombadas largas
    set align(center + top)

    box(
      width: 100%,
      height: 100%,
    )[
      #set text(size: 9pt)

      // Autor
      if author != none {
        text(weight: "bold", size: 10pt, upper(author))
        v(0.5em)
      }

      v(1fr)

      // Titulo
      if title != none {
        text(weight: "bold", upper(title))
      }

      v(1fr)

      // Elementos alfanumericos
      {
        if volume != none { [v. #volume] }
        if year != none {
          if volume != none { linebreak() }
          str(year)
        }
        if institution != none {
          linebreak()
          institution
        }
      }

      v(0.5em)

      // Logo
      if logo != none {
        logo
      }

      // Espaco reservado
      v(reserved-space)
    ]
  }

  pagebreak()
}

/// Gera preview da lombada em uma caixa
/// Util para visualizacao no documento
///
/// Parametros: mesmos da funcao lombada()
/// Retorna: uma caixa com a lombada renderizada verticalmente
#let lombada-preview(
  author: none,
  title: none,
  volume: none,
  year: none,
  institution: none,
  logo: none,
  spine-width: 2cm,
  spine-height: 20cm,
  reserved-space: 30mm,
) = {
  box(
    width: spine-width,
    height: spine-height,
    stroke: 0.5pt + gray,
    inset: 2mm,
  )[
    #set text(size: 8pt)
    #set align(center)

    // Autor (topo)
    if author != none {
      rotate(-90deg, reflow: true)[
        #text(weight: "bold", size: 7pt, upper(author))
      ]
      v(0.3em)
    }

    v(1fr)

    // Titulo (rotacionado)
    if title != none {
      rotate(-90deg, reflow: true)[
        #text(weight: "bold", size: 8pt, upper(title))
      ]
    }

    v(1fr)

    // Elementos alfanumericos
    rotate(-90deg, reflow: true)[
      #{
        let elements = ()
        if volume != none { elements.push("v. " + str(volume)) }
        if year != none { elements.push(str(year)) }
        elements.join(" ")
      }
    ]

    if institution != none {
      v(0.3em)
      rotate(-90deg, reflow: true)[
        #text(size: 7pt, institution)
      ]
    }

    v(0.5em)

    // Logo
    if logo != none {
      logo
    }

    // Indicador de espaco reservado
    v(0.3em)
    line(length: 100%, stroke: 0.3pt + gray)
    text(size: 5pt, fill: gray)[30mm]
  ]
}

/// Gera texto formatado para lombada descendente
/// Retorna o texto rotacionado para ser usado em outros contextos
#let spine-text-descending(
  author: none,
  title: none,
  volume: none,
  year: none,
) = {
  let parts = ()

  if author != none {
    parts.push(text(weight: "bold", upper(author)))
  }

  if title != none {
    parts.push(text(weight: "bold", upper(title)))
  }

  let elements = ()
  if volume != none { elements.push("v. " + str(volume)) }
  if year != none { elements.push(str(year)) }

  if elements.len() > 0 {
    parts.push(elements.join(" "))
  }

  parts.join(h(2em))
}

/// Titulo de margem de capa
/// Para itens cujas lombadas nao comportam inscricoes
/// Titulo impresso longitudinalmente ao lado da lombada
///
/// Parametros:
/// - title: titulo do trabalho
/// - volume: numero do volume (opcional)
/// - margin-width: largura da margem (padrao: 1.5cm)
#let margem-capa(
  title: none,
  volume: none,
  margin-width: 1.5cm,
) = {
  box(
    width: margin-width,
    height: 100%,
  )[
    #set align(center + horizon)
    #rotate(-90deg, reflow: true)[
      #set text(size: 10pt)
      #if title != none { upper(title) }
      #if volume != none { [ - v. #volume] }
    ]
  ]
}
