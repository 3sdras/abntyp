// Capa conforme NBR 14724:2024
// Elementos obrigatórios: instituição, autor, título, subtítulo, local, ano

/// Cria capa conforme ABNT
/// - institution: nome da instituição (em maiúsculas)
/// - author: nome do autor
/// - title: título do trabalho
/// - subtitle: subtítulo (opcional)
/// - location: cidade
/// - year: ano de depósito
#let capa(
  institution: none,
  faculty: none,
  program: none,
  author: none,
  title: none,
  subtitle: none,
  location: none,
  year: none,
) = {
  set page(numbering: none)
  set align(center)

  // Instituição (maiúsculas, negrito)
  if institution != none {
    text(weight: "bold", size: 12pt, upper(institution))
    linebreak()
  }

  if faculty != none {
    text(weight: "bold", size: 12pt, upper(faculty))
    linebreak()
  }

  if program != none {
    text(weight: "bold", size: 12pt, upper(program))
  }

  v(1fr)

  // Autor
  if author != none {
    text(size: 12pt, upper(author))
  }

  v(1fr)

  // Título (maiúsculas, negrito)
  if title != none {
    if subtitle != none {
      // Título com dois-pontos no final
      text(weight: "bold", size: 14pt, upper(title) + ":")
      linebreak()
      // Subtítulo em linha separada
      text(size: 14pt, subtitle)
    } else {
      text(weight: "bold", size: 14pt, upper(title))
    }
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
