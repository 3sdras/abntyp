// Breve Introdução ao ABNTypst
// Documento tutorial para iniciantes
// Inspirado no "Breve Introdução ao LaTeX 2ε" de Lenimar Nunes de Andrade

#import "../lib.typ": *
#import "../../matypst/lib.typ": *

#show: livro.with(
  titulo: "Breve Introdução ao ABNTypst",
  autor: "ABNTypst",
  editora: "",
  local: "",
  ano: 2026,
  fonte: "Times New Roman",
)

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

// Nota visual indicando conteúdo do matypst (pacote companheiro)
#let matypst-nota(body) = {
  block(
    width: 100%,
    inset: 1em,
    stroke: (left: 3pt + eastern),
    fill: eastern.lighten(95%),
  )[
    #set par(first-line-indent: 0pt)
    #text(weight: "bold", fill: eastern)[matypst]
    #h(0.5em) #body
  ]
}

// ============================================================================
// CAPA
// ============================================================================

#align(center)[
  #v(2cm)

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

#book-toc(profundidade: 3)

// ============================================================================
// PREFÁCIO
// ============================================================================

#book-preface(titulo: "PREFÁCIO")[
  Estas notas são uma adaptação dos trabalhos originais "Uma breve introdução ao $"LaTeX" 2 epsilon$", de Lenimar Nunes de Andrade e a documentação do pacote ABNTex2 de LaTeX, para o caso do Typst, com o objetivo de servir de material didático para a disciplina "Software Livre para digitação de textos matemáticos" na UFJ.

  O ABNTypst é um pacote gratuito, de código aberto, desenvolvido para facilitar a produção de documentos técnicos e científicos brasileiros. Pode ser utilizado diretamente no navegador através do #link("https://typst.app")[typst.app], ou instalado localmente em qualquer sistema operacional.

  O *matypst* é o pacote companheiro do ABNTypst, fornecendo utilitários genéricos para matemática, código e caixas decorativas. Enquanto o ABNTypst cuida da formatação conforme normas ABNT, o matypst oferece funções auxiliares como operadores em português (`sen`), frações com estilo (`fracao`), raízes (`raiz`), e ambientes como teoremas, definições e demonstrações. As seções deste documento que utilizam funções do matypst estão identificadas com uma nota visual.

  No Capítulo 1 são introduzidos os conceitos básicos do Typst e do ABNTypst. O Capítulo 2 trata dos elementos pré-textuais (capa, folha de rosto, resumo, etc.) e o Capítulo 3 aborda os elementos textuais (seções, citações, alíneas). A leitura desses três primeiros capítulos deve habilitar o leitor a produzir um trabalho acadêmico básico.

  O Capítulo 4 trata de figuras, quadros e tabelas. O Capítulo 5 apresenta uma cobertura completa de fórmulas matemáticas, e o Capítulo 6 aborda diagramas e gráficos.

  Os Capítulos 7 e 8 tratam dos elementos pós-textuais e dos diferentes tipos de documentos suportados pelo ABNTypst.

  Os apêndices contêm tabelas de referência para símbolos matemáticos (Apêndice A), um guia de migração para quem vem do LaTeX (Apêndice B), recursos na Internet (Apêndice C) e uma tabela das normas ABNT implementadas (Apêndice D).

  #v(1cm)

  #align(right)[
    Jataí, janeiro de 2026

    _Equipe ABNTypst_
  ]
]

// ============================================================================
// CAPÍTULO 1: CONCEITOS BÁSICOS
// ============================================================================

// Inicia numeração de páginas
#book-start-numbering()

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
  titulo: \"Meu Trabalho Acadêmico\",
  autor: \"Maria da Silva\",
  instituicao: \"Universidade Federal\",
  local: \"Cidade\",
  ano: 2026,
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

  *Atenção:* ao usar `all: true`, evite `#show raw: set par(first-line-indent: 0pt)` --- essa regra genérica quebra o fluxo de código inline (backticks), forçando-o para linhas separadas. Use `#show raw.where(block: true): set par(first-line-indent: 0pt)` para excluir apenas blocos de código da indentação, sem afetar o inline.
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
  instituicao: \"Universidade Federal de Jataí\",
  faculdade: \"Instituto de Ciências Exatas e Tecnológicas\",
  programa: \"PROFMAT\",
  autor: \"Maria da Silva\",
  titulo: \"Análise de Algoritmos de Ordenação\",
  subtitulo: \"Um estudo comparativo\",
  local: \"Jataí\",
  ano: 2026,
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
  autor: \"Maria da Silva\",
  titulo: \"Análise de Algoritmos de Ordenação\",
  subtitulo: \"Um estudo comparativo\",
  natureza: \"Dissertação apresentada ao Programa de Pós-Graduação
    em Ciência da Computação da Universidade Federal de Jataí\",
  objetivo: \"como requisito parcial para obtenção do título
    de Mestre em Ciência da Computação.\",
  area: \"Algoritmos e Estruturas de Dados\",
  orientador: \"Prof. Dr. João Santos\",
  coorientador: \"Profa. Dra. Ana Costa\",  // opcional
  local: \"Jataí\",
  ano: 2026,
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

Diferente de funções como `#capa()` ou `#folha-rosto()`, que possuem campos nomeados (`autor:`, `titulo:`, etc.), a `#ficha-catalografica()` recebe conteúdo livre, pois a ficha segue uma notação biblioteconômica específica (código Cutter, CDU/CDD) que não se presta a campos parametrizados:


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
  referencia: [SILVA, Maria da. *Análise de algoritmos de
    ordenação*. 2026. Dissertação (Mestrado) -- UFJ, Jataí, 2026.],
  itens: (
    (pagina: 15, linha: 3, errado: \"ordenção\", correto: \"ordenação\"),
    (pagina: 42, linha: 10, errado: \"algortimo\", correto: \"algoritmo\"),
  ),
)")
]

== Folha de aprovação

A folha de aprovação contém os elementos da folha de rosto mais a data de aprovação e a composição da banca examinadora:

#exemplo[
  #raw(block: true, lang: "typst", "// NOTA: a folha de aprovação geralmente é fornecida pela
// instituição em PDF, após a defesa. Para incluí-la:
#page[
  #v(1fr)
  #image(\"folha-aprovacao.pdf\", page: 1, width: 100%)
]")
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
  palavras-chave: (\"Algoritmos\", \"Ordenação\", \"Complexidade\", \"Análise\"),
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

#abstract(
  palavras-chave: (\"Algorithms\", \"Sorting\", \"Complexity\", \"Analysis\"),
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
  titulo: \"SUMÁRIO\",
  profundidade: 3,  // Até seções terciárias
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
  autor: \"SILVA\",
  ano: \"2023\",
  pagina: \"42\"
).")

  Resultado: Conforme o autor, "a formatação adequada é essencial para a clareza" (SILVA, 2023, p. 42).
]

=== Citação direta longa

Citações com mais de três linhas devem ser destacadas com recuo de 4 cm, fonte menor e espaçamento simples:

#exemplo[
  #raw(block: true, lang: "typst", "#citacao-longa(
  autor: \"SILVA\",
  ano: \"2023\",
  pagina: \"42-43\"
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
A metodologia é importante #citar(\"SILVA\", \"2023\", pagina: \"45\").

// Múltiplos autores (até 3)
Conforme #citar(\"SILVA; SANTOS; COSTA\", \"2023\")...

// Mais de 3 autores (et al.)
De acordo com #citar(\"SILVA et al.\", \"2023\")...

// Citação de citação (apud)
#citar-apud(\"FREUD\", \"1900\", \"LACAN\", \"1966\", pagina: \"123\")")

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

O resultado foi positivo #citar-num(\"silva2023\", pagina: \"45\").

Outros autores #citar-num-multiplos((\"santos2022\", \"costa2021\"))
confirmam os resultados.

// No final do documento:
#bibliografia-numerica((
  (\"silva2023\", [SILVA, J. *Título*. São Paulo: Editora, 2023.]),
  (\"santos2022\", [SANTOS, M. Artigo. *Revista*, v. 1, 2022.]),
  (\"costa2021\", [COSTA, A. Outro título. Rio: Ed., 2021.]),
))")
]

=== Citações com arquivo .bib

Além das funções manuais apresentadas acima, o ABNTypst suporta citações automáticas via arquivo `.bib`, usando a sintaxe nativa `@chave` do Typst. Esse é o método recomendado para documentos com muitas referências, pois evita erros de formatação e mantém a consistência entre citações e lista de referências.

Para habilitar, basta adicionar `configurar-citacoes-abnt` no preâmbulo do documento:

#exemplo[
  #raw(block: true, lang: "typst", "// No preâmbulo do documento
#show: configurar-citacoes-abnt

// Citação entre parênteses
O resultado foi positivo @silva2023.

// Citação com página
O resultado foi positivo @silva2023[p. 45].

// Autor no texto (suprime o nome entre parênteses)
Segundo Silva [-@silva2023], o resultado foi positivo.")

  Resultado: nas citações com `@chave`, o ABNTypst gera automaticamente o formato ABNT autor-data --- por exemplo, "(SILVA, 2023)" ou "(SILVA, 2023, p. 45)". A sintaxe `[-@chave]` suprime o nome do autor, útil quando ele já aparece no texto.
]

As chaves (como `silva2023`) devem corresponder às entradas do arquivo `.bib` usado na bibliografia. No final do documento, inclua `#referencias("arquivo.bib")` para gerar a lista de referências (veja a @sec:ref-auto).

#block(
  width: 100%,
  inset: 1em,
  stroke: (left: 2pt + gray),
  fill: luma(245),
)[
  #set par(first-line-indent: 0pt)
  *Quando usar cada abordagem:*
  - *Arquivo `.bib` + `@chave`:* recomendado para a maioria dos trabalhos. As referências são formatadas automaticamente e a consistência é garantida pelo CSL.
  - *Funções manuais (`citar()`, `citar-autor()`, etc.):* úteis quando se precisa de controle total sobre o formato da citação, ou quando a entrada não existe no `.bib`.
  - *Sistema numérico:* quando exigido pela instituição ou revista. Não pode ser combinado com notas de rodapé.
]

== Notas de rodapé

Notas de rodapé são indicações ou observações complementares ao texto, regulamentadas pela NBR 10520:2023 (seção 6). A norma distingue _notas de referência_ (que indicam a fonte consultada) e _notas explicativas_ (para comentários e esclarecimentos). A NBR 14724:2024 complementa: devem ser separadas do texto por filete de 5 cm, em fonte menor e espaçamento simples. Em Typst, são criadas com a função `#footnote()`:

#exemplo[
  #raw(block: true, lang: "typst", "O Typst#footnote[Sistema de composição tipográfica criado
em 2019.] é uma alternativa moderna ao LaTeX#footnote[Criado
por Leslie Lamport na década de 1980.].")
]

O ABNTypst formata as notas automaticamente conforme a ABNT: fonte menor (10pt), espaçamento simples, separadas do texto por um filete de 5 cm.

== Alíneas e subalíneas

Alíneas e subalíneas são regulamentadas pela NBR 6024:2012 (seções 4 e 5). Alíneas são subdivisões de um assunto dentro de uma seção, sem título próprio, indicadas por letras minúsculas seguidas de parêntese --- o texto que as antecede deve terminar em dois-pontos. Subalíneas são subdivisões das alíneas, indicadas por travessão seguido de espaço. Ambas terminam em ponto e vírgula, exceto a última (ponto final):

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

No ABNTypst, todos esses elementos são inseridos por meio da função `#container()`. Ela é um invólucro sobre a função nativa `figure()` do Typst e cuida automaticamente de título (caption), numeração sequencial, fonte e nota --- tudo formatado conforme a ABNT. Dentro do container, usamos funções auxiliares para o conteúdo: `#imagem()` para fotografias e ilustrações, `#quadro()` para tabelas textuais com bordas fechadas, e `#tabela()` para tabelas numéricas no padrão IBGE (sem bordas laterais).

O parâmetro `tipo` indica o tipo do elemento --- a partir dele, o `container` infere a legenda automaticamente:

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    inset: 6pt,
    [*`tipo`*], [*Legenda inferida*], [*Uso*],
    [`"imagem"` (padrão)], ["Figura"], [Fotografias, ilustrações, gráficos],
    [`"tabela"`], ["Tabela"], [Tabelas numéricas (IBGE)],
    [`"quadro"`], ["Quadro"], [Tabelas textuais com bordas],
  ),
  caption: [Tipos de container],
  kind: "quadro",
  supplement: [Quadro],
)

== O container <sec:container>

A função `#container()` é a _única_ forma de criar um elemento com título e numeração no ABNTypst. Seus parâmetros principais são:

#raw(block: true, lang: "typst", "#container(
  legenda: [Título do elemento],  // aparece acima
  origem: [Elaborado pelo autor.],  // aparece abaixo (\"Fonte: ...\")
  nota: [Nota opcional.],  // aparece abaixo da fonte (\"Nota: ...\")
  tipo: \"imagem\",  // \"imagem\" (padrão), \"tabela\" ou \"quadro\"
)[
  // conteúdo: #imagem(), #quadro(), #tabela(), ou qualquer outro
]")

A NBR 14724:2024 estabelece que ilustrações e tabelas devem ter:
- Identificação na parte superior: tipo, número sequencial (algarismos arábicos), travessão e título
- Fonte na parte inferior (obrigatória, mesmo quando produção do próprio autor)
- Notas e legendas em fonte menor

O `container` cuida de tudo isso automaticamente, inclusive a centralização horizontal do elemento na página.

#figure(
  table(
    columns: (auto, auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Aceita*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`legenda`], [em branco ou conteúdo], [em branco], [Título do elemento. Aparece acima, com numeração automática (ex: "Figura 1 --- Título"). Se omitido, o elemento não recebe título nem numeração.],
    [`origem`], [em branco ou conteúdo], [em branco], [Fonte do elemento. Aparece abaixo com o prefixo "Fonte:". Obrigatório pela ABNT, mesmo para produções do próprio autor (ex: `[Elaborado pelo autor (2026).]`).],
    [`nota`], [em branco ou conteúdo], [em branco], [Nota explicativa. Aparece abaixo da fonte com o prefixo "Nota:". Opcional.],
    [`tipo`], [texto], [`"imagem"`], [Tipo do elemento, usado para numeração e legenda automáticas. Valores: \ -- `"imagem"`: ilustrações, gráficos, fotos (legenda: "Figura") \ -- `"tabela"`: tabelas numéricas IBGE (legenda: "Tabela") \ -- `"quadro"`: tabelas textuais com bordas (legenda: "Quadro")],
    [`suplemento`], [automático ou conteúdo], [automático], [Texto que precede o número (ex: "Figura", "Tabela"). Se automático, é inferido do `tipo`. Use para customizar: `suplemento: [Gráfico]`.],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros da função `container()`],
  kind: "quadro",
  supplement: [Quadro],
)

== Inserindo figuras

A NBR 14724:2024 classifica figuras como _ilustrações_ (assim como gráficos, fotografias, desenhos, mapas, etc.). Use `#imagem()` dentro de `#container()`:

#exemplo[
  #raw(block: true, lang: "typst", "#container(
  legenda: [Comparação de desempenho dos algoritmos],
  origem: [Elaborado pelo autor (2026).],
)[
  #imagem(\"imagens/grafico.png\", largura: 80%)
] <fig:comparacao>")
]

Como o `tipo` padrão é `"imagem"`, não é necessário informá-lo para figuras. Gráficos exportados como imagem (PNG, SVG, PDF) seguem o mesmo padrão --- são inseridos com `#imagem()`.

=== Parâmetros de `imagem()`

A função `#imagem()` é um wrapper sobre a função nativa `image()` do Typst, com todos os parâmetros traduzidos para o português. Formatos suportados: PNG, JPEG, GIF, SVG e PDF.

#figure(
  table(
    columns: (auto, auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Aceita*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`caminho`], [texto ou bytes], [obrigatório], [Caminho do arquivo de imagem (ex: `"imagens/foto.png"`) ou bytes brutos.],
    [`largura`], [automático ou medida], [automático], [Largura: absoluta (`5cm`), relativa (`80%`) ou automático (tamanho original).],
    [`altura`], [automático ou medida], [automático], [Altura da imagem. Se ambos forem definidos, `ajuste` controla a adaptação.],
    [`ajuste`], [texto], [`"cobrir"`], [`"cobrir"` (preenche, pode cortar), `"conter"` (cabe inteira) ou `"esticar"` (deforma).],
    [`alternativo`], [em branco ou texto], [em branco], [Texto alternativo para acessibilidade (leitores de tela).],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros comuns da função `imagem()`],
  kind: "quadro",
  supplement: [Quadro],
)

#figure(
  table(
    columns: (auto, auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Aceita*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`pagina`], [automático ou inteiro], [automático], [Página a extrair de arquivos PDF: `#imagem("doc.pdf", pagina: 3)`. Para outros formatos, deixe em automático.],
    [`formato`], [automático ou texto], [automático], [Formato da imagem. Detectado automaticamente pela extensão. Valores: `"png"`, `"jpg"`, `"gif"`, `"svg"`, `"pdf"`.],
    [`escala`], [automático ou texto], [automático], [Escala de renderização para imagens vetoriais (SVG).],
    [`icc`], [automático, texto ou bytes], [automático], [Perfil de cor ICC. Normalmente não é necessário alterar.],
    [`..outros`], [quaisquer], [---], [Parâmetros adicionais repassados diretamente a `image()`. Útil para compatibilidade com versões futuras do Typst.],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros avançados da função `imagem()`],
  kind: "quadro",
  supplement: [Quadro],
)

*Exemplos de uso:*

#raw(block: true, lang: "typst", "// Largura relativa (mais comum)
#imagem(\"grafico.png\", largura: 80%)

// Dimensões absolutas com ajuste
#imagem(\"foto.jpg\", largura: 10cm, altura: 7cm, ajuste: \"conter\")

// Página específica de um PDF
#imagem(\"documento.pdf\", pagina: 2, largura: 100%)

// Com texto alternativo para acessibilidade
#imagem(\"diagrama.svg\", largura: 90%, alternativo: \"Diagrama de fluxo do algoritmo\")")

== Centralização horizontal

O `#container()` centraliza automaticamente seu conteúdo --- não é preciso fazer nada além de usá-lo. Para elementos _fora_ de um container (uma imagem avulsa, um diagrama, um gráfico), use `#align(center)`:

#exemplo[
  #raw(block: true, lang: "typst", "// Imagem dentro de container: já centralizada
#container(
  legenda: [Meu gráfico],
  origem: [Elaborado pelo autor.],
)[
  #imagem(\"grafico.svg\", largura: 80%)
]

// Imagem avulsa (sem container): centralizar manualmente
#align(center)[
  #imagem(\"diagrama.svg\", largura: 60%)
]

// Diagrama ou gráfico avulso: mesmo padrão
#align(center)[
  #diagram(
    node((0, 0), $A$),
    node((1, 0), $B$),
    edge((0, 0), (1, 0), \"->\"),
  )
]")
]

== Quadros <sec:quadros>

Pela NBR 14724:2024, quadros são um tipo de ilustração e seguem as mesmas regras de identificação (título na parte superior, fonte na parte inferior). O IBGE (Normas de Apresentação Tabular, 1993) define quadro como "arranjo predominantemente de palavras dispostas em linhas e colunas, com ou sem dados numéricos". Diferem das tabelas por serem fechados (com bordas em todos os lados) e conterem predominantemente texto.

Use `#quadro()` dentro de `#container()` com `tipo: "quadro"`:


#exemplo[
  #raw(block: true, lang: "typst", "#container(
  legenda: [Glossário de termos],
  tipo: \"quadro\",
  origem: [Elaborado pelo autor.],
)[
  #quadro(
    columns: (1fr, 2fr),
    inset: 8pt,
    [*Termo*], [*Definição*],
    [Algoritmo], [Sequência finita de instruções],
    [Complexidade], [Medida de recursos necessários],
    [Ordenação], [Organização de dados em sequência],
  )
]")
]

A função `#quadro()` é um wrapper sobre `table()` --- aceita todos os mesmos parâmetros.

== Tabelas no padrão IBGE

A ABNT não define regras próprias para a apresentação de tabelas --- a NBR 14724:2024 (seção sobre tabelas) determina explicitamente: "conforme IBGE - Normas de Apresentação Tabular (1993)". A NBR 6022:2018 (artigos científicos) reitera: "padronizadas conforme Normas de apresentação tabular do IBGE". O documento referenciado é: FUNDAÇÃO INSTITUTO BRASILEIRO DE GEOGRAFIA E ESTATÍSTICA -- IBGE. _Normas de apresentação tabular_. 3. ed. Rio de Janeiro: IBGE, 1993. As principais regras são:
- Sem bordas laterais (tabelas são "abertas")
- Traços horizontais obrigatórios apenas no topo, após o cabeçalho e no rodapé
- O dado numérico é a informação central (dados textuais pertencem a quadros, não a tabelas)
- Fonte obrigatória no rodapé, indicando a entidade responsável pelo levantamento

Use `#tabela()` dentro de `#container()` com `tipo: "tabela"`:

#exemplo[
  #raw(block: true, lang: "typst", "#container(
  legenda: [Complexidade dos algoritmos de ordenação],
  tipo: \"tabela\",
  origem: [Adaptado de Cormen et al. (2012).],
)[
  #tabela(
    columns: 4,
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
  )
]")
]

A função `#tabela()` é um wrapper sobre `table()` que aplica `stroke: none` automaticamente (padrão IBGE: sem bordas laterais). Você só precisa adicionar as linhas horizontais com `table.hline()`.

== Legendas e fontes

O `container` já cuida da fonte e da nota por meio dos parâmetros `origem` e `nota`. Para casos em que você precise inserir fonte ou nota de forma avulsa (fora de um container), use as funções auxiliares:

#raw(block: true, lang: "typst", "// Fonte elaborada pelo autor
#fonte[Elaborado pelo autor (2026).]

// Fonte adaptada
#fonte[Adaptado de Silva (2023).]

// Fonte de terceiros
#fonte[IBGE (2022).]

// Nota explicativa (opcional)
#nota-figura[Os valores foram arredondados para duas casas decimais.]")

Porém, o uso recomendado é sempre via `container`:

#raw(block: true, lang: "typst", "#container(
  legenda: [Minha tabela],
  tipo: \"tabela\",
  origem: [Elaborado pelo autor (2026).],
  nota: [Os valores foram arredondados para duas casas decimais.],
)[
  #tabela(columns: 2,
    table.hline(stroke: 1.5pt),
    [*Região*], [*População*],
    table.hline(stroke: 0.75pt),
    [Nordeste], [57 366 598],
    table.hline(stroke: 1.5pt),
  )
]")

== Listas automáticas

O ABNTypst gera automaticamente listas de figuras, tabelas e quadros:

#raw(block: true, lang: "typst", "// No início do documento, após o sumário:

#lista-ilustracoes()  // Lista de figuras

#lista-tabelas()      // Lista de tabelas

#lista-quadros()      // Lista de quadros")

As listas são geradas a partir dos títulos definidos no parâmetro `legenda` de cada `#container()`.

#pagebreak()

// ============================================================================
// CAPÍTULO 5: FÓRMULAS MATEMÁTICAS
// ============================================================================

= Fórmulas Matemáticas

Uma das grandes vantagens do Typst sobre processadores de texto convencionais é a facilidade de escrever fórmulas matemáticas com qualidade tipográfica profissional.

== Modo matemático em Typst

Em Typst, fórmulas são escritas entre cifrões (`$`). Existem dois modos:

- *Inline* (na linha): `$x + y$` produz $x + y$
- *Destaque* (display): `$ x + y $` (com espaços) produz uma equação centralizada

#exemplo[
  #raw(block: true, lang: "typst", "A fórmula $a^2 + b^2 = c^2$ é o teorema de Pitágoras.

A mesma fórmula em destaque:
$ a^2 + b^2 = c^2 $")
]


== Espaçamentos

O Typst oferece duas funções nativas para inserir espaço em qualquer ponto do documento:

- `h(tamanho)` --- espaço *horizontal*
- `v(tamanho)` --- espaço *vertical*

Ambas aceitam qualquer unidade de medida (`cm`, `mm`, `pt`, `em`, `fr`, etc.) e funcionam tanto no texto quanto no modo matemático (com `#`):

#exemplo[
  #raw(block: true, lang: "typst", "Palavra#h(2cm)distante

#v(1cm)

Parágrafo com 1cm de distância vertical acima.

// No modo matemático:
$ f(x) #h(1cm) g(x) #h(1cm) h(x) $")
]

Palavra#h(2cm)distante

#v(1cm)

Parágrafo com 1cm de distância vertical acima.

No modo matemático:

$ f(x) #h(1cm) g(x) #h(1cm) h(x) $

No modo matemático, existe também `quad` --- um espaço padrão usado para separar expressões dentro de uma equação. Compare sem e com `quad`:

#exemplo[
  #raw(block: true, lang: "typst", "// Sem quad: tudo colado
$ f(x) g(x) h(x) $

// Com quad: separação clara
$ f(x) quad g(x) quad h(x) $")
]

Sem `quad`: $ f(x) g(x) h(x) $

Com `quad`: $ f(x) quad g(x) quad h(x) $

== Letras gregas

#matypst-nota[O matypst fornece nomes em português para as letras gregas que diferem do inglês.]

As letras gregas podem ser escritas em português ou inglês no modo matemático. A tabela abaixo mostra todas as minúsculas, com o nome em português quando disponível:

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Português*], [*Letra*], [*Português*], [*Letra*], [*Português*], [*Letra*],
    table.hline(stroke: 0.5pt),
    [`alfa`], [$alfa$], [`beta`], [$beta$], [`gama`], [$gama$],
    [`delta`], [$delta$], [`epsilon`], [$epsilon$], [`zeta`], [$zeta$],
    [`eta`], [$eta$], [`teta`], [$teta$], [`iota`], [$iota$],
    [`capa`], [$capa$], [`lambda`], [$lambda$], [`mi`], [$mi$],
    [`ni`], [$ni$], [`csi`], [$csi$], [`pi`], [$pi$],
    [`ro`], [$ro$], [`sigma`], [$sigma$], [`tau`], [$tau$],
    [`ipsilon`], [$ipsilon$], [`fi`], [$fi$], [`qui`], [$qui$],
    [`psi`], [$psi$], [`omega`], [$omega$], [], [],
    table.hline(stroke: 1pt),
  ),
  caption: [Letras gregas minúsculas],
  kind: table,
)

Quatro letras possuem variantes cursivas acessíveis com `.alt`:

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Letra*], [*Código*], [*Letra*], [*Código*], [*Letra*], [*Código*], [*Letra*],
    table.hline(stroke: 0.5pt),
    [`teta.alt`], [$teta.alt$], [`capa.alt`], [$capa.alt$], [`ro.alt`], [$ro.alt$], [`fi.alt`], [$fi.alt$],
    table.hline(stroke: 1pt),
  ),
  caption: [Variantes cursivas],
  kind: table,
)

Para maiúsculas, use a primeira letra em maiúsculo. O matypst fornece os nomes em português para as que diferem:

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Português*], [*Letra*], [*Português*], [*Letra*], [*Português*], [*Letra*],
    table.hline(stroke: 0.5pt),
    [`Gama`], [$Gama$], [`Delta`], [$Delta$], [`Teta`], [$Teta$],
    [`Lambda`], [$Lambda$], [`Csi`], [$Csi$], [`Pi`], [$Pi$],
    [`Sigma`], [$Sigma$], [`Ipsilon`], [$Ipsilon$], [`Fi`], [$Fi$],
    [`Psi`], [$Psi$], [`Omega`], [$Omega$], [], [],
    table.hline(stroke: 1pt),
  ),
  caption: [Letras gregas maiúsculas],
  kind: table,
)

== Nomes de funções

#matypst-nota[As funções desta seção são fornecidas pelo matypst.]

Funções matemáticas são escritas sem formatação especial. O matypst fornece o operador `sen` (seno em português), que substitui o `sin` padrão do Typst:

#exemplo[
  #raw(block: true, lang: "typst", "$sen(x)$, $cos(x)$, $tan(x)$
$log(x)$, $ln(x)$, $exp(x)$
$lim_(x -> 0) f(x)$
$max(a, b)$, $min(a, b)$")

  Resultado: $sen(x)$, $cos(x)$, $tan(x)$, $log(x)$, $ln(x)$, $exp(x)$
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

== Frações, binômios e tamanhos

#matypst-nota[As funções `fracao`, `binomio`, `exibicao`, `emLinha`, `subscrito` e `subSubscrito` são fornecidas pelo matypst.]

Frações são criadas com `fracao(numerador, denominador)` ou com a notação `/`. O matypst fornece um wrapper que aceita o parâmetro `estilo` em português:

#exemplo[
  #raw(block: true, lang: "typst", "// Inline — a fração fica compacta automaticamente
$fracao(a, b)$, $fracao(x+1, x-1)$, $a/b$

// Destaque — a fração fica maior
$ fracao(a+b, c+d) $")
]

Inline: $fracao(a, b)$, $fracao(x+1, x-1)$, $a/b$. Em destaque:

$ fracao(a+b, c+d) $

O parâmetro `estilo` controla o layout da fração:

#figure(
  table(
    columns: (auto, 1fr, auto),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Estilo*], [*Descrição*], [*Resultado*],
    table.hline(stroke: 0.5pt),
    [`"vertical"`], [Numerador sobre denominador com barra (padrão)], [$fracao(a+b, c+d)$],
    [`"inclinada"`], [Separados por barra inclinada], [$fracao(a+b, c+d, estilo: "inclinada")$],
    [`"horizontal"`], [Em linha, mantendo parênteses], [$fracao(a+b, c+d, estilo: "horizontal")$],
    table.hline(stroke: 1pt),
  ),
  caption: [Estilos de fração],
  kind: table,
)

#exemplo[
  #raw(block: true, lang: "typst", "// Vertical (padrão)
$fracao(a+b, c+d)$

// Inclinada — útil para frações simples no meio do texto
$fracao(a+b, c+d, estilo: \"inclinada\")$

// Horizontal — mantém parênteses explícitos
$fracao(a+b, c+d, estilo: \"horizontal\")$")
]

$fracao(a+b, c+d)$, #h(1em) $fracao(a+b, c+d, estilo: "inclinada")$, #h(1em) $fracao(a+b, c+d, estilo: "horizontal")$

=== Binômios

Coeficientes binomiais usam `binomio(n, k)`:

#exemplo[
  #raw(block: true, lang: "typst", "$binomio(n, k)$

$ binomio(n, k) = fracao(n!, k!(n-k)!) $

// Multinomial (vários índices inferiores)
$binomio(n, k_1, k_2, k_3)$")
]

$binomio(n, k)$, $binomio(n, k_1, k_2, k_3)$

=== Tamanhos: destaque vs. inline

No Typst, equações entre `$ ... $` (com espaço) ficam em _destaque_ (centralizadas, maiores) e equações `$...$` (sem espaço) ficam _inline_ (no meio do texto, menores). Compare a mesma fração e somatório nos dois modos:

#exemplo[
  #raw(block: true, lang: "typst", "// Inline — compacto, no meio do texto
Sabemos que $sum_(i=1)^n i = fracao(n(n+1), 2)$ para todo $n$.

// Destaque — centralizado, tamanho completo
$ sum_(i=1)^n i = fracao(n(n+1), 2) $")
]

Inline: sabemos que $sum_(i=1)^n i = fracao(n(n+1), 2)$ para todo $n$. Destaque:

$ sum_(i=1)^n i = fracao(n(n+1), 2) $

Às vezes é preciso forçar o tamanho de destaque dentro de uma equação inline (equivalente ao `\displaystyle` do LaTeX) ou vice-versa. O matypst oferece funções para isso:

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*matypst*], [*LaTeX*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`exibicao()`], [`\displaystyle`], [Força tamanho de destaque (o maior)],
    [`emLinha()`], [`\textstyle`], [Força tamanho inline],
    [`subscrito()`], [`\scriptstyle`], [Tamanho de sub/sobrescrito],
    [`subSubscrito()`], [`\scriptscriptstyle`], [Tamanho de sub/sobrescrito de 2º nível (o menor)],
    table.hline(stroke: 1pt),
  ),
  caption: [Funções de tamanho matemático],
  kind: table,
)

Todas aceitam o parâmetro `compacto:` (`false` por padrão em `exibicao`/`emLinha`, `true` em `subscrito`/`subSubscrito`), que restringe a altura dos expoentes.

#exemplo[
  #raw(block: true, lang: "typst", "// Sem exibicao(): somatório inline fica compacto
Temos $sum_(i=1)^n x_i$ como resultado.

// Com exibicao(): somatório inline fica grande como destaque
Temos $exibicao(sum_(i=1)^n x_i)$ como resultado.

// Inverso: forçar inline dentro de destaque
$ emLinha(sum_(i=1)^n x_i) quad \"versus\" quad sum_(i=1)^n x_i $")
]

Sem `exibicao`: temos $sum_(i=1)^n x_i$ como resultado. Com `exibicao`: temos $exibicao(sum_(i=1)^n x_i)$ como resultado.

== Raízes

#matypst-nota[A função `raiz` é fornecida pelo matypst.]

O matypst fornece `raiz()`: com um argumento é raiz quadrada, com dois é raiz n-ésima.

#exemplo[
  #raw(block: true, lang: "typst", "// Raiz quadrada (um argumento)
$raiz(2)$, $raiz(x+1)$

// Raiz n-ésima (dois argumentos: índice, radicando)
$raiz(3, 8)$, $raiz(n, x)$")

  Resultado: $raiz(2)$, $raiz(x+1)$, $raiz(3, 8)$, $raiz(n, x)$
]

== Somatórios, produtórios, uniões, interseções

#matypst-nota[Os símbolos `somatorio`, `produtorio`, `uniao` e `inter` são fornecidos pelo matypst.]

#exemplo[
  #raw(block: true, lang: "typst", "// Somatório
$somatorio_(i=1)^n a_i$

// Produtório
$produtorio_(i=1)^n a_i$

// União
$uniao.maior_(i=1)^n A_i$

// Interseção
$inter.maior_(i=1)^n A_i$")
]

Resultado:

$ somatorio_(i=1)^n a_i quad quad produtorio_(i=1)^n a_i quad quad uniao.maior_(i=1)^n A_i quad quad inter.maior_(i=1)^n A_i $

== Limites

#exemplo[
  #raw(block: true, lang: "typst", "$lim_(x -> 0) fracao(sen x, x) = 1$

$lim_(n -> infinito) (1 + 1/n)^n = e$

$lim_(x -> 0^+) ln x = -infinito$")
]

$ lim_(x -> 0) fracao(sen x, x) = 1 $

$ lim_(n -> infinito) (1 + 1/n)^n = e $

$ lim_(x -> 0^+) ln x = -infinito $

== Derivadas

#matypst-nota[As funções `leibniz` e `parcial` são fornecidas pelo matypst.
Em `leibniz`, a ordem é o terceiro argumento: `leibniz(y, x, 2)`.
Em `parcial`, a ordem precisa ser nomeada (`ordem: 2`) para não ser confundida com uma segunda variável — `parcial(f, x, y)` é a derivada mista $partial^2 f \/ partial x partial y$.]

#exemplo[
  #raw(block: true, lang: "typst", "// Derivada com notação de Leibniz
$leibniz(y, x)$, $leibniz(y, x, 2)$

// Derivadas parciais
$parcial(f, x)$, $parcial(f, x, ordem: 2)$

// Derivada parcial mista
$parcial(f, x, y)$

// Notação de Newton (ponto)
$dot(x)$, $dot.double(x)$

// Notação de Lagrange (linha)
$f'(x)$, $f''(x)$")
]

$ leibniz(y, x) quad leibniz(y, x, 2) quad parcial(f, x) quad parcial(f, x, ordem: 2) quad parcial(f, x, y) $

$ dot(x) comma dot.double(x) comma f'(x) comma f''(x) $

== Integrais

#matypst-nota[O símbolo `integral` com variantes em português é fornecido pelo matypst.]

#exemplo[
  #raw(block: true, lang: "typst", "// Integral simples
$integral_a^b f(x) dif x$

// Integral dupla
$integral.dupla_D f(x,y) dif x dif y$

// Integral tripla
$integral.tripla_V f dif V$

// Integral de contorno
$integral.contorno_C bold(F) dot dif bold(r)$")
]

$ integral_a^b f(x) dif x quad quad integral.dupla_D f(x,y) dif x dif y quad quad integral.tripla_V f dif V quad quad integral.contorno_C bold(F) dot dif bold(r) $

== Parênteses, colchetes e chaves (delimitadores)

#matypst-nota[A função `delimitar` é fornecida pelo matypst como wrapper de `lr` (left-right).]

Delimitadores podem ser redimensionados automaticamente:

#exemplo[
  #raw(block: true, lang: "typst", "// Com delimitar: delimitadores ajustam ao conteúdo
$delimitar(chevron.l frac(1+frac(a,b), c) chevron.r)$
$delimitar(( frac(1+frac(a,b), c) ))$

// Sem delimitar: delimitadores ficam pequenos
$chevron.l frac(1+frac(a,b), c) chevron.r$
$( frac(1+frac(a,b), c) )$")
]

Com `delimitar`: $delimitar(chevron.l frac(1+frac(a,b), c) chevron.r)$ $delimitar((frac(1+frac(a,b), c)))$ #h(1em) Sem: $chevron.l frac(1+frac(a,b), c) chevron.r$ $(frac(1+frac(a,b), c))$

#exemplo[
  #raw(block: true, lang: "typst", "// Tipos de delimitadores
$delimitar(( frac(a, b) ))$  // parênteses
$delimitar([ frac(a, b) ])$  // colchetes
$delimitar(| x |)$           // valor absoluto
$delimitar(|| x ||)$         // norma
$delimitar(chevron.l x chevron.r)$  // produto interno
$delimitar({ x : x > 0 })$  // conjunto")
]

$ delimitar((frac(a, b))) quad delimitar([frac(a, b)]) quad delimitar(|x|) quad delimitar(||x||) quad delimitar(chevron.l x chevron.r) quad delimitar({x : x > 0}) $

== Vetores e conjugados

#matypst-nota[As funções `vetor`, `vetorNegrito`, `conjugado` e `segmento` são fornecidas pelo matypst.]

#exemplo[
  #raw(block: true, lang: "typst", "// Vetor com seta
$vetor(v)$, $vetor(A B)$

// Vetor em negrito
$vetorNegrito(v)$, $vetorNegrito(F)$

// Conjugado
$conjugado(z)$

// Segmento (barra superior)
$segmento(A B)$

// Chapéu
$hat(x)$, $hat(i)$, $hat(j)$, $hat(k)$

// Til
$tilde(x)$")
]

$vetor(v)$, $vetor(A B)$, $vetorNegrito(v)$, $vetorNegrito(F)$, $conjugado(z)$, $segmento(A B)$, $hat(x)$, $tilde(x)$

== Matrizes e determinantes

#matypst-nota[As funções `matriz`, `colchete`, `barra` e `norma` são fornecidas pelo matypst.]

O matypst fornece quatro funções para matrizes, cada uma com seu delimitador:

- `matriz()` --- parênteses $(med)$
- `colchete()` --- colchetes $[med]$
- `barra()` --- barras $|med|$ (determinante)
- `norma()` --- barras duplas $‖med‖$

#exemplo[
  #raw(block: true, lang: "typst", "// Parênteses
$matriz(a, b; c, d)$

// Colchetes
$colchete(1, 2, 3; 4, 5, 6)$

// Barras (determinante)
$barra(a, b; c, d)$

// Barras duplas (norma)
$norma(a, b; c, d)$")
]

$ matriz(a, b; c, d) quad colchete(1, 2, 3; 4, 5, 6) quad barra(a, b; c, d) quad norma(a, b; c, d) $

== Equações numeradas

Equações em destaque são numeradas automaticamente ao ativar `numbering` em `math.equation`. Cada equação pode receber um rótulo (`<nome>`) para ser referenciada no texto com `@nome`:

#exemplo[
  #raw(block: true, lang: "typst", "#set math.equation(numbering: \"(1)\")

$ E = m c^2 $ <eq:einstein>

$ integral_0^infinito e^(-x^2) dif x = fracao(raiz(pi), 2) $ <eq:gauss>

Pela equação @eq:einstein e @eq:gauss...")
]

#set math.equation(numbering: "(1)")

$ E = m c^2 $ <eq:einstein>

$ integral_0^infinito e^(-x^2) dif x = fracao(raiz(pi), 2) $ <eq:gauss>

Pela equação @eq:einstein e @eq:gauss, temos resultados fundamentais da física e da análise.

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

#matypst-nota[Os ambientes desta seção são fornecidos pelo matypst. Todos estão prontos para uso --- basta importar o matypst e usar diretamente.]

O matypst fornece 14 ambientes matemáticos pré-configurados, divididos em quatro categorias:

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (left, left, left, left),
    table.header[*Ambiente*][*Categoria*][*Cor*][*Corpo*],
    [`teorema`], [Enunciado], [azul], [itálico],
    [`lema`], [Enunciado], [azul escuro], [itálico],
    [`corolario`], [Enunciado], [azul claro], [itálico],
    [`proposicao`], [Enunciado], [eastern], [itálico],
    [`axioma`], [Enunciado], [navy], [itálico],
    [`conjectura`], [Enunciado], [roxo], [itálico],
    [`afirmacao`], [Enunciado], [teal], [itálico],
    [`definicao`], [Definição], [verde], [normal],
    [`notacao`], [Definição], [olive], [normal],
    [`propriedade`], [Definição], [verde escuro], [normal],
    [`exemplo`], [Exemplo], [cinza], [normal],
    [`problema`], [Exemplo], [laranja], [normal],
    [`observacao`], [Informal], [maroon], [normal (sem numeração)],
    [`demonstracao`], [Informal], [---], [normal (com QED)],
  ),
  caption: [Ambientes matemáticos disponíveis no matypst],
  kind: table,
)

=== Uso básico

Cada ambiente aceita conteúdo direto e um título opcional:

#exemplo[
  #raw(block: true, lang: "typst", "#definicao[
  Um *grupo* é um conjunto $G$ munido de uma operação
  $dot : G times G -> G$ satisfazendo associatividade,
  existência de elemento neutro e existência de inversos.
]

#teorema(titulo: [de Lagrange])[
  Se $H$ é um subgrupo de um grupo finito $G$, então
  a ordem de $H$ divide a ordem de $G$.
]

#demonstracao[
  As classes laterais à esquerda de $H$ particionam $G$
  em subconjuntos de mesmo tamanho $|H|$.
]

#observacao[Nem todo subconjunto de um grupo é subgrupo.]")
]

#definicao[
  Um *grupo* é um conjunto $G$ munido de uma operação $dot : G times G -> G$ satisfazendo associatividade, existência de elemento neutro e existência de inversos.
]

#teorema(titulo: [de Lagrange])[
  Se $H$ é um subgrupo de um grupo finito $G$, então a ordem de $H$ divide a ordem de $G$.
]

#demonstracao[
  As classes laterais à esquerda de $H$ particionam $G$ em subconjuntos de mesmo tamanho $|H|$, logo $|G| = [G : H] dot |H|$.
]

#observacao[Nem todo subconjunto de um grupo é subgrupo.]

=== Numeração

A numeração dos ambientes é controlada por `configurar-numeracao`, que recebe três parâmetros:

- *modo*: `"por-tipo"` (padrão) ou `"unificado"`
- *por-secao*: `false` (padrão) ou `true`
- *nivel*: nível do heading que dispara reinício dos contadores (padrão: `1`)

O parâmetro `nivel` indica qual nível de heading delimita as "seções" para fins de numeração. O padrão `nivel: 1` é adequado para monografias e teses, onde `= Capítulo` é nível 1. Em artigos, onde `= Título do artigo` é nível 1 e as seções reais são `== Seção`, use `nivel: 2` para que os contadores reiniciem a cada `==` e a numeração exiba o formato "seção.subseção.número" (ex.: 1.2.1).

Coloque no início do documento, como show rule:

#exemplo[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\")  // padrão")
]

Isso gera quatro combinações possíveis, detalhadas a seguir.

==== Por tipo, global

Cada tipo de ambiente tem seu próprio contador, numerado do início ao fim do documento. Este é o comportamento padrão:

#exemplo[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\")

#definicao[...]   // Definição 1
#teorema[...]    // Teorema 1
#lema[...]       // Lema 1
#teorema[...]    // Teorema 2
#lema[...]       // Lema 2
#definicao[...]  // Definição 2")
]

==== Por tipo, por seção

Cada tipo mantém seu próprio contador, mas a numeração inclui o número da seção (ou capítulo) e reinicia automaticamente:

#exemplo[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\", por-secao: true)

= Capítulo 1
#definicao[...]  // Definição 1.1
#teorema[...]   // Teorema 1.1
#teorema[...]   // Teorema 1.2

= Capítulo 2
#teorema[...]   // Teorema 2.1 (reinicia)
#definicao[...]  // Definição 2.1 (reinicia)")
]

==== Unificado, global

Todos os ambientes compartilham um único contador sequencial. Isso facilita localizar resultados no texto:

#exemplo[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"unificado\")

#definicao[...]   // Definição 1
#teorema[...]    // Teorema 2
#lema[...]       // Lema 3
#teorema[...]    // Teorema 4")
]

==== Unificado, por seção

Contador único com número da seção, reiniciando a cada capítulo:

#exemplo[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"unificado\", por-secao: true)

= Capítulo 1
#definicao[...]  // Definição 1.1
#teorema[...]   // Teorema 1.2
#lema[...]      // Lema 1.3

= Capítulo 2
#teorema[...]   // Teorema 2.1 (reinicia)")
]

==== Usando `nivel` em artigos

Em artigos acadêmicos, o heading nível 1 (`=`) costuma ser o título do artigo, e as seções reais usam nível 2 (`==`). Use `nivel: 2` para que a numeração por seção reinicie a cada `==`:

#exemplo[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\", por-secao: true, nivel: 2)

= Título do Artigo
== Introdução
#definicao[...]  // Definição 1.1.1
#teorema[...]   // Teorema 1.1.1

== Resultados
#teorema[...]   // Teorema 1.2.1 (reinicia na subseção)
#lema[...]      // Lema 1.2.1")
]

A numeração inclui todos os níveis de heading até o configurado. Com `nivel: 1` (padrão), o prefixo é "capítulo.número" (ex.: 2.1). Com `nivel: 2`, é "capítulo.seção.número" (ex.: 1.2.1).

A função `num-equacao` também aceita o parâmetro `nivel` com a mesma semântica:

#exemplo[
  #raw(block: true, lang: "typst", "#show: num-equacao(por-secao: true, nivel: 2)")
]

=== Estilos visuais

O matypst suporta três estilos globais, controlados por `configurar-ambientes`:

#exemplo[
  #raw(block: true, lang: "typst", "#configurar-ambientes(\"colorido\")  // padrão: cada ambiente com sua cor
#configurar-ambientes(\"cinza\")      // todos em tons de cinza
#configurar-ambientes(\"sem-caixa\")  // apenas rótulo em negrito, sem fundo/borda")
]

==== Estilo colorido (padrão)

#teorema(titulo: [colorido])[Se $H$ é um subgrupo de $G$, então $|H|$ divide $|G|$.]

#definicao[Um *anel* é um conjunto munido de duas operações satisfazendo certas propriedades.]

==== Estilo cinza

#configurar-ambientes("cinza")

#teorema(titulo: [em cinza])[Se $H$ é um subgrupo de $G$, então $|H|$ divide $|G|$.]

#definicao[Um *anel* é um conjunto munido de duas operações satisfazendo certas propriedades.]

==== Estilo sem caixa

#configurar-ambientes("sem-caixa")

#teorema(titulo: [sem caixa])[Se $H$ é um subgrupo de $G$, então $|H|$ divide $|G|$.]

#definicao[Um *anel* é um conjunto munido de duas operações satisfazendo certas propriedades.]

#configurar-ambientes("colorido")

=== Ambientes personalizados

Para criar ambientes com configuração própria, use `ambiente-matematico`:

#exemplo[
  #raw(block: true, lang: "typst", "#let hipotese = ambiente-matematico(
  cor: purple,
  espessura: 5cm,
  prefixo: \"Hipótese\",
  contador: \"hipotese\",
)

#hipotese[Toda função contínua em $[a,b]$ é integrável.]")
]

#let hipotese = ambiente-matematico(
  cor: purple,
  espessura: 5cm,
  prefixo: "Hipótese",
  contador: "hipotese",
)

#hipotese[Toda função contínua em $[a,b]$ é integrável.]


// ============================================================================
// CAPÍTULO 6: DIAGRAMAS E GRÁFICOS
// ============================================================================

= Diagramas e Gráficos

Typst oferece pacotes externos para criação de diagramas, gráficos e visualizações. Os principais são:

- *fletcher*: Diagramas de fluxo e comutativos
- *cetz* e *cetz-plot*: Gráficos vetoriais e de funções (similar ao TikZ)

== Diagramas comutativos

#import "@preview/fletcher:0.5.8": diagram, node, edge, shapes

Diagramas comutativos são essenciais em álgebra e teoria das categorias. Use o pacote `fletcher`:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/fletcher:0.5.8\": diagram, node, edge

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

#align(center,
  diagram(
    node((0, 0), $A$),
    node((1, 0), $B$),
    node((0, 1), $C$),
    node((1, 1), $D$),
    edge((0, 0), (1, 0), $f$, "->"),
    edge((0, 0), (0, 1), $g$, "->"),
    edge((1, 0), (1, 1), $h$, "->"),
    edge((0, 1), (1, 1), $k$, "->"),
  )
)

== Fluxogramas

O `fletcher` também serve para fluxogramas:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/fletcher:0.5.8\": diagram, node, edge, shapes

#diagram(
  node((0, 0), [Início], shape: shapes.ellipse),
  edge(\"->\"),
  node((0, 1), [Processar]),
  edge(\"->\"),
  node((0, 2), [Decisão?], shape: shapes.diamond),
  edge(\"r\", \"->\", [Sim]),
  node((1, 2), [Ação A]),
  edge((0, 2), (0, 3), \"->\", [Não]),
  node((0, 3), [Ação B]),
  edge((1, 2), (0, 4), \"->\"),
  edge((0, 3), (0, 4), \"->\"),
  node((0, 4), [Fim], shape: shapes.ellipse),
)")
]

#align(center,
  diagram(
    node((0, 0), [Início], shape: shapes.ellipse),
    edge("->"),
    node((0, 1), [Processar]),
    edge("->"),
    node((0, 2), [Decisão?], shape: shapes.diamond),
    edge("r", "->", [Sim]),
    node((1, 2), [Ação A]),
    edge((0, 2), (0, 3), "->", [Não]),
    node((0, 3), [Ação B]),
    edge((1, 2), (0, 4), "->"),
    edge((0, 3), (0, 4), "->"),
    node((0, 4), [Fim], shape: shapes.ellipse),
  )
)

== Gráficos de funções

Para gráficos matemáticos, há duas abordagens principais: programar o gráfico diretamente em Typst com os pacotes `cetz` e `cetz-plot`, ou criá-lo em um software externo como o GeoGebra e importar a imagem.

=== Gráficos com cetz-plot

Os pacotes `cetz` e `cetz-plot` permitem criar gráficos diretamente no documento:

#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/cetz-plot:0.1.1": plot

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/cetz:0.3.4\": canvas, draw
#import \"@preview/cetz-plot:0.1.1\": plot

#canvas({
  import draw: *

  plot.plot(
    size: (8, 5),
    x-label: $x$,
    y-label: rotate(90deg, $y$),
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

#let y-vertical = rotate(90deg, $y$)
#align(center,
  canvas({
    import draw: *

    plot.plot(
      size: (8, 5),
      x-label: $x$,
      y-label: y-vertical,
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
  })
)

=== Gráficos com GeoGebra

Para gráficos mais elaborados ou interativos, o GeoGebra (#link("https://www.geogebra.org")[geogebra.org]) é uma excelente alternativa. Crie o gráfico no GeoGebra e exporte como SVG (_Arquivo → Exportar → Gráficos como SVG_). O formato SVG é o mais indicado para Typst porque é vetorial --- a imagem mantém qualidade perfeita em qualquer escala, diferente de formatos rasterizados como PNG.

#exemplo[
  #raw(block: true, lang: "typst", "// Gráfico criado no GeoGebra e exportado como SVG
#imagem(\"grafico-geogebra.svg\", largura: 80%)")

  Gráficos complexos com múltiplas curvas, regiões hachuradas, pontos notáveis e anotações são muito mais fáceis de construir visualmente no GeoGebra do que programar com `cetz-plot`. A exportação em SVG garante que o resultado no PDF terá a mesma nitidez de um gráfico programado diretamente.
]

#pagebreak()

// ============================================================================
// CAPÍTULO 7: ELEMENTOS PÓS-TEXTUAIS
// ============================================================================

= Elementos Pós-textuais

Os elementos pós-textuais complementam o trabalho e incluem referências, apêndices, anexos, glossário e índice.

== Referências bibliográficas (NBR 6023)

As referências são obrigatórias e devem seguir a NBR 6023:2018. O ABNTypst suporta referências manuais e automáticas via arquivo `.bib`.

=== Referências manuais <sec:ref-manual>

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

=== Referências automáticas <sec:ref-auto>

O ABNTypst pode usar arquivos `.bib` para gerar referências automaticamente, seguindo o fluxo: configurar citações → citar no texto → gerar bibliografia.

#exemplo[
  #raw(block: true, lang: "typst", "// 1. No preâmbulo: habilitar citações ABNT
#show: configurar-citacoes-abnt

// 2. No texto: citar com @chave
O resultado foi positivo @silva2023.

// 3. No final: gerar a lista de referências
#referencias(\"referencias.bib\")")

  Os três passos são obrigatórios. Sem `configurar-citacoes-abnt`, as citações usam o estilo padrão do Typst (não ABNT). Sem `referencias()`, o Typst não sabe onde buscar as entradas.
]

Os nomes em português `configurar-citacoes-abnt` e `referencias()` são equivalentes a `abnt-cite-setup` e `abnt-bibliography()`, respectivamente --- ambas as formas funcionam.

Para listar *todas* as entradas do `.bib` (inclusive as não citadas no texto), use o parâmetro `completa`:

#raw(block: true, lang: "typst", "#referencias(\"referencias.bib\", completa: true)")

==== Tipos de entrada `.bib` suportados

O ABNTypst usa o estilo CSL `abnt.csl` para formatar as referências, baseado no trabalho original de Jucá da Costa e Antenor Aguiar C. A. Matos (#link("https://github.com/virgilinojuca/csl-abnt")[csl-abnt], domínio público). Os principais tipos de entrada BibTeX/BibLaTeX suportados são:

#figure(
  table(
    columns: (auto, 1fr),
    align: (left, left),
    table.header(
      [*Tipo*], [*Uso*],
    ),
    [`@book`], [Livros e monografias],
    [`@article`], [Artigos de periódicos e revistas],
    [`@thesis`], [Teses e dissertações (BibLaTeX)],
    [`@phdthesis`], [Tese de doutorado (BibTeX)],
    [`@mastersthesis`], [Dissertação de mestrado (BibTeX)],
    [`@inproceedings`], [Trabalhos publicados em anais de eventos],
    [`@incollection`], [Capítulos de livros com organizador],
    [`@online`], [Páginas web e recursos da internet],
    [`@techreport`], [Relatórios técnicos e institucionais],
    [`@legislation`], [Legislação (suporte limitado pelo CSL)],
  ),
  caption: [Tipos de entrada `.bib` suportados pelo CSL ABNT],
)

==== Exemplos de entradas `.bib`

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
}

@online{ibge2024,
  author = {{Instituto Brasileiro de Geografia e Estatística}},
  title = {Censo Demográfico 2022},
  url = {https://www.ibge.gov.br/censo2022},
  year = {2024},
  urldate = {2024-03-15},
}

@thesis{oliveira2021,
  author = {Oliveira, Pedro Henrique de},
  title = {Aprendizado de máquina aplicado à saúde pública},
  type = {Dissertação (Mestrado em Ciência da Computação)},
  institution = {Universidade de Brasília},
  address = {Brasília},
  year = {2021},
}

@inproceedings{lima2023,
  author = {Lima, Fernanda and Souza, Ricardo},
  title = {Detecção de anomalias em séries temporais},
  booktitle = {Anais do Simpósio Brasileiro de Computação},
  address = {Porto Alegre},
  year = {2023},
  pages = {112-125},
}")

==== Limitações do CSL e soluções manuais

O formato CSL (Citation Style Language) é um padrão internacional para formatação de referências. Ele funciona muito bem para a maioria dos casos, mas possui três limitações que afetam a conformidade com a NBR 6023. Essas limitações são da _especificação CSL em si_ --- não é possível corrigi-las no arquivo `.csl`, nem resolver o problema dentro do `.bib` (que não suporta formatação rica como negrito ou itálico).

Também não é possível misturar referências automáticas (via `.bib`) com manuais na mesma lista --- o `bibliography()` do Typst gera sua própria lista, e entradas manuais não se mesclam alfabeticamente com ela.

===== 1. Subtítulos em negrito

A NBR 6023 exige que apenas o _título_ fique em negrito, e o subtítulo (após os dois-pontos) fique em texto normal. O CSL não possui uma variável separada para subtítulo --- ele trata o campo `title` como um bloco único e aplica negrito a tudo.

#exemplo[
  #raw(block: true, lang: "typst", "// ❌ O CSL gera (incorretamente):
// SILVA, J. C. *Introdução à programação: conceitos básicos*. ...
//
// ✅ A ABNT exige:
// SILVA, J. C. *Introdução à programação*: conceitos básicos. ...
//
// Solução: referência manual
SILVA, João Carlos da. *Introdução à programação*: conceitos
básicos. 2. ed. São Paulo: Editora Atlas, 2023.")
]

Resultado correto (manual):

#block(inset: (left: 1.25cm, rest: 0pt))[
  #set par(hanging-indent: 1.25cm, first-line-indent: 0pt)
  SILVA, João Carlos da. *Introdução à programação*: conceitos básicos. 2. ed. São Paulo: Editora Atlas, 2023.
]

===== 2. Obras sem autor (entrada pelo título)

Quando uma obra não tem autor pessoal, a NBR 6023 exige que a primeira palavra do título apareça em MAIÚSCULAS. O CSL nem sempre aplica essa regra. Uma solução parcial é escrever a primeira palavra em maiúsculas diretamente no campo `title` do `.bib` (`title = {DIRETRIZES curriculares...}`), mas isso pode afetar citações no texto.

#exemplo[
  #raw(block: true, lang: "typst", "// ❌ O CSL pode gerar:
// Diretrizes curriculares nacionais para o ensino médio. ...
//
// ✅ A ABNT exige:
// DIRETRIZES curriculares nacionais para o ensino médio. ...
//
// Solução: referência manual
DIRETRIZES curriculares nacionais para o ensino médio.
Brasília: MEC, 2018. 56 p.")
]

Resultado correto (manual):

#block(inset: (left: 1.25cm, rest: 0pt))[
  #set par(hanging-indent: 1.25cm, first-line-indent: 0pt)
  DIRETRIZES curriculares nacionais para o ensino médio. Brasília: MEC, 2018. 56 p.
]

===== 3. Legislação brasileira

A NBR 6023 tem regras específicas para legislação (leis, decretos, portarias, etc.) que o CSL não consegue representar. A referência deve começar pela jurisdição em maiúsculas, seguida do tipo de norma, número e data --- uma estrutura que não se encaixa em nenhum tipo de entrada padrão do BibTeX.

#exemplo[
  #raw(block: true, lang: "typst", "// Legislação deve ser sempre formatada manualmente:
BRASIL. Lei nº 9.394, de 20 de dezembro de 1996. Estabelece as
diretrizes e bases da educação nacional. *Diário Oficial da
União*, Brasília, 23 dez. 1996.

BRASIL. Decreto nº 9.235, de 15 de dezembro de 2017. Dispõe
sobre o exercício das funções de regulação, supervisão e
avaliação das instituições de educação superior. *Diário Oficial
da União*, Brasília, 18 dez. 2017.")
]

Resultado correto (manual):

#block(inset: (left: 1.25cm, rest: 0pt))[
  #set par(hanging-indent: 1.25cm, first-line-indent: 0pt)
  BRASIL. Lei nº 9.394, de 20 de dezembro de 1996. Estabelece as diretrizes e bases da educação nacional. *Diário Oficial da União*, Brasília, 23 dez. 1996.

  BRASIL. Decreto nº 9.235, de 15 de dezembro de 2017. Dispõe sobre o exercício das funções de regulação, supervisão e avaliação das instituições de educação superior. *Diário Oficial da União*, Brasília, 18 dez. 2017.
]

===== Recomendação

Para a maioria dos trabalhos acadêmicos, as referências automáticas via `.bib` funcionam bem --- livros, artigos, teses e sites são formatados corretamente.

No entanto, se o seu trabalho depende fortemente de algum dos três casos acima (por exemplo, um trabalho de Direito com muitas referências legislativas, ou uma bibliografia com muitos subtítulos), recomendamos usar referências manuais para toda a bibliografia. Isso garante conformidade total com a ABNT e evita inconsistências entre entradas automáticas e manuais na mesma lista. Veja o modelo na @sec:ref-manual.

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
  titulo: \"Título do Trabalho\",
  subtitulo: \"Subtítulo (se houver)\",
  autor: \"Nome do Autor\",
  instituicao: \"Universidade Federal\",
  faculdade: \"Faculdade/Instituto\",
  programa: \"Programa de Pós-Graduação\",
  local: \"Cidade\",
  ano: 2026,
  natureza: \"Dissertação apresentada ao...\",
  objetivo: \"como requisito parcial para...\",
  orientador: \"Prof. Dr. Nome\",
  coorientador: \"Profa. Dra. Nome\",
  palavras-chave: (\"Palavra1\", \"Palavra2\"),
  palavras-chave-en: (\"Keyword1\", \"Keyword2\"),
  fonte: \"Times New Roman\",  // ou \"Arial\"
)")

== Artigo científico

O template `artigo` segue a NBR 6022:2018:

#raw(block: true, lang: "typst", "#show: artigo.with(
  titulo: \"Título do Artigo\",
  autores: (
    (name: \"Autor Um\",
     affiliation: \"Universidade A\",
     email: \"autor1@exemplo.com\"),
    (name: \"Autor Dois\",
     affiliation: \"Universidade B\",
     email: \"autor2@exemplo.com\"),
  ),
  resumo: [Resumo em português...],
  resumo-en: [Abstract in English...],
  palavras-chave: (\"palavra1\", \"palavra2\"),
  palavras-chave-en: (\"keyword1\", \"keyword2\"),
  colunas: 1,  // ou 2 para duas colunas
)")

== Relatório técnico

O template `relatorio` segue a NBR 10719:2015:

#raw(block: true, lang: "typst", "#show: relatorio.with(
  titulo: \"Título do Relatório\",
  numero-relatorio: \"RT-001/2026\",
  instituicao: \"Instituição\",
  autores: (
    (name: \"Nome\", qualification: \"Pesquisador\"),
  ),
  classificacao: \"Ostensivo\",  // ou \"Reservado\", \"Confidencial\"
  local: \"Cidade\",
  ano: 2026,
)")

== Projeto de pesquisa

O template `projeto-pesquisa` segue a NBR 15287:2025:

#raw(block: true, lang: "typst", "#show: projeto-pesquisa.with(
  titulo: \"Título do Projeto\",
  autor: \"Nome do Pesquisador\",
  instituicao: \"Universidade\",
  orientador: \"Prof. Dr. Orientador\",
  tipo-projeto: \"Projeto de Mestrado\",
  local: \"Cidade\",
  ano: 2026,
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
  titulo: \"Título do Livro\",
  autor: \"Nome do Autor\",
  editora: \"Editora\",
  local: \"Cidade\",
  ano: 2026,
  edicao: 1,
  isbn: \"978-85-00000-00-0\",
)")

== Pôster científico

O template `poster` segue a NBR 15437:2006:

#raw(block: true, lang: "typst", "#show: poster.with(
  titulo: \"Título do Pôster\",
  autores: ((name: \"Autor\", affiliation: \"Instituição\"),),
  texto-resumo: [Resumo em até 100 palavras...],
  palavras-chave: (\"palavra1\", \"palavra2\"),
  num-colunas: 3,
  largura: 90cm,
  altura: 120cm,
)

#poster-section(titulo: \"INTRODUÇÃO\")[...]
#poster-section(titulo: \"METODOLOGIA\")[...]
#poster-section(titulo: \"RESULTADOS\")[...]
#poster-section(titulo: \"CONCLUSÕES\")[...]
#poster-references((...))
")

== Slides para defesa

O template `slides` usa o pacote Touying para apresentações:

#raw(block: true, lang: "typst", "#import \"@preview/touying:0.4.0\": *
#import \"@preview/abntypst:0.1.0\": slides-defesa

#show: slides-defesa.with(
  titulo: \"Título do Trabalho\",
  autor: \"Nome do Autor\",
  instituicao: \"Universidade\",
  data: \"15 de março de 2026\",
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

#matypst-nota[Os nomes em português (`vezes`, `maisMenos`, `eLogico`, `uniao`, etc.) são fornecidos pelo matypst. Os símbolos nativos do Typst usam nomes em inglês (`times`, `plus.minus`, `and`, `union`, etc.).]

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`+`], [$+$], [`-`], [$-$], [`vezes`], [$times$],
    [`div`], [$div$], [`maisMenos`], [$plus.minus$], [`menosMais`], [$minus.plus$],
    [`ponto`], [$dot$], [`ast`], [$ast$], [`estrela`], [$star$],
    [`circulo`], [$circle.small$], [`marcador`], [$bullet$], [`losango`], [$diamond$],
    [`eLogico`], [$and$], [`ou`], [$or$], [`ouExclusivo`], [$xor$],
    [`uniao`], [$union$], [`inter`], [$inter$], [`sem`], [$without$],
    table.hline(stroke: 1pt),
  ),
  caption: [Operadores binários],
  kind: table,
)

== Relações

#matypst-nota[Os nomes em português (`aprox`, `pertence`, `estaContido`, `contem`, `proporcional`, etc.) são fornecidos pelo matypst. Os símbolos nativos do Typst usam nomes em inglês (`approx`, `in`, `subset`, `supset`, `prop`, etc.).]

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
    [`aprox`], [$approx$], [`equiv`], [$equiv$], [`tilde`], [$tilde$],
    [`precede`], [$prec$], [`sucede`], [$succ$], [`tilde.eq`], [$tilde.eq$],
    [`estaContido`], [$subset$], [`contem`], [$supset$], [`pertence`], [$in$],
    [`estaContido.eq`], [$subset.eq$], [`contem.eq`], [$supset.eq$], [`pertence.nao`], [$in.not$],
    [`proporcional`], [$prop$], [`paralelo`], [$parallel$], [`perpendicular`], [$perp$],
    table.hline(stroke: 1pt),
  ),
  caption: [Símbolos de relação],
  kind: table,
)

== Setas

#matypst-nota[As setas `->`, `<-` e `<->` são atalhos nativos do Typst. As demais (`implica`, `sse`, `seta.*`) são fornecidas pelo matypst. Os equivalentes nativos usam nomes em inglês (`arrow.t`, `arrow.r.long`, etc.).]

A função `seta` do matypst usa subcampos direcionais baseados nas teclas WASD: *w* = cima (↑), *a* = esquerda (←), *s* = baixo (↓), *d* = direita (→). Combinações como `seta.w.s` (↕) e `seta.a.d` (↔) indicam dupla direção.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`->`], [$->$], [`<-`], [$<-$], [`<->`], [$<->$],
    [`implica`], [$=>$], [`sse`], [$<=>$], [], [],
    [`seta.w`], [$arrow.t$], [`seta.s`], [$arrow.b$], [`seta.w.s`], [$arrow.t.b$],
    [`seta.d.longa`], [$arrow.r.long$], [`seta.a.longa`], [$arrow.l.long$], [`seta.a.d.longa`], [$arrow.l.r.long$],
    [`seta.mapa`], [$|->$], [`seta.gancho`], [$arrow.hook$], [`seta.d.cauda`], [$arrow.r.tail$],
    table.hline(stroke: 1pt),
  ),
  caption: [Setas],
  kind: table,
)

== Símbolos diversos

#matypst-nota[Os nomes em português (`infinito`, `vazio`, `portanto`, `pois`, `paraTodo`, `existe`, `nao`, `parcial`, `alef`, `reticencias`) são fornecidos pelo matypst. Os equivalentes nativos do Typst são `infinity`, `emptyset`, `therefore`, `because`, `forall`, `exists`, `not`, `partial`, `aleph`, `dots`.]

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`infinito`], [$infinito$], [`vazio`], [$emptyset$], [`portanto`], [$therefore$],
    [`pois`], [$because$], [`paraTodo`], [$forall$], [`existe`], [$exists$],
    [`nao`], [$not$], [`parcial`], [$partial$], [`nabla`], [$nabla$],
    [`ell`], [$ell$], [`planck`], [$planck$], [`Re`], [$Re$],
    [`Im`], [$Im$], [`alef`], [$aleph$], [`reticencias`], [$dots$],
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
    [Matemática destaque], [`$$...$$` ou `\[...\]`], [`$ ... $` (com espaços)],
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
    [`\begin{figure}...\end{figure}`], [`#container(...)[#imagem(...)]`],
    [`\begin{table}...\end{table}`], [`#container(tipo: "tabela")[#tabela(...)]`],
    [`\caption{...}`], [`legenda: [...]`],
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
    [#raw("\\begin{abstract}...\\end{abstract}")], [#raw("#abstract(..)[...]")],
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

- *Repositório GitHub*: #link("https://github.com/3sdras/abntypst")
- *Documentação*: #link("https://github.com/3sdras/abntypst/docs")
- *Issues (problemas)*: #link("https://github.com/3sdras/abntypst/issues")

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
