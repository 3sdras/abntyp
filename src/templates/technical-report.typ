// Template para Relatorio Tecnico e/ou Cientifico conforme NBR 10719:2015
//
// Estrutura:
// Parte Externa:
// - Capa (opcional)
// - Lombada (opcional)
//
// Parte Interna - Pre-textuais:
// - Folha de rosto (obrigatorio)
// - Errata (opcional)
// - Agradecimentos (opcional)
// - Resumo na lingua vernacula (obrigatorio)
// - Lista de ilustracoes (opcional)
// - Lista de tabelas (opcional)
// - Lista de abreviaturas e siglas (opcional)
// - Lista de simbolos (opcional)
// - Sumario (obrigatorio)
//
// Parte Interna - Textuais:
// - Introducao (obrigatorio)
// - Desenvolvimento (obrigatorio)
// - Consideracoes finais (obrigatorio)
//
// Parte Interna - Pos-textuais:
// - Referencias (obrigatorio)
// - Glossario (opcional)
// - Apendice (opcional)
// - Anexo (opcional)
// - Indice (opcional)
// - Formulario de identificacao (opcional)

#import "../core/page.typ": *
#import "../core/fonts.typ": *
#import "../core/spacing.typ": *
#import "../text/headings.typ": *
#import "../elements/toc.typ": *
#import "../elements/abstract.typ": *
#import "../references/bibliography.typ": *

/// Template principal para Relatorio Tecnico conforme NBR 10719:2015
///
/// Parametros:
/// - title: titulo do relatorio
/// - subtitle: subtitulo (opcional)
/// - report-number: numero do relatorio
/// - report-code: codigo de identificacao (sigla+categoria+data+assunto+sequencial)
/// - institution: nome do orgao ou entidade responsavel
/// - institution-address: endereco da instituicao
/// - project-title: titulo do projeto/programa/plano relacionado
/// - authors: lista de autores (nome e qualificacao)
/// - classification: classificacao de seguranca (opcional)
/// - issn: ISSN se houver
/// - location: cidade da instituicao
/// - year: ano de publicacao
/// - volume: numero do volume (se mais de um)
/// - font: fonte a usar
/// - bibliography-file: arquivo .bib (opcional)
/// - bibliography-title: titulo da secao de referencias
#let relatorio(
  title: "",
  subtitle: none,
  report-number: none,
  report-code: none,
  institution: "",
  institution-address: none,
  project-title: none,
  authors: (),
  classification: none,
  issn: none,
  location: "",
  year: datetime.today().year(),
  volume: none,
  font: "Times New Roman",
  bibliography-file: none,
  bibliography-title: "REFERENCIAS",
  body,
) = {
  // Configuracao do documento
  set document(
    title: title,
    author: authors.map(a => if type(a) == dictionary { a.name } else { a }).join(", "),
  )

  // Configuracao de pagina conforme NBR 10719
  // Anverso: esquerda/superior 3cm, direita/inferior 2cm
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 2cm,
      left: 3cm,
      right: 2cm,
    ),
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
    first-line-indent: (amount: 1.25cm, all: true),
  )

  set list(indent: 2em, body-indent: 0.5em)
  set enum(indent: 2em, body-indent: 0.5em)
  set terms(indent: 0em, hanging-indent: 2em, separator: [: ])

  // Configuracao de headings
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
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
    v(1.5em)
    text(weight: "regular", size: 12pt)[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #upper(it.body)
    ]
    v(1.5em)
  }

  show heading.where(level: 3): it => {
    v(1.5em)
    text(weight: "bold", size: 12pt)[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #it.body
    ]
    v(1.5em)
  }

  show heading.where(level: 4): it => {
    v(1.5em)
    text(weight: "regular", size: 12pt)[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #it.body
    ]
    v(1.5em)
  }

  show heading.where(level: 5): it => {
    v(1.5em)
    text(weight: "regular", style: "italic", size: 12pt)[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #it.body
    ]
    v(1.5em)
  }

  // Excluir indentacao de containers que nao devem ser indentados
  show heading: set par(first-line-indent: 0pt)
  show figure: set par(first-line-indent: 0pt)
  show raw: set par(first-line-indent: 0pt)
  show outline: set par(first-line-indent: 0pt)
  show terms: set par(first-line-indent: 0pt)

  // Configuracao de notas de rodape
  set footnote.entry(
    separator: line(length: 5cm, stroke: 0.5pt),
  )

  // Conteudo
  body

  // Bibliografia automatica
  if bibliography-file != none {
    abnt-bibliography(bibliography-file, title: bibliography-title)
  }
}

/// Capa para Relatorio Tecnico conforme NBR 10719:2015
/// Primeira capa - recomenda-se incluir:
/// - Nome e endereco da instituicao responsavel
/// - Numero do relatorio
/// - ISSN (se houver)
/// - Titulo e subtitulo (se houver)
/// - Classificacao de seguranca (se houver)
#let report-cover(
  institution: none,
  institution-address: none,
  report-number: none,
  issn: none,
  title: none,
  subtitle: none,
  classification: none,
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  // Instituicao e endereco
  if institution != none {
    text(weight: "bold", size: 12pt, upper(institution))
    linebreak()
  }

  if institution-address != none {
    text(size: 10pt, institution-address)
  }

  v(1cm)

  // Numero do relatorio e ISSN
  if report-number != none {
    text(size: 11pt, "Relatorio n. " + str(report-number))
    linebreak()
  }

  if issn != none {
    text(size: 10pt, "ISSN " + issn)
  }

  v(1fr)

  // Titulo e subtitulo
  if title != none {
    text(weight: "bold", size: 14pt, upper(title))
  }

  if subtitle != none {
    linebreak()
    text(size: 14pt, ": " + subtitle)
  }

  v(1fr)

  // Classificacao de seguranca
  if classification != none {
    box(
      stroke: 1pt,
      inset: 0.5em,
    )[
      #text(weight: "bold", classification)
    ]
    v(1cm)
  }

  // Ano
  if year != none {
    text(size: 12pt, str(year))
  }

  pagebreak()
}

/// Folha de rosto para Relatorio Tecnico conforme NBR 10719:2015
///
/// Anverso:
/// a) Nome do orgao ou entidade responsavel
/// b) Titulo do projeto/programa/plano relacionado
/// c) Titulo do relatorio
/// d) Subtitulo (precedido de dois pontos)
/// e) Numero do volume (se mais de um)
/// f) Codigo de identificacao
/// g) Classificacao de seguranca
/// h) Nome do autor ou autor-entidade
/// i) Local (cidade) da instituicao
/// j) Ano de publicacao
#let report-title-page(
  institution: none,
  project-title: none,
  title: none,
  subtitle: none,
  volume: none,
  report-code: none,
  classification: none,
  authors: (),
  location: none,
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  // Instituicao
  if institution != none {
    text(weight: "bold", size: 12pt, upper(institution))
    v(0.5cm)
  }

  // Titulo do projeto relacionado
  if project-title != none {
    text(size: 11pt, project-title)
    v(1cm)
  }

  v(1fr)

  // Titulo e subtitulo
  if title != none {
    text(weight: "bold", size: 14pt, upper(title))
  }

  if subtitle != none {
    text(size: 14pt, ": " + subtitle)
  }

  // Volume
  if volume != none {
    v(0.5em)
    text(size: 12pt, "Volume " + str(volume))
  }

  v(1cm)

  // Codigo de identificacao
  if report-code != none {
    text(size: 10pt, report-code)
    v(0.5cm)
  }

  // Classificacao de seguranca
  if classification != none {
    box(
      stroke: 1pt,
      inset: 0.5em,
    )[
      #text(weight: "bold", size: 10pt, classification)
    ]
  }

  v(1fr)

  // Autores
  if authors.len() > 0 {
    for author in authors {
      if type(author) == dictionary {
        text(size: 12pt, author.name)
        if "qualification" in author {
          linebreak()
          text(size: 10pt, author.qualification)
        }
      } else {
        text(size: 12pt, author)
      }
      v(0.5em)
    }
  }

  v(1fr)

  // Local e ano
  if location != none {
    text(size: 12pt, location)
    linebreak()
  }

  if year != none {
    text(size: 12pt, str(year))
  }

  pagebreak()
}

/// Verso da folha de rosto
/// Contem equipe tecnica e/ou dados de catalogacao
#let report-title-page-verso(
  technical-team: none,
  cataloging-data: none,
) = {
  set page(numbering: none)

  // Equipe tecnica (opcional)
  if technical-team != none {
    align(center)[
      #text(weight: "bold", size: 11pt, "EQUIPE TECNICA")
    ]
    v(1em)

    for member in technical-team {
      if type(member) == dictionary {
        [*#member.role:* #member.name]
      } else {
        member
      }
      linebreak()
    }

    v(2cm)
  }

  // Dados de catalogacao (parte inferior)
  v(1fr)

  if cataloging-data != none {
    align(center)[
      #box(
        width: 12.5cm,
        stroke: 0.5pt,
        inset: 0.5cm,
      )[
        #set text(size: 10pt)
        #set par(leading: 1em * 0.65)
        #cataloging-data
      ]
    ]
  }

  pagebreak()
}

/// Errata para Relatorio Tecnico
/// Formato de tabela: Folha, Linha, Onde se le, Leia-se
#let errata(
  reference: none,
  items: (),
) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "ERRATA")
  ]

  v(1.5em)

  // Referencia da publicacao
  if reference != none {
    set par(first-line-indent: 0pt)
    reference
    v(1em)
  }

  // Tabela de erros
  if items.len() > 0 {
    table(
      columns: (auto, auto, 1fr, 1fr),
      stroke: 0.5pt,
      inset: 6pt,
      align: left,

      [*Folha*], [*Linha*], [*Onde se le*], [*Leia-se*],

      ..{
        let cells = ()
        for item in items {
          cells.push(str(item.page))
          cells.push(str(item.line))
          cells.push(item.wrong)
          cells.push(item.correct)
        }
        cells
      }
    )
  }

  pagebreak()
}

/// Agradecimentos para Relatorio Tecnico
#let agradecimentos-relatorio(content) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "AGRADECIMENTOS")
  ]
  v(1.5em)
  content
  pagebreak()
}

/// Resumo para Relatorio Tecnico conforme NBR 6028
#let resumo-relatorio(content, keywords: ()) = {
  align(center)[
    #text(weight: "bold", size: 12pt, "RESUMO")
  ]

  v(1.5em)

  set par(
    leading: 1.5em * 0.65,
    first-line-indent: 0pt,
    justify: true,
  )

  content

  v(1.5em)

  if keywords.len() > 0 {
    [*Palavras-chave:* #keywords.join(". ").]
  }

  pagebreak()
}

/// Formulario de identificacao para Relatorio Tecnico
/// Obrigatorio quando nao utilizados dados de catalogacao-na-publicacao
#let formulario-identificacao(
  title: none,
  classification: none,
  report-number: none,
  report-type: none,
  date: none,
  authors: (),
  institutions: (),
  abstract-text: none,
  keywords: (),
  edition: none,
  pages: none,
  volume: none,
  issn: none,
  distribution: none,
  distributor: none,
  price: none,
  notes: none,
) = {
  heading(level: 1, numbering: none, "FORMULARIO DE IDENTIFICACAO")

  let field(label, value) = {
    if value != none {
      [*#label:* #value]
      linebreak()
    }
  }

  set par(first-line-indent: 0pt)

  field("Titulo", title)
  field("Classificacao de seguranca", classification)
  field("Numero", report-number)
  field("Tipo de relatorio", report-type)
  field("Data", date)

  if authors.len() > 0 {
    [*Autores:*]
    linebreak()
    for author in authors {
      [- #if type(author) == dictionary { author.name } else { author }]
      linebreak()
    }
  }

  if institutions.len() > 0 {
    [*Instituicoes:*]
    linebreak()
    for inst in institutions {
      [- #inst]
      linebreak()
    }
  }

  v(0.5em)

  if abstract-text != none {
    [*Resumo:*]
    linebreak()
    abstract-text
    linebreak()
  }

  if keywords.len() > 0 {
    [*Palavras-chave:* #keywords.join("; ")]
    linebreak()
  }

  v(0.5em)

  field("Edicao", edition)
  field("Numero de paginas", pages)
  field("Volume", volume)
  field("ISSN", issn)
  field("Distribuicao", distribution)
  field("Distribuidor", distributor)
  field("Preco", price)
  field("Observacoes", notes)

  pagebreak()
}

/// Codigo de identificacao do relatorio
/// Formato: sigla da instituicao + categoria + data + assunto + numero sequencial
///
/// Exemplo: INPE-RPE-2024-EST-001
#let report-code(
  institution-code: "",
  category: "",
  year: none,
  subject: "",
  sequence: 1,
  separator: "-",
) = {
  let parts = ()
  parts.push(institution-code)
  parts.push(category)
  if year != none { parts.push(str(year)) }
  parts.push(subject)
  parts.push(str(sequence).clusters().rev().enumerate().map(((i, c)) => {
    if i > 0 and calc.rem(i, 3) == 0 { c }
    else { c }
  }).rev().join(""))

  // Formatar numero com zeros a esquerda
  let seq-str = if sequence < 10 { "00" + str(sequence) }
                else if sequence < 100 { "0" + str(sequence) }
                else { str(sequence) }

  [#institution-code#separator#category#separator#if year != none {str(year) + separator}#subject#separator#seq-str]
}
