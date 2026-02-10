// Citações conforme NBR 10520:2023

/// Citação direta curta (até 3 linhas)
/// Incorporada ao parágrafo, entre aspas duplas
#let citacao-curta(text, author: none, year: none, page: none) = {
  ["#text"]
  if author != none or year != none or page != none {
    [ (]
    if author != none { upper(author) }
    if year != none {
      if author != none { [, ] }
      [#year]
    }
    if page != none {
      [, p. #page]
    }
    [)]
  }
}

/// Citação direta longa (mais de 3 linhas)
/// Recuo de 4 cm da margem esquerda, fonte tamanho 10, espaçamento simples
#let citacao-longa(body, author: none, year: none, page: none) = {
  v(1em)
  pad(left: 4cm)[
    #set text(size: 10pt)
    #set par(
      leading: 1em * 0.65,
      first-line-indent: 0pt,
      justify: true,
    )
    #body
    #if author != none or year != none or page != none {
      [ (]
      if author != none { upper(author) }
      if year != none {
        if author != none { [, ] }
        [#year]
      }
      if page != none {
        [, p. #page]
      }
      [)]
    }
  ]
  v(1em)
}

/// Supressão de texto [...]
#let supressao = [[...]]

/// Interpolação de texto [texto]
#let interpolacao(text) = {
  [\[#text\]]
}

/// Ênfase adicionada pelo autor da citação
#let grifo-nosso(text) = {
  [#emph(text), grifo nosso]
}

/// Ênfase do autor original
#let grifo-do-autor(text) = {
  [#emph(text), grifo do autor]
}
