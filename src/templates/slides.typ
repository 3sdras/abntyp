// Template para Apresentacao de Slides Academicos
//
// IMPORTANTE: NAO EXISTE NORMA ABNT ESPECIFICA PARA SLIDES
//
// A ABNT (Associacao Brasileira de Normas Tecnicas) nao possui nenhuma norma
// dedicada a apresentacoes de slides. Nao ha regras oficiais para:
// - Fonte, tamanho ou espacamento
// - Layout ou quantidade de texto por slide
// - Estrutura ou organizacao do conteudo
// - Cores ou elementos visuais
//
// Este template oferece um formato padronizado para apresentacoes academicas
// baseado em boas praticas e convencoes comuns em instituicoes brasileiras,
// mas NAO representa uma exigencia normativa da ABNT.
//
// Normas ABNT que PODEM ser aplicadas em slides (quando relevante):
// - NBR 6023:2018 - Referencias bibliograficas (se houver citacoes)
// - NBR 10520:2023 - Citacoes em documentos (formato autor-data)
//
// Baseado no pacote Touying para Typst
// Documentacao: https://touying-typ.github.io/docs/intro/

#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import themes.university: *

// Re-exportar funcoes de citacao do ABNTypst para uso em slides
#import "../references/citation.typ": citar, citar-autor, citar-multiplos, citar-etal, citar-entidade, citar-titulo

// =============================================================================
// TEMPLATE PRINCIPAL: slides()
// =============================================================================

/// Template principal para apresentacao de slides academicos
///
/// NOTA: Nao existe norma ABNT para slides. Este template segue boas praticas
/// academicas comuns no Brasil, mas nao representa exigencia normativa.
///
/// Parametros:
/// - title: titulo da apresentacao
/// - subtitle: subtitulo (opcional)
/// - author: nome do autor/apresentador
/// - advisor: orientador (opcional, para defesas de TCC/dissertacao/tese)
/// - institution: nome da instituicao
/// - department: departamento/programa (opcional)
/// - date: data da apresentacao (padrao: data atual)
/// - logo: logotipo da instituicao (opcional, imagem)
/// - aspect-ratio: proporcao da tela ("16-9" ou "4-3", padrao: "16-9")
/// - font: fonte a usar (padrao: "Arial")
/// - theme: tema visual ("simple", "academic", "institutional")
/// - primary-color: cor principal (padrao: azul institucional)
/// - secondary-color: cor secundaria (opcional)
#let slides(
  title: "",
  subtitle: none,
  author: "",
  advisor: none,
  institution: "",
  department: none,
  date: datetime.today(),
  logo: none,
  aspect-ratio: "16-9",
  font: "Arial",
  theme: "academic",
  primary-color: rgb("#003366"),
  secondary-color: rgb("#666666"),
  body,
) = {
  // Nota sobre ausencia de norma ABNT
  // (Este comentario serve como documentacao para quem ler o codigo-fonte)
  // A ABNT nao possui norma especifica para apresentacoes de slides.
  // As escolhas de formatacao neste template sao baseadas em:
  // 1. Boas praticas de design de apresentacoes
  // 2. Convencoes comuns em instituicoes academicas brasileiras
  // 3. Recomendacoes de legibilidade (fonte 18-24pt para corpo)

  // Configuracao do documento
  set document(
    title: title,
    author: author,
  )

  // Configuracao de texto base
  set text(
    font: font,
    lang: "pt",
    region: "BR",
  )

  // Aplicar tema Touying com configuracoes academicas
  show: simple-theme.with(
    aspect-ratio: aspect-ratio,
    primary: primary-color,
    secondary: secondary-color,
    footer: [#institution #h(1fr) #author],
  )

  // Slide de titulo personalizado
  touying-slide-wrapper(self => {
    touying-slide(self: self, setting: body => {
      set align(center + horizon)
      body
    })[
      // Logo (se fornecido)
      #if logo != none {
        logo
        v(0.5em)
      }

      // Instituicao
      #text(size: 18pt, fill: secondary-color, upper(institution))

      #if department != none {
        linebreak()
        text(size: 14pt, fill: secondary-color, department)
      }

      #v(1em)

      // Titulo
      #text(size: 32pt, weight: "bold", fill: primary-color, title)

      // Subtitulo
      #if subtitle != none {
        linebreak()
        v(0.3em)
        text(size: 20pt, fill: secondary-color, subtitle)
      }

      #v(1.5em)

      // Autor
      #text(size: 18pt, author)

      // Orientador (para defesas)
      #if advisor != none {
        linebreak()
        v(0.3em)
        text(size: 14pt)[Orientador(a): #advisor]
      }

      #v(1em)

      // Data
      #text(size: 14pt, fill: secondary-color)[
        #date.display("[day] de [month repr:long] de [year]")
      ]
    ]
  })

  // Conteudo da apresentacao
  body
}

// =============================================================================
// TEMPLATE PARA DEFESA DE TCC/DISSERTACAO/TESE
// =============================================================================

/// Template especializado para defesa de trabalho academico
///
/// NOTA: Nao existe norma ABNT para slides de defesa. Este template segue
/// convencoes comuns em bancas de defesa no Brasil.
///
/// Parametros adicionais alem de slides():
/// - degree: grau pretendido (ex: "Bacharel em Ciencia da Computacao")
/// - program: programa de pos-graduacao (para mestrado/doutorado)
/// - committee: membros da banca (lista de nomes)
#let slides-defesa(
  title: "",
  subtitle: none,
  author: "",
  advisor: none,
  co-advisor: none,
  institution: "",
  department: none,
  degree: none,
  program: none,
  committee: (),
  date: datetime.today(),
  logo: none,
  aspect-ratio: "16-9",
  font: "Arial",
  primary-color: rgb("#003366"),
  secondary-color: rgb("#666666"),
  body,
) = {
  // Configuracao do documento
  set document(
    title: title,
    author: author,
  )

  set text(
    font: font,
    lang: "pt",
    region: "BR",
  )

  show: simple-theme.with(
    aspect-ratio: aspect-ratio,
    primary: primary-color,
    secondary: secondary-color,
    footer: [#institution #h(1fr) Defesa de #if program != none { "Dissertacao/Tese" } else { "TCC" }],
  )

  // Slide de titulo para defesa
  touying-slide-wrapper(self => {
    touying-slide(self: self, setting: body => {
      set align(center + horizon)
      body
    })[
      #if logo != none {
        logo
        v(0.3em)
      }

      #text(size: 16pt, fill: secondary-color, upper(institution))

      #if department != none {
        linebreak()
        text(size: 12pt, fill: secondary-color, department)
      }

      #if program != none {
        linebreak()
        text(size: 12pt, fill: secondary-color, program)
      }

      #v(0.8em)

      #text(size: 28pt, weight: "bold", fill: primary-color, title)

      #if subtitle != none {
        linebreak()
        v(0.2em)
        text(size: 18pt, fill: secondary-color, subtitle)
      }

      #v(1em)

      #text(size: 16pt, author)

      #v(0.5em)

      #grid(
        columns: if co-advisor != none { (1fr, 1fr) } else { (1fr,) },
        gutter: 1em,
        text(size: 12pt)[
          *Orientador(a):* \
          #advisor
        ],
        if co-advisor != none {
          text(size: 12pt)[
            *Coorientador(a):* \
            #co-advisor
          ]
        },
      )

      #v(0.5em)

      #if degree != none {
        text(size: 11pt, fill: secondary-color)[
          Trabalho apresentado para obtencao do grau de #degree
        ]
      }

      #v(0.3em)

      #text(size: 12pt, fill: secondary-color)[
        #date.display("[day] de [month repr:long] de [year]")
      ]
    ]
  })

  body

  // Slide final com agradecimentos (padrao em defesas)
  touying-slide-wrapper(self => {
    touying-slide(self: self, setting: body => {
      set align(center + horizon)
      body
    })[
      #text(size: 36pt, weight: "bold", fill: primary-color)[
        Obrigado!
      ]

      #v(1em)

      #text(size: 18pt)[Perguntas?]

      #v(2em)

      #if committee.len() > 0 {
        text(size: 14pt, fill: secondary-color)[
          *Banca Examinadora:* \
          #committee.join(" | ")
        ]
      }
    ]
  })
}

// =============================================================================
// FUNCOES AUXILIARES PARA SLIDES
// =============================================================================

/// Slide de sumario/agenda
///
/// Uso comum em apresentacoes academicas para mostrar estrutura
#let slide-sumario(
  title: "Sumario",
  items: (),
  primary-color: rgb("#003366"),
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self)[
      #text(size: 24pt, weight: "bold")[#title]
      #v(0.5em)
      #set text(size: 20pt)
      #set enum(numbering: "1.", body-indent: 1em)

      #for (i, item) in items.enumerate() {
        [#text(fill: primary-color, weight: "bold", str(i + 1) + ".") #item \ ]
        v(0.5em)
      }
    ]
  })
}

/// Slide de secao (divisor)
///
/// Usado para marcar inicio de nova secao da apresentacao
#let slide-secao(
  title: "",
  subtitle: none,
  primary-color: rgb("#003366"),
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self, setting: body => {
      set align(center + horizon)
      body
    })[
      #text(size: 36pt, weight: "bold", fill: primary-color, title)

      #if subtitle != none {
        v(0.5em)
        text(size: 20pt, fill: primary-color.lighten(30%), subtitle)
      }
    ]
  })
}

/// Slide com citacao em destaque
///
/// Para apresentar citacoes importantes de forma visual
/// Segue NBR 10520:2023 para formato da citacao
#let slide-citacao(
  quote: "",
  author: "",
  year: "",
  page: none,
  primary-color: rgb("#003366"),
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self, setting: body => {
      set align(center + horizon)
      body
    })[
      #box(
        width: 80%,
        inset: 2em,
        stroke: (left: 4pt + primary-color),
        fill: primary-color.lighten(95%),
      )[
        #set text(size: 22pt, style: "italic")
        #set par(leading: 1.2em)
        "#quote"
      ]

      #v(1em)

      // Formato NBR 10520:2023 para citacao
      #text(size: 16pt, fill: primary-color)[
        (#upper(author), #year#if page != none [, p. #page])
      ]
    ]
  })
}

/// Slide de referencias
///
/// NOTA: As referencias em slides devem seguir NBR 6023:2018
/// Este e um dos poucos aspectos onde uma norma ABNT se aplica
#let slide-referencias(
  title: "Referencias",
  items: (),
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self)[
      #text(size: 24pt, weight: "bold")[#title]
      #v(0.5em)
      #set text(size: 14pt)
      #set par(
        hanging-indent: 1em,
        first-line-indent: 0pt,
        leading: 0.8em,
      )

      // Nota sobre a norma aplicavel
      #text(size: 10pt, fill: gray)[
        _Formatacao conforme NBR 6023:2018_
      ]

      #v(0.5em)

      #for item in items {
        item
        v(0.3em)
      }
    ]
  })
}

/// Slide de figura com fonte
///
/// Quando incluir figuras de terceiros, a fonte deve ser citada
/// seguindo as normas de citacao (NBR 10520:2023)
#let slide-figura(
  title: none,
  image: none,
  caption: none,
  source: none,
  source-year: none,
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self)[
      #if title != none {
        text(size: 24pt, weight: "bold", title)
        v(0.5em)
      }
      #align(center)[
        #if image != none { image }

        #if caption != none {
          v(0.5em)
          text(size: 14pt, weight: "bold", caption)
        }

        #if source != none {
          v(0.3em)
          text(size: 12pt, fill: gray)[
            Fonte: #if source-year != none {
              [(#upper(source), #source-year)]
            } else {
              source
            }
          ]
        }
      ]
    ]
  })
}

/// Slide comparativo (duas colunas)
#let slide-comparativo(
  title: "",
  left-title: "",
  left-content: [],
  right-title: "",
  right-content: [],
  primary-color: rgb("#003366"),
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self)[
      #text(size: 24pt, weight: "bold")[#title]
      #v(0.5em)
      #grid(
        columns: (1fr, 1fr),
        gutter: 2em,

        // Coluna esquerda
        [
          #align(center)[
            #text(weight: "bold", fill: primary-color, size: 18pt, left-title)
          ]
          #v(0.5em)
          #left-content
        ],

        // Coluna direita
        [
          #align(center)[
            #text(weight: "bold", fill: primary-color, size: 18pt, right-title)
          ]
          #v(0.5em)
          #right-content
        ],
      )
    ]
  })
}

/// Slide de metodologia
///
/// Formato comum para apresentar metodologia de pesquisa
#let slide-metodologia(
  title: "Metodologia",
  tipo-pesquisa: none,
  abordagem: none,
  procedimentos: (),
  instrumentos: (),
  primary-color: rgb("#003366"),
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self)[
      #text(size: 24pt, weight: "bold")[#title]
      #v(0.5em)
      #grid(
        columns: (1fr, 1fr),
        gutter: 1.5em,
        row-gutter: 1em,

        if tipo-pesquisa != none {
          [
            #text(weight: "bold", fill: primary-color)[Tipo de Pesquisa] \
            #tipo-pesquisa
          ]
        },

        if abordagem != none {
          [
            #text(weight: "bold", fill: primary-color)[Abordagem] \
            #abordagem
          ]
        },

        if procedimentos.len() > 0 {
          [
            #text(weight: "bold", fill: primary-color)[Procedimentos] \
            #list(..procedimentos)
          ]
        },

        if instrumentos.len() > 0 {
          [
            #text(weight: "bold", fill: primary-color)[Instrumentos] \
            #list(..instrumentos)
          ]
        },
      )
    ]
  })
}

/// Slide de resultados com destaque numerico
#let slide-resultado-numerico(
  title: "Resultados",
  items: (), // Lista de (valor, descricao)
  primary-color: rgb("#003366"),
) = {
  touying-slide-wrapper(self => {
    touying-slide(self: self)[
      #text(size: 24pt, weight: "bold")[#title]
      #v(0.5em)
      #set align(center)

      #if items.len() > 0 {
        grid(
          columns: items.len(),
          gutter: 2em,

          ..items.map(item => {
            box(
              inset: 1em,
              [
                #text(size: 48pt, weight: "bold", fill: primary-color, item.at(0)) \
                #text(size: 14pt, item.at(1))
              ]
            )
          })
        )
      }
    ]
  })
}

// =============================================================================
// FUNCOES DE ANIMACAO (TOUYING)
// =============================================================================

// Re-exportar funcoes de animacao do Touying para conveniencia
// Estas permitem revelacao progressiva de conteudo

/// Pausa - conteudo apos #pause aparece no proximo clique
/// Exemplo:
/// - Primeiro item
/// #pause
/// - Segundo item (aparece depois)
#let slide-pause = pause

/// Revelacao condicional
/// only(2)[Este texto so aparece no passo 2]
/// only("2-")[Este texto aparece do passo 2 em diante]
/// only("1, 3")[Este texto aparece nos passos 1 e 3]
#let slide-only = only

/// Revelacao com espaco reservado
/// uncover(2)[Este texto fica invisivel ate o passo 2, mas ocupa espaco]
#let slide-uncover = uncover

// =============================================================================
// ESTILOS DE COR PRE-DEFINIDOS
// =============================================================================

/// Cores institucionais comuns em universidades brasileiras
#let cores-usp = (primary: rgb("#004A8F"), secondary: rgb("#FFB81C"))
#let cores-unicamp = (primary: rgb("#003366"), secondary: rgb("#C41230"))
#let cores-unesp = (primary: rgb("#1E3A5F"), secondary: rgb("#B8860B"))
#let cores-ufrj = (primary: rgb("#003366"), secondary: rgb("#FF6600"))
#let cores-ufmg = (primary: rgb("#003366"), secondary: rgb("#FFD700"))
#let cores-ufrgs = (primary: rgb("#003366"), secondary: rgb("#C8102E"))
#let cores-ufsc = (primary: rgb("#003366"), secondary: rgb("#007A33"))
#let cores-ufpr = (primary: rgb("#003366"), secondary: rgb("#C8102E"))
#let cores-unb = (primary: rgb("#003366"), secondary: rgb("#006633"))
#let cores-ufpe = (primary: rgb("#800000"), secondary: rgb("#FFD700"))

// Cores neutras para uso geral
#let cores-academico = (primary: rgb("#003366"), secondary: rgb("#666666"))
#let cores-moderno = (primary: rgb("#2C3E50"), secondary: rgb("#E74C3C"))
#let cores-clean = (primary: rgb("#34495E"), secondary: rgb("#3498DB"))

// =============================================================================
// DOCUMENTACAO E AVISOS
// =============================================================================

/// Funcao para inserir nota sobre ausencia de norma ABNT
/// Pode ser usada no primeiro slide ou em slide de metodologia
#let nota-sem-norma-abnt() = {
  text(size: 10pt, fill: gray, style: "italic")[
    Nota: A ABNT nao possui norma especifica para apresentacoes de slides. \
    Este formato segue boas praticas academicas, nao exigencias normativas.
  ]
}

/// Aviso sobre citacoes em slides
/// Para uso quando houver citacoes na apresentacao
#let aviso-citacoes() = {
  text(size: 10pt, fill: gray, style: "italic")[
    Citacoes formatadas conforme NBR 10520:2023. \
    Referencias conforme NBR 6023:2018.
  ]
}
