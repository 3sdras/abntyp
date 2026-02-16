// Figuras, quadros, tabelas e ilustrações conforme NBR 14724:2024 e IBGE

/// Configuração de figuras conforme ABNT
/// - Legenda na parte superior: tipo, número, traço, título
/// - Fonte na parte inferior
/// - Centralizadas
#let abnt-figure-setup() = {
  show figure: it => {
    set align(center)
    it
  }

  show figure.caption: it => {
    set text(size: 10pt)
    it
  }
}

/// Container genérico para elementos com título, numeração e fonte (ABNT).
/// É a única forma de criar um `figure()` no ABNTypst.
/// O `suplemento` é inferido automaticamente a partir do `tipo`:
/// - `image` → "Figura" (padrão)
/// - `table` → "Tabela"
/// - `"quadro"` → "Quadro"
///
/// Uso:
/// ```typst
/// #container(legenda: "Meu título", origem: "O autor")[
///   #imagem("foto.png")
/// ]
/// ```
#let container(
  body,
  legenda: none,
  origem: none,
  nota: none,
  tipo: image,
  suplemento: auto,
  ..args,
) = {
  let supp = if suplemento != auto { suplemento }
    else if tipo == image { "Figura" }
    else if tipo == table { "Tabela" }
    else if tipo == "quadro" { "Quadro" }
    else { "Figura" }

  figure(
    body,
    caption: if legenda != none { legenda },
    kind: tipo,
    supplement: supp,
    ..args,
  )

  if origem != none {
    align(center)[
      #text(size: 10pt)[Fonte: #origem]
    ]
  }

  if nota != none {
    align(left)[
      #text(size: 10pt)[Nota: #nota]
    ]
  }
}

/// Wrapper para `image()` em português.
/// Aceita os mesmos parâmetros de `image()`.
///
/// Uso (dentro de um `container`):
/// ```typst
/// #container(legenda: "Logo", origem: "O autor")[
///   #imagem("logo.png", width: 80%)
/// ]
/// ```
#let imagem(caminho, ..args) = {
  image(caminho, ..args)
}

/// Quadro: tabela textual com bordas fechadas (conforme IBGE).
/// Aceita os mesmos parâmetros de `table()`.
///
/// Uso (dentro de um `container`):
/// ```typst
/// #container(legenda: "Glossário", tipo: "quadro", origem: "O autor")[
///   #quadro(columns: 2,
///     [*Termo*], [*Definição*],
///     [Algoritmo], [Sequência finita de instruções],
///   )
/// ]
/// ```
#let quadro(..args) = {
  table(..args)
}

/// Fonte da figura (para usar avulso abaixo de um elemento)
#let fonte(conteudo) = {
  align(center)[
    #text(size: 10pt)[Fonte: #conteudo]
  ]
}

/// Nota da figura (para usar avulso abaixo de um elemento)
#let nota-figura(conteudo) = {
  align(left)[
    #text(size: 10pt)[Nota: #conteudo]
  ]
}
