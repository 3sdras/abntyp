// Breve Introdução ao ABNTypst
// Documento tutorial para iniciantes
// Inspirado no "Breve Introdução ao LaTeX 2ε" de Lenimar Nunes de Andrade

#set document(
  title: "Breve Introdução ao ABNTypst",
  author: "ABNTypst",
)

#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm),
  numbering: none,
)

#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "pt",
  region: "BR",
)

#set par(
  leading: 0.65em,
  spacing: 0.65em,
  justify: true,
  first-line-indent: (amount: 1.25cm, all: true),
)

#set heading(numbering: "1.1")

// Latex escrito como LaTeX
#let LaTeX = {
  [L]
  h(-0.1em)
  text(baseline: -0.2em, size: 0.7em)[A]
  h(-0.1em)
  [T]
  h(-0.1em)
  text(baseline: 0.2em)[E]
  h(-0.1em)
  [X]
}

#show "LaTeX": LaTeX

// ambiente de descrição
#set terms(
  indent: 0em,           // indentação do item
  hanging-indent: 2em, // recuo da descrição
  separator: [: ],       // separador entre termo e descrição
)

// recuo de listas e enumerações
#set list(indent: 2em, body-indent: 0.5em)
#set enum(indent: 2em, body-indent: 0.5em)

// O first-line-indent com all: true indenta o primeiro parágrafo dentro
// de qualquer contêiner. As show rules abaixo excluem os elementos que
// não devem ser indentados (solução idiomática do Typst).
#show heading: set par(first-line-indent: 0pt)
#show figure: set par(first-line-indent: 0pt)
#show raw: set par(first-line-indent: 0pt)
#show outline: set par(first-line-indent: 0pt)
#show terms: set par(first-line-indent: 0pt)

// Formatação dos headings conforme NBR 6024
// Nível 1 (primário): MAIÚSCULAS + negrito
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1.5em)
  text(size: 12pt, weight: "bold")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #upper(it.body)
  ]
  v(1.5em)
}

// Nível 2 (secundário): MAIÚSCULAS, sem negrito
#show heading.where(level: 2): it => {
  v(1.5em)
  text(size: 12pt, weight: "regular")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #upper(it.body)
  ]
  v(1em)
}

// Nível 3 (terciário): minúsculas + negrito
#show heading.where(level: 3): it => {
  v(1em)
  text(size: 12pt, weight: "bold")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(0.5em)
}

// Nível 4 (quaternário): minúsculas, sem negrito
#show heading.where(level: 4): it => {
  v(1em)
  text(size: 12pt, weight: "regular")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(0.5em)
}

// Nível 5 (quinário): minúsculas, itálico
#show heading.where(level: 5): it => {
  v(1em)
  text(size: 12pt, weight: "regular", style: "italic")[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(0.5em)
}

// Função auxiliar para exemplos numerados
#let exemplo-counter = counter("exemplo")

#let exemplo(body) = {
  exemplo-counter.step()
  block(
    width: 100%,
    inset: 1em,
    stroke: (left: 2pt + gray),
    fill: luma(245),
  )[
    #set par(first-line-indent: 0pt)
    #text(weight: "bold")[Exemplo #context exemplo-counter.display():]
    #body
  ]
}

// Função para código inline
#let code(body) = {
  box(
    fill: luma(240),
    inset: (x: 3pt, y: 1pt),
    radius: 2pt,
    raw(body)
  )
}

// ============================================================================
// CAPA
// ============================================================================

#align(center)[
  #v(2cm)

  #text(size: 14pt)[UNIVERSIDADE FEDERAL DE JATAÍ]

  #text(size: 12pt)[INSTITUTO DE CIÊNCIAS EXATAS E TECNOLÓGICAS]

  #v(3cm)

  #text(size: 14pt)[Breve Introdução ao]

  #v(0.5cm)

  #text(size: 36pt, weight: "bold")[ABNTypst]

  #v(0.5cm)

  #text(size: 14pt)[Formatação de Documentos Acadêmicos]

  #text(size: 14pt)[conforme Normas ABNT para Typst]

  #v(3cm)

  #text(size: 12pt)[
    versão 1.0 -- Janeiro/2026
  ]

  #v(1fr)

  #text(size: 12pt)[Jataí -- GO]
]

#pagebreak()

// ============================================================================
// SUMÁRIO
// ============================================================================

// Formatação do sumário conforme NBR 6024/6027
// Nível 1: MAIÚSCULAS + negrito
#show outline.entry.where(level: 1): it => {
  v(1em)
  block[
    #link(it.element.location())[
      #text(weight: "bold")[#upper(it.body())]
      #box(width: 1fr, it.fill)
      #it.page()
    ]
  ]
}

// Nível 2: MAIÚSCULAS (normal)
#show outline.entry.where(level: 2): it => {
  block[
    #link(it.element.location())[
      #h(1em)
      #upper(it.body())
      #box(width: 1fr, it.fill)
      #it.page()
    ]
  ]
}

// Nível 3: Minúsculas + negrito
#show outline.entry.where(level: 3): it => {
  block[
    #link(it.element.location())[
      #h(2em)
      #text(weight: "bold")[#it.body()]
      #box(width: 1fr, it.fill)
      #it.page()
    ]
  ]
}

#outline(
  title: [#align(center)[#text(weight: "bold")[SUMÁRIO]]],
  indent: 0pt,
  depth: 3,
)

#pagebreak()

// ============================================================================
// PREFÁCIO
// ============================================================================

#heading(level: 1, numbering: none)[Prefácio]



Estas notas são uma adaptação dos trabalhos originais "Uma breve introdução ao $"LaTeX" 2 epsilon$", de Lenimar Nunes de Andrade e a documentação do pacote ABNTex2 de LaTeX, para o caso do Typst, com o objetivo de servir de material didático para a disciplina "Software Livre para digitação de textos matemáticos" na UFJ.

O ABNTypst é um pacote gratuito, de código aberto, desenvolvido para facilitar a produção de documentos técnicos e científicos brasileiros. Pode ser utilizado diretamente no navegador através do #link("https://typst.app")[typst.app], ou instalado localmente em qualquer sistema operacional.

No Capítulo 1 são introduzidos os conceitos básicos do Typst e do ABNTypst. O Capítulo 2 trata dos elementos pré-textuais (capa, folha de rosto, resumo, etc.) e o Capítulo 3 aborda os elementos textuais (seções, citações, alíneas). A leitura desses três primeiros capítulos deve habilitar o leitor a produzir um trabalho acadêmico básico.

O Capítulo 4 trata de figuras, quadros e tabelas. O Capítulo 5 apresenta uma cobertura completa de fórmulas matemáticas, e o Capítulo 6 aborda diagramas e gráficos.

Os Capítulos 7 e 8 tratam dos elementos pós-textuais e dos diferentes tipos de documentos suportados pelo ABNTypst.

Os apêndices contêm tabelas de referência para símbolos matemáticos (Apêndice A), um guia de migração para quem vem do LaTeX (Apêndice B), recursos na Internet (Apêndice C) e uma tabela das normas ABNT implementadas (Apêndice D).

#v(1cm)

#align(right)[
  Jataí, janeiro de 2026

  _Equipe ABNTypst_
]

#pagebreak()

// ============================================================================
// CAPÍTULO 1: CONCEITOS BÁSICOS
// ============================================================================

// Inicia numeração de páginas (arábica, canto superior direito)
#set page(numbering: "1", number-align: top + right)
#counter(page).update(1)

= Conceitos Básicos

== Introdução ao Typst

O Typst é um sistema de composição tipográfica moderno, criado em 2019 por Laurenz Mädje e Martin Haug na Universidade Técnica de Berlim. Diferente do LaTeX, que foi desenvolvido na década de 1980, o Typst foi projetado desde o início para ser mais acessível e intuitivo.

Um documento em Typst é formado pelo texto propriamente dito, mais alguns comandos e funções. Os comandos em Typst iniciam com `#` ('jogo da velha' ou cerquilha), diferente do \ LaTeX que usa `\` (barra invertida).

Ao contrário de processadores de texto como o Microsoft Word, o texto em Typst não é digitado na forma como vai ser impresso (WYSIWYG). O texto é digitado com marcações, similar ao Markdown ou HTML. Por exemplo, $sqrt(2)$ é digitado como `$sqrt(2)$` e a letra grega $pi$ é digitada como `$pi$`.

As principais vantagens do Typst sobre o LaTeX são:

- *Compilação instantânea*: O Typst compila documentos em milissegundos, permitindo visualização em tempo real
- *Sintaxe mais simples*: Comandos mais intuitivos e menos verbosos
- *Mensagens de erro claras*: Erros são indicados com precisão e explicações úteis
- *Instalação fácil*: Um único executável, sem dependências complexas
- *Webapp disponível*: Pode ser usado diretamente no navegador sem instalar nada

== O que é o ABNTypst

O ABNTypst (ABNTypst Biblioteca Normativa Typst) é um pacote que implementa as normas da Associação Brasileira de Normas Técnicas (ABNT) para formatação de documentos acadêmicos em Typst.

O projeto é uma adaptação do abnTeX2, o excelente pacote LaTeX mantido por Lauro César Araujo e colaboradores, que há anos auxilia a comunidade acadêmica brasileira.

Graças ao trabalho original da equipe do abnTeX2, o ABNTypst oferece templates prontos para teses, dissertações, TCCs, artigos, relatórios e outros tipos de documentos, além de:

- Funções para criar capas, folhas de rosto, resumos e outros elementos pré-textuais
- Formatação automática de seções conforme a NBR 6024
- Sistema de citações autor-data e numérico conforme a NBR 10520
- Tabelas no padrão IBGE
- Formatação automática de referências conforme a NBR 6023

== Usando o Typst

=== typst.app (webapp online)

A forma mais fácil de começar com Typst é usando o webapp online em #link("https://typst.app")[typst.app]. Não é necessário instalar nada --- basta criar uma conta gratuita e começar a escrever.

O webapp oferece:
- Editor com destaque de sintaxe
- Visualização em tempo real do PDF
- Armazenamento na nuvem
- Colaboração em tempo real (similar ao Google Docs)
- Acesso a pacotes da comunidade

Para usar o ABNTypst no webapp, basta importar o pacote no início do documento:

#raw(block: true, lang: "typst", "#import \"@preview/abntypst:0.1.0\": *")

=== Instalação local (CLI)

Para trabalhar offline ou em projetos maiores, você pode instalar o Typst localmente. O Typst está disponível para Windows, macOS e Linux.

/ Windows (via winget):
#raw(block: true, lang: "bash", "winget install --id Typst.Typst")

/ MacOS (via Homebrew):
#raw(block: true, lang: "bash", "brew install typst")

/ Linux (via pacotes):
#raw(block: true, lang: "bash", "# Arch Linux
pacman -S typst

# Ubuntu/Debian (via cargo)
cargo install typst-cli")

Para compilar um documento, use:
#raw(block: true, lang: "bash", "typst compile documento.typ")

Para compilar e assistir mudanças em tempo real:
#raw(block: true, lang: "bash", "typst watch documento.typ")

=== Editores e extensões

O Typst pode ser editado em qualquer editor de texto, mas alguns oferecem suporte especial:

/ Neovim:
- Instale o plugin `tinymist` para LSP completo, destaque de sintaxe e autocompletar
- Visualização em tempo real integrada

/ Visual Studio Code:
- Instale a extensão "Tinymist Typst" para LSP e destaque de sintaxe
- Instale a extensão "Typst Preview" para visualização em tempo real

/ Outros editores:
- Emacs: modo `typst-mode`
- Sublime Text: pacote "Typst"

=== Um exemplo simples

Vejamos o documento Typst mais simples possível:

#exemplo[
  #raw(block: true, lang: "typst", "Olá, mundo!")
]

Este código acima produz um documento de uma página contendo apenas "Olá, mundo!".

Para um documento acadêmico usando ABNTypst, o exemplo mínimo seria:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/abntypst:0.1.0\": *

#show: abntcc.with(
  title: \"Meu Trabalho Acadêmico\",
  author: \"Maria da Silva\",
  institution: \"Universidade Federal\",
  location: \"Cidade\",
  year: 2026,
)

= Introdução

Este é o texto da introdução.

= Desenvolvimento

Este é o desenvolvimento do trabalho.

= Conclusão

Esta é a conclusão.")
]

O comando `#show: abntcc.with(...)` aplica o template de trabalho acadêmico a todo o documento, configurando automaticamente margens, fontes, espaçamentos e numeração de seções.

== Estrutura de um documento Typst

Um documento Typst pode ser dividido em três partes:

1. *Preâmbulo (opcional)*: Importações de pacotes e definições de funções
2. *Configuração (opcional)*: Comandos `#set` e `#show` que definem formatação
3. *Conteúdo*: O texto propriamente dito

#exemplo[
  #raw(block: true, lang: "typst", "// 1. Preâmbulo (importações)
#import \"@preview/abntypst:0.1.0\": *

// 2. Configuração
#set page(paper: \"a4\", margin: 2cm)
#set text(font: \"Times New Roman\", size: 12pt)
#set par(justify: true)

// 3. Conteúdo
= Introdução

Texto do documento...")
]

== Tipos e tamanhos de letras

O Typst oferece várias formas de alterar o estilo do texto. A @tab:estilos resume os principais estilos disponíveis, a @tab:tamanhos mostra como alterar o tamanho e, em seguida, apresentamos como trocar a fonte.

=== Estilos de texto

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Resultado*],
    table.hline(stroke: 0.5pt),
    [`*negrito*`], [*negrito*],
    [`_itálico_`], [_itálico_],
    [`*_negrito itálico_*`], [*_negrito itálico_*],
    [#raw("`código`")], [`código`],
    [`#underline[sublinhado]`], [#underline[sublinhado]],
    [`#strike[riscado]`], [#strike[riscado]],
    [`#smallcaps[Versalete]`], [V#text(size: 0.8em)[ERSALETE]],
    table.hline(stroke: 1pt),
  ),
  caption: [Estilos de texto em Typst],
  kind: table,
) <tab:estilos>

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)
  *Observação sobre versalete:* A função `#smallcaps` do Typst depende de a fonte possuir suporte nativo a small caps (feature OpenType "smcp"). Fontes como Times New Roman não possuem esse recurso. Para garantir versalete em qualquer fonte, pode-se criar uma função que simula o efeito:

  #raw(block: true, lang: "typst", "#let versalete(texto) = {
  let chars = texto.clusters()
  if chars.len() > 0 {
    chars.first()
    text(size: 0.8em, upper(chars.slice(1).join()))
  }
}

// Uso: #versalete(\"Texto em Versalete\")")
]

=== Tamanhos de texto

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Resultado*],
    table.hline(stroke: 0.5pt),
    [`#text(size: 8pt)[pequeno]`], [#text(size: 8pt)[pequeno]],
    [`#text(size: 10pt)[menor]`], [#text(size: 10pt)[menor]],
    [`#text(size: 12pt)[normal]`], [#text(size: 12pt)[normal]],
    [`#text(size: 14pt)[maior]`], [#text(size: 14pt)[maior]],
    [`#text(size: 18pt)[grande]`], [#text(size: 18pt)[grande]],
    table.hline(stroke: 1pt),
  ),
  caption: [Tamanhos de texto em Typst],
  kind: table,
) <tab:tamanhos>

=== Fontes

Para alterar a fonte de todo o documento, use `#set text(font: ...)`. Para alterar pontualmente, use `#text(font: ...)[...]`:

#raw(block: true, lang: "typst", "#set text(font: \"Arial\")  // Todo o documento em Arial

#text(font: \"Courier New\")[Texto em Courier]")

== Parágrafos e espaçamentos

Em Typst, um novo parágrafo é criado deixando uma linha em branco, assim como no LaTeX e Markdown:

#exemplo[
  #raw(block: true, lang: "typst", "Este é o primeiro parágrafo. Ele continua
na mesma linha porque não há linha em branco.

Este é o segundo parágrafo, pois há
uma linha em branco acima.")
]

Para configurar o espaçamento entre linhas e o recuo de parágrafo:

#raw(block: true, lang: "typst", "#set par(
  leading: 0.65em,           // Espaçamento entre linhas (padrão ≈ 1,5)
  spacing: 0.65em,           // Espaço entre parágrafos
  first-line-indent: (amount: 1.25cm, all: true), // Recuo da primeira linha
  justify: true,             // Texto justificado
)")

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)
  *Observação sobre indentação no Brasil:* Por padrão, o Typst não indenta o primeiro parágrafo após um título --- seguindo a convenção tipográfica anglo-saxônica, conhecida em editoração portuguesa como "composição à inglesa". No entanto, no Brasil, a norma ABNT é indentar _todos_ os parágrafos, inclusive o primeiro. Para isso, é necessário usar `first-line-indent` com o parâmetro `all: true`:

  #raw(block: true, lang: "typst", "// Indenta TODOS os parágrafos (padrão brasileiro)
#set par(first-line-indent: (amount: 1.25cm, all: true))

// Comportamento padrão do Typst (NÃO indenta o primeiro parágrafo)
#set par(first-line-indent: 1.25cm)")
]

Para forçar uma quebra de linha sem iniciar novo parágrafo, use `\`:

#exemplo[
  #raw(block: true, lang: "typst", "Primeira linha \\
Segunda linha (mesmo parágrafo)")
]

== Comentários

Comentários são trechos de texto ignorados na compilação. São úteis para anotações e organização do código:

#raw(block: true, lang: "typst", "// Isto é um comentário de linha única

/* Isto é um comentário
   de múltiplas linhas */

Texto normal // comentário ao final da linha")

== Compilação e visualização

Ao usar o typst.app, a compilação e visualização são automáticas. Ao usar o CLI:

#figure(
  table(
    columns: (auto, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Comando*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`typst compile doc.typ`], [Compila uma vez, gera `doc.pdf`],
    [`typst watch doc.typ`], [Compila e fica observando mudanças],
    [`typst compile doc.typ -o saida.pdf`], [Especifica nome do arquivo de saída],
    [`typst fonts`], [Lista fontes disponíveis],
    table.hline(stroke: 1pt),
  ),
  caption: [Comandos do Typst CLI],
  kind: table,
)

#pagebreak()

// ============================================================================
// CAPÍTULO 2: ELEMENTOS PRÉ-TEXTUAIS
// ============================================================================

= Elementos Pré-textuais

Os elementos pré-textuais são aqueles que antecedem o texto principal do trabalho. Conforme a NBR 14724:2024, eles incluem capa, folha de rosto, ficha catalográfica, errata, folha de aprovação, dedicatória, agradecimentos, epígrafe, resumo, abstract, listas e sumário.

== Capa

A capa é elemento obrigatório e deve conter:
- Nome da instituição (opcional)
- Nome do autor
- Título do trabalho
- Subtítulo (se houver)
- Local (cidade)
- Ano

No ABNTypst, a capa é criada com a função `#capa()`:

#exemplo[
  #raw(block: true, lang: "typst", "#capa(
  institution: \"Universidade Federal de Jataí\",
  faculty: \"Instituto de Ciências Exatas e Tecnológicas\",
  program: \"PROFMAT\",
  author: \"Maria da Silva\",
  title: \"Análise de Algoritmos de Ordenação\",
  subtitle: \"Um estudo comparativo\",
  location: \"Jataí\",
  year: 2026,
)")
]

== Folha de rosto

A folha de rosto contém os mesmos elementos da capa, acrescidos de:
- Natureza do trabalho (tese, dissertação, TCC, etc.)
- Objetivo (obtenção de grau)
- Nome do orientador
- Nome do coorientador (se houver)

#exemplo[
  #raw(block: true, lang: "typst", "#folha-rosto(
  author: \"Maria da Silva\",
  title: \"Análise de Algoritmos de Ordenação\",
  subtitle: \"Um estudo comparativo\",
  nature: \"Dissertação apresentada ao Programa de Pós-Graduação
    em Ciência da Computação da Universidade Federal de Jataí\",
  objective: \"como requisito parcial para obtenção do título
    de Mestre em Ciência da Computação.\",
  area: \"Algoritmos e Estruturas de Dados\",
  advisor: \"Prof. Dr. João Santos\",
  co-advisor: \"Profa. Dra. Ana Costa\",  // opcional
  location: \"Jataí\",
  year: 2026,
)")
]

== Ficha catalográfica

A ficha catalográfica deve ser elaborada por um bibliotecário. Na maioria das instituições, o bibliotecário fornece a ficha pronta em formato PDF. Para incluí-la no documento, basta usar a função `image()` do Typst (a partir da versão 0.14.0), que aceita arquivos PDF:

#exemplo[
  #raw(block: true, lang: "typst", "// Inserir a ficha catalográfica a partir de um PDF
// fornecido pelo bibliotecário
#page[
  #v(1fr)
  #image(\"ficha-catalografica.pdf\", page: 1, width: 100%)
]")
]


O ABNTypst também oferece a função `#ficha-catalografica()`, que cria a moldura padrão da ficha (caixa de 12,5 × 7,5~cm, fonte 10pt, centralizada na parte inferior da página).

Diferente de funções como `#capa()` ou `#folha-rosto()`, que possuem campos nomeados (`author:`, `title:`, etc.), a `#ficha-catalografica()` recebe conteúdo livre, pois a ficha segue uma notação biblioteconômica específica (código Cutter, CDU/CDD) que não se presta a campos parametrizados:


#exemplo[
  #raw(block: true, lang: "typst", "// Moldura para compor a ficha manualmente
// (útil para rascunho ou conferência com o bibliotecário)
#ficha-catalografica[
  S586a  Silva, Maria da.
         Análise de algoritmos de ordenação: um estudo
         comparativo / Maria da Silva. -- Jataí, 2026.
         120 f. : il.

         Dissertação (Mestrado) -- Universidade Federal de
         Jataí, Programa de Pós-Graduação em Ciência da
         Computação, 2026.
         Orientador: Prof. Dr. João Santos.

         1. Algoritmos. 2. Ordenação. 3. Complexidade.
         I. Santos, João. II. Título.

         CDU: 004.021
]")
]

== Errata

A errata é elemento opcional, utilizado para correções após a impressão:

#exemplo[
  #raw(block: true, lang: "typst", "#errata(
  reference: [SILVA, Maria da. *Análise de algoritmos de
    ordenação*. 2026. Dissertação (Mestrado) -- UFJ, Jataí, 2026.],
  items: (
    (page: 15, line: 3, wrong: \"ordenção\", correct: \"ordenação\"),
    (page: 42, line: 10, wrong: \"algortimo\", correct: \"algoritmo\"),
  ),
)")
]

== Folha de aprovação

A folha de aprovação contém os elementos da folha de rosto mais a data de aprovação e a composição da banca examinadora:

#exemplo[
  #raw(block: true, lang: "typst", "#approval-page(
  author: \"Maria da Silva\",
  title: \"Análise de Algoritmos de Ordenação\",
  nature: \"Dissertação apresentada ao Programa...\",
  date: \"15 de março de 2026\",
  committee: (
    (name: \"Prof. Dr. João Santos\",
     role: \"Orientador\",
     institution: \"UFJ\"),
    (name: \"Profa. Dra. Ana Costa\",
     role: \"Membro interno\",
     institution: \"UFJ\"),
    (name: \"Prof. Dr. Pedro Lima\",
     role: \"Membro externo\",
     institution: \"UFG\"),
  ),
)")
]

== Dedicatória e agradecimentos

A dedicatória é um texto curto onde o autor homenageia pessoas especiais. Os agradecimentos são mais extensos e incluem pessoas e instituições que contribuíram para o trabalho.

#exemplo[
  #raw(block: true, lang: "typst", "// Dedicatória (alinhada à direita, parte inferior)
#dedicatoria[
  À minha família, pelo apoio incondicional.
]

// Agradecimentos (texto corrido)
#agradecimentos[
  Agradeço primeiramente a Deus pela oportunidade.

  Ao meu orientador, Prof. Dr. João Santos, pela
  paciência e dedicação durante todo o processo.

  À CAPES pelo apoio financeiro.

  A todos que direta ou indiretamente contribuíram
  para a realização deste trabalho.
]")
]

== Epígrafe

A epígrafe é uma citação relacionada ao conteúdo do trabalho:

#exemplo[
  #raw(block: true, lang: "typst", "#epigrafe(
  \"A ciência é feita de erros, mas de erros
  que é bom cometer, pois levam pouco a pouco
  à verdade.\",
  \"Júlio Verne\"
)")
]

== Resumo e Abstract

O resumo deve apresentar de forma concisa os pontos relevantes do trabalho. Conforme a NBR 6028:2021, deve ter entre 150 e 500 palavras para trabalhos acadêmicos.

#exemplo[
  #raw(block: true, lang: "typst", "#resumo(
  keywords: (\"Algoritmos\", \"Ordenação\", \"Complexidade\", \"Análise\"),
)[
  Este trabalho apresenta um estudo comparativo de algoritmos
  de ordenação, analisando sua complexidade temporal e espacial.
  Foram avaliados os algoritmos Quicksort, Mergesort, Heapsort
  e Timsort em diferentes cenários de entrada. Os resultados
  demonstram que o Timsort apresenta melhor desempenho em dados
  parcialmente ordenados, enquanto o Quicksort é mais eficiente
  para dados aleatórios. Conclui-se que a escolha do algoritmo
  deve considerar as características dos dados de entrada.
]

#abstract-page(
  keywords: (\"Algorithms\", \"Sorting\", \"Complexity\", \"Analysis\"),
)[
  This work presents a comparative study of sorting algorithms,
  analyzing their time and space complexity. The Quicksort,
  Mergesort, Heapsort and Timsort algorithms were evaluated in
  different input scenarios. Results show that Timsort performs
  better on partially sorted data, while Quicksort is more
  efficient for random data. We conclude that algorithm choice
  should consider input data characteristics.
]")
]

== Listas (ilustrações, tabelas, siglas)

As listas são elementos opcionais que facilitam a localização de figuras, tabelas, quadros (arranjos textuais com bordas fechadas, diferenciados das tabelas --- ver @sec:quadros) e a compreensão de siglas e símbolos.

#exemplo[
  #raw(block: true, lang: "typst", "// Lista de ilustrações (gerada automaticamente)
#lista-ilustracoes()

// Lista de tabelas (gerada automaticamente)
#lista-tabelas()

// Lista de quadros (gerada automaticamente)
#lista-quadros()

// Lista de siglas (manual)
#lista-siglas((
  \"ABNT\": \"Associação Brasileira de Normas Técnicas\",
  \"NBR\": \"Norma Brasileira\",
  \"TCC\": \"Trabalho de Conclusão de Curso\",
  \"UFJ\": \"Universidade Federal de Jataí\",
))

// Lista de símbolos (manual)
#lista-simbolos((
  ($O(n)$, \"Complexidade linear\"),
  ($O(n^2)$, \"Complexidade quadrática\"),
  ($O(log n)$, \"Complexidade logarítmica\"),
))")
]

== Sumário

O sumário é elemento obrigatório conforme a NBR 6027:2012, que estabelece as regras para sua apresentação. Ele lista as seções do trabalho com suas respectivas páginas. No ABNTypst, é gerado automaticamente:

#exemplo[
  #raw(block: true, lang: "typst", "#sumario()

// Com opções personalizadas:
#sumario(
  title: \"SUMÁRIO\",
  depth: 3,  // Até seções terciárias
)")
]

#pagebreak()

// ============================================================================
// CAPÍTULO 3: ELEMENTOS TEXTUAIS
// ============================================================================

= Elementos Textuais

Os elementos textuais constituem o núcleo do trabalho, onde o autor desenvolve o conteúdo propriamente dito. Incluem introdução, desenvolvimento e conclusão.

== Seções e numeração progressiva (NBR 6024)

A NBR 6024:2012 estabelece as regras para numeração progressiva das seções de um documento. O ABNTypst implementa automaticamente a formatação correta:

#figure(
  table(
    columns: (auto, auto, auto),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Nível*], [*Typst*], [*Formatação*],
    table.hline(stroke: 0.5pt),
    [Primário], [`= Título`], [MAIÚSCULAS, negrito],
    [Secundário], [`== Título`], [MAIÚSCULAS, normal],
    [Terciário], [`=== Título`], [Minúsculas, negrito],
    [Quaternário], [`==== Título`], [Minúsculas, normal],
    [Quinário], [`===== Título`], [Minúsculas, itálico],
    table.hline(stroke: 1pt),
  ),
  caption: [Formatação de seções conforme NBR 6024],
  kind: table,
)

#exemplo[
  #raw(block: true, lang: "typst", "= Introdução                    // 1 INTRODUÇÃO
== Contextualização             // 1.1 CONTEXTUALIZAÇÃO
=== Histórico                   // 1.1.1 Histórico
==== Período inicial            // 1.1.1.1 Período inicial
===== Primeiros experimentos    // 1.1.1.1.1 Primeiros experimentos")
]

Para seções sem numeração (Referências, Apêndices, Anexos), usa-se `numbering: none`:

#exemplo[
  #raw(block: true, lang: "typst", "#heading(level: 1, numbering: none)[REFERÊNCIAS]

#heading(level: 1, numbering: none)[APÊNDICES]

#heading(level: 1, numbering: none)[ANEXOS]")

  Resultado: os títulos aparecem centralizados, em caixa alta e negrito, sem numeração.
]

== Citações (NBR 10520)

A NBR 10520:2023 estabelece as regras para citações em documentos. A seção 4.2 da norma prevê dois sistemas de chamada: *autor-data* e *numérico*. Ambos são embasados pela ABNT, porém o sistema autor-data é amplamente predominante nos trabalhos acadêmicos brasileiros. Uma vez escolhido um sistema, ele deve ser utilizado de forma consistente em todo o documento.

=== Citação direta curta

Citações diretas de até três linhas são inseridas no texto entre aspas duplas:

#exemplo[
  #raw(block: true, lang: "typst", "Conforme o autor, #citacao-curta(
  \"a formatação adequada é essencial para a clareza\",
  author: \"SILVA\",
  year: \"2023\",
  page: \"42\"
).")

  Resultado: Conforme o autor, "a formatação adequada é essencial para a clareza" (SILVA, 2023, p. 42).
]

=== Citação direta longa

Citações com mais de três linhas devem ser destacadas com recuo de 4 cm, fonte menor e espaçamento simples:

#exemplo[
  #raw(block: true, lang: "typst", "#citacao-longa(
  author: \"SILVA\",
  year: \"2023\",
  page: \"42-43\"
)[
  A formatação adequada dos trabalhos acadêmicos é
  essencial para a clareza e a credibilidade da
  comunicação científica. As normas ABNT estabelecem
  padrões que facilitam a leitura e a compreensão
  dos textos, além de uniformizar a apresentação
  dos documentos técnicos e científicos no Brasil.
]")
]

=== Sistema autor-data

No sistema autor-data, a indicação da fonte é feita pelo sobrenome do autor e o ano de publicação:

#exemplo[
  #raw(block: true, lang: "typst", "// Autor no texto
Segundo #citar-autor(\"Silva\", \"2023\"), a metodologia...

// Autor entre parênteses
A metodologia é importante #citar(\"SILVA\", \"2023\", page: \"45\").

// Múltiplos autores (até 3)
Conforme #citar(\"SILVA; SANTOS; COSTA\", \"2023\")...

// Mais de 3 autores (et al.)
De acordo com #citar(\"SILVA et al.\", \"2023\")...

// Citação de citação (apud)
#citar-apud(\"FREUD\", \"1900\", \"LACAN\", \"1966\", page: \"123\")")

  Resultados:

  / Autor no texto: Segundo Silva (2023), a metodologia...
  / Autor entre parênteses: A metodologia é importante (SILVA, 2023, p. 45).
  / Múltiplos autores: Conforme (SILVA; SANTOS; COSTA, 2023)...
  / Mais de 3 autores: De acordo com (SILVA ET AL., 2023)...
  / Citação de citação: (FREUD, 1900 apud LACAN, 1966, p. 123)
]

=== Sistema numérico

O sistema numérico, também previsto na seção 4.2 da NBR 10520:2023, usa números arábicos consecutivos para indicar as fontes. A numeração remete à lista de referências ao final do documento. *Importante*: conforme a própria norma, o sistema numérico *não* pode ser usado quando houver notas de rodapé, pois haveria conflito na numeração.

#exemplo[
  #raw(block: true, lang: "typst", "#show: citacao-num-config

O resultado foi positivo #citar-num(\"silva2023\", page: \"45\").

Outros autores #citar-num-multiplos((\"santos2022\", \"costa2021\"))
confirmam os resultados.

// No final do documento:
#bibliografia-numerica((
  (\"silva2023\", [SILVA, J. *Título*. São Paulo: Editora, 2023.]),
  (\"santos2022\", [SANTOS, M. Artigo. *Revista*, v. 1, 2022.]),
  (\"costa2021\", [COSTA, A. Outro título. Rio: Ed., 2021.]),
))")
]

== Notas de rodapé

Notas de rodapé são indicações ou observações complementares ao texto. Em Typst, são criadas com a função `#footnote()`:

#exemplo[
  #raw(block: true, lang: "typst", "O Typst#footnote[Sistema de composição tipográfica criado
em 2019.] é uma alternativa moderna ao LaTeX#footnote[Criado
por Leslie Lamport na década de 1980.].")
]

O ABNTypst formata as notas automaticamente conforme a ABNT: fonte menor (10pt), espaçamento simples, separadas do texto por um filete.

== Alíneas e subalíneas

Alíneas são subdivisões de uma seção, indicadas por letras minúsculas seguidas de parênteses. Subalíneas são subdivisões das alíneas, indicadas por travessão:

#exemplo[
  #raw(block: true, lang: "typst", "Os elementos obrigatórios são:

#alineas[
  + capa;
  + folha de rosto;
  + resumo na língua vernácula;
  + sumário;
  + referências.
]

As referências podem incluir:

#alineas[
  + livros:
    #subalineas[
      - com autor pessoal;
      - com autor institucional;
      - sem autoria.
    ]
  + artigos de periódico;
  + documentos eletrônicos.
]")
]

== Referências cruzadas

Referências cruzadas permitem citar figuras, tabelas, equações e seções do próprio documento:

#exemplo[
  #raw(block: true, lang: "typst", "= Introdução <sec:intro>

Conforme discutido na @sec:intro...

#figure(
  image(\"grafico.png\"),
  caption: [Resultados obtidos],
) <fig:resultados>

Os resultados da @fig:resultados mostram...

$ E = m c^2 $ <eq:einstein>

A @eq:einstein demonstra...")
]

Para criar uma referência, use `<label>` após o elemento. Para citá-la, use `@label`.

#pagebreak()

// ============================================================================
// CAPÍTULO 4: FIGURAS, QUADROS E TABELAS
// ============================================================================

= Figuras, Quadros e Tabelas

Figuras, quadros e tabelas são elementos essenciais em trabalhos acadêmicos. A ABNT estabelece regras específicas para sua apresentação.

== Inserindo figuras

Figuras são elementos visuais como gráficos, fotografias, desenhos, mapas, etc. Conforme a ABNT, devem ter:
- Título na parte superior
- Fonte na parte inferior
- Numeração sequencial

#exemplo[
  #raw(block: true, lang: "typst", "#figure(
  image(\"imagens/grafico.png\", width: 80%),
  caption: [Comparação de desempenho dos algoritmos],
) <fig:comparacao>

#fonte[Elaborado pelo autor (2026).]")
]

Parâmetros úteis para imagens:

#raw(block: true, lang: "typst", "image(\"arquivo.png\",
  width: 80%,       // Largura relativa
  height: 5cm,      // Altura absoluta
  fit: \"contain\",   // Modo de ajuste
)")

== Quadros <sec:quadros>

Quadros são arranjos predominantemente textuais, com informações dispostas em linhas e colunas. Diferem das tabelas por serem fechados (com bordas em todos os lados):

#exemplo[
  #raw(block: true, lang: "typst", "#figure(
  table(
    columns: (1fr, 2fr),
    inset: 8pt,
    [*Termo*], [*Definição*],
    [Algoritmo], [Sequência finita de instruções],
    [Complexidade], [Medida de recursos necessários],
    [Ordenação], [Organização de dados em sequência],
  ),
  caption: [Glossário de termos],
  kind: \"quadro\",
  supplement: [Quadro],
)

#fonte[Elaborado pelo autor.]")
]

== Tabelas no padrão IBGE

Tabelas contêm dados numéricos e seguem as normas de apresentação tabular do IBGE:
- Sem bordas laterais (abertas)
- Apenas linhas horizontais no topo, separando cabeçalho e no final
- Fonte menor que o texto

#exemplo[
  #raw(block: true, lang: "typst", "#figure(
  table(
    columns: 4,
    stroke: none,
    inset: 8pt,

    // Linha superior
    table.hline(stroke: 1.5pt),

    // Cabeçalho
    [*Algoritmo*], [*Melhor*], [*Médio*], [*Pior*],

    // Linha após cabeçalho
    table.hline(stroke: 0.75pt),

    // Dados
    [Quicksort], [$O(n log n)$], [$O(n log n)$], [$O(n^2)$],
    [Mergesort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$],
    [Heapsort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$],
    [Bubblesort], [$O(n)$], [$O(n^2)$], [$O(n^2)$],

    // Linha inferior
    table.hline(stroke: 1.5pt),
  ),
  caption: [Complexidade dos algoritmos de ordenação],
  kind: table,
)

#fonte[Adaptado de Cormen et al. (2012).]")
]

== Legendas e fontes

A legenda (caption) é obrigatória e deve ser concisa. A fonte indica a origem dos dados e é obrigatória mesmo quando elaborada pelo autor:

#raw(block: true, lang: "typst", "// Fonte elaborada pelo autor
#fonte[Elaborado pelo autor (2026).]

// Fonte adaptada
#fonte[Adaptado de Silva (2023).]

// Fonte de terceiros
#fonte[IBGE (2022).]

// Nota explicativa (opcional)
#nota-figura[Os valores foram arredondados para duas casas decimais.]")

== Listas automáticas

O ABNTypst gera automaticamente listas de figuras, tabelas e quadros:

#raw(block: true, lang: "typst", "// No início do documento, após o sumário:

#lista-ilustracoes()  // Lista de figuras

#lista-tabelas()      // Lista de tabelas

#lista-quadros()      // Lista de quadros")

As listas são geradas a partir das `caption` definidas em cada elemento.

#pagebreak()

// ============================================================================
// CAPÍTULO 5: FÓRMULAS MATEMÁTICAS
// ============================================================================

= Fórmulas Matemáticas

Uma das grandes vantagens do Typst sobre processadores de texto convencionais é a facilidade de escrever fórmulas matemáticas com qualidade tipográfica profissional.

== Modo matemático em Typst

Em Typst, fórmulas são escritas entre cifrões (`$`). Existem dois modos:

- *Inline* (na linha): `$x + y$` produz $x + y$
- *Display* (destacado): `$ x + y $` (com espaços) produz uma equação centralizada

#exemplo[
  #raw(block: true, lang: "typst", "A fórmula $a^2 + b^2 = c^2$ é o teorema de Pitágoras.

A mesma fórmula em destaque:
$ a^2 + b^2 = c^2 $")
]

== Letras gregas

As letras gregas são escritas pelo nome em inglês:

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Letra*], [*Código*], [*Letra*], [*Código*], [*Letra*],
    table.hline(stroke: 0.5pt),
    [`alpha`], [$alpha$], [`beta`], [$beta$], [`gamma`], [$gamma$],
    [`delta`], [$delta$], [`epsilon`], [$epsilon$], [`zeta`], [$zeta$],
    [`eta`], [$eta$], [`theta`], [$theta$], [`iota`], [$iota$],
    [`kappa`], [$kappa$], [`lambda`], [$lambda$], [`mu`], [$mu$],
    [`nu`], [$nu$], [`xi`], [$xi$], [`pi`], [$pi$],
    [`rho`], [$rho$], [`sigma`], [$sigma$], [`tau`], [$tau$],
    [`upsilon`], [$upsilon$], [`phi`], [$phi$], [`chi`], [$chi$],
    [`psi`], [$psi$], [`omega`], [$omega$], [], [],
    table.hline(stroke: 1pt),
  ),
  caption: [Letras gregas minúsculas],
  kind: table,
)

Para maiúsculas, use a primeira letra em maiúsculo: `Gamma` $Gamma$, `Delta` $Delta$, `Theta` $Theta$, `Lambda` $Lambda$, `Pi` $Pi$, `Sigma` $Sigma$, `Phi` $Phi$, `Psi` $Psi$, `Omega` $Omega$.

== Nomes de funções

Funções matemáticas são escritas sem formatação especial:

#exemplo[
  #raw(block: true, lang: "typst", "$sin(x)$, $cos(x)$, $tan(x)$
$log(x)$, $ln(x)$, $exp(x)$
$lim_(x -> 0) f(x)$
$max(a, b)$, $min(a, b)$")

  Resultado: $sin(x)$, $cos(x)$, $tan(x)$, $log(x)$, $ln(x)$, $exp(x)$
]

== Outros tipos de letras

O Typst oferece várias variantes de letras para matemática:

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Resultado*], [*Uso comum*],
    table.hline(stroke: 0.5pt),
    [`bb(R)`], [$bb(R)$], [Conjuntos numéricos],
    [`cal(L)`], [$cal(L)$], [Operadores, transformadas],
    [`frak(g)`], [$frak(g)$], [Álgebras de Lie],
    [`bold(x)`], [$bold(x)$], [Vetores (alternativa)],
    [`italic(f)`], [$italic(f)$], [Funções (padrão)],
    [`upright(d)`], [$upright(d)$], [Operador diferencial],
    table.hline(stroke: 1pt),
  ),
  caption: [Variantes de letras matemáticas],
  kind: table,
)

#exemplo[
  #raw(block: true, lang: "typst", "$bb(R)$, $bb(N)$, $bb(Z)$, $bb(Q)$, $bb(C)$
// Conjuntos reais, naturais, inteiros, racionais, complexos

$cal(F)[f(t)] = F(omega)$  // Transformada de Fourier

$frak(g) = frak(sl)(2, bb(C))$  // Álgebra de Lie")
]

== Potências e índices

Potências (sobrescritos) usam `^` e índices (subscritos) usam `_`:

#exemplo[
  #raw(block: true, lang: "typst", "$x^2$, $x^n$, $x^{n+1}$
$a_1$, $a_n$, $a_{i,j}$
$x_1^2$, $x_n^{k+1}$")

  Resultado: $x^2$, $x^n$, $x^(n+1)$, $a_1$, $a_n$, $a_(i,j)$, $x_1^2$, $x_n^(k+1)$
]

Em Typst, use parênteses para agrupar quando necessário: `x^(n+1)` em vez de chaves.

== Frações

Frações são criadas com `frac(numerador, denominador)` ou com a notação `/`:

#exemplo[
  #raw(block: true, lang: "typst", "$frac(a, b)$, $frac(x+1, x-1)$, $a/b$

// Fração maior (display style)
$ frac(a+b, c+d) $

// Fração em linha com barra
$a slash b$ ou $(a+b)/(c+d)$")
]

$frac(a, b)$, $frac(x+1, x-1)$, $a/b$

== Raízes

Raízes são criadas com `sqrt()` ou `root()`:

#exemplo[
  #raw(block: true, lang: "typst", "$sqrt(2)$, $sqrt(x+1)$
$root(3, 8)$, $root(n, x)$")

  Resultado: $sqrt(2)$, $sqrt(x+1)$, $root(3, 8)$, $root(n, x)$
]

== Somatórios, produtórios, uniões, interseções

#exemplo[
  #raw(block: true, lang: "typst", "// Somatório
$sum_(i=1)^n a_i$

// Produtório
$product_(i=1)^n a_i$

// União
$union.big_(i=1)^n A_i$

// Interseção
$sect.big_(i=1)^n A_i$")
]

Resultado:

$ sum_(i=1)^n a_i quad quad product_(i=1)^n a_i quad quad union.big_(i=1)^n A_i quad quad inter.big_(i=1)^n A_i $

== Limites

#exemplo[
  #raw(block: true, lang: "typst", "$lim_(x -> 0) frac(sin x, x) = 1$

$lim_(n -> infinity) (1 + 1/n)^n = e$

$lim_(x -> 0^+) ln x = -infinity$")
]

$ lim_(x -> 0) frac(sin x, x) = 1 $

== Derivadas

#exemplo[
  #raw(block: true, lang: "typst", "// Derivada com notação de Leibniz
$frac(dif y, dif x)$, $frac(dif^2 y, dif x^2)$

// Derivadas parciais
$frac(diff f, diff x)$, $frac(diff^2 f, diff x diff y)$

// Notação de Newton (ponto)
$dot(x)$, $dot.double(x)$

// Notação de Lagrange (linha)
$f'(x)$, $f''(x)$")
]

$frac(dif y, dif x)$, $frac(dif^2 y, dif x^2)$, $frac(partial f, partial x)$, $dot(x)$, $dot.double(x)$, $f'(x)$, $f''(x)$

== Integrais

#exemplo[
  #raw(block: true, lang: "typst", "// Integral simples
$integral_a^b f(x) dif x$

// Integral dupla
$integral.double_D f(x,y) dif x dif y$

// Integral tripla
$integral.triple_V f dif V$

// Integral de linha
$integral.cont_C bold(F) dot dif bold(r)$")
]

$ integral_a^b f(x) dif x quad quad integral.double_D f(x,y) dif x dif y $

== Parênteses, colchetes e chaves (delimitadores)

Delimitadores podem ser redimensionados automaticamente:

#exemplo[
  #raw(block: true, lang: "typst", "// Delimitadores automáticos
$lr((frac(a, b)))$

// Delimitadores manuais
$( frac(a, b) )$  // não ajusta
$lr([ frac(a, b) ])$  // ajusta

// Tipos de delimitadores
$lr(| x |)$      // valor absoluto
$lr(|| x ||)$    // norma
$lr(angle.l x angle.r)$  // produto interno
$lr({ x : x > 0 })$  // conjunto")
]

$ lr((frac(a, b))) quad lr([frac(a, b)]) quad lr(|x|) quad lr(||x||) quad lr(chevron.l x, y chevron.r) $

== Vetores e conjugados

#exemplo[
  #raw(block: true, lang: "typst", "// Vetor com seta
$arrow(v)$, $arrow(A B)$

// Vetor em negrito
$bold(v)$, $bold(F)$

// Conjugado
$overline(z)$

// Barra superior
$overline(A B)$

// Chapéu
$hat(x)$, $hat(i)$, $hat(j)$, $hat(k)$

// Til
$tilde(x)$")
]

$arrow(v)$, $bold(v)$, $overline(z)$, $hat(x)$, $tilde(x)$

== Matrizes e determinantes

#exemplo[
  #raw(block: true, lang: "typst", "// Matriz com parênteses
$mat(
  a, b;
  c, d;
)$

// Matriz com colchetes
$mat(delim: \"[\",
  1, 2, 3;
  4, 5, 6;
)$

// Determinante
$mat(delim: \"|\",
  a, b;
  c, d;
)$

// Matriz identidade
$mat(delim: \"(\",
  1, 0, 0;
  0, 1, 0;
  0, 0, 1;
)$")
]

$ mat(a, b; c, d) quad quad mat(delim: "[", 1, 2, 3; 4, 5, 6) quad quad mat(delim: "|", a, b; c, d) $

== Equações numeradas

Para numerar equações, use o ambiente `math.equation` com `block: true`:

#exemplo[
  #raw(block: true, lang: "typst", "#set math.equation(numbering: \"(1)\")

$ E = m c^2 $ <eq:einstein>

$ integral_0^infinity e^(-x^2) dif x = frac(sqrt(pi), 2) $ <eq:gauss>

Pela equação @eq:einstein e @eq:gauss...")
]

#set math.equation(numbering: "(1)")

$ E = m c^2 $ <eq:einstein>

$ integral_0^infinity e^(-x^2) dif x = frac(sqrt(pi), 2) $ <eq:gauss>

#set math.equation(numbering: none)

== Alinhamento de equações

Para alinhar múltiplas equações, use `&` para marcar o ponto de alinhamento:

#exemplo[
  #raw(block: true, lang: "typst", "$
(a + b)^2 &= (a + b)(a + b) \\
          &= a^2 + a b + b a + b^2 \\
          &= a^2 + 2 a b + b^2
$")
]

$
(a + b)^2 &= (a + b)(a + b) \
          &= a^2 + a b + b a + b^2 \
          &= a^2 + 2 a b + b^2
$

== Teoremas, definições e demonstrações

O Typst permite criar ambientes personalizados para teoremas:

#exemplo[
  #raw(block: true, lang: "typst", "#let theorem = figure.with(
  kind: \"theorem\",
  supplement: [Teorema],
)

#theorem(caption: [Teorema de Pitágoras])[
  Em um triângulo retângulo, o quadrado da hipotenusa
  é igual à soma dos quadrados dos catetos:
  $ c^2 = a^2 + b^2 $
]

*Demonstração.* Seja um triângulo retângulo com
catetos $a$ e $b$ e hipotenusa $c$... $square$")
]

#let theorem-counter = counter("theorem")

#let teorema(title: none, body) = {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 1em,
    stroke: (left: 3pt + blue),
    fill: rgb("#f0f7ff"),
  )[
    #text(weight: "bold")[Teorema #context theorem-counter.display()#if title != none [: #title]]

    #body
  ]
}

#teorema(title: [Fundamental do Cálculo])[
  Se $f$ é contínua em $[a, b]$ e $F$ é uma primitiva de $f$, então:
  $ integral_a^b f(x) dif x = F(b) - F(a) $
]

#pagebreak()

// ============================================================================
// CAPÍTULO 6: DIAGRAMAS E GRÁFICOS
// ============================================================================

= Diagramas e Gráficos

Typst oferece recursos nativos e pacotes externos para criação de diagramas, gráficos e visualizações.

== Pacotes para diagramas em Typst

Os principais pacotes para diagramas são:

- *fletcher*: Diagramas de fluxo e comutativos
- *cetz*: Gráficos vetoriais (similar ao TikZ)
- *diagraph*: Grafos usando sintaxe DOT
- *plotst*: Gráficos de funções simples

Para usar um pacote:

#raw(block: true, lang: "typst", "#import \"@preview/fletcher:0.5.0\": *
#import \"@preview/cetz:0.2.0\"")

== Diagramas comutativos

Diagramas comutativos são essenciais em álgebra e teoria das categorias. Use o pacote `fletcher`:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/fletcher:0.5.0\": diagram, node, edge

#diagram(
  node((0, 0), $A$),
  node((1, 0), $B$),
  node((0, 1), $C$),
  node((1, 1), $D$),
  edge((0, 0), (1, 0), $f$, \"->\"),
  edge((0, 0), (0, 1), $g$, \"->\"),
  edge((1, 0), (1, 1), $h$, \"->\"),
  edge((0, 1), (1, 1), $k$, \"->\"),
)")
]

== Grafos e fluxogramas

Para grafos simples, o pacote `diagraph` permite usar a sintaxe DOT do Graphviz:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/diagraph:0.2.0\": *

#raw-render(```
  digraph {
    rankdir=LR
    A -> B -> C
    B -> D
  }
```)")
]

Para fluxogramas mais elaborados, use `fletcher` ou `cetz`:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/fletcher:0.5.0\": *

#diagram(
  node((0, 0), [Início], shape: ellipse),
  edge(\"->\"),
  node((0, 1), [Processar]),
  edge(\"->\"),
  node((0, 2), [Decisão?], shape: diamond),
  edge(\"r\", \"->\", [Sim]),
  node((1, 2), [Ação A]),
  edge((0, 2), (0, 3), \"->\", [Não]),
  node((0, 3), [Ação B]),
  edge((1, 2), (0, 4), \"->\"),
  edge((0, 3), (0, 4), \"->\"),
  node((0, 4), [Fim], shape: ellipse),
)")
]

== Gráficos de funções

Para gráficos matemáticos, use o pacote `cetz`:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/cetz:0.2.0\"

#cetz.canvas({
  import cetz.draw: *
  import cetz.plot

  plot.plot(
    size: (8, 6),
    x-label: $x$,
    y-label: $y$,
    x-min: -2, x-max: 2,
    y-min: -1, y-max: 4,
    {
      plot.add(
        domain: (-2, 2),
        x => calc.pow(x, 2),
        label: $y = x^2$,
      )
    }
  )
})")
]

Para gráficos estatísticos simples, o ABNTypst inclui funções auxiliares:

#raw(block: true, lang: "typst", "// Gráfico de barras (simplificado)
#grafico-barras(
  dados: ((\"A\", 30), (\"B\", 45), (\"C\", 25)),
  titulo: \"Distribuição\",
)

// Gráfico de pizza
#grafico-pizza(
  dados: ((\"Sim\", 60), (\"Não\", 30), (\"Talvez\", 10)),
)")

#pagebreak()

// ============================================================================
// CAPÍTULO 7: ELEMENTOS PÓS-TEXTUAIS
// ============================================================================

= Elementos Pós-textuais

Os elementos pós-textuais complementam o trabalho e incluem referências, apêndices, anexos, glossário e índice.

== Referências bibliográficas (NBR 6023)

As referências são obrigatórias e devem seguir a NBR 6023:2018. O ABNTypst suporta referências manuais e automáticas via arquivo `.bib`.

=== Referências manuais

#exemplo[
  #raw(block: true, lang: "typst", "#heading(level: 1, numbering: none)[REFERÊNCIAS]

#set par(
  hanging-indent: 1.25cm,
  first-line-indent: 0pt,
)

SILVA, João Carlos da. *Introdução à programação*.
2. ed. São Paulo: Editora Atlas, 2023.

SANTOS, Maria; COSTA, Ana Paula. Análise de algoritmos.
*Revista Brasileira de Computação*, Brasília, v. 15,
n. 3, p. 45-67, set. 2022.")
]

=== Referências automáticas

O ABNTypst pode usar arquivos `.bib` para gerar referências automaticamente:

#raw(block: true, lang: "typst", "// No preâmbulo
#show: abntcc.with(
  bibliography-file: \"referencias.bib\",
)

// Ou no final do documento
#abnt-bibliography(\"referencias.bib\")")

Exemplo de arquivo `.bib`:

#raw(block: true, lang: "bibtex", "@book{silva2023,
  author = {Silva, João Carlos da},
  title = {Introdução à programação},
  edition = {2},
  publisher = {Editora Atlas},
  address = {São Paulo},
  year = {2023},
}

@article{santos2022,
  author = {Santos, Maria and Costa, Ana Paula},
  title = {Análise de algoritmos},
  journal = {Revista Brasileira de Computação},
  volume = {15},
  number = {3},
  pages = {45-67},
  year = {2022},
}")

== Apêndices e Anexos

Apêndices são documentos elaborados pelo próprio autor. Anexos são documentos de terceiros.

#exemplo[
  #raw(block: true, lang: "typst", "// Inicia seção de apêndices
#heading(level: 1, numbering: none)[APÊNDICES]

== Apêndice A -- Questionário aplicado <apendice-a>

Texto do apêndice...

== Apêndice B -- Código-fonte <apendice-b>

#raw(block: true, lang: \"python\", \"def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    ...\")

// Inicia seção de anexos
#heading(level: 1, numbering: none)[ANEXOS]

== Anexo A -- Norma ABNT NBR 14724 <anexo-a>

Texto do anexo...")
]

== Glossário

O glossário lista termos técnicos em ordem alfabética:

#exemplo[
  #raw(block: true, lang: "typst", "#heading(level: 1, numbering: none)[GLOSSÁRIO]

#glossario((
  \"Algoritmo\": \"Sequência finita de instruções bem definidas
    que, quando executadas, realizam uma tarefa específica.\",

  \"Complexidade\": \"Medida dos recursos computacionais
    (tempo ou espaço) necessários para executar um algoritmo.\",

  \"Ordenação\": \"Processo de organizar elementos de uma
    coleção em uma sequência específica.\",
))")
]

== Índice remissivo

O índice remissivo lista termos importantes com suas páginas. O ABNTypst oferece funções para marcar e gerar índices:

#exemplo[
  #raw(block: true, lang: "typst", "// No texto, marque termos para o índice
Um #idx[algoritmo] é uma sequência de instruções...

O #idx[Quicksort] é um algoritmo de #idx[ordenação]...

// No final do documento
#heading(level: 1, numbering: none)[ÍNDICE]

#indice()")
]

#pagebreak()

// ============================================================================
// CAPÍTULO 8: TIPOS DE DOCUMENTOS
// ============================================================================

= Tipos de Documentos

O ABNTypst oferece templates para diversos tipos de documentos acadêmicos e técnicos.

== Trabalho acadêmico (tese, dissertação, TCC)

O template `abntcc` é o mais completo, seguindo a NBR 14724:2024:

#raw(block: true, lang: "typst", "#show: abntcc.with(
  title: \"Título do Trabalho\",
  subtitle: \"Subtítulo (se houver)\",
  author: \"Nome do Autor\",
  institution: \"Universidade Federal\",
  faculty: \"Faculdade/Instituto\",
  program: \"Programa de Pós-Graduação\",
  location: \"Cidade\",
  year: 2026,
  nature: \"Dissertação apresentada ao...\",
  objective: \"como requisito parcial para...\",
  advisor: \"Prof. Dr. Nome\",
  co-advisor: \"Profa. Dra. Nome\",
  keywords-pt: (\"Palavra1\", \"Palavra2\"),
  keywords-en: (\"Keyword1\", \"Keyword2\"),
  font: \"Times New Roman\",  // ou \"Arial\"
)")

== Artigo científico

O template `artigo` segue a NBR 6022:2018:

#raw(block: true, lang: "typst", "#show: artigo.with(
  title: \"Título do Artigo\",
  authors: (
    (name: \"Autor Um\",
     affiliation: \"Universidade A\",
     email: \"autor1@exemplo.com\"),
    (name: \"Autor Dois\",
     affiliation: \"Universidade B\",
     email: \"autor2@exemplo.com\"),
  ),
  abstract-pt: [Resumo em português...],
  abstract-en: [Abstract in English...],
  keywords-pt: (\"palavra1\", \"palavra2\"),
  keywords-en: (\"keyword1\", \"keyword2\"),
  columns: 1,  // ou 2 para duas colunas
)")

== Relatório técnico

O template `relatorio` segue a NBR 10719:2015:

#raw(block: true, lang: "typst", "#show: relatorio.with(
  title: \"Título do Relatório\",
  report-number: \"RT-001/2026\",
  institution: \"Instituição\",
  authors: (
    (name: \"Nome\", qualification: \"Pesquisador\"),
  ),
  classification: \"Ostensivo\",  // ou \"Reservado\", \"Confidencial\"
  location: \"Cidade\",
  year: 2026,
)")

== Projeto de pesquisa

O template `projeto-pesquisa` segue a NBR 15287:2025:

#raw(block: true, lang: "typst", "#show: projeto-pesquisa.with(
  title: \"Título do Projeto\",
  author: \"Nome do Pesquisador\",
  institution: \"Universidade\",
  advisor: \"Prof. Dr. Orientador\",
  project-type: \"Projeto de Mestrado\",
  location: \"Cidade\",
  year: 2026,
)

= Introdução
= Justificativa
= Objetivos
== Objetivo Geral
== Objetivos Específicos
= Metodologia
= Cronograma
#cronograma(...)
= Referências")

== Livro

O template `livro` segue a NBR 6029:2023:

#raw(block: true, lang: "typst", "#show: livro.with(
  title: \"Título do Livro\",
  author: \"Nome do Autor\",
  publisher: \"Editora\",
  location: \"Cidade\",
  year: 2026,
  edition: 1,
  isbn: \"978-85-00000-00-0\",
)")

== Pôster científico

O template `poster` segue a NBR 15437:2006:

#raw(block: true, lang: "typst", "#show: poster.with(
  title: \"Título do Pôster\",
  authors: ((name: \"Autor\", affiliation: \"Instituição\"),),
  abstract-text: [Resumo em até 100 palavras...],
  keywords: (\"palavra1\", \"palavra2\"),
  columns: 3,
  width: 90cm,
  height: 120cm,
)

#poster-section(title: \"INTRODUÇÃO\")[...]
#poster-section(title: \"METODOLOGIA\")[...]
#poster-section(title: \"RESULTADOS\")[...]
#poster-section(title: \"CONCLUSÕES\")[...]
#poster-references((...))
")

== Slides para defesa

O template `slides` usa o pacote Touying para apresentações:

#raw(block: true, lang: "typst", "#import \"@preview/touying:0.4.0\": *
#import \"@preview/abntypst:0.1.0\": slides-defesa

#show: slides-defesa.with(
  title: \"Título do Trabalho\",
  author: \"Nome do Autor\",
  institution: \"Universidade\",
  date: \"15 de março de 2026\",
)

== Introdução

- Contexto do trabalho
- Problema de pesquisa
- Objetivos

== Metodologia

- Métodos utilizados
- Materiais

== Resultados

#figure(
  image(\"resultados.png\"),
  caption: [Principais resultados],
)

== Conclusões

- Principais contribuições
- Trabalhos futuros
- Agradecimentos")

#pagebreak()

// ============================================================================
// APÊNDICE A: SÍMBOLOS MATEMÁTICOS
// ============================================================================

#heading(level: 1, numbering: none)[APÊNDICE A -- Símbolos Matemáticos em Typst]
#label("apendice-a")

#set heading(numbering: "A.1")
#counter(heading).update((0,))

== Operadores binários

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`+`], [$+$], [`-`], [$-$], [`times`], [$times$],
    [`div`], [$div$], [`plus.minus`], [$plus.minus$], [`minus.plus`], [$minus.plus$],
    [`dot`], [$dot$], [`ast`], [$ast$], [`star`], [$star$],
    [`circle.small`], [$circle.small$], [`bullet`], [$bullet$], [`diamond`], [$diamond$],
    [`and`], [$and$], [`or`], [$or$], [`xor`], [$xor$],
    [`union`], [$union$], [`inter`], [$inter$], [`without`], [$without$],
    table.hline(stroke: 1pt),
  ),
  caption: [Operadores binários],
  kind: table,
)

== Relações

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`=`], [$=$], [`!=`], [$!=$], [`<`], [$<$],
    [`>`], [$>$], [`<= `], [$<=$], [`>=`], [$>=$],
    [`approx`], [$approx$], [`equiv`], [$equiv$], [`tilde`], [$tilde$],
    [`prec`], [$prec$], [`succ`], [$succ$], [`tilde.eq`], [$tilde.eq$],
    [`subset`], [$subset$], [`supset`], [$supset$], [`in`], [$in$],
    [`subset.eq`], [$subset.eq$], [`supset.eq`], [$supset.eq$], [`in.not`], [$in.not$],
    [`prop`], [$prop$], [`parallel`], [$parallel$], [`perp`], [$perp$],
    table.hline(stroke: 1pt),
  ),
  caption: [Símbolos de relação],
  kind: table,
)

== Setas

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`->`], [$->$], [`<-`], [$<-$], [`<->`], [$<->$],
    [`=>`], [$=>$], [`<=`], [$<=$], [`<=>`], [$<=>$],
    [`arrow.t`], [$arrow.t$], [`arrow.b`], [$arrow.b$], [`arrow.t.b`], [$arrow.t.b$],
    [`arrow.r.long`], [$arrow.r.long$], [`arrow.l.long`], [$arrow.l.long$], [`arrow.l.r.long`], [$arrow.l.r.long$],
    [`|-> `], [$|->$], [`arrow.hook`], [$arrow.hook$], [`arrow.r.tail`], [$arrow.r.tail$],
    table.hline(stroke: 1pt),
  ),
  caption: [Setas],
  kind: table,
)

== Símbolos diversos

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`infinity`], [$infinity$], [`emptyset`], [$emptyset$], [`therefore`], [$therefore$],
    [`because`], [$because$], [`forall`], [$forall$], [`exists`], [$exists$],
    [`not`], [$not$], [`partial`], [$partial$], [`nabla`], [$nabla$],
    [`ell`], [$ell$], [`planck`], [$planck$], [`Re`], [$Re$],
    [`Im`], [$Im$], [`aleph`], [$aleph$], [`dots`], [$dots$],
    table.hline(stroke: 1pt),
  ),
  caption: [Símbolos diversos],
  kind: table,
)

#pagebreak()

// ============================================================================
// APÊNDICE B: GUIA DE MIGRAÇÃO LATEX -> TYPST
// ============================================================================

#heading(level: 1, numbering: none)[APÊNDICE B -- Guia de Migração LaTeX → Typst]
#label("apendice-b")

#counter(heading).update((1,))

Este apêndice é destinado a usuários que já conhecem LaTeX e desejam migrar para Typst.

== Diferenças fundamentais de sintaxe

#figure(
  table(
    columns: (1fr, 1fr, 2fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Conceito*], [*LaTeX*], [*Typst*],
    table.hline(stroke: 0.5pt),
    [Comando], [`\comando`], [`#comando`],
    [Ambiente], [`\begin{env}...\end{env}`], [`#env[...]` ou função],
    [Comentário], [`% comentário`], [`// comentário`],
    [Negrito], [`\textbf{texto}`], [`*texto*`],
    [Itálico], [`\textit{texto}`], [`_texto_`],
    [Matemática inline], [`$...$`], [`$...$`],
    [Matemática display], [`$$...$$` ou `\[...\]`], [`$ ... $` (com espaços)],
    [Potência], [`x^{n+1}`], [`x^(n+1)`],
    [Índice], [`a_{ij}`], [`a_(i j)`],
    [Fração], [`\frac{a}{b}`], [`frac(a, b)`],
    table.hline(stroke: 1pt),
  ),
  caption: [Diferenças de sintaxe entre LaTeX e Typst],
  kind: table,
)

== Equivalências de comandos comuns

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*LaTeX*], [*Typst*],
    table.hline(stroke: 0.5pt),
    [`\documentclass{article}`], [`#set page(paper: "a4")`],
    [`\usepackage{...}`], [`#import "@preview/...": *`],
    [`\title{...}`], [`#set document(title: "...")`],
    [`\section{...}`], [`= Título`],
    [`\subsection{...}`], [`== Título`],
    [`\includegraphics{...}`], [`#image("...")`],
    [`\begin{figure}...\end{figure}`], [`#figure(...)`],
    [`\begin{table}...\end{table}`], [`#figure(table(...), kind: table)`],
    [`\caption{...}`], [`caption: [...]`],
    [`\label{...}`], [`<label>`],
    [`\ref{...}`], [`@label`],
    [`\cite{...}`], [`@referencia` ou `#cite(<ref>)`],
    [`\footnote{...}`], [`#footnote[...]`],
    [`\textbf{...}`], [`*...*`],
    [`\textit{...}`], [`_..._`],
    [`\underline{...}`], [`#underline[...]`],
    [`\emph{...}`], [`_..._` ou `#emph[...]`],
    [`\url{...}`], [`#link("...")` ],
    [`\href{url}{texto}`], [`#link("url")[texto]`],
    [`\newpage`], [`#pagebreak()`],
    [#raw("\\\\")], [#raw("\\") (quebra de linha)],
    table.hline(stroke: 1pt),
  ),
  caption: [Equivalências de comandos LaTeX/Typst],
  kind: table,
)

== Pacotes LaTeX e equivalentes Typst

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Pacote LaTeX*], [*Pacote Typst*], [*Função*],
    table.hline(stroke: 0.5pt),
    [`graphicx`], [nativo], [Imagens],
    [`hyperref`], [nativo], [Links],
    [`amsmath`], [nativo], [Matemática avançada],
    [`amssymb`], [nativo], [Símbolos matemáticos],
    [#raw("`geometry`")], [nativo (#raw("#set page"))], [Margens],
    [#raw("`babel`")], [nativo (#raw("#set text"))], [Idioma],
    [`tikz`], [`cetz`], [Gráficos vetoriais],
    [`pgfplots`], [`cetz` ou `plotst`], [Gráficos de funções],
    [`xy-pic`], [`fletcher`], [Diagramas comutativos],
    [`beamer`], [`touying` ou `polylux`], [Apresentações],
    [`algorithm2e`], [`algorithmic`], [Pseudocódigo],
    [#raw("`listings`")], [nativo (#raw("raw"))], [Código-fonte],
    [`booktabs`], [nativo], [Tabelas elegantes],
    [`natbib`/`biblatex`], [nativo + CSL], [Bibliografia],
    [`abnTeX2`], [`abntypst`], [Normas ABNT],
    table.hline(stroke: 1pt),
  ),
  caption: [Equivalências de pacotes],
  kind: table,
)

== abnTeX2 vs ABNTypst

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*abnTeX2 (LaTeX)*], [*ABNTypst (Typst)*],
    table.hline(stroke: 0.5pt),
    [#raw("\\documentclass{abntex2}")], [#raw("#show: abntcc.with(..)")],
    [#raw("\\imprimircapa")], [#raw("#capa(..)")],
    [#raw("\\imprimirfolhaderosto")], [#raw("#folha-rosto(..)")],
    [#raw("\\begin{resumo}...\\end{resumo}")], [#raw("#resumo(..)[...]")],
    [#raw("\\begin{abstract}...\\end{abstract}")], [#raw("#abstract-page(..)[...]")],
    [#raw("\\pdfbookmark{Sumário}{toc}\\tableofcontents")], [#raw("#sumario()")],
    [#raw("\\chapter{...}")], [#raw("= Título") (nível 1)],
    [#raw("\\section{...}")], [#raw("== Título") (nível 2)],
    [#raw("\\cite{...}")], [#raw("@ref") ou #raw("#cite(<ref>)")],
    [#raw("\\citeonline{...}")], [#raw("#citar-autor(\"Autor\", \"2023\")")],
    [#raw("\\apud{...}{...}")], [#raw("#citar-apud(..)")],
    [#raw("\\textcite{...}")], [#raw("#citar-autor(..)")],
    [#raw("\\begin{citacao}...\\end{citacao}")], [#raw("#citacao-longa(..)[...]")],
    [#raw("\\SingleSpacing")], [#raw("#set par(leading: 0.5em)")],
    [#raw("\\OnehalfSpacing")], [#raw("#set par(leading: 0.65em)")],
    [#raw("\\DoubleSpacing")], [#raw("#set par(leading: 1.4em)")],
    table.hline(stroke: 1pt),
  ),
  caption: [Equivalências abnTeX2/ABNTypst],
  kind: table,
)

#pagebreak()

// ============================================================================
// APÊNDICE C: RECURSOS NA INTERNET
// ============================================================================

#heading(level: 1, numbering: none)[APÊNDICE C -- Recursos na Internet]
#label("apendice-c")

#counter(heading).update((2,))

== Typst

- *Site oficial*: #link("https://typst.app")
- *Documentação*: #link("https://typst.app/docs")
- *Repositório GitHub*: #link("https://github.com/typst/typst")
- *Typst Universe* (pacotes): #link("https://typst.app/universe")
- *Discord da comunidade*: #link("https://discord.gg/2uDybryKPe")
- *Fórum de discussões*: #link("https://github.com/typst/typst/discussions")

== ABNTypst

- *Repositório GitHub*: #link("https://github.com/esdras/abntypst")
- *Documentação*: #link("https://github.com/esdras/abntypst/docs")
- *Issues (problemas)*: #link("https://github.com/esdras/abntypst/issues")

== Normas ABNT

- *ABNT Catálogo*: #link("https://www.abntcatalogo.com.br")
- *ABNT Coleção*: #link("https://www.abntcolecao.com.br")

== Tutoriais e cursos

- *Typst Tutorial* (oficial): #link("https://typst.app/docs/tutorial")
- *Typst by Example*: #link("https://sitandr.github.io/typst-examples-book/book")

== Ferramentas

- *Typst LSP* (VS Code): #link("https://marketplace.visualstudio.com/items?itemName=nvarner.typst-lsp")
- *Typst Preview* (VS Code): #link("https://marketplace.visualstudio.com/items?itemName=mgt19937.typst-preview")
- *Tinymist* (language server): #link("https://github.com/Enter-tainer/tinymist")

#pagebreak()

// ============================================================================
// APÊNDICE D: NORMAS ABNT IMPLEMENTADAS
// ============================================================================

#heading(level: 1, numbering: none)[APÊNDICE D -- Normas ABNT Implementadas]
#label("apendice-d")

#counter(heading).update((3,))

== Normas principais

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Norma*], [*Título*], [*Versão*],
    table.hline(stroke: 0.5pt),
    [NBR 14724], [Trabalhos acadêmicos --- Apresentação], [2024],
    [NBR 6023], [Referências --- Elaboração], [2018],
    [NBR 10520], [Citações em documentos --- Apresentação], [2023],
    [NBR 6024], [Numeração progressiva das seções], [2012],
    [NBR 6027], [Sumário --- Apresentação], [2012],
    [NBR 6028], [Resumo, resenha e recensão --- Apresentação], [2021],
    table.hline(stroke: 1pt),
  ),
  caption: [Normas principais implementadas],
  kind: table,
)

== Normas para tipos específicos de documentos

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Norma*], [*Título*], [*Versão*],
    table.hline(stroke: 0.5pt),
    [NBR 6022], [Artigo em publicação periódica], [2018],
    [NBR 6021], [Publicação periódica --- Apresentação], [2015],
    [NBR 6029], [Livros e folhetos --- Apresentação], [2023],
    [NBR 10719], [Relatório técnico --- Apresentação], [2015],
    [NBR 15287], [Projeto de pesquisa --- Apresentação], [2025],
    [NBR 15437], [Pôsteres técnicos e científicos], [2006],
    table.hline(stroke: 1pt),
  ),
  caption: [Normas para tipos de documentos],
  kind: table,
)

== Normas complementares

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Norma*], [*Título*], [*Versão*],
    table.hline(stroke: 0.5pt),
    [NBR 6034], [Índice --- Apresentação], [2004],
    [NBR 12225], [Lombada --- Apresentação], [2004],
    [NBR 5892], [Representação de datas e horas], [2019],
    [NBR 6025], [Revisão de originais e provas], [2002],
    [NBR 6032], [Abreviação de títulos de periódicos], [1989],
    [NBR 6033], [Ordem alfabética], [1989],
    [NBR ISO 2108], [ISBN], [2006],
    [NBR 10525], [ISSN], [2005],
    [IBGE], [Normas de apresentação tabular], [1993],
    table.hline(stroke: 1pt),
  ),
  caption: [Normas complementares implementadas],
  kind: table,
)

#pagebreak()

// ============================================================================
// REFERÊNCIAS
// ============================================================================

#heading(level: 1, numbering: none)[REFERÊNCIAS]

#set par(
  hanging-indent: 1.25cm,
  first-line-indent: 0pt,
)

ANDRADE, Lenimar Nunes de. *Breve Introdução ao LaTeX 2ε*. Versão 2.1. João Pessoa: UFPB, 2000. Disponível em: ftp:\/\/mat.ufpb.br/pub/textos/tex/. Acesso em: 15 jan. 2026.

ARAUJO, Lauro César. *O pacote abnTeX2*. Versão 1.9. 2015. Disponível em: https:\/\/github.com/abntex/abntex2. Acesso em: 10 jan. 2026.

ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 6023*: informação e documentação: referências: elaboração. Rio de Janeiro, 2018.

ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 6024*: informação e documentação: numeração progressiva das seções de um documento: apresentação. Rio de Janeiro, 2012.

ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 6027*: informação e documentação: sumário: apresentação. Rio de Janeiro, 2012.

ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 6028*: informação e documentação: resumo, resenha e recensão: apresentação. Rio de Janeiro, 2021.

ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 10520*: informação e documentação: citações em documentos: apresentação. Rio de Janeiro, 2023.

ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *NBR 14724*: informação e documentação: trabalhos acadêmicos: apresentação. Rio de Janeiro, 2024.

HAUG, Martin; MÄDJE, Laurenz. *Typst Documentation*. 2024. Disponível em: https:\/\/typst.app/docs. Acesso em: 10 jan. 2026.

IBGE. *Normas de apresentação tabular*. 3. ed. Rio de Janeiro, 1993.
