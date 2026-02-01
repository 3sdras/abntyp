// Resumo e Abstract conforme NBR 6028:2021

/// Cria página de resumo conforme ABNT
/// - title: "RESUMO" ou "ABSTRACT"
/// - content: texto do resumo (150-500 palavras para trabalhos acadêmicos)
/// - keywords: lista de palavras-chave (3 a 5)
/// - keyword-label: "Palavras-chave" ou "Keywords"
#let abstract-page(
  title: "RESUMO",
  content: none,
  keywords: (),
  keyword-label: "Palavras-chave",
) = {
  // Título centralizado, negrito
  align(center)[
    #text(weight: "bold", size: 12pt, title)
  ]

  v(1.5em)

  // Texto do resumo (parágrafo único, espaçamento simples entre linhas)
  set par(
    leading: 1.5em * 0.65,
    first-line-indent: 0pt,
    justify: true,
  )

  content

  v(1.5em)

  // Palavras-chave
  if keywords.len() > 0 {
    set par(first-line-indent: 0pt)
    [*#keyword-label:* #keywords.join(". "). ]
  }

  pagebreak()
}

/// Resumo em português
#let resumo(content, keywords: ()) = {
  abstract-page(
    title: "RESUMO",
    content: content,
    keywords: keywords,
    keyword-label: "Palavras-chave",
  )
}

/// Abstract em inglês
#let abstract(content, keywords: ()) = {
  abstract-page(
    title: "ABSTRACT",
    content: content,
    keywords: keywords,
    keyword-label: "Keywords",
  )
}

/// Resumo em língua estrangeira (genérico)
#let foreign-abstract(
  title: "ABSTRACT",
  content: none,
  keywords: (),
  keyword-label: "Keywords",
) = {
  abstract-page(
    title: title,
    content: content,
    keywords: keywords,
    keyword-label: keyword-label,
  )
}
