// Sistema de citacoes e referencias conforme NBR 6023:2018 e NBR 10520:2023
//
// ============================================================================
// SISTEMAS DE CHAMADA (NBR 10520:2023, secao 4)
// ============================================================================
//
// A NBR 10520:2023 permite dois sistemas de chamada para citacoes:
//
// 1. SISTEMA AUTOR-DATA (este arquivo)
//    - Formato: (Autor, ano) ou (Autor, ano, p. X)
//    - Mais comum em trabalhos academicos no Brasil
//    - Pode ser usado com notas de rodape
//
// 2. SISTEMA NUMERICO (ver numeric.typ)
//    - Formato: (1) ou (1, p. X) ou sobrescrito
//    - Permitido pela norma, inspirado no abntex2-num.bst
//    - NAO pode ser usado com notas de rodape
//
// Escolha UM sistema e use consistentemente em todo o trabalho.
//
// ============================================================================

// Este modulo fornece funcoes auxiliares para o sistema AUTOR-DATA
// Para referências completas, usar arquivo .bib com estilo CSL ABNT
// Para sistema numerico, ver: numeric.typ

/// Formata citação autor-data
/// - author: sobrenome do autor
/// - year: ano da publicação
/// - page: página (opcional)
#let citar(author, year, page: none) = {
  [(#upper(author), #year#if page != none [, p. #page])]
}

/// Citação com autor no texto
/// "Segundo Silva (2023)..."
#let citar-autor(author, year) = {
  [#author (#year)]
}

/// Citação indireta (parafraseada)
/// Apenas menciona o autor e ano
#let citar-indireto(author, year) = {
  [(#upper(author), #year)]
}

/// Citação de citação (apud)
/// Autor original apud autor da obra consultada
#let citar-apud(
  original-author,
  original-year,
  secondary-author,
  secondary-year,
  page: none,
) = {
  [(#upper(original-author), #original-year apud #upper(secondary-author), #secondary-year#if page != none [, p. #page])]
}

/// Citação com múltiplos autores (até 3)
#let citar-multiplos(authors, year, page: none) = {
  let formatted = authors.map(a => upper(a)).join("; ")
  [(#formatted, #year#if page != none [, p. #page])]
}

/// Citação com mais de 3 autores (et al.)
#let citar-etal(first-author, year, page: none) = {
  [(#upper(first-author) et al., #year#if page != none [, p. #page])]
}

/// Citação de entidade coletiva
#let citar-entidade(entity, year, page: none) = {
  [(#upper(entity), #year#if page != none [, p. #page])]
}

/// Citação de obra sem autoria
#let citar-titulo(title, year, page: none) = {
  [(#upper(title), #year#if page != none [, p. #page])]
}

/// Título da seção de referências
#let referencias-titulo() = {
  heading(level: 1, numbering: none, "REFERÊNCIAS")
}

// Funções para formatação manual de referências
// (usar quando não for possível usar .bib)

/// Formata referência de livro
#let ref-livro(
  author: none,
  title: none,
  subtitle: none,
  edition: none,
  location: none,
  publisher: none,
  year: none,
) = {
  set par(
    hanging-indent: 1.25cm,
    first-line-indent: 0pt,
  )

  if author != none { upper(author); [. ] }
  if title != none { strong(title) }
  if subtitle != none { [: #subtitle] }
  [. ]
  if edition != none { [#edition. ed. ] }
  if location != none { [#location: ] }
  if publisher != none { publisher }
  if year != none { [, #year.] }
}

/// Formata referência de artigo de periódico
#let ref-artigo(
  author: none,
  title: none,
  journal: none,
  location: none,
  volume: none,
  number: none,
  pages: none,
  month: none,
  year: none,
) = {
  set par(
    hanging-indent: 1.25cm,
    first-line-indent: 0pt,
  )

  if author != none { upper(author); [. ] }
  if title != none { [#title. ] }
  if journal != none { strong(journal) }
  if location != none { [, #location] }
  if volume != none { [, v. #volume] }
  if number != none { [, n. #number] }
  if pages != none { [, p. #pages] }
  if month != none { [, #month] }
  if year != none { [. #year.] }
}

/// Formata referência de documento eletrônico
#let ref-online(
  author: none,
  title: none,
  site: none,
  year: none,
  url: none,
  access-date: none,
) = {
  set par(
    hanging-indent: 1.25cm,
    first-line-indent: 0pt,
  )

  if author != none { upper(author); [. ] }
  if title != none { strong(title); [. ] }
  if site != none { [#site, ] }
  if year != none { year }
  [. ]
  if url != none { [Disponível em: #url. ] }
  if access-date != none { [Acesso em: #access-date.] }
}
