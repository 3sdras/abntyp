// Template para livros e folhetos conforme NBR 6029:2023
// Informacao e documentacao - Livros e folhetos - Apresentacao

#import "../core/page.typ": *
#import "../core/fonts.typ": *
#import "../core/spacing.typ": *
#import "../core/dates.typ": *

/// Template principal para livro ou folheto
/// Conforme NBR 6029:2023
///
/// Parametros:
/// - title: titulo da obra
/// - subtitle: subtitulo (opcional)
/// - author: nome do autor
/// - publisher: nome da editora
/// - location: cidade de publicacao
/// - year: ano de publicacao
/// - edition: numero da edicao (a partir da 2a)
/// - volume: numero do volume (se houver)
/// - isbn: numero ISBN
/// - font: fonte a usar
/// - running-header: titulo corrente (opcional)
#let book(
  title: "",
  subtitle: none,
  author: "",
  publisher: "",
  location: "",
  year: datetime.today().year(),
  edition: none,
  volume: none,
  isbn: none,
  font: "Times New Roman",
  running-header: none,
  body,
) = {
  // Configuracao do documento
  set document(
    title: title,
    author: author,
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
    // Titulo corrente no alto da mancha
    header: context {
      if running-header != none {
        let page-num = counter(page).get().first()
        // Paginas pares: autor/titulo a esquerda
        // Paginas impares: capitulo a direita
        if calc.rem(page-num, 2) == 0 {
          // Pagina par
          text(size: 10pt, running-header)
        } else {
          // Pagina impar
          align(right)[
            #text(size: 10pt, running-header)
          ]
        }
      }
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

  // Configuracao de headings com numeracao progressiva
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5em)
    if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    text(weight: "bold", size: 14pt, upper(it.body))
    v(1.5em)
  }

  show heading.where(level: 2): it => {
    v(1.5em)
    if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    text(weight: "bold", size: 12pt, it.body)
    v(1.5em)
  }

  show heading.where(level: 3): it => {
    v(1.5em)
    if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    text(weight: "regular", size: 12pt, it.body)
    v(1em)
  }

  // Notas de rodape
  set footnote.entry(
    separator: line(length: 5cm, stroke: 0.5pt),
  )

  body
}

/// Primeira capa do livro
/// Conforme NBR 6029:2023 - deve conter:
/// - Nome do autor
/// - Titulo e subtitulo por extenso
/// - Nome da editora e/ou logomarca
/// - Recomenda-se: edicao, local e ano
///
/// Parametros:
/// - author: nome do autor
/// - title: titulo da obra
/// - subtitle: subtitulo (opcional)
/// - publisher: nome da editora
/// - publisher-logo: logomarca da editora (opcional)
/// - edition: numero da edicao (opcional)
/// - location: cidade (opcional)
/// - year: ano (opcional)
#let book-cover(
  author: "",
  title: "",
  subtitle: none,
  publisher: "",
  publisher-logo: none,
  edition: none,
  location: none,
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  v(2cm)

  // Autor
  text(size: 14pt, upper(author))

  v(1fr)

  // Titulo
  text(weight: "bold", size: 18pt, upper(title))

  // Subtitulo
  if subtitle != none {
    linebreak()
    text(size: 14pt, ": " + subtitle)
  }

  v(1fr)

  // Edicao
  if edition != none {
    text(size: 12pt)[#edition. edicao]
    v(0.5em)
  }

  // Editora
  if publisher-logo != none {
    publisher-logo
    v(0.5em)
  }
  text(size: 12pt, publisher)

  v(1em)

  // Local e ano
  if location != none {
    text(size: 12pt, location)
    linebreak()
  }
  if year != none {
    text(size: 12pt, str(year))
  }

  v(2cm)
  pagebreak()
}

/// Quarta capa (contracapa)
/// Conforme NBR 6029:2023 - deve conter:
/// - ISBN (obrigatorio)
/// - Codigo de barras (se houver)
/// - Pode conter: resumo e endereco da editora
///
/// Parametros:
/// - isbn: numero ISBN
/// - barcode: codigo de barras (imagem, opcional)
/// - summary: resumo do conteudo (opcional)
/// - publisher-address: endereco da editora (opcional)
#let book-back-cover(
  isbn: "",
  barcode: none,
  summary: none,
  publisher-address: none,
) = {
  set page(numbering: none)

  v(1fr)

  // Resumo
  if summary != none {
    set par(first-line-indent: 0pt)
    summary
    v(2em)
  }

  // Endereco da editora
  if publisher-address != none {
    set text(size: 10pt)
    publisher-address
    v(2em)
  }

  v(1fr)

  // ISBN e codigo de barras
  align(left)[
    #text(size: 10pt)[ISBN #isbn]
  ]

  if barcode != none {
    v(0.5em)
    barcode
  }

  pagebreak()
}

/// Falsa folha de rosto (opcional)
/// Apenas o titulo da obra
#let half-title-page(title: "") = {
  set page(numbering: none)
  set align(center)

  v(1fr)
  text(size: 14pt, title)
  v(1fr)

  pagebreak()
}

/// Folha de rosto - anverso
/// Conforme NBR 6029:2023 - elementos na ordem:
/// a) Autor
/// b) Titulo e subtitulo
/// c) Outros colaboradores
/// d) Indicacao de edicao (a partir da 2a)
/// e) Numeracao do volume
/// f) Editora
/// g) Local de publicacao
/// h) Ano de publicacao
///
/// Parametros:
/// - author: nome do autor
/// - title: titulo
/// - subtitle: subtitulo (opcional)
/// - collaborators: outros colaboradores (tradutor, ilustrador, etc.)
/// - edition: numero da edicao (a partir da 2a)
/// - volume: numero do volume (se houver)
/// - publisher: editora
/// - location: cidade
/// - year: ano
#let book-title-page(
  author: "",
  title: "",
  subtitle: none,
  collaborators: none,
  edition: none,
  volume: none,
  publisher: "",
  location: "",
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  // Autor
  text(size: 12pt, upper(author))

  v(1fr)

  // Titulo
  text(weight: "bold", size: 16pt, upper(title))

  // Subtitulo (diferenciado tipograficamente)
  if subtitle != none {
    linebreak()
    text(size: 14pt, ": " + subtitle)
  }

  v(1em)

  // Colaboradores
  if collaborators != none {
    set text(size: 11pt)
    collaborators
  }

  v(1em)

  // Edicao
  if edition != none {
    text(size: 11pt)[#edition. edicao]
    v(0.5em)
  }

  // Volume
  if volume != none {
    text(size: 11pt)[Volume #volume]
  }

  v(1fr)

  // Editora
  text(size: 12pt, publisher)

  v(0.5em)

  // Local
  text(size: 12pt, location)

  // Ano
  if year != none {
    linebreak()
    text(size: 12pt, str(year))
  }

  pagebreak()
}

/// Folha de rosto - verso
/// Conforme NBR 6029:2023 - deve conter:
/// a) Direito autoral
/// b) Direito de reproducao
/// c) Titulo original (se traducao)
/// d) Outros suportes disponiveis
/// e) Creditos
/// f) Ficha catalografica + nome e CRB do bibliotecario
/// g) Dados da editora
///
/// Parametros:
/// - copyright-year: ano do copyright
/// - copyright-holder: detentor dos direitos
/// - original-title: titulo original (se traducao)
/// - reproduction-rights: texto sobre direito de reproducao
/// - other-formats: outros suportes disponiveis
/// - credits: creditos diversos
/// - catalog-card: conteudo da ficha catalografica
/// - librarian: nome e CRB do bibliotecario
/// - publisher-info: dados da editora
#let book-title-page-verso(
  copyright-year: none,
  copyright-holder: none,
  original-title: none,
  reproduction-rights: none,
  other-formats: none,
  credits: none,
  catalog-card: none,
  librarian: none,
  publisher-info: none,
) = {
  set page(numbering: none)
  set text(size: 10pt)
  set par(first-line-indent: 0pt, leading: 1em * 0.65)

  // Copyright
  if copyright-year != none and copyright-holder != none {
    [(c) #copyright-year #copyright-holder]
    v(1em)
  }

  // Direito de reproducao
  if reproduction-rights != none {
    reproduction-rights
    v(1em)
  }

  // Titulo original
  if original-title != none {
    [Titulo original: #emph[#original-title]]
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

  // Ficha catalografica (parte inferior)
  if catalog-card != none {
    align(center)[
      #box(
        width: 12.5cm,
        height: auto,
        stroke: 0.5pt,
        inset: 0.5cm,
      )[
        #catalog-card

        #if librarian != none {
          v(0.5em)
          text(size: 9pt, librarian)
        }
      ]
    ]
    v(1em)
  }

  // Dados da editora
  if publisher-info != none {
    align(center)[
      #text(size: 9pt, publisher-info)
    ]
  }

  pagebreak()
}

/// Dedicatoria
/// Conforme NBR 6029:2023 - pagina impar
#let book-dedication(content) = {
  set page(numbering: none)
  v(1fr)
  align(right)[
    #box(width: 50%)[
      #set par(first-line-indent: 0pt)
      #set text(size: 11pt)
      #content
    ]
  ]
  pagebreak()
}

/// Agradecimentos
/// Conforme NBR 6029:2023 - pagina impar
#let book-acknowledgments(content) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "AGRADECIMENTOS")
  ]
  v(1.5em)
  content
  pagebreak()
}

/// Epigrafe
/// Conforme NBR 6029:2023 - pagina impar
#let book-epigraph(quote, author) = {
  set page(numbering: none)
  v(1fr)
  align(right)[
    #box(width: 50%)[
      #set par(first-line-indent: 0pt)
      #set text(size: 11pt, style: "italic")
      "#quote"
      #linebreak()
      #set text(style: "normal")
      [(#author)]
    ]
  ]
  pagebreak()
}

/// Lista de ilustracoes
/// Conforme NBR 6029:2023 - ordem de apresentacao
/// Formato: nome especifico + travessao + titulo + pagina
#let book-list-illustrations() = {
  align(center)[
    #text(weight: "bold", size: 12pt, "LISTA DE ILUSTRACOES")
  ]

  v(1.5em)

  outline(
    title: none,
    target: figure.where(kind: image),
  )

  pagebreak()
}

/// Lista de tabelas
#let book-list-tables() = {
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
/// Conforme NBR 6029:2023 - ordem alfabetica
#let book-list-abbreviations(items) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "LISTA DE ABREVIATURAS E SIGLAS")
  ]

  v(1.5em)

  set par(first-line-indent: 0pt)

  // Ordenar alfabeticamente
  let sorted-keys = items.keys().sorted()
  for key in sorted-keys {
    [#key #h(1em) #items.at(key) \ ]
  }

  pagebreak()
}

/// Lista de simbolos
/// Conforme NBR 6029:2023 - ordem de apresentacao
#let book-list-symbols(items) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "LISTA DE SIMBOLOS")
  ]

  v(1.5em)

  set par(first-line-indent: 0pt)

  for (symbol, meaning) in items {
    [#symbol #h(1em) #meaning \ ]
  }

  pagebreak()
}

/// Sumario do livro
/// Conforme NBR 6027
#let book-toc(
  title: "SUMARIO",
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

/// Prefacio ou apresentacao
/// Conforme NBR 6029:2023 - pagina impar, sem indicativo de secao
/// Em novas edicoes: prefacio novo precede os anteriores
#let book-preface(title: "PREFACIO", content) = {
  heading(level: 1, numbering: none, upper(title))
  content
  pagebreak()
}

/// Apresentacao
#let book-presentation(content) = {
  book-preface(title: "APRESENTACAO", content)
}

/// Posfacio
/// Conforme NBR 6029:2023 - elemento pos-textual opcional
#let book-postface(content) = {
  heading(level: 1, numbering: none, "POSFACIO")
  content
  pagebreak()
}

/// Glossario
/// Conforme NBR 6029:2023 - elemento pos-textual opcional
/// - items: dicionario termo -> definicao
#let book-glossary(items) = {
  heading(level: 1, numbering: none, "GLOSSARIO")

  set par(first-line-indent: 0pt)

  let sorted-keys = items.keys().sorted()
  for key in sorted-keys {
    [*#key:* #items.at(key) \ ]
    v(0.5em)
  }

  pagebreak()
}

/// Apendice
/// Conforme NBR 6029:2023 - identificacao: termo + travessao + titulo
/// Multiplos: letras maiusculas consecutivas (A, B, C...)
#let book-appendix(letter: "A", title: "", body) = {
  heading(level: 1, numbering: none)[APENDICE #letter -- #title]
  body
  pagebreak()
}

/// Anexo
/// Conforme NBR 6029:2023 - identificacao: termo + travessao + titulo
/// Multiplos: letras maiusculas consecutivas (A, B, C...)
#let book-annex(letter: "A", title: "", body) = {
  heading(level: 1, numbering: none)[ANEXO #letter -- #title]
  body
  pagebreak()
}

/// Indice remissivo
/// Conforme NBR 6034 - no final da publicacao
#let book-index(title: "INDICE", entries) = {
  heading(level: 1, numbering: none, upper(title))

  set par(first-line-indent: 0pt)
  set text(size: 10pt)

  // Organizar por letra inicial
  let by-letter = (:)
  for (term, pages) in entries {
    let letter = upper(term.at(0))
    if letter not in by-letter {
      by-letter.insert(letter, ())
    }
    by-letter.at(letter).push((term, pages))
  }

  for letter in by-letter.keys().sorted() {
    text(weight: "bold", size: 11pt, letter)
    linebreak()
    for (term, pages) in by-letter.at(letter) {
      [#term #box(width: 1fr, repeat[.]) #pages \ ]
    }
    v(0.5em)
  }

  pagebreak()
}

/// Colofao
/// Conforme NBR 6029:2023 - ultima folha do miolo
/// Especificacoes graficas da publicacao
#let book-colophon(content) = {
  v(1fr)
  set text(size: 10pt)
  set par(first-line-indent: 0pt)
  align(center)[
    #content
  ]
}

/// Inicia numeracao das paginas (apos elementos pre-textuais)
/// Conforme NBR 6029:2023:
/// - Folhas iniciais ate o Sumario: contadas mas nao numeradas
/// - Algarismos arabicos
/// - Localizacao: fora da mancha, a criterio do projeto grafico
#let book-start-numbering() = {
  counter(page).update(1)
  set page(
    numbering: "1",
    number-align: bottom + center,
  )
}

/// Equacoes e formulas
/// Conforme NBR 6029:2023 - numeradas com algarismos arabicos entre parenteses
#let book-equation(body) = {
  set math.equation(numbering: "(1)")
  body
}
