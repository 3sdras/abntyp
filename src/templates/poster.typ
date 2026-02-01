// Template para Poster Tecnico e Cientifico conforme NBR 15437:2006
//
// Estrutura:
// - Titulo (obrigatorio) - parte superior
// - Subtitulo (opcional) - diferenciado tipograficamente ou separado por :
// - Autor (obrigatorio) - logo abaixo do titulo
// - Informacoes complementares (opcional) - instituicao, cidade, estado, pais, etc.
// - Resumo (opcional) - ate 100 palavras, seguido de palavras-chave
// - Conteudo (obrigatorio) - ideias centrais em texto/tabelas/ilustracoes
// - Referencias (opcional) - conforme NBR 6023
//
// Dimensoes recomendadas:
// - Largura: 0,60m a 0,90m
// - Altura: 0,90m a 1,20m
//
// O poster deve ser legivel a pelo menos 1 metro de distancia

/// Template principal para Poster Cientifico conforme NBR 15437:2006
///
/// Parametros:
/// - title: titulo do poster (obrigatorio)
/// - subtitle: subtitulo (opcional)
/// - authors: lista de autores (nome e afiliacao)
/// - institution: instituicao principal
/// - contact: informacoes de contato (email, endereco)
/// - abstract-text: resumo (ate 100 palavras)
/// - keywords: palavras-chave
/// - num-columns: numero de colunas para o conteudo (padrao: 3)
/// - width: largura do poster (padrao: 90cm)
/// - height: altura do poster (padrao: 120cm)
/// - font: fonte a usar
/// - title-size: tamanho da fonte do titulo (padrao: 72pt)
/// - body-size: tamanho da fonte do corpo (padrao: 24pt)
/// - background: cor de fundo (opcional)
/// - accent-color: cor de destaque (opcional)
#let poster(
  title: "",
  subtitle: none,
  authors: (),
  institution: none,
  contact: none,
  abstract-text: none,
  keywords: (),
  num-columns: 3,
  width: 90cm,
  height: 120cm,
  font: "Arial",
  title-size: 72pt,
  body-size: 24pt,
  background: white,
  accent-color: rgb("#003366"),
  body,
) = {
  // Configuracao do documento
  set document(
    title: title,
    author: authors.map(a => if type(a) == dictionary { a.name } else { a }).join(", "),
  )

  // Configuracao de pagina para poster
  set page(
    width: width,
    height: height,
    margin: 2cm,
    fill: background,
  )

  // Configuracao de fonte
  set text(
    font: font,
    size: body-size,
    lang: "pt",
    region: "BR",
  )

  // Configuracao de paragrafo
  set par(
    leading: 1.2em,
    justify: true,
    first-line-indent: 0pt,
  )

  // Configuracao de headings para poster
  show heading.where(level: 1): it => {
    v(0.5em)
    text(
      weight: "bold",
      size: body-size * 1.5,
      fill: accent-color,
      upper(it.body),
    )
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(0.3em)
    text(
      weight: "bold",
      size: body-size * 1.2,
      it.body,
    )
    v(0.3em)
  }

  // Cabecalho do poster (titulo, autores, instituicao)
  align(center)[
    // Titulo
    #text(
      weight: "bold",
      size: title-size,
      fill: accent-color,
      upper(title),
    )

    // Subtitulo
    #if subtitle != none {
      linebreak()
      text(
        size: title-size * 0.6,
        ": " + subtitle,
      )
    }

    #v(1cm)

    // Autores
    #if authors.len() > 0 {
      text(size: body-size * 1.3)[
        #for (i, author) in authors.enumerate() {
          if i > 0 { [, ] }
          if type(author) == dictionary {
            text(weight: "bold", author.name)
            if "affiliation" in author {
              super(str(i + 1))
            }
          } else {
            text(weight: "bold", author)
          }
        }
      ]
      linebreak()

      // Afiliacoes
      v(0.5cm)
      text(size: body-size * 0.9)[
        #for (i, author) in authors.enumerate() {
          if type(author) == dictionary and "affiliation" in author {
            super(str(i + 1))
            author.affiliation
            linebreak()
          }
        }
      ]
    }

    // Instituicao principal
    #if institution != none {
      v(0.3cm)
      text(size: body-size, institution)
    }

    // Contato
    #if contact != none {
      linebreak()
      text(size: body-size * 0.8, contact)
    }
  ]

  v(1cm)

  // Linha divisoria
  line(length: 100%, stroke: 2pt + accent-color)

  v(1cm)

  // Resumo (se fornecido)
  if abstract-text != none {
    box(
      width: 100%,
      inset: 1em,
      fill: accent-color.lighten(90%),
      radius: 5pt,
    )[
      #text(weight: "bold", size: body-size * 1.1)[RESUMO]
      #linebreak()
      #v(0.3em)
      #abstract-text
      #if keywords.len() > 0 {
        v(0.5em)
        text(weight: "bold")[Palavras-chave: ]
        keywords.join("; ")
      }
    ]
    v(1cm)
  }

  // Conteudo em colunas
  columns(num-columns, gutter: 2em, body)
}

/// Secao de poster com caixa colorida
#let poster-section(
  title: none,
  accent-color: rgb("#003366"),
  body,
) = {
  box(
    width: 100%,
    inset: 1em,
    stroke: 2pt + accent-color,
    radius: 5pt,
  )[
    #if title != none {
      align(center)[
        #box(
          fill: accent-color,
          inset: 0.5em,
          radius: 3pt,
        )[
          #text(weight: "bold", fill: white, upper(title))
        ]
      ]
      v(0.5em)
    }
    #body
  ]
  v(1em)
}

/// Caixa de destaque para poster
#let poster-highlight(
  accent-color: rgb("#003366"),
  body,
) = {
  box(
    width: 100%,
    inset: 1em,
    fill: accent-color.lighten(90%),
    radius: 5pt,
  )[
    #body
  ]
  v(0.5em)
}

/// Figura para poster
/// Maior e com legenda mais visivel
#let poster-figure(
  body,
  caption: none,
  source: none,
) = {
  align(center)[
    #body
    #if caption != none {
      v(0.3em)
      text(weight: "bold")[#caption]
    }
    #if source != none {
      linebreak()
      text(size: 0.8em)[Fonte: #source]
    }
  ]
  v(0.5em)
}

/// Referencias para poster
/// Formato compacto, sem notas de rodape
#let poster-references(items) = {
  text(weight: "bold", size: 1.2em)[REFERENCIAS]
  v(0.3em)

  set par(
    hanging-indent: 1em,
    first-line-indent: 0pt,
  )
  set text(size: 0.8em)

  for item in items {
    item
    linebreak()
    v(0.2em)
  }
}

/// Template de poster academico (com orientador)
#let academic-poster(
  title: "",
  subtitle: none,
  authors: (),
  advisor: none,
  institution: none,
  department: none,
  contact: none,
  abstract-text: none,
  keywords: (),
  num-columns: 3,
  width: 90cm,
  height: 120cm,
  font: "Arial",
  title-size: 72pt,
  body-size: 24pt,
  background: white,
  accent-color: rgb("#003366"),
  logo: none,
  body,
) = {
  // Configuracao do documento
  set document(
    title: title,
    author: authors.map(a => if type(a) == dictionary { a.name } else { a }).join(", "),
  )

  // Configuracao de pagina
  set page(
    width: width,
    height: height,
    margin: 2cm,
    fill: background,
  )

  set text(
    font: font,
    size: body-size,
    lang: "pt",
    region: "BR",
  )

  set par(
    leading: 1.2em,
    justify: true,
    first-line-indent: 0pt,
  )

  show heading.where(level: 1): it => {
    v(0.5em)
    text(
      weight: "bold",
      size: body-size * 1.5,
      fill: accent-color,
      upper(it.body),
    )
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(0.3em)
    text(
      weight: "bold",
      size: body-size * 1.2,
      it.body,
    )
    v(0.3em)
  }

  // Cabecalho com logo
  grid(
    columns: if logo != none { (auto, 1fr, auto) } else { (1fr,) },
    gutter: 1cm,
    align: horizon,

    // Logo esquerdo
    if logo != none { logo },

    // Titulo e informacoes
    align(center)[
      #text(
        weight: "bold",
        size: title-size,
        fill: accent-color,
        upper(title),
      )

      #if subtitle != none {
        linebreak()
        text(size: title-size * 0.6, ": " + subtitle)
      }

      #v(0.5cm)

      // Autores
      #text(size: body-size * 1.2)[
        #for (i, author) in authors.enumerate() {
          if i > 0 { [, ] }
          if type(author) == dictionary {
            text(weight: "bold", author.name)
          } else {
            text(weight: "bold", author)
          }
        }
      ]

      // Orientador
      #if advisor != none {
        linebreak()
        text(size: body-size)[Orientador: #advisor]
      }

      #v(0.3cm)

      // Instituicao
      #if institution != none {
        text(size: body-size * 0.9, institution)
      }
      #if department != none {
        linebreak()
        text(size: body-size * 0.8, department)
      }

      #if contact != none {
        linebreak()
        text(size: body-size * 0.7, contact)
      }
    ],

    // Logo direito (mesmo que esquerdo para simetria)
    if logo != none { logo },
  )

  v(1cm)
  line(length: 100%, stroke: 2pt + accent-color)
  v(1cm)

  // Resumo
  if abstract-text != none {
    box(
      width: 100%,
      inset: 1em,
      fill: accent-color.lighten(90%),
      radius: 5pt,
    )[
      #text(weight: "bold", size: body-size * 1.1)[RESUMO]
      #linebreak()
      #v(0.3em)
      #abstract-text
      #if keywords.len() > 0 {
        v(0.5em)
        text(weight: "bold")[Palavras-chave: ]
        keywords.join("; ")
      }
    ]
    v(1cm)
  }

  // Conteudo
  columns(num-columns, gutter: 2em, body)
}

/// Cria um poster A0 (padrao para congressos)
#let poster-a0(
  title: "",
  subtitle: none,
  authors: (),
  institution: none,
  contact: none,
  abstract-text: none,
  keywords: (),
  num-columns: 3,
  font: "Arial",
  accent-color: rgb("#003366"),
  body,
) = {
  poster(
    title: title,
    subtitle: subtitle,
    authors: authors,
    institution: institution,
    contact: contact,
    abstract-text: abstract-text,
    keywords: keywords,
    num-columns: num-columns,
    width: 84.1cm,   // A0 width
    height: 118.9cm, // A0 height
    font: font,
    title-size: 72pt,
    body-size: 24pt,
    accent-color: accent-color,
    body,
  )
}

/// Cria um poster A1
#let poster-a1(
  title: "",
  subtitle: none,
  authors: (),
  institution: none,
  contact: none,
  abstract-text: none,
  keywords: (),
  num-columns: 2,
  font: "Arial",
  accent-color: rgb("#003366"),
  body,
) = {
  poster(
    title: title,
    subtitle: subtitle,
    authors: authors,
    institution: institution,
    contact: contact,
    abstract-text: abstract-text,
    keywords: keywords,
    num-columns: num-columns,
    width: 59.4cm,  // A1 width
    height: 84.1cm, // A1 height
    font: font,
    title-size: 48pt,
    body-size: 18pt,
    accent-color: accent-color,
    body,
  )
}
