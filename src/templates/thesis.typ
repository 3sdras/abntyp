// Template para tese/dissertação/TCC conforme NBR 14724:2024

#import "../core/page.typ": *
#import "../core/fonts.typ": *
#import "../core/spacing.typ": *
#import "../text/headings.typ": *
#import "../elements/cover.typ": *
#import "../elements/title-page.typ": *
#import "../elements/abstract.typ": *
#import "../elements/toc.typ": *
#import "../references/bibliography.typ": *

/// Template principal para trabalhos acadêmicos (tese, dissertação, TCC)
///
/// Parâmetros:
/// - title: título do trabalho
/// - subtitle: subtítulo (opcional)
/// - author: nome do autor
/// - institution: nome da instituição
/// - faculty: faculdade/unidade
/// - program: programa de pós-graduação
/// - location: cidade
/// - year: ano de depósito
/// - nature: natureza do trabalho
/// - objective: objetivo (ex: "Dissertação apresentada ao Programa...")
/// - area: área de concentração
/// - advisor: orientador
/// - co-advisor: coorientador (opcional)
/// - keywords-pt: palavras-chave em português
/// - keywords-en: keywords em inglês
/// - font: fonte a usar ("Times New Roman" ou "Arial")
/// - bibliography-file: caminho para arquivo .bib (opcional)
/// - bibliography-title: título da seção de referências (padrão: "REFERÊNCIAS")
#let abntcc(
  title: "",
  subtitle: none,
  author: "",
  institution: "",
  faculty: none,
  program: none,
  location: "",
  year: datetime.today().year(),
  nature: none,
  objective: none,
  area: none,
  advisor: none,
  co-advisor: none,
  keywords-pt: (),
  keywords-en: (),
  font: "Times New Roman",
  bibliography-file: none,
  bibliography-title: "REFERÊNCIAS",
  body,
) = {
  // Configuração do documento
  set document(
    title: title,
    author: author,
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
    first-line-indent: 1.25cm,
  )

  // Configuração de headings
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5em)
    if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    text(weight: "bold", size: 12pt, upper(it.body))
    v(1.5em)
  }

  show heading.where(level: 2): it => {
    v(1.5em)
    if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    text(weight: "regular", size: 12pt, upper(it.body))
    v(1.5em)
  }

  show heading.where(level: 3): it => {
    v(1.5em)
    if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    text(weight: "bold", size: 12pt, it.body)
    v(1.5em)
  }

  show heading.where(level: 4): it => {
    v(1.5em)
    if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    text(weight: "regular", size: 12pt, it.body)
    v(1.5em)
  }

  // Configuração de notas de rodapé
  set footnote.entry(
    separator: line(length: 5cm, stroke: 0.5pt),
  )

  // Conteúdo
  body

  // Bibliografia automática (se arquivo .bib fornecido)
  if bibliography-file != none {
    abnt-bibliography(bibliography-file, title: bibliography-title)
  }
}

/// Marca início da parte pré-textual (sem numeração visível)
#let pretextual() = {
  counter(page).update(1)
  set page(numbering: none)
}

/// Marca início da parte textual (numeração arábica)
#let textual() = {
  counter(page).update(1)
  set page(
    numbering: "1",
    number-align: top + right,
  )
}

/// Marca início da parte pós-textual
#let postextual() = {
  // Continua numeração
}

/// Página de dedicatória
#let dedicatoria(content) = {
  set page(numbering: none)
  v(1fr)
  align(right)[
    #box(width: 50%)[
      #set par(first-line-indent: 0pt)
      #content
    ]
  ]
  pagebreak()
}

/// Página de agradecimentos
#let agradecimentos(content) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "AGRADECIMENTOS")
  ]
  v(1.5em)
  content
  pagebreak()
}

/// Epígrafe
#let epigrafe(quote, author) = {
  set page(numbering: none)
  v(1fr)
  align(right)[
    #box(width: 50%)[
      #set par(first-line-indent: 0pt)
      "#quote" \
      [(#author)]
    ]
  ]
  pagebreak()
}
