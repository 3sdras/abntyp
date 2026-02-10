// Template para Projeto de Pesquisa conforme NBR 15287:2025
//
// Estrutura:
// - Parte Externa: Capa (opcional), Lombada (opcional)
// - Pre-textual: Folha de rosto, Listas, Sumario
// - Textual: Introducao, Desenvolvimento, Metodologia, Cronograma
// - Pos-textual: Referencias, Glossario, Apendices, Anexos, Indice

#import "../core/page.typ": *
#import "../core/fonts.typ": *
#import "../core/spacing.typ": *
#import "../text/headings.typ": *
#import "../elements/cover.typ": *
#import "../elements/title-page.typ": *
#import "../elements/toc.typ": *
#import "../references/bibliography.typ": *

/// Template principal para Projeto de Pesquisa conforme NBR 15287:2025
///
/// Parametros:
/// - title: titulo do projeto
/// - subtitle: subtitulo (opcional)
/// - author: nome do(s) autor(es) - pode ser string ou array
/// - institution: nome da entidade
/// - location: cidade da entidade
/// - year: ano de entrega
/// - project-type: tipo de projeto (ex: "Projeto de pesquisa apresentado...")
/// - advisor: nome do orientador (opcional)
/// - co-advisor: nome do coorientador (opcional)
/// - coordinator: nome do coordenador (opcional)
/// - volume: numero do volume (se houver mais de um)
/// - font: fonte a usar ("Times New Roman" ou "Arial")
/// - bibliography-file: caminho para arquivo .bib (opcional)
/// - bibliography-title: titulo da secao de referencias
#let projeto-pesquisa(
  title: "",
  subtitle: none,
  author: "",
  institution: "",
  location: "",
  year: datetime.today().year(),
  project-type: none,
  advisor: none,
  co-advisor: none,
  coordinator: none,
  volume: none,
  font: "Times New Roman",
  bibliography-file: none,
  bibliography-title: "REFERENCIAS",
  body,
) = {
  // Configuracao do documento
  set document(
    title: title,
    author: if type(author) == array { author.join(", ") } else { author },
  )

  // Configuracao de pagina conforme NBR 15287
  // Anverso: superior/esquerda 3cm, inferior/direita 2cm
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

  // Configuracao de paragrafo - espacamento 1,5
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
  // Filete de 5cm a partir da margem esquerda
  set footnote.entry(
    separator: line(length: 5cm, stroke: 0.5pt),
  )

  // Conteudo
  body

  // Bibliografia automatica (se arquivo .bib fornecido)
  if bibliography-file != none {
    abnt-bibliography(bibliography-file, title: bibliography-title)
  }
}

/// Capa para Projeto de Pesquisa conforme NBR 15287:2025
/// Elementos na ordem:
/// 1. Nome da entidade (quando solicitado)
/// 2. Nome(s) do(s) autor(es)
/// 3. Titulo
/// 4. Subtitulo (se houver) - precedido de dois pontos
/// 5. Numero do volume (se houver mais de um)
/// 6. Local (cidade) da entidade
/// 7. Ano de entrega
#let project-cover(
  institution: none,
  author: none,
  title: none,
  subtitle: none,
  volume: none,
  location: none,
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  // Instituicao (maiusculas, negrito)
  if institution != none {
    text(weight: "bold", size: 12pt, upper(institution))
  }

  v(1fr)

  // Autor(es)
  if author != none {
    if type(author) == array {
      for a in author {
        text(size: 12pt, upper(a))
        linebreak()
      }
    } else {
      text(size: 12pt, upper(author))
    }
  }

  v(1fr)

  // Titulo (maiusculas, negrito)
  if title != none {
    text(weight: "bold", size: 14pt, upper(title))
  }

  // Subtitulo (precedido de dois-pontos)
  if subtitle != none {
    text(size: 14pt, ": " + subtitle)
  }

  // Volume
  if volume != none {
    v(0.5em)
    text(size: 12pt, "Volume " + str(volume))
  }

  v(1fr)

  // Local e ano
  if location != none {
    text(size: 12pt, upper(location))
    linebreak()
  }

  if year != none {
    text(size: 12pt, str(year))
  }

  pagebreak()
}

/// Folha de rosto para Projeto de Pesquisa conforme NBR 15287:2025
/// Elementos na ordem:
/// 1. Nome(s) do(s) autor(es)
/// 2. Titulo
/// 3. Subtitulo (se houver)
/// 4. Numero do volume (se houver)
/// 5. Tipo de projeto + nome da entidade
/// 6. Nome do orientador/coorientador/coordenador (se houver)
/// 7. Local (cidade)
/// 8. Ano da entrega
#let project-title-page(
  author: none,
  title: none,
  subtitle: none,
  volume: none,
  project-type: none,
  institution: none,
  advisor: none,
  co-advisor: none,
  coordinator: none,
  location: none,
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  // Autor(es)
  if author != none {
    if type(author) == array {
      for a in author {
        text(size: 12pt, upper(a))
        linebreak()
      }
    } else {
      text(size: 12pt, upper(author))
    }
  }

  v(1fr)

  // Titulo (maiusculas, negrito)
  if title != none {
    text(weight: "bold", size: 14pt, upper(title))
  }

  // Subtitulo
  if subtitle != none {
    text(size: 14pt, ": " + subtitle)
  }

  // Volume
  if volume != none {
    v(0.5em)
    text(size: 12pt, "Volume " + str(volume))
  }

  v(2cm)

  // Tipo de projeto e orientadores (recuo de 8cm, espaco simples)
  if project-type != none or advisor != none or coordinator != none {
    set align(right)
    box(width: 8cm)[
      #set align(left)
      #set par(
        leading: 1em * 0.65,
        first-line-indent: 0pt,
        justify: true,
      )
      #set text(size: 10pt)

      #if project-type != none { project-type }
      #if institution != none { linebreak(); institution }

      #if advisor != none {
        linebreak()
        linebreak()
        [Orientador: #advisor]
      }

      #if co-advisor != none {
        linebreak()
        [Coorientador: #co-advisor]
      }

      #if coordinator != none {
        linebreak()
        [Coordenador: #coordinator]
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

/// Cronograma do projeto
/// Cria uma tabela de cronograma com atividades e periodos
///
/// Parametros:
/// - title: titulo da secao (padrao: "CRONOGRAMA")
/// - activities: lista de atividades (strings)
/// - periods: lista de periodos (ex: ("Jan", "Fev", "Mar", ...))
/// - schedule: matriz de booleanos indicando quando cada atividade ocorre
///             schedule.at(i).at(j) = true se atividade i ocorre no periodo j
#let cronograma(
  title: "CRONOGRAMA",
  activities: (),
  periods: (),
  schedule: (),
) = {
  heading(level: 1, title)

  let num-periods = periods.len()
  let num-activities = activities.len()

  // Criar colunas: primeira para atividades, demais para periodos
  let cols = (auto,) + (1fr,) * num-periods

  table(
    columns: cols,
    stroke: 0.5pt,
    inset: 6pt,
    align: (left,) + (center,) * num-periods,

    // Cabecalho
    [*Atividades*],
    ..periods.map(p => [*#p*]),

    // Linhas de atividades
    ..{
      let cells = ()
      for (i, activity) in activities.enumerate() {
        cells.push(activity)
        for j in range(num-periods) {
          if schedule.len() > i and schedule.at(i).len() > j and schedule.at(i).at(j) {
            cells.push([X])
          } else {
            cells.push([])
          }
        }
      }
      cells
    }
  )
}

/// Recursos do projeto
/// Cria uma secao listando os recursos necessarios
///
/// Parametros:
/// - title: titulo da secao (padrao: "RECURSOS")
/// - items: lista de tuplas (descricao, valor) ou apenas descricoes
/// - total: valor total (opcional, calculado automaticamente se valores forem numeros)
#let recursos(
  title: "RECURSOS",
  items: (),
  total: none,
) = {
  heading(level: 1, title)

  if items.len() > 0 {
    // Verificar se items tem valores
    let has-values = if type(items.at(0)) == array { items.at(0).len() > 1 } else { false }

    if has-values {
      // Tabela com descricao e valores
      table(
        columns: (1fr, auto),
        stroke: none,
        inset: 6pt,
        align: (left, right),

        table.hline(stroke: 1pt),
        [*Descricao*], [*Valor (R\$)*],
        table.hline(stroke: 0.5pt),

        ..{
          let cells = ()
          for item in items {
            cells.push(item.at(0))
            cells.push(str(item.at(1)))
          }
          cells
        },

        table.hline(stroke: 0.5pt),

        // Total
        if total != none {
          ([*Total*], [*#str(total)*])
        } else {
          // Calcular total se possivel
          let sum = items.fold(0, (acc, item) => {
            if type(item.at(1)) == int or type(item.at(1)) == float {
              acc + item.at(1)
            } else {
              acc
            }
          })
          ([*Total*], [*#str(sum)*])
        },

        table.hline(stroke: 1pt),
      )
    } else {
      // Lista simples
      for item in items {
        [- #item]
        linebreak()
      }
    }
  }
}

/// Glossario para projeto de pesquisa
/// Conforme NBR 15287 - ordem alfabetica
#let glossario-projeto(items) = {
  heading(level: 1, numbering: none, "GLOSSARIO")

  set par(first-line-indent: 0pt)

  // Ordenar itens alfabeticamente
  let sorted-items = items.pairs().sorted(key: p => p.at(0))

  for (termo, definicao) in sorted-items {
    [*#termo:* #definicao]
    linebreak()
    v(0.5em)
  }

  pagebreak()
}

/// Apendice para projeto de pesquisa
/// Formato: APENDICE A - TITULO EM MAIUSCULAS
#let apendice(letter, title) = {
  pagebreak()
  align(center)[
    #text(weight: "bold", size: 12pt)[APENDICE #letter -- #upper(title)]
  ]
  v(1.5em)
}

/// Anexo para projeto de pesquisa
/// Formato: ANEXO A - TITULO EM MAIUSCULAS
#let anexo(letter, title) = {
  pagebreak()
  align(center)[
    #text(weight: "bold", size: 12pt)[ANEXO #letter -- #upper(title)]
  ]
  v(1.5em)
}
