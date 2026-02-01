// Citações conforme NBR 10520:2023

/// Citação direta curta (até 3 linhas)
/// Incorporada ao parágrafo, entre aspas duplas
#let quote-short(text, author: none, year: none, page: none) = {
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
#let quote-long(body, author: none, year: none, page: none) = {
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

/// Citação indireta (parafraseada)
/// Apenas menciona o autor e ano
#let cite-indirect(author, year) = {
  [(#upper(author), #year)]
}

/// Citação com autor no texto
/// "Segundo Silva (2023)..."
#let cite-author(author, year) = {
  [#author (#year)]
}

/// Citação com autor fora do texto
/// "... (SILVA, 2023)"
#let cite-parenthetical(author, year, page: none) = {
  [(#upper(author), #year#if page != none [, p. #page])]
}

/// Citação de citação (apud)
/// Autor original apud autor da obra consultada
#let cite-apud(
  original-author,
  original-year,
  secondary-author,
  secondary-year,
  page: none,
) = {
  [(#upper(original-author), #original-year apud #upper(secondary-author), #secondary-year#if page != none [, p. #page])]
}

/// Supressão de texto [...]
#let ellipsis = [[...]]

/// Interpolação de texto [texto]
#let interpolation(text) = {
  [\[#text\]]
}

/// Ênfase adicionada pelo autor da citação
#let emphasis-mine(text) = {
  [#emph(text), grifo nosso]
}

/// Ênfase do autor original
#let emphasis-original(text) = {
  [#emph(text), grifo do autor]
}
