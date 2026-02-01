// Template para publicacao periodica tecnica e/ou cientifica
// Conforme NBR 6021:2015

#import "../core/page.typ": *
#import "../core/fonts.typ": *
#import "../core/spacing.typ": *
#import "../core/dates.typ": *
#import "../references/abbreviations.typ": *

/// Template principal para fasciculo de periodico
///
/// Parametros:
/// - title: titulo do periodico
/// - subtitle: subtitulo (opcional)
/// - issn: numero ISSN
/// - volume: numero do volume
/// - number: numero do fasciculo
/// - year: ano de publicacao
/// - month-start: mes inicial (1-12)
/// - month-end: mes final (1-12, opcional para periodo)
/// - location: cidade de publicacao
/// - publisher: editora
/// - institution: instituicao responsavel
/// - doi: identificador DOI (opcional)
/// - font: fonte a usar
#let periodical(
  title: "",
  subtitle: none,
  issn: none,
  volume: none,
  number: none,
  year: datetime.today().year(),
  month-start: none,
  month-end: none,
  location: none,
  publisher: none,
  institution: none,
  doi: none,
  font: "Times New Roman",
  body,
) = {
  // Configuracao do documento
  set document(
    title: title,
  )

  // Configuracao de pagina
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 2cm,
      left: 3cm,
      right: 2cm,
    ),
    numbering: "1",
    number-align: top + right,
    // Legenda bibliografica no rodape
    footer: context {
      let abbrev-title = abbreviate-title(title)
      let month-text = if month-start != none {
        if month-end != none {
          format-month-range(month-start, month-end)
        } else {
          get-month-abbrev(month-start)
        }
      } else { "" }

      let page-num = counter(page).get().first()

      set text(size: 10pt)
      set align(left)
      [#abbrev-title, #location, v. #volume, n. #number, p. #page-num, #month-text #year.]
    },
  )

  // Configuracao de fonte
  set text(
    font: font,
    size: 12pt,
    lang: "pt",
    region: "BR",
  )

  // Configuracao de paragrafo
  set par(
    leading: 1.5em * 0.65,
    justify: true,
    first-line-indent: 1.25cm,
  )

  // Configuracao de headings
  show heading.where(level: 1): it => {
    v(1.5em)
    text(weight: "bold", size: 12pt, upper(it.body))
    v(1.5em)
  }

  show heading.where(level: 2): it => {
    v(1em)
    text(weight: "bold", size: 12pt, it.body)
    v(1em)
  }

  body
}

/// Capa do fasciculo conforme NBR 6021:2015
/// Primeira capa com elementos obrigatorios
///
/// Parametros:
/// - title: titulo do periodico
/// - subtitle: subtitulo (opcional)
/// - issn: numero ISSN (obrigatorio, canto superior direito)
/// - volume: numero do volume
/// - number: numero do fasciculo
/// - year: ano
/// - month-start: mes inicial
/// - month-end: mes final (opcional)
/// - logo: logomarca (opcional)
/// - supplement: indicacao de suplemento (opcional)
#let periodical-cover(
  title: "",
  subtitle: none,
  issn: none,
  volume: none,
  number: none,
  year: none,
  month-start: none,
  month-end: none,
  logo: none,
  supplement: none,
) = {
  set page(numbering: none)

  // ISSN no canto superior direito
  if issn != none {
    place(top + right)[
      #text(size: 10pt)[ISSN #issn]
    ]
  }

  v(2cm)

  // Logomarca (se houver)
  if logo != none {
    align(center)[#logo]
    v(1cm)
  }

  // Titulo e subtitulo
  align(center)[
    #text(weight: "bold", size: 16pt, upper(title))
    #if subtitle != none {
      linebreak()
      text(size: 14pt, subtitle)
    }
  ]

  v(1fr)

  // Indicacao de suplemento
  if supplement != none {
    align(center)[
      #text(size: 12pt, supplement)
    ]
    v(1em)
  }

  // Volume, numero e data
  align(center)[
    #text(size: 12pt)[
      v. #volume
      #h(1em)
      n. #number
      #h(1em)
      #if month-start != none {
        if month-end != none {
          [#month-names.at(month-start)/#month-names.at(month-end)]
        } else {
          month-names.at(month-start)
        }
      }
      #h(0.5em)
      #year
    ]
  ]

  v(2cm)
  pagebreak()
}

/// Folha de rosto do fasciculo (anverso)
/// Conforme NBR 6021:2015 secao 4.3.1
///
/// Parametros:
/// - title: titulo do periodico
/// - issn: numero ISSN
/// - volume: numero do volume
/// - number: numero do fasciculo
/// - pages: intervalo de paginas (ex: "1-154")
/// - year: ano
/// - month-start: mes inicial
/// - month-end: mes final (opcional)
/// - location: cidade de publicacao
#let periodical-title-page(
  title: "",
  issn: none,
  volume: none,
  number: none,
  pages: none,
  year: none,
  month-start: none,
  month-end: none,
  location: none,
) = {
  set page(numbering: none)

  // Titulo com destaque
  align(center)[
    #text(weight: "bold", size: 14pt, upper(title))
  ]

  v(2cm)

  // ISSN acima da legenda bibliografica
  if issn != none {
    align(center)[
      #text(size: 10pt)[ISSN #issn]
    ]
  }

  v(1cm)

  // Legenda bibliografica completa
  let abbrev-title = abbreviate-title(title)
  let month-text = if month-start != none {
    if month-end != none {
      format-month-range(month-start, month-end)
    } else {
      get-month-abbrev(month-start)
    }
  } else { "" }

  align(center)[
    #text(size: 10pt)[
      #abbrev-title, #location, v. #volume, n. #number, p. #pages, #month-text #year.
    ]
  ]

  v(1fr)
  pagebreak()
}

/// Verso da folha de rosto
/// Conforme NBR 6021:2015 secao 4.3.1.2
///
/// Parametros:
/// - copyright-year: ano do copyright
/// - copyright-holder: detentor dos direitos
/// - reproduction-rights: autorizacao de reproducao (opcional)
/// - other-formats: outros suportes disponiveis (opcional)
/// - cataloging: dados de catalogacao na publicacao
/// - credits: creditos e outras informacoes
#let periodical-title-page-verso(
  copyright-year: none,
  copyright-holder: none,
  reproduction-rights: none,
  other-formats: none,
  cataloging: none,
  credits: none,
) = {
  set page(numbering: none)
  set text(size: 10pt)
  set par(first-line-indent: 0pt, leading: 1em * 0.65)

  // Copyright
  if copyright-year != none and copyright-holder != none {
    [(c) #copyright-year #copyright-holder]
    v(1em)
  }

  // Autorizacao de reproducao
  if reproduction-rights != none {
    reproduction-rights
    v(1em)
  }

  // Outros suportes
  if other-formats != none {
    other-formats
    v(1em)
  }

  // Creditos
  if credits != none {
    credits
    v(1em)
  }

  v(1fr)

  // Dados de catalogacao (parte inferior)
  if cataloging != none {
    align(center)[
      #box(
        width: 12cm,
        stroke: 0.5pt,
        inset: 0.5cm,
      )[
        #cataloging
      ]
    ]
  }

  pagebreak()
}

/// Sumario do fasciculo
/// Conforme NBR 6027
#let periodical-toc(
  title: "SUMARIO",
) = {
  align(center)[
    #text(weight: "bold", size: 12pt, title)
  ]

  v(1.5em)

  outline(
    title: none,
    depth: 2,
    indent: auto,
  )

  pagebreak()
}

/// Editorial
/// Texto do editor apresentando o conteudo do fasciculo
#let editorial(content) = {
  heading(level: 1, numbering: none, "EDITORIAL")
  content
  pagebreak()
}

/// Legenda bibliografica completa
/// Para uso no rodape de cada pagina ou folha de rosto
///
/// Parametros:
/// - title: titulo do periodico (sera abreviado)
/// - location: cidade
/// - volume: numero do volume
/// - number: numero do fasciculo
/// - pages: paginas (ex: "1-154" para fasciculo, "9-21" para artigo)
/// - month-start: mes inicial (1-12)
/// - month-end: mes final (1-12, opcional)
/// - year: ano
#let bibliographic-legend(
  title: "",
  location: "",
  volume: none,
  number: none,
  pages: none,
  month-start: none,
  month-end: none,
  year: none,
) = {
  let abbrev-title = abbreviate-title(title)

  let month-text = if month-start != none {
    if month-end != none {
      format-month-range(month-start, month-end)
    } else {
      get-month-abbrev(month-start)
    }
  } else { "" }

  text(size: 10pt)[
    #abbrev-title, #location, v. #volume, n. #number, p. #pages, #month-text #year.
  ]
}

/// Artigo em periodico
/// Conforme NBR 6022:2018 (integrado com NBR 6021:2015)
///
/// Parametros:
/// - title: titulo do artigo
/// - authors: lista de autores com afiliacao
/// - abstract-pt: resumo em portugues
/// - keywords-pt: palavras-chave
/// - abstract-en: abstract em ingles (opcional)
/// - keywords-en: keywords (opcional)
#let periodical-article(
  title: "",
  authors: (),
  abstract-pt: none,
  keywords-pt: (),
  abstract-en: none,
  keywords-en: (),
  body,
) = {
  // Titulo do artigo
  align(center)[
    #text(weight: "bold", size: 12pt, upper(title))
  ]

  v(1em)

  // Autores
  for author in authors {
    align(center)[
      #text(size: 12pt, author.name)
      #if "affiliation" in author {
        footnote(author.affiliation)
      }
    ]
  }

  v(2em)

  // Resumo
  if abstract-pt != none {
    set par(first-line-indent: 0pt)
    [*RESUMO*]
    linebreak()
    abstract-pt
    if keywords-pt.len() > 0 {
      linebreak()
      linebreak()
      [*Palavras-chave:* #keywords-pt.join(". ").]
    }
    v(2em)
  }

  // Abstract
  if abstract-en != none {
    set par(first-line-indent: 0pt)
    [*ABSTRACT*]
    linebreak()
    abstract-en
    if keywords-en.len() > 0 {
      linebreak()
      linebreak()
      [*Keywords:* #keywords-en.join(". ").]
    }
    v(2em)
  }

  // Corpo do artigo
  body
}

/// Instrucoes editoriais para autores
/// Conforme NBR 6021:2015 secao 4.5.2
#let author-guidelines(content) = {
  heading(level: 1, numbering: none, "INSTRUCOES PARA AUTORES")
  set par(first-line-indent: 0pt)
  content
}

/// Suplemento de periodico
/// Conforme NBR 6021:2015 secao 5.4
///
/// Parametros:
/// - main-title: titulo do periodico principal
/// - supplement-title: titulo do suplemento
/// - volume: volume do periodico principal
/// - year: ano
/// - issn: ISSN do periodico principal
#let supplement-info(
  main-title: "",
  supplement-title: "",
  volume: none,
  year: none,
  issn: none,
) = {
  text(size: 10pt)[
    Suplemento de: #main-title, v. #volume, #year.
    #if issn != none { [ISSN #issn] }
  ]
}
