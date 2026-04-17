// Breve Introdução ao ABNTyp
// Documento tutorial para iniciantes
// Adaptado da documentação do pacote ABNTex2 de LaTeX
// Cap. 1 baseado em "Breve Introdução ao LaTeX 2ε" de Lenimar Nunes de Andrade

#import "../lib.typ": *

#show: livro.with(
  titulo: "Breve Introdução ao ABNTyp — Base Normativa Typst",
  autor: "ABNTyp",
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

// ============================================================================
// CAPA
// ============================================================================

#align(center)[
  #v(2cm)

  #text(size: 14pt)[Breve Introdução ao]

  #v(0.5cm)

  #text(size: 36pt, weight: "bold")[ABNTyp]

  #v(0.3cm)

  #text(size: 16pt, style: "italic")[Base Normativa Typst]

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
  Estas notas são uma adaptação da documentação do pacote ABNTex2 de LaTeX, para o caso do Typst, com o objetivo de servir de material didático para a disciplina "Software Livre para digitação de textos matemáticos" na UFJ. O Capítulo 1, sobre conceitos básicos do Typst, é baseado no trabalho "Uma breve introdução ao $"LaTeX" 2 epsilon$", de Lenimar Nunes de Andrade.

  O ABNTyp é um pacote gratuito, de código aberto, desenvolvido para facilitar a produção de documentos técnicos e científicos brasileiros. Pode ser utilizado diretamente no navegador através do #link("https://typst.app")[typst.app], ou instalado localmente em qualquer sistema operacional.

  O *FerrMat* é o pacote companheiro do ABNTyp, fornecendo utilitários genéricos para matemática em português, caixas decorativas, ambientes de teoremas e estilização de código. Para detalhes, consulte a _Breve Introdução ao FerrMat_.

  No Capítulo 1 são introduzidos os conceitos básicos do Typst e do ABNTyp. O Capítulo 2 trata dos elementos pré-textuais (capa, folha de rosto, resumo, etc.) e o Capítulo 3 aborda os elementos textuais (seções, citações, alíneas). A leitura desses três primeiros capítulos deve habilitar o leitor a produzir um trabalho acadêmico básico.

  O Capítulo 4 trata de figuras, quadros e tabelas. Os Capítulos 5 e 6 tratam dos elementos pós-textuais e dos diferentes tipos de documentos suportados pelo ABNTyp. Para fórmulas matemáticas, diagramas e gráficos, consulte a _Breve Introdução ao FerrMat_.

  Os apêndices contêm um guia de migração para quem vem do LaTeX (Apêndice A), recursos na Internet (Apêndice B) e uma tabela das normas ABNT implementadas (Apêndice C).

  #v(1cm)

  #align(right)[
    Jataí, janeiro de 2026

    _Equipe ABNTyp_
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

== O que é o ABNTyp

O ABNTyp (ABNTyp — Base Normativa Typst) é um pacote que implementa as normas da Associação Brasileira de Normas Técnicas (ABNT) para formatação de documentos acadêmicos em Typst.

O projeto é uma adaptação do abnTeX2, o excelente pacote LaTeX mantido por Lauro César Araujo e colaboradores, que há anos auxilia a comunidade acadêmica brasileira.

Graças ao trabalho original da equipe do abnTeX2, o ABNTyp oferece templates prontos para teses, dissertações, TCCs, artigos, relatórios e outros tipos de documentos, além de:

- Funções para criar capas, folhas de rosto, resumos e outros elementos pré-textuais
- Formatação automática de seções conforme a NBR 6024
- Sistema de citações autor-data e numérico conforme a NBR 10520
- Tabelas no padrão IBGE
- Formatação automática de referências conforme a NBR 6023

Para fórmulas matemáticas em português, caixas decorativas, ambientes de teoremas e estilização de código, consulte o pacote companheiro *FerrMat* e sua documentação (_Breve Introdução ao FerrMat_).

== Usando o Typst

=== typst.app (webapp online)

A forma mais fácil de começar com Typst é usando o webapp online em #link("https://typst.app")[typst.app]. Não é necessário instalar nada --- basta criar uma conta gratuita e começar a escrever.

O webapp oferece:
- Editor com destaque de sintaxe
- Visualização em tempo real do PDF
- Armazenamento na nuvem
- Colaboração em tempo real (similar ao Google Docs)
- Acesso a pacotes da comunidade

Para usar o ABNTyp no webapp, basta importar o pacote no início do documento:

#raw(block: true, lang: "typst", "#import \"@preview/abntyp:0.1.3\": *")

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

Para um documento acadêmico usando ABNTyp, o exemplo mínimo seria:

#exemplo[
  #raw(block: true, lang: "typst", "#import \"@preview/abntyp:0.1.3\": *

#show: dados.with(
  titulo: \"Meu Trabalho Acadêmico\",
  autor: \"Maria da Silva\",
  instituicao: \"Universidade Federal\",
  local: \"Cidade\",
  ano: 2026,
)

#show: normasABNT.with()

= Introdução

Este é o texto da introdução.

= Desenvolvimento

Este é o desenvolvimento do trabalho.

= Conclusão

Esta é a conclusão.")
]

O comando `#show: dados.with(...)` armazena os metadados do trabalho, e `#show: normasABNT.with()` aplica a formatação ABNT (margens, fontes, espaçamentos, numeração de seções). Os elementos pré-textuais (`#capa()`, `#folha-rosto()`, `#resumo()`) leem os dados automaticamente.

== Estrutura de um documento Typst

Um documento Typst pode ser dividido em três partes:

1. *Preâmbulo (opcional)*: Importações de pacotes e definições de funções
2. *Configuração (opcional)*: Comandos `#set` e `#show` que definem formatação
3. *Conteúdo*: O texto propriamente dito

#exemplo[
  #raw(block: true, lang: "typst", "// 1. Preâmbulo (importações)
#import \"@preview/abntyp:0.1.3\": *

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
    [`#underline[sublinhado]` ou `#sub[sublinhado]`], [#underline[sublinhado]],
    [`#strike[riscado]` ou `#risc[riscado]`], [#strike[riscado]],
    [`#caps("Versalete")`], [V#text(size: 0.8em)[ERSALETE]],
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
  *Atalhos do ABNTypst:* As funções `#sub`, `#risc` e `#caps` não existem no Typst puro — são exportadas pelo pacote ABNTypst como atalhos de escrita para `#underline`, `#strike` e versalete, respectivamente. Ao importar o pacote com `#import "@preview/abntyp:0.1.3": *`, essas funções ficam disponíveis automaticamente.

  *Observação sobre versalete:* A função `#smallcaps` do Typst depende de a fonte possuir suporte nativo a small caps (feature OpenType "smcp"). Fontes como Times New Roman não possuem esse recurso. O ABNTypst fornece `#caps` que simula versalete em qualquer fonte — desde que receba uma *string* (aspas):

  #raw(block: true, lang: "typst", "#caps(\"Texto em Versalete\")  // correto: string
#caps[Texto em Versalete]   // fallback: usa #smallcaps nativo")

  Internamente, `#caps` trata a primeira letra em tamanho normal e as demais em caixa alta a 0.8em. O modo `[colchetes]` não permite manipulação de caracteres — limitação do Typst — portanto cai automaticamente em `#smallcaps`.
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
  *Indentação no Brasil:* Por padrão, o Typst não indenta o primeiro parágrafo após um título — seguindo a convenção tipográfica anglo-saxônica. A ABNT exige indentar _todos_ os parágrafos, inclusive o primeiro. O ABNTyp já aplica isso automaticamente via `#show: normasABNT.with()`, incluindo a exclusão correta de blocos de código, figuras e sumário. Nenhuma configuração manual é necessária.

  Ao usar Typst puro, sem o ABNTyp, a configuração equivalente é:

  #raw(block: true, lang: "typst", "// Indenta TODOS os parágrafos (padrão brasileiro/ABNT)
#set par(first-line-indent: (amount: 1.25cm, all: true))

// Excluir blocos de código da indentação (NÃO use #show raw: — quebra o inline)
#show raw.where(block: true): set par(first-line-indent: 0pt)")
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

Os elementos pré-textuais são aqueles que antecedem o texto principal do trabalho. A NBR 14724:2024 define a seguinte ordem obrigatória:

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: none,
    inset: 7pt,
    table.hline(stroke: 1pt),
    table.header([*Elemento*], [*Função ABNTyp*], [*Obrigatório*]),
    table.hline(stroke: 0.5pt),
    [Capa],                    [`#capa()`],                    [sim],
    [Folha de rosto],          [`#folha-rosto()`],             [sim],
    [Ficha catalográfica],     [`#ficha-catalografica[...]`],  [sim],
    [Errata],                  [`#errata(...)`],               [não],
    [Folha de aprovação],      [_(PDF institucional)_],        [sim],
    [Dedicatória],             [`#dedicatoria[...]`],          [não],
    [Agradecimentos],          [`#agradecimentos[...]`],       [não],
    [Epígrafe],                [`#epigrafe(...)`],             [não],
    [Resumo em português],     [`#resumo[...]`],               [sim],
    [Resumo em língua estrang.],[`#resumo-en[...]`],           [sim],
    [Listas],                  [`#lista-ilustracoes()` etc.],  [não],
    [Sumário],                 [`#sumario()`],                 [sim],
    table.hline(stroke: 1pt),
  ),
  caption: [Ordem dos elementos pré-textuais conforme NBR 14724:2024],
  kind: table,
)

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)
  *Por que o ABNTypst não força esta ordem?* A norma define a sequência, mas não todos os elementos são usados em todos os trabalhos — errata, dedicatória, epígrafe e listas são opcionais, e algumas instituições têm exigências próprias. Forçar a ordem exigiria que o pacote conhecesse de antemão quais elementos o documento vai incluir, o que tornaria a API rígida e difícil de adaptar a casos não-padrão. O mesmo vale para o ABNTex2, referência em LaTeX: ele fornece os comandos na ordem certa, mas deixa a responsabilidade com o autor.

  O arquivo `tcc-exemplo.typ` serve de modelo completo na ordem correta; a tabela acima é o gabarito de referência.
]

== Paginação e transição entre partes (`pretextual`, `textual`, `postextual`) <sec:paginacao>

A NBR 14724:2024 define três regras para a paginação:

- *Contagem*: inicia na folha de rosto (a capa não é contada)
- *Numeração visível*: apenas a partir da primeira folha textual, em algarismos arábicos
- *Posição*: canto superior direito, a 2 cm da borda

O ABNTyp fornece três funções para marcar essas transições:

#exemplo[
  #raw(block: true, lang: "typst", "// Após a capa — inicia contagem (página 1 = folha de rosto)
#pretextual()
#folha-rosto()
#resumo[...]
#sumario()

// Início do texto — torna numeração visível, SEM reiniciar o contador
#textual()
= Introdução
...

// Início dos pós-textuais — mantém numeração contínua
#postextual()
= Referências
...")
]

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)
  *Por que `#textual()` não reinicia o contador?* A norma exige que a numeração reflita a posição real da página no documento — se o sumário termina na página 14, a introdução deve aparecer como página 15. Reiniciar para 1 estaria em desacordo com a NBR 14724:2024.
]

== Metadados e formatação (`dados()` + `normasABNT`) <sec:dados>

Todo documento ABNTyp começa com dois comandos obrigatórios, sempre nesta ordem:

#exemplo[
  #raw(block: true, lang: "typst", "// 1. Metadados: armazena título, autor, instituição etc. no state global
#show: dados.with(
  titulo: \"Análise de Algoritmos de Ordenação\",
  subtitulo: \"Um estudo comparativo\",
  autor: \"Maria da Silva\",
  instituicao: \"Universidade Federal de Jataí\",
  faculdade: \"Instituto de Ciências Exatas e Tecnológicas\",
  programa: \"Programa de Pós-Graduação em Ciência da Computação\",
  local: \"Jataí\",
  ano: 2026,
  natureza: \"Dissertação apresentada ao PPGCC da UFJ\",
  objetivo: \"como requisito parcial para obtenção do grau de Mestre\",
  area: \"Algoritmos e Estruturas de Dados\",
  orientador: \"Prof. Dr. João Santos\",
  palavras-chave: (\"Algoritmos\", \"Ordenação\", \"Complexidade\"),
  palavras-chave-en: (\"Algorithms\", \"Sorting\", \"Complexity\"),
)

// 2. Formatação ABNT: margens, fonte, espaçamento, numeração de seções
#show: normasABNT.with()

// A partir daqui, os elementos pré-textuais leem os dados automaticamente:
#capa()
#folha-rosto()
#resumo[...]")
]

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)

  *O que acontece sem `#show: normasABNT.with()`?*

  Sem esse comando, o documento compila normalmente, mas *sem nenhuma formatação ABNT*: as margens ficam no padrão do Typst (2,5 cm uniformes em vez de 3/2/2/2 cm), a fonte não é configurada (sem Times New Roman ou Arial), o espaçamento entre linhas fica simples (sem o 1,5 exigido), e os títulos de seção não recebem numeração progressiva (NBR 6024). Os dados inseridos via `dados()` aparecem nos elementos como capa e folha de rosto, mas a apresentação visual estará fora da norma.

  Em resumo: `dados()` cuida do *conteúdo*; `normasABNT` cuida da *forma*. Os dois são necessários.
]

A tabela a seguir lista todos os parâmetros aceitos por `dados()`:

#figure(
  table(
    columns: (auto, 1fr, auto),
    align: (left, left, left),
    table.header([*Parâmetro*], [*Descrição*], [*Obrigatório*]),
    [`titulo`], [Título do trabalho], [sim],
    [`subtitulo`], [Subtítulo (opcional)], [não],
    [`autor`], [Nome do autor (templates de autor único)], [sim],
    [`autores`], [Lista de autores (templates multi-autor, ex.: artigo)], [não],
    [`instituicao`], [Nome da instituição], [sim],
    [`faculdade`], [Faculdade ou unidade acadêmica], [não],
    [`programa`], [Programa de pós-graduação], [não],
    [`local`], [Cidade de depósito], [sim],
    [`ano`], [Ano de depósito], [sim],
    [`natureza`], [Natureza do trabalho (ex.: "Dissertação apresentada a…")], [não],
    [`objetivo`], [Objetivo do trabalho (ex.: "como requisito para…")], [não],
    [`area`], [Área de concentração], [não],
    [`orientador`], [Nome do orientador], [não],
    [`coorientador`], [Nome do coorientador], [não],
    [`palavras-chave`], [Palavras-chave em português (array de strings)], [não],
    [`palavras-chave-en`], [Keywords em inglês (array de strings)], [não],
  ),
  caption: [Parâmetros de `dados()`],
  kind: table,
)

Parâmetros explícitos passados diretamente a cada função (ex.: `#capa(titulo: ...)`) sobrescrevem o state *apenas para aquele elemento*, sem alterar os demais. Esse recurso é raramente necessário em documentos comuns.

== Capa

A capa é elemento obrigatório e deve conter:
- Nome da instituição (opcional)
- Nome do autor
- Título do trabalho
- Subtítulo (se houver)
- Local (cidade)
- Ano

No ABNTyp, a capa é criada com a função `#capa()`. Quando `dados()` já foi declarado (ver @sec:dados), basta chamar `#capa()` sem nenhum parâmetro:

#exemplo[
  #raw(block: true, lang: "typst", "// Se dados() já foi chamado, basta:
#capa()

// Ou com override parcial:
#capa(titulo: \"Título alternativo na capa\")")
]

Em casos excepcionais — como elementos isolados ou documentos que não usam `dados()` — é possível passar os parâmetros diretamente. Os valores explícitos têm prioridade sobre o state:

#exemplo[
  #raw(block: true, lang: "typst", "// Uso sem dados(): todos os campos explícitos.
// Em documentos normais com dados(), esses campos já vêm do state
// e não precisam ser repetidos aqui.
#capa(
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

Assim como a capa, lê automaticamente de `dados()`. Override parcial é útil em situações pontuais — por exemplo, quando a folha de rosto precisa exibir um orientador diferente do registrado nos metadados:

#exemplo[
  #raw(block: true, lang: "typst", "// Uso normal: dados() já declarou todos os campos
#folha-rosto()

// Override pontual (raro): substitui apenas os campos indicados,
// mantendo os demais de dados()
#folha-rosto(
  orientador: \"Prof. Dr. Orientador Alternativo\",
  area: \"Outra Área\",
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


O ABNTyp também oferece a função `#ficha-catalografica[...]`, que cria a moldura padrão da ficha (caixa de 12,5 × 7,5~cm, fonte 10pt, centralizada na parte inferior da página).

Diferente de funções como `#capa()` ou `#folha-rosto()`, que possuem campos nomeados (`autor:`, `titulo:`, etc.), a `#ficha-catalografica[...]` recebe conteúdo livre entre colchetes, pois a ficha segue uma notação biblioteconômica específica (código Cutter, CDU/CDD) que não se presta a campos parametrizados:


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
  #raw(block: true, lang: "typst", "// título e palavras-chave são lidos de dados() automaticamente:
#resumo[
  Este trabalho apresenta um estudo comparativo de algoritmos
  de ordenação, analisando sua complexidade temporal e espacial.
  Foram avaliados os algoritmos Quicksort, Mergesort, Heapsort
  e Timsort em diferentes cenários de entrada. Os resultados
  demonstram que o Timsort apresenta melhor desempenho em dados
  parcialmente ordenados, enquanto o Quicksort é mais eficiente
  para dados aleatórios. Conclui-se que a escolha do algoritmo
  deve considerar as características dos dados de entrada.
]

// Idem para o abstract:
#resumo-en[
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

O sumário é elemento obrigatório conforme a NBR 6027:2012, que estabelece as regras para sua apresentação. Ele lista as seções do trabalho com suas respectivas páginas. No ABNTyp, é gerado automaticamente:

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

Os elementos textuais constituem o núcleo do trabalho, onde o autor desenvolve o conteúdo propriamente dito. Incluem introdução, desenvolvimento e conclusão. Lembre-se de chamar `#textual()` antes da primeira seção (ver @sec:paginacao).

== Seções e numeração progressiva (NBR 6024)

A NBR 6024:2012 estabelece as regras para numeração progressiva das seções de um documento. O ABNTyp implementa automaticamente a formatação correta:

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

Para títulos sem numeração (Referências, Apêndices, Anexos, Glossário etc.), usa-se `#titulo-sem-num`. A função cria um heading nível 1 sem numeração, em caixa alta, que aparece no sumário. O parâmetro `nivel:` permite usá-la em outros níveis quando necessário:

#exemplo[
  #raw(block: true, lang: "typst", "#titulo-sem-num[REFERÊNCIAS]

#titulo-sem-num[APÊNDICES]

#titulo-sem-num[GLOSSÁRIO]

// Em nível 2 (subseção sem número):
#titulo-sem-num(\"Obras consultadas\", nivel: 2)")

  Resultado: os títulos aparecem em caixa alta e negrito, sem numeração, e entram no sumário. O alias `#secao` ainda funciona para retrocompatibilidade.
]

== Citações (NBR 10520) <sec:citacoes>

Toda citação é uma chamada no texto que aponta para uma entrada na lista de referências ao final do documento. Há três formas de construir essa lista:

#exemplo[
  #raw(block: true, lang: "typst", "// 1. Referências manuais (sistema autor-data) — funções ref-livro, ref-artigo etc.:
#titulo-sem-num[REFERÊNCIAS]
#ref-livro(autor: \"SILVA, João\", titulo: \"Metodologia Científica\",
  local: \"São Paulo\", editora: \"Atlas\", ano: 2023)
#ref-artigo(autor: \"SANTOS, M.\", titulo: \"Pesquisa qualitativa\",
  revista: \"Rev. Bras. Educ.\", volume: \"28\", ano: 2022)

// 2. Lista numerada manual — para o sistema numérico:
#bibliografia-numerica((
  (\"silva2023\", [SILVA, J. *Metodologia Científica*. São Paulo: Atlas, 2023.]),
  (\"santos2022\", [SANTOS, M. Pesquisa qualitativa. *Rev. Bras. Educ.*, v. 28, 2022.]),
))

// 3. Arquivo .bib (recomendado) — formatação automática:
#referencias(\"refs.bib\")")
]

A abordagem com arquivo `.bib` é a mais recomendada para trabalhos com muitas referências, pois formata tudo automaticamente e garante consistência. Ela é detalhada na @sec:ref-auto; aqui nos concentramos nas chamadas de citação dentro do texto.

A NBR 10520:2023 organiza as citações em dois eixos independentes:

- *Tipo*: *direta* (transcrição literal do texto original) × *indireta* (paráfrase das ideias do autor)
- *Sistema de chamada*: *autor-data* (SILVA, 2023) × *numérico* \[1\]

Os dois eixos são ortogonais: uma citação direta pode usar o sistema autor-data ou o numérico, e o mesmo vale para uma indireta. O sistema escolhido deve ser consistente em todo o documento.

=== Citações diretas

Uma citação direta reproduz literalmente as palavras da fonte. A apresentação varia conforme o tamanho:

==== Curta (até 3 linhas)

Inserida no próprio parágrafo, entre aspas duplas. A referência aparece ao final, entre parênteses.

#exemplo[
  #raw(block: true, lang: "typst", "// Forma posicional (autor, ano, página):
Conforme o autor, #citacao-curta(\"SILVA\", 2023,
  42)[a formatação adequada é essencial para a clareza].

// Forma nomeada (equivalente):
Conforme o autor, #citacao-curta(autor: \"SILVA\", ano: 2023,
  pagina: 42)[a formatação adequada é essencial para a clareza].

// Sem referência (apenas aspas):
A expressão #citacao-curta()[sic transit gloria mundi] é conhecida.

// Intervalos de página: usar string
#citacao-curta(\"SILVA\", 2023, pagina: \"42-43\")[texto...]")

  Resultado: Conforme o autor, \u{201C}a formatação adequada é essencial para a clareza\u{201D} (SILVA, 2023, p. 42).
]

Alias curto disponível: `#ccurta(...)`.

==== Longa (mais de 3 linhas)

Destacada do texto com recuo de 4 cm, fonte 10pt e espaçamento simples. Sem aspas.

#exemplo[
  #raw(block: true, lang: "typst", "#citacao-longa(\"SILVA\", 2023, \"42-43\")[
  A formatação adequada dos trabalhos acadêmicos é
  essencial para a clareza e a credibilidade da
  comunicação científica. As normas ABNT estabelecem
  padrões que facilitam a leitura e a compreensão
  dos textos, além de uniformizar a apresentação
  dos documentos técnicos e científicos no Brasil.
]

// Forma nomeada (equivalente):
#citacao-longa(autor: \"SILVA\", ano: 2023, pagina: \"42-43\")[
  Texto longo da citação...
]")
]

Alias curto disponível: `#clonga(...)`.

==== Marcações especiais dentro de citações

Quando o trecho citado é modificado em relação ao original, a ABNT exige indicações precisas:

#exemplo[
  #raw(block: true, lang: "typst", "// Omissão de trecho (reticências entre colchetes):
#citacao-curta(\"SILVA\", 2023, 10)[O texto #supressao revela...]

// Interpolação (acréscimo do citador):
#citacao-curta(\"SILVA\", 2023, 10)[O resultado #interpolacao[deste experimento] foi positivo.]

// Grifo do citador (ênfase adicionada por quem cita):
#citacao-curta(\"SILVA\", 2023, 10)[A #grifo-nosso[clareza] é fundamental.]

// Grifo do autor (ênfase já existia no original):
#citacao-curta(\"SILVA\", 2023, 10)[A #grifo-do-autor[clareza] é fundamental.]")

  Resultados:
  / `#supressao`: insere `[...]` (constante, não função)
  / `#interpolacao[...]`: envolve o texto entre colchetes
  / `#grifo-nosso(...)`: aplica itálico e acrescenta ", grifo nosso" após a citação
  / `#grifo-do-autor(...)`: aplica itálico e acrescenta ", grifo do autor" após a citação
]

Aliases curtos: `#interp`, `#gnosso`, `#gautor`.

=== Citações indiretas

Uma citação indireta (paráfrase) reproduz as *ideias* do autor com as palavras do redator --- sem aspas, sem bloco recuado. A referência é obrigatória.

#exemplo[
  #raw(block: true, lang: "typst", "// Paráfrase simples:
A norma ABNT orienta que a formatação seja padronizada
#citar-indireto(\"SILVA\", 2023).

// Citação de citação (apud) --- quando não se teve acesso à fonte original:
A ideia foi elaborada originalmente por Freud
#citar-apud(\"FREUD\", 1900, \"LACAN\", 1966, pagina: 123).

// Múltiplos autores (até 3):
#citar-multiplos((\"SILVA\", \"SANTOS\", \"COSTA\"), 2023)

// Mais de 3 autores (et al.):
#citar-etal(\"SILVA\", 2023)")

  Resultados:
  / `#citar-indireto`: `(SILVA, 2023)`
  / `#citar-apud`: `(FREUD, 1900 apud LACAN, 1966, p. 123)`
  / `#citar-multiplos`: `(SILVA; SANTOS; COSTA, 2023)`
  / `#citar-etal`: `(SILVA et al., 2023)`
]

=== Sistema autor-data

No sistema autor-data, a chamada indica o sobrenome do autor e o ano de publicação. É o sistema predominante nos trabalhos acadêmicos brasileiros.

A posição da chamada no texto determina qual função usar:

#exemplo[
  #raw(block: true, lang: "typst", "// Autor integrado à frase (forma discursiva):
Segundo #citar-autor(\"Silva\", 2023), a metodologia...

// Autor entre parênteses (forma parentética):
A metodologia é eficiente #citar(\"SILVA\", 2023, pagina: 45).

// Entidade coletiva como autora:
O relatório recomenda mudanças #citar-entidade(\"BRASIL\", 2023).

// Obra sem autor identificado (entrada pelo título):
O manual orienta que #citar-titulo(\"MANUAL\", 2022)...")

  Resultados:
  / `#citar-autor`: Segundo Silva (2023)...
  / `#citar`: ...(SILVA, 2023, p. 45).
  / `#citar-entidade`: ...(BRASIL, 2023).
  / `#citar-titulo`: ...(MANUAL, 2022).
]

*Abordagem recomendada: arquivo `.bib` com `@chave`*

Para documentos com muitas referências, a abordagem recomendada é usar um arquivo `.bib` com a sintaxe nativa `@chave` do Typst. As chamadas são geradas automaticamente no formato ABNT e a consistência com a lista de referências é garantida. Para habilitar, adicione `configurar-citacoes-abnt` no preâmbulo:

#exemplo[
  #raw(block: true, lang: "typst", "// No preâmbulo do documento:
#show: configurar-citacoes-abnt

// Citação entre parênteses:
O resultado foi positivo @silva2023.

// Citação com página:
O resultado foi positivo @silva2023[p. 45].

// Autor no texto (suprime o nome entre parênteses):
Segundo Silva [-@silva2023], o resultado foi positivo.")

  O ABNTyp gera automaticamente "(SILVA, 2023)", "(SILVA, 2023, p. 45)" etc. A sintaxe `[-@chave]` suprime o nome do autor quando ele já aparece no texto.
]

As chaves do `@chave` devem corresponder às entradas do arquivo `.bib`. Para gerar a lista de referências, veja a @sec:ref-auto.

#block(
  width: 100%,
  inset: 1em,
  stroke: (left: 2pt + blue.lighten(40%)),
  fill: blue.lighten(93%),
)[
  #set par(first-line-indent: 0pt)
  *Funções manuais vs. arquivo `.bib`:*
  - *`@chave` (recomendado):* formatação automática, consistência garantida pelo CSL, ideal para trabalhos com bibliografias extensas. Detalhes na @sec:ref-auto.
  - *`citar()`, `citar-autor()` etc.:* controle total sobre o texto da chamada; úteis em situações pontuais ou quando a entrada não existe no `.bib`.
]

=== Sistema numérico

O sistema numérico, previsto na seção 4.2 da NBR 10520:2023, usa números arábicos consecutivos entre parênteses ou colchetes para indicar as fontes. A numeração remete à lista de referências ao final.

#block(
  width: 100%,
  inset: 1em,
  stroke: (left: 2pt + orange),
  fill: orange.lighten(90%),
)[
  #set par(first-line-indent: 0pt)
  *Restrição normativa (NBR 10520:2023, seção 4.2):* o sistema numérico *não pode* ser usado quando o documento contiver notas de rodapé, pois os números conflitariam. Se o trabalho usar notas de rodapé, adote o sistema autor-data.
]

Para ativar o sistema numérico, aplique `citacao-num-config` no preâmbulo. Todas as citações do documento devem então usar as funções `citar-num-*`:

#exemplo[
  #raw(block: true, lang: "typst", "// No preâmbulo:
#show: citacao-num-config

// Citação simples:
O resultado foi positivo #citar-num(\"silva2023\", pagina: \"45\").

// Múltiplas referências:
Vários estudos #citar-num-multiplos((\"santos2022\", \"costa2021\"))
confirmam os resultados.

// Autor integrado à frase:
#citar-num-linha(\"silva2023\") demonstra que...

// Citação de citação (apud):
#citar-num-apud(\"freud1900\", \"lacan1966\", pagina: \"123\")

// Citação direta curta numerada:
O autor afirma #citacao-num-curta(\"silva2023\", pagina: \"10\")[que o resultado é positivo].

// Citação direta longa numerada:
#citacao-num-longa(\"silva2023\", pagina: \"10-11\")[
  Texto longo da citação que ocupa mais de três linhas e
  deve ser apresentado em bloco recuado conforme a ABNT.
]

// Lista de referências numerada (no final do documento):
#bibliografia-numerica((
  (\"silva2023\", [SILVA, J. *Título*. São Paulo: Editora, 2023.]),
  (\"santos2022\", [SANTOS, M. Artigo. *Revista*, v. 1, 2022.]),
  (\"costa2021\", [COSTA, A. Outro título. Rio: Ed., 2021.]),
))")
]

== Notas de rodapé

Notas de rodapé são indicações ou observações complementares ao texto, regulamentadas pela NBR 10520:2023 (seção 6). A norma distingue _notas de referência_ (que indicam a fonte consultada) e _notas explicativas_ (para comentários e esclarecimentos). A NBR 14724:2024 complementa: devem ser separadas do texto por filete de 5 cm, em fonte menor e espaçamento simples. Em Typst, são criadas com a função `#footnote()`:

#exemplo[
  #raw(block: true, lang: "typst", "O Typst#footnote[Sistema de composição tipográfica criado
em 2019.] é uma alternativa moderna ao LaTeX#footnote[Criado
por Leslie Lamport na década de 1980.].")
]

O ABNTyp formata as notas automaticamente conforme a ABNT: fonte menor (10pt), espaçamento simples, separadas do texto por um filete de 5 cm.

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

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)
  *Suplemento de headings de nível 1:* Ao referenciar uma seção de nível 1 (ex.: `@cap:intro`), o Typst antepõe automaticamente o "suplemento" ao número — por exemplo, "Capítulo 1". O ABNTypst configura esse suplemento conforme o template:

  - `normasABNT`, `livro`, `relatorio` → *"Capítulo"* (nível 1 corresponde a capítulo nesses documentos)
  - `artigo` → *"Seção"* (artigos não têm capítulos, apenas seções)

  Portanto, `@cap:intro` produz "Capítulo 1" em uma tese, e "Seção 1" em um artigo, sem nenhuma configuração manual.

  Usuários que constroem templates customizados com `with-abnt-setup` diretamente podem ajustar esse texto via o parâmetro `suplemento-nivel1`:

  #raw(block: true, lang: "typst", "#show: with-abnt-setup.with(
  fonte: \"Times New Roman\",
  suplemento-nivel1: \"Parte\",  // ex.: para documentos divididos em partes
)")
]

#pagebreak()

// ============================================================================
// CAPÍTULO 4: FIGURAS, QUADROS E TABELAS
// ============================================================================

= Figuras, Quadros e Tabelas

Figuras, quadros e tabelas são elementos essenciais em trabalhos acadêmicos. A ABNT estabelece regras específicas para sua apresentação.

No ABNTyp, todos esses elementos são inseridos por meio da função `#container()`. Ela é um invólucro sobre a função nativa `figure()` do Typst e cuida automaticamente de título (caption), numeração sequencial, fonte e nota --- tudo formatado conforme a ABNT. Dentro do container, usamos funções auxiliares para o conteúdo: `#imagem()` para fotografias e ilustrações, `#quadro()` para tabelas textuais com bordas fechadas, e `#tabela()` para tabelas numéricas no padrão IBGE (sem bordas laterais).

*`grid()` vs. `table()`* --- No Typst, `grid()` e `table()` são funções diferentes. A `grid()` é um mecanismo de _layout_: posiciona elementos em linhas e colunas, sem bordas por padrão, sem título nem numeração. Já a `table()` é semântica: representa uma tabela de dados, com bordas por padrão, e pode receber legenda via `figure()`. As funções `#quadro()` e `#tabela()` do ABNTyp são wrappers sobre `table()` --- use-as dentro de `#container()` para dados tabulares. Para diagramação de layout (alinhar blocos lado a lado), use `grid()` diretamente.

*A unidade `fr`* --- Ao definir colunas, a unidade `fr` (_fraction_) distribui o espaço disponível proporcionalmente. Por exemplo: `(1fr, 1fr, 1fr)` cria três colunas iguais (1/3 cada); `(1fr, 2fr)` cria duas colunas onde a segunda tem o dobro da largura; `(auto, 1fr)` faz a primeira ocupar só o necessário e a segunda preencher o restante; `(100pt, 1fr)` fixa a primeira e preenche o resto com a segunda.

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

A função `#container()` é a _única_ forma de criar um elemento com título e numeração no ABNTyp. Seus parâmetros principais são:

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

== Mesclando células (multicolumn e multirow)

No LaTeX, mesclar células exige `\multicolumn{}` e o pacote `multirow`. No Typst, isso é nativo via `table.cell()`:

/ `colspan`: número de colunas que a célula ocupa (equivalente a `\multicolumn`)
/ `rowspan`: número de linhas que a célula ocupa (equivalente a `\multirow`)

#exemplo[
  #raw(block: true, lang: "typst", "#container(
  legenda: [Horário de aulas],
  tipo: \"quadro\",
  origem: [Elaborado pelo autor.],
)[
  #quadro(
    columns: (auto, 1fr, 1fr),
    inset: 8pt,
    align: center,
    // Cabeçalho
    [], [*Segunda*], [*Terça*],
    // Célula que ocupa 2 linhas
    table.cell(rowspan: 2)[*Manhã*],
    [Cálculo I], [Física II],
    [Álgebra], [Química],
    // Célula que ocupa 2 colunas
    table.cell(colspan: 2)[_Intervalo_],
    [*Tarde*], [Programação], [Estatística],
  )
]")
]

O parâmetro `colspan` mescla colunas (horizontal) e `rowspan` mescla linhas (vertical). Ambos aceitam qualquer inteiro positivo. Os mesmos parâmetros funcionam em `#tabela()`, `#quadro()` e `table()` --- todos usam `table.cell()` internamente.

== Listas automáticas

O ABNTyp gera automaticamente listas de figuras, tabelas e quadros:

#raw(block: true, lang: "typst", "// No início do documento, após o sumário:

#lista-ilustracoes()  // Lista de figuras

#lista-tabelas()      // Lista de tabelas

#lista-quadros()      // Lista de quadros")

As listas são geradas a partir dos títulos definidos no parâmetro `legenda` de cada `#container()`.

#pagebreak()

// ============================================================================
// CAPÍTULO 5: ELEMENTOS PÓS-TEXTUAIS
// ============================================================================

= Elementos Pós-textuais

Os elementos pós-textuais complementam o trabalho e incluem referências, apêndices, anexos, glossário e índice. Chame `#postextual()` antes do primeiro elemento pós-textual para sinalizar a transição (ver @sec:paginacao).

== Referências bibliográficas (NBR 6023)

As referências são obrigatórias e devem seguir a NBR 6023:2018. O ABNTyp suporta referências manuais e automáticas via arquivo `.bib`.

=== Referências manuais <sec:ref-manual>

#exemplo[
  #raw(block: true, lang: "typst", "#titulo-sem-num[REFERÊNCIAS]

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

O ABNTyp pode usar arquivos `.bib` para gerar referências automaticamente, seguindo o fluxo: configurar citações → citar no texto → gerar bibliografia.

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

O ABNTyp usa o estilo CSL `abnt.csl` para formatar as referências, baseado no trabalho original de Jucá da Costa e Antenor Aguiar C. A. Matos (#link("https://github.com/virgilinojuca/csl-abnt")[csl-abnt], domínio público). Os principais tipos de entrada BibTeX/BibLaTeX suportados são:

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
#titulo-sem-num[APÊNDICES]

== Apêndice A -- Questionário aplicado <apendice-a>

Texto do apêndice...

== Apêndice B -- Código-fonte <apendice-b>

#raw(block: true, lang: \"python\", \"def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    ...\")

// Inicia seção de anexos
#titulo-sem-num[ANEXOS]

== Anexo A -- Norma ABNT NBR 14724 <anexo-a>

Texto do anexo...")
]

== Glossário

O glossário lista termos técnicos em ordem alfabética:

#exemplo[
  #raw(block: true, lang: "typst", "#titulo-sem-num[GLOSSÁRIO]

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

O índice remissivo lista termos importantes com suas páginas. O ABNTyp oferece funções para marcar e gerar índices:

#exemplo[
  #raw(block: true, lang: "typst", "// No texto, marque termos para o índice
Um #idx[algoritmo] é uma sequência de instruções...

O #idx[Quicksort] é um algoritmo de #idx[ordenação]...

// No final do documento
#titulo-sem-num[ÍNDICE]

#indice()")
]

#pagebreak()

// ============================================================================
// CAPÍTULO 6: TIPOS DE DOCUMENTOS
// ============================================================================

= Tipos de Documentos

O ABNTyp oferece templates para diversos tipos de documentos acadêmicos e técnicos.

== Trabalho acadêmico (tese, dissertação, TCC)

O template `normasABNT` é o mais completo, seguindo a NBR 14724:2024:

#raw(block: true, lang: "typst", "// 1. Metadados
#show: dados.with(
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
)

// 2. Formatação ABNT
#show: normasABNT.with(
  fonte: \"Times New Roman\",  // ou \"Arial\"
)

// 3. Elementos pré-textuais — leem do state
#capa()
#folha-rosto()
#resumo[...]
#resumo-en[...]
#sumario()")

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
#cronograma-simples(...)
= Referências")

A função `cronograma-simples()` gera uma tabela básica de atividades × períodos. Para um cronograma mais elaborado --- gráfico de Gantt com barras coloridas, progresso, dependências e marcos --- use a função `cronograma()` do pacote FerrMat.

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
  colunas: 3,
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
#import \"@preview/abntyp:0.1.3\": slides-defesa

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
// APÊNDICE A: GUIA DE MIGRAÇÃO LATEX -> TYPST
// ============================================================================

#apendice("A", "Guia de Migração LaTeX → Typst")
#label("apendice-a")

#set heading(numbering: "A.1")
#counter(heading).update((0,))

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
    [`abnTeX2`], [`abntyp`], [Normas ABNT],
    table.hline(stroke: 1pt),
  ),
  caption: [Equivalências de pacotes],
  kind: table,
)

== abnTeX2 vs ABNTyp

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*abnTeX2 (LaTeX)*], [*ABNTyp (Typst)*],
    table.hline(stroke: 0.5pt),
    [#raw("\\documentclass{abntex2}")], [#raw("#show: dados.with(..)") + linebreak() + #raw("#show: normasABNT.with()")],
    [#raw("\\imprimircapa")], [#raw("#capa()")],
    [#raw("\\imprimirfolhaderosto")], [#raw("#folha-rosto()")],
    [#raw("\\begin{resumo}...\\end{resumo}")], [#raw("#resumo(..)[...]")],
    [#raw("\\begin{abstract}...\\end{abstract}")], [#raw("#resumo-en(..)[...]")],
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
  caption: [Equivalências abnTeX2/ABNTyp],
  kind: table,
)

#pagebreak()

// ============================================================================
// APÊNDICE B: RECURSOS NA INTERNET
// ============================================================================

#apendice("B", "Recursos na Internet")
#label("apendice-b")

#counter(heading).update((1,))

== Typst

- *Site oficial*: #link("https://typst.app")
- *Documentação*: #link("https://typst.app/docs")
- *Repositório GitHub*: #link("https://github.com/typst/typst")
- *Typst Universe* (pacotes): #link("https://typst.app/universe")
- *Discord da comunidade*: #link("https://discord.gg/2uDybryKPe")
- *Fórum de discussões*: #link("https://github.com/typst/typst/discussions")

== ABNTyp

- *Repositório GitHub*: #link("https://github.com/3sdras/abntyp")
- *Documentação*: #link("https://github.com/3sdras/abntyp/docs")
- *Issues (problemas)*: #link("https://github.com/3sdras/abntyp/issues")

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

== Aliases (nomes curtos)

Todas as funções principais do ABNTyp possuem _aliases_ --- nomes curtos equivalentes. Ambas as formas são válidas e produzem o mesmo resultado:

#figure(
  table(
    columns: (1fr, auto),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Função completa*], [*Alias*],
    table.hline(stroke: 0.5pt),
    [`citacao-curta`], [`ccurta`],
    [`citacao-longa`], [`clonga`],
    [`citar-autor`], [`cautor`],
    [`citar-apud`], [`capud`],
    [`citar-multiplos`], [`cmultiplos`],
    [`citar-etal`], [`cetal`],
    [`folha-rosto`], [`rosto`],
    [`ficha-catalografica`], [`ficha`],
    [`dedicatoria`], [`dedica`],
    [`agradecimentos`], [`agradece`],
    [`lista-siglas`], [`siglas`],
    [`lista-simbolos`], [`simbolos`],
    [`interpolacao`], [`interp`],
    [`grifo-nosso`], [`gnosso`],
    [`grifo-do-autor`], [`gautor`],
    [`citar-num`], [`cnum`],
    [`citar-num-multiplos`], [`cnmultiplos`],
    [`citacao-num-curta`], [`cncurta`],
    [`citacao-num-longa`], [`cnlonga`],
    [`bibliografia-numerica`], [`bibnum`],
    table.hline(stroke: 1pt),
  ),
  caption: [Aliases disponíveis no ABNTyp],
  kind: table,
)

Por exemplo, `#ccurta("Silva", 2023, 42)[texto]` é idêntico a `#citacao-curta("Silva", 2023, 42)[texto]`.

#pagebreak()

// ============================================================================
// APÊNDICE C: NORMAS ABNT IMPLEMENTADAS
// ============================================================================

#apendice("C", "Normas ABNT Implementadas")
#label("apendice-c")

#counter(heading).update((2,))

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

#titulo-sem-num[REFERÊNCIAS]

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
