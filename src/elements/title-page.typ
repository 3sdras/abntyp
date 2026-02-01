// Folha de rosto conforme NBR 14724:2024
// Anverso: autor, título, natureza, orientador, local, ano

#import "../core/spacing.typ": nature-block

/// Cria folha de rosto conforme ABNT
#let title-page(
  author: none,
  title: none,
  subtitle: none,
  nature: none,        // Natureza do trabalho (dissertação, tese, TCC)
  objective: none,     // Objetivo (obtenção de grau)
  institution: none,
  area: none,          // Área de concentração
  advisor: none,       // Orientador
  co-advisor: none,    // Coorientador
  location: none,
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  // Autor
  if author != none {
    text(size: 12pt, upper(author))
  }

  v(1fr)

  // Título (maiúsculas, negrito)
  if title != none {
    if subtitle != none {
      // Título com dois-pontos no final
      text(weight: "bold", size: 14pt, upper(title) + ":")
      linebreak()
      // Subtítulo em linha separada
      text(size: 14pt, subtitle)
    } else {
      text(weight: "bold", size: 14pt, upper(title))
    }
  }

  v(2cm)

  // Natureza do trabalho (recuo de 8cm, espaço simples)
  if nature != none or objective != none or advisor != none {
    set align(right)
    box(width: 8cm)[
      #set align(left)
      #set par(
        leading: 1em * 0.65,
        first-line-indent: 0pt,
        justify: true,
      )
      #set text(size: 10pt)

      #if nature != none { nature }
      #if objective != none { [ #objective] }
      #if institution != none { linebreak(); institution }
      #if area != none { linebreak(); [Área de concentração: #area] }

      #if advisor != none {
        linebreak()
        linebreak()
        [Orientador: #advisor]
      }

      #if co-advisor != none {
        linebreak()
        [Coorientador: #co-advisor]
      }
    ]
  }

  v(1fr)

  // Local e ano
  set align(center)
  if location != none {
    text(size: 12pt, upper(location))
    linebreak()
  }

  if year != none {
    text(size: 12pt, str(year))
  }

  pagebreak()
}

/// Verso da folha de rosto (ficha catalográfica)
/// Deve ocupar a parte inferior da página
#let catalog-card(content) = {
  set page(numbering: none)
  v(1fr)

  align(center)[
    #box(
      width: 12.5cm,
      height: 7.5cm,
      stroke: 0.5pt,
      inset: 0.5cm,
    )[
      #set text(size: 10pt)
      #set par(leading: 1em * 0.65)
      #content
    ]
  ]

  pagebreak()
}
