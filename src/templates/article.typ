// Template para artigo científico conforme NBR 6022:2018

#import "../core/page.typ": *
#import "../core/fonts.typ": *
#import "../core/spacing.typ": *
#import "../references/bibliography.typ": *

/// Template para artigo científico
///
/// Parâmetros:
/// - title: título do artigo
/// - subtitle: subtítulo (opcional)
/// - authors: lista de autores com afiliação
/// - abstract-pt: resumo em português
/// - abstract-en: abstract em inglês
/// - keywords-pt: palavras-chave
/// - keywords-en: keywords
/// - font: fonte a usar
/// - columns: número de colunas (1 ou 2)
/// - bibliography-file: caminho para arquivo .bib (opcional)
/// - bibliography-title: título da seção de referências (padrão: "REFERÊNCIAS")
#let artigo(
  title: "",
  subtitle: none,
  authors: (),
  abstract-pt: none,
  abstract-en: none,
  keywords-pt: (),
  keywords-en: (),
  font: "Times New Roman",
  columns: 1,
  bibliography-file: none,
  bibliography-title: "REFERÊNCIAS",
  body,
) = {
  // Configuração do documento
  set document(
    title: title,
    author: authors.map(a => a.name).join(", "),
  )

  // Configuração de página
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
  )

  // Configuração de fonte
  set text(
    font: font,
    size: 12pt,
    lang: "pt",
    region: "BR",
  )

  // Configuração de parágrafo
  set par(
    leading: 1.5em * 0.65,
    justify: true,
    first-line-indent: (amount: 1.25cm, all: true),
  )

  set list(indent: 2em, body-indent: 0.5em)
  set enum(indent: 2em, body-indent: 0.5em)
  set terms(indent: 0em, hanging-indent: 2em, separator: [: ])

  // Configuração de headings (sem numeração para artigo)
  show heading.where(level: 1): it => {
    v(1.5em)
    text(weight: "bold", size: 12pt)[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #upper(it.body)
    ]
    v(1.5em)
  }

  show heading.where(level: 2): it => {
    v(1em)
    text(weight: "regular", size: 12pt)[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #upper(it.body)
    ]
    v(1em)
  }

  // Excluir indentação de containers que não devem ser indentados
  show heading: set par(first-line-indent: 0pt)
  show figure: set par(first-line-indent: 0pt)
  show raw: set par(first-line-indent: 0pt)
  show outline: set par(first-line-indent: 0pt)
  show terms: set par(first-line-indent: 0pt)

  // Título centralizado, maiúsculas, negrito
  align(center)[
    #text(weight: "bold", size: 14pt, upper(title))
    #if subtitle != none {
      linebreak()
      text(size: 14pt, ": " + subtitle)
    }
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
    [*RESUMO*]
    linebreak()
    set par(first-line-indent: 0pt)
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
    [*ABSTRACT*]
    linebreak()
    set par(first-line-indent: 0pt)
    abstract-en
    if keywords-en.len() > 0 {
      linebreak()
      linebreak()
      [*Keywords:* #keywords-en.join(". ").]
    }
    v(2em)
  }

  // Corpo do artigo
  if columns == 2 {
    columns(2, body)
  } else {
    body
  }

  // Bibliografia automática (se arquivo .bib fornecido)
  if bibliography-file != none {
    abnt-bibliography(bibliography-file, title: bibliography-title)
  }
}

/// Seção de artigo (sem numeração)
#let article-section(title) = {
  heading(level: 1, numbering: none, title)
}

/// Subseção de artigo
#let article-subsection(title) = {
  heading(level: 2, numbering: none, title)
}
