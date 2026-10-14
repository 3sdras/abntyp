// Manual de Implementação do ABNTyp
// Documentação completa do pacote

#set document(
  title: "Manual de Implementação do ABNTyp",
  author: "ABNTyp",
)

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2cm, left: 2.5cm, right: 2cm),
  numbering: "1",
  number-align: center + bottom,
)

#set text(
  font: "Times New Roman",
  size: 11pt,
  lang: "pt",
  region: "BR",
)

#set par(
  leading: 1.2em,
  justify: true,
)

#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1em)
  text(size: 16pt, weight: "bold", it)
  v(1em)
}

#show heading.where(level: 2): it => {
  v(1em)
  text(size: 13pt, weight: "bold", it)
  v(0.5em)
}

#show heading.where(level: 3): it => {
  v(0.8em)
  text(size: 11pt, weight: "bold", it)
  v(0.3em)
}

// Capa
#align(center)[
  #v(3cm)
  #text(size: 24pt, weight: "bold")[ABNTyp]

  #v(1cm)
  #text(size: 14pt)[Formatação de Documentos Acadêmicos]
  #text(size: 14pt)[conforme Normas ABNT para Typst]

  #v(2cm)
  #text(size: 12pt)[Manual de Implementação]

  #v(1cm)
  #text(size: 11pt)[Versão 0.7.0]

  #v(1fr)
  #text(size: 11pt)[Outubro 2026]
]

#pagebreak()

// Sumário
#outline(
  title: [Sumário],
  indent: auto,
  depth: 3,
)

#pagebreak()

= Introdução

O *ABNTyp* (ABNTyp — Base Normativa Typst) é um pacote para o sistema de composição tipográfica Typst que implementa as normas da Associação Brasileira de Normas Técnicas (ABNT) para formatação de documentos acadêmicos.

== Por que usar o ABNTyp?

- *Simplicidade*: Typst é mais simples que LaTeX, com sintaxe moderna e intuitiva
- *Velocidade*: Compilação instantânea, ideal para visualização em tempo real
- *Modularidade*: Use apenas os módulos que precisar

== Normas Implementadas

O pacote implementa as seguintes normas ABNT:

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: 6pt,
  table.hline(stroke: 1pt),
  [*Norma*], [*Descrição*],
  table.hline(stroke: 0.5pt),
  // Normas principais para trabalhos acadêmicos
  [NBR 14724:2024], [Trabalhos acadêmicos -- Apresentação],
  [NBR 6023:2018], [Referências -- Elaboração],
  [NBR 10520:2023], [Citações em documentos (sistemas autor-data e numérico)],
  [NBR 6024:2012], [Numeração progressiva das seções de um documento],
  [NBR 6027:2012], [Sumário -- Apresentação],
  [NBR 6028:2021], [Resumo, resenha e recensão -- Apresentação],
  // Tipos de documentos
  [NBR 6022:2018], [Artigo em publicação periódica técnica e/ou científica],
  [NBR 6021:2015], [Publicação periódica técnica e/ou científica -- Apresentação],
  [NBR 6029:2023], [Livros e folhetos -- Apresentação],
  [NBR 10719:2015], [Relatório técnico e/ou científico -- Apresentação],
  [NBR 15287:2025], [Projeto de pesquisa -- Apresentação],
  [NBR 15437:2006], [Pôsteres técnicos e científicos -- Apresentação],
  // Elementos específicos
  [NBR 6034:2004], [Índice -- Apresentação],
  [NBR 12225:2004], [Lombada -- Apresentação],
  // Normas auxiliares
  [NBR 5892:2019], [Representação e formatos de tempo -- Datas e horas],
  [NBR 6025:2002], [Revisão de originais e provas],
  [NBR 6032:1989], [Abreviação de títulos de periódicos e publicações seriadas],
  [NBR 6033:1989], [Ordem alfabética],
  // Identificadores
  [NBR ISO 2108:2006], [ISBN -- Número Padrão Internacional de Livro],
  [NBR 10525:2005], [ISSN -- Número Padrão Internacional para Publicação Seriada],
  // Outras normas
  [IBGE 1993], [Normas de apresentação tabular],
  table.hline(stroke: 1pt),
)

= Instalação

== Requisitos

- Typst versão 0.13 ou superior (o recuo `first-line-indent: (amount: ..., all: true)` exige 0.13)
- Fontes: o padrão do pacote é Times New Roman (opcionalmente Arial); a NBR 14724:2024 não nomeia fonte, só o corpo de 12 pt. Sem elas, o pacote cai em outra fonte (ver "Pilhas de fonte" em `fonts.typ`); com `fonte: "Arial"` fora do Linux, o Typst emite 1 aviso (ver `fonts.typ`)

== Instalação Local

Clone ou baixe o repositório e coloque a pasta `abntyp` no seu projeto:

```
seu-projeto/
├── abntyp/
│   ├── lib.typ
│   └── src/
│       └── ...
└── seu-documento.typ
```

No seu documento:

```typst
#import "abntyp/lib.typ": *
```

== Instalação como Pacote

Este manual descreve a versão 0.7.0, que muda a saída e o uso em relação à 0.6.0 (ver o changelog). Para instalar:

```typst
#import "@preview/abntyp:0.7.0": *
```

= Guia Rápido

== Documento Mínimo

O fluxo recomendado separa metadados (`dados()`) e formatação (`normas-abnt()`). Os elementos pré-textuais leem tudo automaticamente do state. Este é o mínimo para *compilar*, e não o mínimo exigido pela NBR 14724:2024: falta a `natureza` na folha de rosto, a folha de aprovação (`folha-aprovacao()`), a ficha catalográfica (`ficha-catalografica()`) e as referências:

```typst
#import "abntyp/lib.typ": *

// 1. Metadados — armazenados no state
#show: dados.with(
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  autor: "Cláudio Código",
  instituicao: "Universidade Federal de Jataí",
  faculdade: "Instituto de Ciências Exatas e Tecnológicas",
  programa: "PROFMAT - Programa de Mestrado Profissional em Rede em Matemática",
  local: "Jataí",
  ano: 2026,
  orientador: "Prof. Dr. Esdras Teixeira Costa",
  palavras-chave: ("formatação", "normas ABNT", "Typst"),
  palavras-chave-en: ("formatting", "ABNT standards", "Typst"),
)

// 2. Formatação ABNT
#show: normas-abnt.with()

// 3. Elementos pré-textuais — leem do state
#capa()
#folha-rosto()

#resumo[
  Texto do resumo...
]

#resumo-en[
  Abstract text...
]

#sumario()

// A paginação é automática (NBR 14724): a contagem começa na folha de rosto
// e o número aparece a partir da primeira seção primária numerada.

= Introdução

Seu texto aqui...

= Conclusão

Conclusão do trabalho...

// REFERÊNCIAS são geradas ao final se normas-abnt receber
// arquivo-bibliografia: read("referencias.bib"). Caso contrário:
// #referencias(read("referencias.bib"))
```

*Override parcial:* qualquer elemento aceita parâmetros explícitos que sobrescrevem o state:

```typst
// Capa com título diferente, resto do state
#capa(titulo: "Título Alternativo")

// Resumo com palavras-chave sobrescritas
#resumo(palavras-chave: ("outra palavra", "mais uma"))[Texto do resumo...]
```

= Referência dos Módulos

== Core (Núcleo)

Os módulos core definem as configurações básicas de formatação.

=== metadata.typ - Metadados do Documento

A função `dados()` armazena os metadados do trabalho em um state compartilhado. Os elementos pré-textuais (`capa()`, `folha-rosto()`, `resumo()`, `lombada()`, etc.) leem automaticamente desse state, evitando repetição de dados.

*Função principal:*

```typst
#let dados(
  titulo: none,
  subtitulo: none,
  autor: none,
  autores: none,        // Array de dicts (para templates multi-autor)
  instituicao: none,
  faculdade: none,
  programa: none,
  local: none,
  ano: none,            // Int ou string
  natureza: none,
  objetivo: none,
  area: none,
  orientador: none,
  coorientador: none,
  volume: none,         // Número do volume (se houver mais de um; capa e folha de rosto)
  palavras-chave: none,
  palavras-chave-en: none,
  ..args,               // em `show: dados.with(...)`, recebe o corpo do documento
)
```

*Uso recomendado (via show rule):*

```typst
#show: dados.with(
  titulo: "Meu Trabalho",
  autor: "Maria da Silva",
  // ...
)
```

*Uso standalone (sem show rule):*

```typst
#dados(
  titulo: "Relatório",
  autor: "João Santos",
  // ...
)
```

`dados()` também configura os metadados do PDF (`set document(title: ..., author: ...)`).

Parâmetros desconhecidos geram erro com `panic()`.

=== page.typ - Configuração de Página

Configura o formato e margens da página conforme NBR 14724.

*Função principal:*

```typst
#let abnt-page-setup(
  papel: "a4",
  margem-superior: 3cm,
  margem-inferior: 2cm,
  margem-esquerda: 3cm,
  margem-direita: 2cm,
  body,
)
```

*Parâmetros:*
- `papel`: Formato do papel (padrão: "a4")
- `margem-superior`: Margem superior (padrão: 3cm)
- `margem-inferior`: Margem inferior (padrão: 2cm)
- `margem-esquerda`: Margem esquerda (padrão: 3cm)
- `margem-direita`: Margem direita (padrão: 2cm)
- `body`: o restante do documento (último argumento, posicional)

*Uso (mudança da 0.7.0):* como todas as funções `abnt-*-setup` e de numeração desta seção, `abnt-page-setup` recebe `body` e vale só como regra `show:`. Antes da 0.7.0 elas eram chamadas como `#abnt-page-setup()`, que não fazia nada; agora essa chamada dá o erro `missing argument: body`.

```typst
#show: abnt-page-setup.with(margem-esquerda: 3cm)

Texto do documento, com a margem esquerda definida acima.
```

*Funções auxiliares:*

```typst
// Aplica configuração de página ao corpo
#let with-abnt-page(body)

// Margens ABNT: frente-verso (interna 3cm, externa 2cm) ou somente anverso
#let abnt-margens(frente-verso)

// Número de página automático (usado por normas-abnt, relatorio e livro)
#let abnt-numero-pagina(paginacao: "auto", frente-verso: false, centro: false, apos-sumario: false)

// Quebra de página; para: "impar" ou "par" (útil em frente-verso)
#let quebra-pagina(fraco: false, para: none)

// Numeração de página (regras show: #show: abnt-page-numbering)
#let start-arabic-numbering(body)  // reinicia a contagem em 1 e usa algarismos arábicos
#let abnt-page-numbering(body)     // arábicos, canto superior direito
#let pretextual-numbering(body)    // algarismos romanos minúsculos
#let no-page-numbering(body)       // remove a numeração
```

As quatro de numeração também recebem `body` desde a 0.7.0 (`#show: abnt-page-numbering`, sem parâmetros). Nos templates a numeração já é automática (veja abaixo) e não é preciso usá-las.

*Marcas de contagem (usadas pelos templates; úteis só a quem monta o documento à mão):*

```typst
// Marca a folha de rosto: a contagem de páginas passa a valer 1 aqui
#let marcar-folha-rosto(primeiro: false)

// Marca o verso da folha de rosto (ficha catalográfica): a página não entra
// na contagem (a seguinte continua a numeração da folha de rosto, NBR 14724 5.3) nem leva número
#let marcar-ficha()

// Em frente-verso avança para a próxima página ímpar (anverso); sem frente-verso, não faz nada
#let abre-anverso()

// State booleano ligado por normas-abnt(frente-verso: true) (lido por abre-anverso)
#let abnt-frente-verso = state("abnt-frente-verso", false)
```

Nos templates (`normas-abnt`, `relatorio`, `livro`), a numeração é controlada pelos parâmetros `paginacao` (`"auto"`, `"todas"` ou `"nenhuma"`) e `frente-verso` (`true` espelha margens e alterna o número entre direita e esquerda). Não é mais necessário reiniciar o contador nem usar `#set page(numbering: ...)` no início do texto.

*Em frente-verso, o número da Introdução pode ser par.* A ficha catalográfica fica no verso da folha de rosto e não é contada (NBR 14724:2024, 5.3). Mas a ficha ocupa uma página física do PDF, então, a partir dela, o número impresso e a página física passam a ter paridades opostas: a Introdução, que abre uma página ímpar do PDF (anverso), sai com número par. A posição do número (direita nas páginas ímpares, esquerda nas pares) segue a página física, não o valor. É o efeito de seguir a norma ao pé da letra (ver "Limitações conhecidas").

=== fonts.typ - Configuração de Fontes

Define fontes e tamanhos. A NBR 14724:2024 não nomeia a fonte: só pede corpo de 12 pt e menor (10 pt) em citações longas, notas e legendas; Times New Roman e Arial são o padrão do pacote, não uma exigência da norma.

*Constantes:*

```typst
#let abnt-fonts = (
  serif: "Times New Roman",
  sans: "Arial",
)

#let abnt-font-sizes = (
  normal: 12pt,      // Texto principal
  small: 10pt,       // Citações, notas, legendas
  footnote: 10pt,    // Notas de rodapé
  caption: 10pt,     // Legendas
  cover-title: 14pt, // Título na capa (informativo: a capa usa 12 pt)
  cover-author: 12pt, // Autor na capa
)
```

As duas constantes são só informativas: nenhum módulo do pacote as lê.

*Funções:*

```typst
// Aplica fonte padrão (Times New Roman, 12pt, pt-BR); recebe body (#show: abnt-font-setup.with(...))
#let abnt-font-setup(fonte-familia: "Times New Roman", body)

// Aplica fonte ao corpo do documento
#let with-abnt-font(fonte-familia: "Times New Roman", body)

// Texto em tamanho reduzido (10pt)
#let small-text(body)

// Texto para notas de rodapé e para legendas (aliases de small-text)
#let footnote-text(body)
#let caption-text(body)

// Notas de rodapé: filete de 5 cm e espaço de 0,5em; recebe body
#let abnt-footnote-setup(body)
```

*Atalhos de formatação inline:*

```typst
// Sublinhado (wrapper de underline)
#let sublinhado(body)    // #sublinhado[texto sublinhado]

// Riscado (wrapper de strike)
#let risc(body)          // #risc[texto riscado]

// Versalete: primeira letra normal, o resto em caixa alta a 0,8em. Pede texto
// (#caps("Texto")); com conteúdo (#caps[...]) cai no smallcaps nativo
#let caps(texto)
```

`sublinhado` se chamava `sub` até a 0.6.0. *Quebra de API da 0.7.0:* `sub` é o subscrito nativo do Typst (`H#sub[2]O`) e o pacote o sobrescrevia com um sublinhado; agora `#sub[…]` volta a ser o subscrito nativo, sem erro, e quem usava o sublinhado do pacote precisa trocar para `#sublinhado[…]`.

*Pilhas de fonte (fallback):* `normas-abnt` e os demais templates (via `with-abnt-setup`) listam várias famílias, porque o compilador avisa quando a fonte pedida não existe e cai na seguinte:

```typst
// fonte: "Times New Roman" (padrão)
("Times New Roman", "Times", "Libertinus Serif", "New Computer Modern")

// fonte: "Arial"
("Arial", "Helvetica", "Liberation Sans", "New Computer Modern")

// qualquer outra: só ela (fonte: "Calibri" → ("Calibri",))
```

Só "Libertinus Serif" e "New Computer Modern" vêm embutidas no compilador. *Aviso com Arial:* o Typst avisa para *cada* família da pilha que não existe no computador, mesmo achando a primeira. Por isso `fonte: "Arial"` gera 1 aviso `unknown font family: liberation sans` em computadores sem essa fonte (macOS e Windows). O aviso é aceito de propósito: sem "Liberation Sans" (o clone métrico da Arial, instalado de fábrica no Linux), o texto cairia numa fonte serifada onde só há a Liberation Sans, e sem aviso. Com Times New Roman (o padrão) não há aviso.

=== spacing.typ - Configuração de Espaçamentos

Define espaçamentos entre linhas e parágrafos. Desde a 0.7.0 a entrelinha é calibrada pelo Word: o passo entre linhas é k × 1,15 × corpo, com k = 1 (simples), 1,5 e 2. Em 12 pt: 13,8 / 20,7 / 27,6 pt, *igual em Times New Roman e em Arial* (as bordas da linha são fixas, para o passo não depender da fonte). O espaço entre parágrafos é igual à entrelinha (os modelos ABNT do Word usam zero entre parágrafos). Medido no PDF (`pdftotext -bbox-layout`): o corpo do TCC tem passo de 20,70 pt; artigo e relatório saem em espaço simples (13,80 pt) por padrão (ver `espacamento` nos templates).

*Funções e constantes de cálculo:*

```typst
// Valor de `leading` e de `spacing` que dá o passo k × 1,15 × corpo (k = 1, 1.5 ou 2),
// já descontadas as bordas fixas abaixo
#let abnt-leading(k)

// Bordas da linha (use junto com abnt-leading nos set de text e par)
#let abnt-top-edge = 0.7em
#let abnt-bottom-edge = 0pt
```

Para fixar o espaçamento fora dos helpers, use os três juntos:

```typst
#set text(top-edge: abnt-top-edge, bottom-edge: abnt-bottom-edge)
#set par(leading: abnt-leading(1.5), spacing: abnt-leading(1.5))
```

*Constantes sem uso:*

```typst
#let abnt-line-spacing = (
  normal: 1.5em,  // NÃO é o que o pacote aplica
  single: 1em,
  double: 2em,
)
```

`abnt-line-spacing` é só uma constante exportada: nenhum módulo a usa. Aplicá-la com `set par(leading: abnt-line-spacing.normal)` dá um passo entre linhas bem maior que os 20,7 pt do corpo do pacote; use `abnt-leading(1.5)`. O mesmo vale para `section-spacing` (`v(1.5em)`), também sem uso.

*Funções:*

```typst
// Aplica espaçamento padrão (1,5 entre linhas, recuo de 1,25cm); recebe body
#let abnt-spacing-setup(body)

// Aplica espaçamento ao corpo
#let with-abnt-spacing(body)

// Espaçamento simples (citações, notas, referências)
#let single-spacing(body)

// Espaçamento 1,5
#let one-half-spacing(body)

// Espaçamento duplo
#let double-spacing(body)

// Remove recuo de primeira linha
#let no-indent(body)

// Bloco com recuo específico (citações longas: 4cm)
#let indented-block(recuo: 4cm, body)

// Bloco para a natureza do trabalho (recuo 8cm, 10pt); hoje sem uso nos templates
#let nature-block(body)
```

`abnt-spacing-setup` também recebe `body` (`#show: abnt-spacing-setup`); ver a nota de `page.typ`.

*Indentação de parágrafos (`all: true`):*

O recuo de 1,25 cm na primeira linha é a convenção adotada pelo pacote (e por muitos modelos institucionais), não uma exigência da NBR 14724:2024, que não traz medida de recuo de parágrafo. Por padrão, o Typst segue a convenção anglo-saxônica e não indenta o primeiro parágrafo depois de um título; os templates do ABNTyp usam `first-line-indent` com `all: true` para indentar também esse parágrafo:

```typst
#set par(first-line-indent: (amount: 1.25cm, all: true))
```

Como o parâmetro `all: true` indenta o conteúdo dentro de _todos_ os contêineres, os templates aplicam automaticamente show rules para excluir elementos que não devem ter indentação:

```typst
#show heading: set par(first-line-indent: 0pt)
#show figure: set par(first-line-indent: 0pt)
#show raw.where(block: true): set par(first-line-indent: 0pt)
#show outline: set par(first-line-indent: 0pt)
#show terms: set par(first-line-indent: 0pt)
```

Os templates também configuram recuo para listas e enumerações:

```typst
#set list(indent: 2em, body-indent: 0.5em)
#set enum(indent: 2em, body-indent: 0.5em, full: true, numbering: numeracao-enum("abnt"))
#set terms(indent: 0em, hanging-indent: 2em, separator: [: ])
```

A enumeração padrão (`enumeracao: "abnt"`) usa alíneas (a), b), c)) no primeiro nível e travessão nos seguintes (subalíneas), conforme a NBR 6024:2012. `enumeracao: "latex"` usa 1., a), i), A., como o `enumerate` do LaTeX. Para outra numeração a partir de certo ponto, use `#set enum(numbering: "1.", full: false)`. Também estão disponíveis `#alineas[...]`, `#subalineas[...]` e `numeracao-enum(esquema)`.

Todas essas configurações são aplicadas automaticamente ao usar qualquer template (`normas-abnt`, `artigo`, `relatorio`, etc.). Se estiver montando o documento manualmente sem template, inclua-as no preâmbulo ou use `with-abnt-setup` (ver `setup.typ` abaixo).

=== setup.typ - Configuração Unificada (`with-abnt-setup`)

Reúne as regras comuns a todos os templates (`normas-abnt`, `artigo`, `periodical`, `livro`, `relatorio`, `projeto-pesquisa`): página, fonte, parágrafos, listas, títulos de cinco níveis, legendas, links e notas de rodapé. Quem monta o documento sem template pode aplicá-la direto:

```typst
#let with-abnt-setup(
  fonte: "Times New Roman",     // "Times New Roman", "Arial" ou outra família
  headings-numeracao: "1.1",    // numeração dos títulos
  level-1-pagebreak: true,      // título de nível 1 abre página
  level-1-pagebreak-impar: false, // ... e em página ímpar (frente-verso)
  cor-links: none,              // none = links externos pretos e sublinhados
  enumeracao: "abnt",           // "abnt" ou "latex"
  suplemento-nivel1: "Seção",   // texto de @rótulo de nível 1 ("Seção 1"; "Capítulo" é opção)
  body,
)
```

```typst
#show: with-abnt-setup.with(fonte: "Times New Roman")

= Introdução

Texto do documento.
```

O que ela aplica, além do que as seções anteriores descrevem:

- *Vãos dos títulos.* Antes de um título de nível 1 o vão é de *51,01 pt* (da linha anterior ao título, medido com `level-1-pagebreak: false`), maior que os 42,30 pt do nível 2; os níveis 3 a 5 seguem o nível 2. O título de nível 1 que abre uma página começa no topo da mancha (a primeira linha a 85,31 pt do alto da folha, contra 85,12 pt de um parágrafo comum): o espaço antes dele é fraco e some no topo. Títulos sem indicativo numérico (REFERÊNCIAS, APÊNDICE, ANEXO, GLOSSÁRIO) saem centralizados (NBR 14724:2024, 5.2.3). A segunda linha de um título longo fica sob a primeira letra do título, e não sob o número (NBR 6024:2012, 4.1 j).
- *Título nunca sozinho no pé da página.* Os títulos "grudam" no parágrafo seguinte.
- *Legendas.* Sempre acima da ilustração ou tabela e com travessão: `Figura 1 – Título`; as listas de ilustrações, tabelas e quadros usam o mesmo travessão.
- *Notas de rodapé.* Filete de 5 cm; a segunda linha da nota fica sob a primeira letra do texto (o expoente fica na margem).
- *Tabela longa.* `show figure.where(kind: table): set block(breakable: true)`: uma tabela maior que a página continua nas seguintes. Isso só vale sob `with-abnt-setup` (todos os templates o aplicam); fora dele, `container(tipo: "tabela")` não quebra entre páginas.
- *`@rótulo` de título sem numeração.* Uma regra `show ref` faz `@rótulo` funcionar para `apendice`, `anexo` e `titulo-sem-num`, que o Typst recusaria (`cannot reference styled`/`cannot reference heading without numbering`). Sem `with-abnt-setup`, essas referências dão erro de compilação. Ver `headings.typ`.

=== sorting.typ - Ordenação Alfabética (NBR 6033:1989)

Funções para ordenação alfabética em listas, índices, catálogos e bibliografias. O glossário (`glossario`, `glossario-projeto`, `book-glossary`), a lista de siglas (`lista-siglas`), o índice remissivo (`indice`, `book-index`) e a lista de abreviaturas do livro usam estas funções, portanto ordenam pela NBR 6033: acentos e caixa não contam (`Álgebra` antes de `Zebra`), artigo inicial é ignorado, números vêm antes das letras e valem pelo valor, siglas antecedem palavras iguais (`ASA` antes de `asa`).

*Funções principais:*

```typst
// Remove acentos e sinais diacríticos (Müller → Muller; ç, ø, œ, æ e ß também)
#let remove-accents(text)

// Remove artigo inicial (A, O, The, L'enfant, al-Khwarizmi...)
#let remove-initial-article(text, keep-articles-in-names: false)

// Gera a chave de ordenação (uma string)
#let sort-key(text, ignore-articles: true, keep-articles-in-names: false)

// Letra do cabeçalho de cada grupo de um índice ("A", "M", "0-9")
#let sort-initial(text, ignore-articles: true)

// Ordena lista de textos conforme NBR 6033
#let sort-alphabetically(items, ignore-articles: true, key: none, keep-articles-in-names: false)

// Lista ordenada alfabeticamente
#let alphabetical-list(items, numbered: false, ignore-articles: true)

// Índice alfabético com cabeçalhos de letras
#let alphabetical-index(items, show-letters: true)

// Ordena lista mista (números primeiro, depois letras)
#let sort-mixed(items)
```

*A chave de `sort-key` não é legível.* Ela serve só para comparar: contém códigos de número e um caractere de controle no fim. Não a imprima nem tire a primeira letra dela (para o título de cada grupo, use `sort-initial`). O uso típico é como argumento de `sorted`:

```typst
// Ordem da NBR 6033: números, depois letras; sigla antes de palavra igual
#let ordem = ("Zebra", "Álvaro", "asa", "ASA", "8º", "8", "9").sorted(key: sort-key)
#ordem
// ("8", "8º", "9", "Álvaro", "ASA", "asa", "Zebra")
```

*Exemplo:*

```typst
// Ordenar ignorando artigos
#let lista = ("O gato", "A casa", "Zebra", "Arvore")
#sort-alphabetically(lista)
// Resultado: ("Arvore", "A casa", "O gato", "Zebra")

// Criar índice alfabético
#alphabetical-index((
  ("Algoritmo", 15),
  ("Banco de dados", 23),
  ("Arvore", 18),
))
```

Um item que seja *só* um artigo (`"A"`, `"O"`, `"The"`) é aceito e ordena como está.

*Funções auxiliares exportadas (ver "Funções auxiliares exportadas"):* `compare-strings`, `make-entry`, `sort-homographs`, `extract-number`, `starts-with-number`.

*Constantes de tipos de entrada (para homógrafas):*

```typst
#let entry-types = (
  author-person: 1,    // Autor (nome próprio)
  author-entity: 2,    // Autor (entidade coletiva)
  subject: 3,          // Assunto
  title: 4,            // Título
)
```

*Limites conhecidos* (NBR 6033): a ordem do exemplo 3.6.2 da norma (`A. A. Enterprises`…) não é uma ordem única e não foi reproduzida; `A e B` perde o `A` (artigo em português); `La Rochefoucault` sem vírgula só mantém o artigo com `keep-articles-in-names: true`; `Monte-Alegre` ordena como `montealegre` (o hífen é sinal, 3.6.1).

=== proofreading.typ - Revisão de Originais (NBR 6025:2002)

Sinais e símbolos para revisão de originais e provas. Os sinais da norma (tabelas 1 e 2) são desenhos manuscritos; o pacote os redesenha em traços vetoriais, na cor de cada função (a norma pede cor diferente da do texto). Quando a norma admite mais de um sinal para a mesma correção, só um é implementado (a norma manda optar por um). Não foram desenhados: transpor várias palavras consecutivas (numeração), subscrever, sobrescrever caractere, "colocar no ponto indicado pela seta", as variações da barra de atenção e "evitar sequência de hifens". A ligação entre a marcação no texto e o sinal na margem (3.3) não existe.

*Marcações de texto (tabela 1):*

```typst
// Marcar para suprimir (traço entre dois traços verticais)
#let suprimir(body)

// Suprimir letras: forma "x" (padrão) ou "fi"
#let suprimir-letras(forma: "x")

// Suprimir espaço / retirar e unir
#let suprimir-espaco()
#let retirar-e-unir()

// Marcar para inserção (sinal "V")
#let inserir(body)

// Substituir texto
#let replace-text(old, new)

// Substituir letra (traço inclinado)
#let substituir-letra()

// Indicar transposição de letra, palavra ou trecho / transpor linhas
#let transpose(a, b)
#let transpor-sinal()
#let transpor-linhas()

// Unir (arco em "S") e separar (adicionar espaço)
#let join-space()
#let separate()

// Salto de trecho ("v.o" circulado)
#let see-original()

// Indicar dúvida
#let duvida()

// Manter original (correção indevida; "vale")
#let keep-original(body)
```

*Marcações tipográficas (códigos circulados na margem):*

```typst
// Alterar a tipologia (fonte)
#let mark-typeface(body)

// Marcar para itálico
#let mark-italic(body)

// Marcar para negrito; label: "neg" (padrão) ou "bold"
#let mark-bold(body, label: "neg")

// Marcar para normal; label: "red" (padrão) ou "nom"
#let mark-normal(body, label: "red")

// Caixa alta (maiúsculas)
#let mark-uppercase(body)

// Caixa baixa (minúsculas)
#let mark-lowercase(body)

// Caixa alta e baixa (iniciais maiúsculas)
#let mark-titlecase(body)

// Versal-versalete
#let mark-smallcaps(body)
```

*Marcações de parágrafo e de espaçamento (tabela 2):*

```typst
// Novo parágrafo
#let new-paragraph()

// Centralizar
#let center-text()

// Alinhar à esquerda / à direita
#let align-left()
#let align-right()

// Recorrer texto, abrir e diminuir entrelinha
#let recorrer-texto()
#let abrir-entrelinha()
#let diminuir-entrelinha()

// Evitar brancos entre as linhas, brancos no fim da linha, palavra repetida;
// descondensar o texto
#let evitar-brancos-entre-linhas()
#let evitar-brancos-no-fim-da-linha()
#let evitar-palavra-repetida()
#let descondensar()
```

*Comentários e ambiente de revisão:*

```typst
// Comentário de revisão ao lado do texto / comentário em linha
#let review-note(body, note)
#let inline-comment(comment)

// Documento em revisão: margem direita de 4 cm e entrelinha maior (extensão do pacote)
#let review-mode(body)

// Caixa de anotação na margem, para uso com place() em posição absoluta
#let margin-note(note)

// Legenda dos sinais: primeiro os das tabelas 1 e 2 da norma; no fim, em bloco
// separado, os marcadores de cor, que são extensão do pacote
#let review-legend()
```

*Controle de alterações (extensão do pacote, fora da NBR 6025):*

```typst
// Texto adicionado
#let added(body)

// Texto removido
#let removed(body)

// Texto modificado
#let modified(body)

// Destaque para atenção
#let attention(body)

// Aprovado
#let approved(body)

// Problema
#let problem(body)
```

*Exemplo:*

```typst
O texto foi #suprimir[removido] e #inserir[inserido].

#replace-text("antigo", "novo")

#attention[Este trecho precisa de revisão.]

#review-note[Texto principal][Verificar fonte]

#review-legend()
```

=== identifiers.typ - ISBN e ISSN

Identificadores padrão internacionais conforme NBR ISO 2108:2006 (ISBN) e NBR 10525:2005 (ISSN).

*Funções ISBN:*

```typst
// Calcula dígito verificador ISBN-13
#let isbn-check-digit(digits)

// Valida ISBN-13 (prefixo 978 ou 979 e dígito verificador; outros EAN-13 são recusados)
#let validate-isbn(isbn)

// Valida ISBN-10
#let validate-isbn10(isbn)

// Converte ISBN-10 para ISBN-13 (devolve os 13 dígitos, sem hífens)
#let isbn10-to-isbn13(isbn10)

// Formata ISBN com hífens: grupo + registrante + publicação devem somar 9 dígitos;
// publication-len: auto = o que sobra
#let format-isbn(isbn, group: none, registrant-len: 4, publication-len: auto)

// Exibe ISBN formatado
#let display-isbn(isbn, format: true, product-form: none)

// Bloco de múltiplos ISBN (para ficha catalográfica)
#let isbn-block(isbns)

// Adiciona ISBN a referência
#let ref-isbn(isbn)

// País ou grupo de registro (pelo prefixo: 979-10 é França; 978-65, Brasil)
#let isbn-country(isbn)

// Diz se um texto é ISBN ou ISSN (dicionário type/value/valid)
#let detect-identifier(text)
```

`format-isbn` com grupo, registrante e publicação que não somam 9 dígitos dá erro (por exemplo, `publication-len: 4` com grupo de 2 e registrante de 4). Ela só separa os elementos nos comprimentos dados: a extensão do registrante vem da tabela da Agência do ISBN (anexo D da NBR ISO 2108), que o pacote não tem. Sem `group`, usa o padrão 2-4-3, que pode estar errado para outras editoras.

*Exemplo ISBN:*

```typst
// Validar ISBN
#validate-isbn("978-0-11-000222-4") // true

// Exibir ISBN
#display-isbn("978-85-1234-567-3")
// ISBN 978-85-1234-567-3

#display-isbn("978-85-1234-567-3", product-form: "e-book")
// ISBN 978-85-1234-567-3 (e-book)

// Múltiplos formatos
#isbn-block((
  ("978-85-1234-567-3", "brochura"),
  ("978-85-1234-568-0", "capa dura"),
  ("978-85-1234-569-7", "e-book"),
))
```

*Funções ISSN:*

```typst
// Calcula dígito verificador ISSN
#let issn-check-digit(digits)

// Valida ISSN
#let validate-issn(issn)

// Formata ISSN com hífen (o X do dígito verificador sai em maiúscula)
#let format-issn(issn)

// Exibe ISSN formatado
#let display-issn(issn, format: true)

// Gera meta tag HTML para ISSN online
#let issn-meta-tag(issn)

// Bloco de ISSN (para capa/ficha)
#let issn-block(issn, title-key: none, support: none)

// Múltiplos ISSN (diferentes suportes)
#let issn-multiple(issns)

// Adiciona ISSN a referência
#let ref-issn(issn)
```

*Exemplo ISSN:*

```typst
// Validar ISSN
#validate-issn("0317-8471") // true
#validate-issn("1050-124X") // true (X é dígito verificador válido)

// Exibir ISSN
#display-issn("0317-8471")
// ISSN 0317-8471

// Para publicação online
#issn-meta-tag("0317-8471")
// <META SCHEME="ISSN" NAME="identifier" CONTENT="0317-8471">

// Múltiplos suportes
#issn-multiple((
  ("0100-1965", "impresso"),
  ("1518-8353", "online"),
))
```

*Funções de conveniência para referências:*

```typst
// Em referência de livro
SILVA, Maria. *Manual de normas*. São Paulo: Atlas, 2023. #ref-isbn("978-85-1234-567-3")

// Em referência de periódico
CIÊNCIA DA INFORMAÇÃO. Brasília: IBICT, 1972-. #ref-issn("0100-1965")
```

*Constantes exportadas:* `isbn-groups` e `isbn-groups-979` (dicionários de grupos de registro por prefixo, usados por `isbn-country`).

== Elements (Elementos Pré-textuais)

=== cover.typ - Capa

Cria a capa do trabalho conforme NBR 14724. Todos os parâmetros são opcionais --- se omitidos, são lidos automaticamente do state definido por `dados()`.

```typst
#let capa(
  instituicao: none,  // Nome da instituição
  faculdade: none,    // Faculdade/Unidade
  programa: none,     // Programa/Curso
  autor: none,        // Nome do autor
  titulo: none,       // Título do trabalho
  subtitulo: none,    // Subtítulo (opcional)
  volume: none,       // Número do volume, se houver mais de um (sai "v. N" depois do título)
  local: none,        // Cidade
  ano: none,          // Ano (int ou string)
)
```

*Exemplo com `dados()` (recomendado):*

```typst
// Metadados já definidos via dados() — capa lê do state
#capa()
```

*Exemplo com override parcial:*

```typst
// Título diferente na capa, resto do state
#capa(titulo: "Título Alternativo na Capa")
```

*Exemplo com todos os parâmetros explícitos:*

```typst
#capa(
  instituicao: "Universidade Federal de Jataí",
  faculdade: "Instituto de Ciências Exatas e Tecnológicas",
  programa: "PROFMAT",
  autor: "Cláudio Código",
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  local: "Jataí",
  ano: 2026,
)
```

=== title-page.typ - Folha de Rosto

Cria a folha de rosto conforme NBR 14724. Todos os parâmetros são opcionais --- se omitidos, são lidos do state definido por `dados()`.

```typst
#let folha-rosto(
  autor: none,        // Nome do autor
  titulo: none,       // Título
  subtitulo: none,    // Subtítulo
  natureza: none,     // Natureza do trabalho
  objetivo: none,     // Objetivo (obtenção de grau)
  instituicao: none,  // Instituição
  area: none,         // Área de concentração
  orientador: none,   // Orientador
  coorientador: none, // Coorientador
  volume: none,       // Número do volume (sai "v. N" depois do título)
  local: none,        // Cidade
  ano: none,          // Ano (int ou string)
)
```

Título, subtítulo e natureza saem em 12 pt (a natureza em espaço simples). O título leva os dois-pontos colados e o subtítulo vem na linha seguinte.

*Exemplo com `dados()` (recomendado):*

```typst
// Lê tudo do state
#folha-rosto()
```

*Exemplo com override parcial:*

```typst
// Orientador e área diferentes, resto do state
#folha-rosto(
  orientador: "Prof. Dr. Orientador Alternativo",
  area: "Álgebra Computacional",
)
```

*Ficha catalográfica (verso):*

```typst
#let ficha-catalografica(conteudo)
```

A ficha vai no verso da folha de rosto e *não entra na contagem de páginas* (NBR 14724:2024, 5.3): a página seguinte continua a numeração da folha de rosto. Com `paginacao: "todas"`, a ficha também não recebe número. Efeito em frente-verso: ver a nota em `page.typ`.

*Folha de aprovação (elemento obrigatório, NBR 14724:2024, 4.2.1.3):*

```typst
#let folha-aprovacao(
  autor: none,
  titulo: none,
  subtitulo: none,
  natureza: none,
  objetivo: none,
  instituicao: none,
  area: none,
  data: none,    // data de aprovação (texto); sem ela sai uma linha em branco para preencher
  banca: (),     // membros da banca
)
```

Os dados que faltam vêm de `dados()`. Cada membro de `banca` é um dicionário `(nome:, titulacao:, instituicao:)` ou um texto/conteúdo, e ganha uma linha para a assinatura sob o título "BANCA EXAMINADORA".

```typst
#folha-aprovacao(
  data: "10 de outubro de 2026",
  banca: (
    (nome: "Prof. Dr. Esdras Teixeira Costa", titulacao: "Orientador", instituicao: "UFJ"),
    (nome: "Profa. Dra. Maria Silva", instituicao: "UFG"),
    "Prof. Dr. João Santos (texto livre)",
  ),
)
```

*Errata:* a função `errata(referencia:, itens:)` (definida em `technical-report.typ`, ver "Relatório Técnico") também é exportada por `lib.typ` e funciona num TCC, depois da ficha e antes da folha de aprovação:

```typst
#errata(
  referencia: [SILVA, M. *Título do trabalho*. 2026. 80 f. Dissertação – UFJ, Jataí, 2026.],
  itens: ((pagina: 10, linha: 3, errado: "isto", correto: "aquilo"),),
)
```

=== abstract.typ - Resumo e Abstract

Cria páginas de resumo conforme NBR 6028. Se `palavras-chave` não for passado, lê automaticamente do state definido por `dados()`.

```typst
// Resumo em português (palavras-chave: array ou string única)
#let resumo(conteudo, palavras-chave: none)

// Abstract em inglês
#let resumo-en(conteudo, palavras-chave: none)

// Resumo em outra língua
#let foreign-abstract(
  titulo: "ABSTRACT",
  conteudo: none,
  palavras-chave: (),
  rotulo-palavras-chave: "Keywords",
)

// Página de resumo genérica (resumo e foreign-abstract usam esta)
#let abstract-page(
  titulo: "RESUMO",
  conteudo: none,
  palavras-chave: (),
  rotulo-palavras-chave: "Palavras-chave",
)
```

As palavras-chave saem separadas por ponto e vírgula, com ponto final: `Palavras-chave: formatação; normas ABNT; Typst.` (a capitalização é do autor: o pacote não altera as palavras). O texto do resumo sai em espaço 1,5. O resumo e o abstract abrem no anverso em frente-verso.

*Exemplo com `dados()` (recomendado):*

```typst
// Palavras-chave vêm automaticamente do state
#resumo[
  Texto do resumo...
]

#resumo-en[
  Abstract text...
]
```

*Exemplo com palavras-chave explícitas (override):*

```typst
#resumo(
  palavras-chave: ("ABNT", "Typst", "Formatação"),
)[
  Texto do resumo...
]
```

=== toc.typ - Sumário e Listas

Cria sumário e listas conforme NBR 6027 e NBR 14724. O sumário formata as entradas espelhando o destaque hierárquico dos títulos (NBR 6024:2012, 4.1 j; NBR 14724:2024, 5.4; a NBR 6027:2012 pede que o sumário reproduza o destaque do texto): nível 1 em maiúsculas e negrito, nível 2 em maiúsculas sem negrito, nível 3 em minúsculas e negrito, nível 4 em minúsculas sem negrito, nível 5 em minúsculas e itálico. Os indicativos (`1`, `1.1`, `1.3.1`) ficam na margem e os títulos alinhados numa coluna; títulos sem indicativo (REFERÊNCIAS) começam na coluna dos títulos. As entradas saem em espaço simples (o sumário do TCC cabe numa página) e cada entrada é um único link. As entradas de `parte()` mantêm o formato "Parte 1: Título".

```typst
// Sumário
#let sumario(
  titulo: "SUMÁRIO",
  profundidade: 3,
)

// Sumário com título "SUMÁRIO" fixo, sem os parâmetros de sumario()
#let abnt-outline()

// Lista de ilustrações (tipo: kind das ilustrações; "imagem"/"tabela" ou o tipo
// de um container; aceita uma lista de tipos)
#let lista-ilustracoes(tipo: image, titulo: "LISTA DE ILUSTRAÇÕES")

// Lista de tabelas
#let lista-tabelas()

// Lista de quadros (container(tipo: "quadro"))
#let lista-quadros()

// Lista de abreviaturas e siglas
#let lista-siglas(itens, titulo: "LISTA DE ABREVIATURAS E SIGLAS")  // itens: dicionário sigla -> significado

// Lista de símbolos
#let lista-simbolos(itens)
```

*Exemplo:*

```typst
#sumario()

#lista-ilustracoes()

#lista-tabelas()

#lista-siglas((
  "ABNT": "Associação Brasileira de Normas Técnicas",
  "NBR": "Norma Brasileira",
  "TCC": "Trabalho de Conclusão de Curso",
))
```

*Comportamento:*
- *Listas vazias não saem.* `lista-ilustracoes`, `lista-tabelas`, `lista-quadros`, `lista-siglas` e `lista-simbolos` não imprimem nada (nem o título) quando não há item (a norma torna as listas opcionais, 4.2.1.9). Para as de ilustrações, a consulta vale para o documento inteiro: a lista sai se existir uma ilustração do tipo em qualquer lugar, antes ou depois dela.
- *Uma lista por tipo.* A NBR 14724:2024 (4.2.1.9) pede uma lista própria para cada tipo de ilustração (gráficos, fotografias, mapas...). Com `container(tipo: "grafico", suplemento: "Gráfico", ...)`, use `#lista-ilustracoes(tipo: "grafico", titulo: "LISTA DE GRÁFICOS")`: sai "Gráfico 1 – ..." Outros tipos que não `"imagem"`, `"tabela"` e `"quadro"` exigem o `suplemento:`; sem ele o rótulo sai "Figura" e a numeração se repete (ver `container`).
- *Siglas.* `lista-siglas` imprime em ordem alfabética (NBR 6033, via `sort-key`: sigla acentuada ordena junto da letra sem acento), qualquer que seja a ordem do dicionário. A norma pede uma lista para siglas e outra para abreviaturas (4.2.1.7): `#lista-siglas(titulo: "LISTA DE SIGLAS", (...))` e `#lista-siglas(titulo: "LISTA DE ABREVIATURAS", (...))`. A primeira menção da sigla no texto, por extenso, não tem apoio no pacote.
- *Símbolos.* `lista-simbolos` mantém a ordem do dicionário (a norma manda a ordem de aparição no texto, 4.2.1.12). As chaves são texto; para símbolos matemáticos como chave use `book-list-symbols`, que recebe pares `($alpha$, "descrição")`.

== Text (Elementos Textuais)

=== headings.typ - Seções e Subseções

Formata títulos de seção conforme NBR 6024.

*Formatação automática:*

```typst
// Aplica formatação ABNT aos headings (regras antigas; os templates usam with-abnt-setup)
#let with-abnt-headings(body)

// Alias de with-abnt-headings; recebe body (#show: abnt-heading-setup)
#let abnt-heading-setup(body)
```

`with-abnt-headings` e `abnt-heading-setup` aplicam só a hierarquia abaixo. Os templates usam as regras de `with-abnt-setup` (ver `setup.typ`), que também centralizam os títulos sem indicativo numérico, mantêm a segunda linha do título sob a primeira letra e impedem título sozinho no pé da página; essas três regras não estão em `with-abnt-headings`.

A formatação segue a hierarquia:

#table(
  columns: (auto, auto, auto),
  stroke: none,
  inset: 6pt,
  table.hline(stroke: 1pt),
  [*Nível*], [*Formato*], [*Exemplo*],
  table.hline(stroke: 0.5pt),
  [1 (Seção)], [MAIÚSCULAS, negrito], [*1 INTRODUÇÃO*],
  [2], [MAIÚSCULAS, normal], [1.1 CONTEXTO],
  [3], [Minúsculas, negrito], [*1.1.1 Histórico*],
  [4], [Minúsculas, normal], [1.1.1.1 Período inicial],
  [5], [Minúsculas, itálico], [_1.1.1.1.1 Detalhes_],
  table.hline(stroke: 1pt),
)

*Uso:*

```typst
= Introdução           // Nível 1
== Contexto            // Nível 2
=== Histórico          // Nível 3
==== Detalhes          // Nível 4
===== Mais detalhes    // Nível 5
```

A NBR 6024:2012 (4.1 b) manda limitar a numeração progressiva à seção quinária (cinco níveis). O pacote não recusa níveis a mais (`=======` sai como `1.1.1.1.1.1.1`), mas isso contraria a norma.

Vãos: o título de nível 1 tem 51,01 pt antes dele e abre a página no topo da mancha; o de nível 2, 42,30 pt (detalhes em `setup.typ`).

*Seção sem numeração:*

```typst
// Para Referências, Glossário e demais títulos sem indicativo numérico (secao = alias de titulo-sem-num).
// Introdução e Conclusão são seções primárias numeradas (NBR 14724:2024, 4.2.2): use `= Introdução`
#let titulo-sem-num(titulo, nivel: 1)

// Apêndice (elaborado pelo autor) e anexo (documento externo): título sem indicativo
// numérico, "APÊNDICE A – TÍTULO", no sumário; a letra é dada por você
#let apendice(letra, titulo)
#let anexo(letra, titulo)

// Glossário: título "GLOSSÁRIO" e termos em ordem alfabética (NBR 6033);
// quebra: false dentro de columns/block, onde o Typst não aceita quebra de página
#let glossario(itens, quebra: true)

// Título pré-textual (não aparece no sumário)
#let pretextual-title(titulo)
```

*`@rótulo` de título sem numeração.* Com `with-abnt-setup` (todos os templates e `normas-abnt`), `@rótulo` funciona para `apendice`, `anexo` e `titulo-sem-num` e vira um link: "Apêndice A", "Anexo B"; `titulo-sem-num` produz "Seção Título" (não há número). Sem `with-abnt-setup`, essas referências dão erro de compilação (o Typst recusa referência a título sem numeração):

```typst
#apendice("A", "Questionário aplicado") <apendice-a>
#anexo("A", "Norma citada") <anexo-a>

Veja o @apendice-a e o @anexo-a.
```

`glossario(itens)` recebe um dicionário termo → definição: `#glossario(("Algoritmo": "Sequência finita de instruções."))`.

*Alíneas, subalíneas e partes:*

```typst
// Alíneas a), b), c) (já é o padrão de normas-abnt; força o formato em um trecho)
#let alineas(body)

// Subalíneas com travessão
#let subalineas(body)

// Parte (Parte N: Título), em página própria, no sumário; @rótulo => "Parte 1"
#let parte(titulo)
```

=== quotes.typ - Citações

Formata citações conforme NBR 10520.

*Citação direta curta (até 3 linhas):*

```typst
#let citacao-curta(autor: none, ano: none, pagina: none, volume: none, localizacao: none, grifo: none, traducao: none, ..args)
```

Aceita parâmetros posicionais (autor, ano, página) ou nomeados. Os parâmetros `ano` e `pagina` aceitam int (sem aspas) ou string. Os demais são nomeados e entram, nesta ordem, no fim da chamada: `volume` (`v. 2`), `localizacao` (fontes não paginadas: `cap. V, art. 49`), `traducao` (`tradução nossa`) e `grifo` (`grifo nosso`).

*Exemplos:*
```typst
// Posicional (ano e página sem aspas)
#citacao-curta("Silva", 2023, 42)[a formatação adequada é essencial].

// Nomeado
#citacao-curta(autor: "Silva", ano: 2023, pagina: 42)[a formatação adequada é essencial].

// Intervalo de páginas (string)
#citacao-curta("Silva", 2023, "42-43")[texto].

// Sem referência
#citacao-curta()[sic transit gloria mundi]

// Com .bib: autor é um <chave> — cita de verdade (entra na bibliografia,
// vira link clicável). ano vem do .bib; use pagina: nomeado.
#citacao-curta(<silva2023>, pagina: 42)[a formatação adequada é essencial].
```

*Citação direta longa (mais de 3 linhas):*

```typst
#let citacao-longa(autor: none, ano: none, pagina: none, volume: none, localizacao: none, grifo: none, traducao: none, ..args)
```

Mesma flexibilidade de parâmetros (recuo de 4 cm, fonte de 10 pt, espaço simples, sem aspas):

*Exemplos:*
```typst
// Posicional
#citacao-longa("Silva", 2023, "42-43")[
  Texto longo da citação...
]

// Nomeado
#citacao-longa(autor: "Silva", ano: 2023)[
  Texto longo da citação...
]

// Com .bib: autor é um <chave> — mesma integração de citacao-curta acima.
#citacao-longa(<silva2023>, pagina: "42-43")[
  Texto longo da citação...
]
```

*Grifo e tradução (NBR 10520:2023, 7.1.5 e 7.1.6):* o trecho destacado por quem cita leva a indicação, ao fim da chamada, `grifo nosso` ou `grifo próprio`; a tradução, `tradução nossa` ou `tradução própria`. O destaque em si é feito com `grifo-nosso[...]` (itálico); a indicação sai por `grifo:` na função de citação:

```typst
#citacao-curta("Souto", 1916, 46, grifo: "nosso")[A #grifo-nosso[clareza] é essencial].
// “A clareza é essencial” (Souto, 1916, p. 46, grifo nosso).
```

Quando o texto transcrito já traz o destaque, a edição de 2023 diz que não há necessidade de informar o grifo; a expressão "grifo do autor" é da edição de 2002.

*Citações indiretas (ano e pagina aceitam int ou string):*

```typst
// Citação com autor no texto: "Segundo Silva (2023)..."
#let citar-autor(autor: none, ano: none, pagina: none, volume: none, ..args)

// Citação com autor fora do texto: "... (Silva, 2023)"
#let citar(autor: none, ano: none, pagina: none, volume: none, localizacao: none, grifo: none, traducao: none, ..args)

// Citação de citação (apud)
#let citar-apud(autor-original: none, ano-original: none, autor-secundario: none, ano-secundario: none, pagina-original: none, pagina: none, ..args)
```

*Elementos especiais:*

```typst
// Supressão de texto: [...]
#let supressao

// Interpolação: [texto adicionado]
#let interpolacao(texto)

// Destaque em itálico de trecho da citação ("grifo nosso"/"grifo próprio");
// a indicação final sai por `grifo:` em citacao-curta/citacao-longa/citar
#let grifo-nosso(texto)

// Mesmo itálico, para o destaque que já existia no original (mantida por compatibilidade;
// a edição 2023 da norma dispensa a indicação "grifo do autor")
#let grifo-do-autor(texto)
```

`grifo-nosso` e `grifo-do-autor` só aplicam o itálico: não imprimem a expressão "grifo nosso".

=== figures.typ - Container, Imagem, Quadro e Ilustrações

Formata figuras, quadros e ilustrações conforme NBR 14724 e IBGE.

```typst
// Container genérico (única forma de criar um figure ABNT)
// A legenda é inferida do tipo: "imagem"→"Figura", "tabela"→"Tabela", "quadro"→"Quadro"
// Backward-compat: aceita também os tipos nativos `image` e `table`
#let container(
  body,              // Conteúdo (imagem, quadro, tabela, etc.)
  legenda: none,     // Título (aparece acima)
  fonte: auto,       // OBRIGATÓRIA: Fonte (aparece abaixo); `origem` também é aceito; `fonte: none` dispensa
  origem: none,      // (alias antigo de `fonte`)
  nota: none,        // Nota explicativa (aparece abaixo da fonte)
  tipo: "imagem",    // Tipo: "imagem", "tabela", "quadro" (aceita também image, table, ou outro: ver abaixo)
  suplemento: auto,  // Inferido do tipo (ou definido manualmente)
  posicao: "aqui",   // "aqui" (fixo), "topo", "fundo" ou "auto" (flutuante)
  ..args,            // Repassados ao figure()
)

// Wrapper para image() em português
#let imagem(
  caminho,           // Arquivo como bytes: read("x.png", encoding: none) (string é recusada)
  largura: auto,     // Largura (auto, relative, fraction)
  altura: auto,      // Altura (auto, relative, fraction)
  ajuste: "cobrir",   // Modo de ajuste: "cobrir", "conter", "esticar"
  alternativo: none,  // Texto alternativo (acessibilidade)
  pagina: auto,      // Página do PDF a extrair (auto = não repassa; usa a primeira)
  formato: auto,     // Formato: auto, "png", "jpg", "gif", "svg", "pdf"
  escala: auto,      // Escala de renderização (SVG)
  icc: auto,         // Perfil de cor ICC
  ..outros,          // Parâmetros adicionais repassados a image()
)

// Quadro: tabela textual com bordas fechadas (wrapper para table())
#let quadro(..args)

// Fonte da figura (para uso avulso)
#let fonte(conteudo)

// Nota da figura (para uso avulso)
#let nota-figura(conteudo)

// Configuração de figuras (legenda de 10 pt, figura centralizada); recebe body
#let abnt-figure-setup(body)
```

*A fonte é obrigatória* (NBR 14724:2024, 5.8; IBGE 4.2), inclusive em produção própria (`fonte: [Elaborado pelo autor (2026).]`). Sem `fonte:` (nem `origem:`), `container()` aborta a compilação com uma mensagem em português; para não imprimir fonte, passe `fonte: none` de propósito. "Fonte:" e "Nota:" saem alinhadas à esquerda da ilustração.

*Outros tipos de ilustração.* Além de `"imagem"`, `"tabela"` e `"quadro"`, `tipo` aceita qualquer nome (`"grafico"`, `"mapa"`), mas então é preciso dar o `suplemento:`: sem ele o rótulo sai "Figura" e a numeração do tipo é própria, e podem sair dois "Figura 2". Com `suplemento: "Gráfico"` sai "Gráfico 1". Para listá-los, `lista-ilustracoes(tipo: "grafico", titulo: "LISTA DE GRÁFICOS")`. Os quadros têm `lista-quadros()`.

*Exemplo — Figura:*

```typst
#container(legenda: [Comparação de desempenho], fonte: [Elaborado pelo autor (2026).])[
  #imagem(read("grafico.png", encoding: none), largura: 80%)
]
```

*Exemplo — Quadro:*

```typst
#container(legenda: [Glossário de termos], tipo: "quadro", fonte: [Elaborado pelo autor.])[
  #quadro(columns: 2,
    [*Termo*], [*Definição*],
    [Algoritmo], [Sequência finita de instruções],
  )
]
```

*Exemplo — Gráfico (outro tipo):*

```typst
#container(legenda: [Evolução anual], tipo: "grafico", suplemento: "Gráfico", fonte: [Elaborado pelo autor.])[
  #imagem(read("grafico.png", encoding: none), largura: 60%)
]
```

=== tables.typ - Tabelas

Formata tabelas conforme IBGE e NBR 14724.

```typst
// Tabela IBGE (sem bordas laterais) — usar dentro de container()
// moldura: desenha os 3 traços horizontais da IBGE 4.3.1 e repete o cabeçalho
// continuacao: "(continua)", "(continuação)", "(conclusão)" em tabela de várias páginas
#let tabela(moldura: true, continuacao: true, ..args)

// Nota de tabela
#let nota-tabela(conteudo)

// Sinais convencionais (IBGE 4.8.1) e a nota que os explica (4.8.2)
#let sinal-convencional(tipo, casas: 0)
#let nota-sinais(..tipos)

// Configuração de tabelas (centralizada); recebe body
#let abnt-table-setup(body)
```

*Exemplo de tabela IBGE:* sem `table.hline`, a primeira linha vira o cabeçalho (repetido em cada página) e a função desenha os três traços da IBGE (topo 1,5 pt, abaixo do cabeçalho 0,75 pt e fecho 1,5 pt); as bordas laterais não existem:

```typst
#container(
  legenda: [Complexidade dos algoritmos de ordenação],
  tipo: "tabela",
  fonte: [Adaptado de Cormen et al. (2012).],
)[
  #tabela(
    columns: 3,
    [*Algoritmo*], [*Melhor caso*], [*Pior caso*],
    [Quicksort], [O(n log n)], [O(n²)],
    [Mergesort], [O(n log n)], [O(n log n)],
    [Heapsort], [O(n log n)], [O(n log n)],
  )
]
```

Se você escreve os traços com `table.hline`, vale o que desenhou e a moldura automática não é aplicada (as espessuras 1,5 pt e 0,75 pt acima são escolha do pacote; a IBGE não fixa espessura):

```typst
#container(
  legenda: [Complexidade dos algoritmos de ordenação],
  tipo: "tabela",
  fonte: [Adaptado de Cormen et al. (2012).],
)[
  #tabela(
    columns: 3,
    table.hline(stroke: 1.5pt),
    [*Algoritmo*], [*Melhor caso*], [*Pior caso*],
    table.hline(stroke: 0.75pt),
    [Quicksort], [O(n log n)], [O(n²)],
    [Mergesort], [O(n log n)], [O(n log n)],
    table.hline(stroke: 1.5pt),
  )
]
```

*Tabela de várias páginas.* Uma tabela maior que a página continua nas páginas seguintes (isso só vale sob `with-abnt-setup`, que todos os templates aplicam; fora dele, `container(tipo: "tabela")` não quebra). Com a moldura, o cabeçalho se repete, o traço de fecho só vem na última página, e abaixo do corpo e à direita aparecem "(continua)", "(continuação)" e "(conclusão)" (os parênteses são convenção do pacote; a IBGE, 8.3, não os exige). O último `table.hline` escrito por você, se vier depois de todas as linhas, também só sai na última página. Tabela de uma página não recebe palavra.

*Limites:* (1) com `table.hline` à mão e *sem* `table.header`, o traço inicial reaparece no alto das páginas seguintes, sem o cabeçalho (o cabeçalho só se repete com `table.header` ou com a moldura automática); (2) se o fim da tabela cair exatamente no pé de uma página, a última página pode mostrar "(continuação)"; (3) as chamadas numeradas em destaque (IBGE 4.9) e as notas específicas na ordem das chamadas (4.12.2) ficam por conta do autor; (4) o `quadro` (kind `"quadro"`) não recebe estas regras.

*Sinais convencionais.* `sinal-convencional` devolve o texto do sinal para a célula; `nota-sinais` monta a nota geral:

```typst
#container(
  legenda: [Produção por região],
  tipo: "tabela",
  fonte: [IBGE (2023).],
  nota: nota-sinais("zero", "nao-disponivel"),
)[
  #tabela(
    columns: 2,
    [*Região*], [*Produção*],
    [Norte], [#sinal-convencional("zero")],
    [Sul], [#sinal-convencional("nao-disponivel")],
  )
]
```

Os tipos são `"zero"` (`-`), `"nao-se-aplica"` (`..`), `"nao-disponivel"` (`...`), `"omitido"` (`X`), `"arredondado-positivo"` (`0`, `0,0`, `0,00`, conforme `casas:`) e `"arredondado-negativo"` (`-0`, `-0,0`, `-0,00`).

=== math.typ _(removido)_

As funções matemáticas em português (`sen`, `frac`, `binomio`, `raiz`, `exibicao`, `em-linha`, `subscrito`, `sub-subscrito`) foram movidas para o *ferrmat*, o pacote companheiro do ABNTyp. Consulte a documentação do ferrmat em `src/matematica.typ`.

== References (Referências)

=== bibliography.typ - Bibliografia Automática

Integração com arquivos `.bib` para formatação automática de referências.

```typst
// Bibliografia com formatação ABNT
#let abnt-bibliography(
  arquivo,                      // Conteúdo do .bib: read("referencias.bib")
  titulo: "REFERÊNCIAS",        // Título da seção
  completa: false,              // true: todas as obras do .bib; false: só as citadas
)

// Versão simplificada
#let referencias(arquivo, titulo: "REFERÊNCIAS", completa: false)

// Mantida só por compatibilidade: não faz nada (devolve o corpo)
#let abnt-cite-setup(body)
#let configurar-citacoes-abnt = abnt-cite-setup  // alias em português
```

O parâmetro `completa` (e não `full`, que é o nome do `bibliography()` nativo) decide entre listar todas as obras do `.bib` ou só as citadas. As referências saem em espaço simples, alinhadas à margem esquerda, *sem recuo*, sem justificar, com uma linha em branco entre elas (NBR 6023:2018, 6.3); o idioma é fixado em pt-BR ("Acesso em", "(ed.)").

*Uso com citações:*

```typst
// No texto, use a sintaxe padrão do Typst:
Conforme @silva2023, a metodologia é importante.
Outros autores @santos2022[p. 45] concordam.

// No final do documento:
#abnt-bibliography(read("referencias.bib"))
```

O estilo ABNT das citações `@chave` vem do `bibliography(style: "abnt.csl")` que `abnt-bibliography`/`referencias` declaram (ou `arquivo-bibliografia` de `normas-abnt` e dos demais templates): sem uma delas no documento, `@chave` não sai no estilo ABNT. `abnt-cite-setup` (e `configurar-citacoes-abnt`) é um no-op desde a 0.1.4: `#show: abnt-cite-setup` não muda nada e pode ser omitido.

Com `normas-abnt(arquivo-bibliografia: read("referencias.bib"))`, a seção REFERÊNCIAS é gerada automaticamente no fim do documento --- nesse caso não chame `abnt-bibliography`/`referencias` novamente.

*Como codificar o `.bib`.* O Typst não lê todos os campos do BibTeX, então algumas entradas precisam de uma forma específica (o `examples/referencias.bib` tem um modelo de cada):

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: 6pt,
  table.hline(stroke: 1pt),
  [*Tipo*], [*Como escrever*],
  table.hline(stroke: 0.5pt),
  [`@book`], [Livros: `edition`, `publisher`, `address`, `year`.],
  [`@article`], [Artigos de periódico: `journal`, `volume`, `number`, `pages`.],
  [`@inbook`], [Capítulo de livro: `booktitle` e `editor`. Não use `@incollection`: perde o "In:" e o título da obra.],
  [`@thesis`, `@phdthesis`, `@mastersthesis`], [`publisher` (a instituição; não `school`/`institution`) e `type` completo, por exemplo `type = {Tese (Doutorado em Física)}`.],
  [`@inproceedings`], [Trabalho em evento: `booktitle = {Anais}`, `eventtitle`, `venue`, `eventdate`, `publisher`. O evento sai em maiúsculas e o "Anais" ganha "[...]".],
  [`@online`, `@webpage`], [Documentos eletrônicos: `url`, `urldate`.],
  [`@techreport`], [Relatórios técnicos e normas: `publisher` no lugar de `institution`.],
  table.hline(stroke: 1pt),
)

- *Subtítulo:* o campo `subtitle` é *descartado* pelo Typst. Escreva `title = {Título: subtítulo}`; título e subtítulo saem juntos em negrito (limitação do formato CSL).
- *Entidade como autor:* caixa mista no `.bib` (`{{Organização Mundial da Saúde}}`); a lista de referências põe em maiúsculas sozinha.
- *Obra sem autoria:* a 1ª palavra do `title` em MAIÚSCULAS e `shorttitle = {Primeira palavra [...]}` para a chamada no texto (`Anteprojeto [...]`, 1987); sem `shorttitle` a chamada sai com o título inteiro.
- *Mesmo sobrenome e ano:* o estilo desambigua por iniciais, `(Barbosa, C., 1958)`, no Typst 0.13 e 0.14; no 0.15 cai no sufixo `1958a`/`1958b`.
- *Ordenação:* nos Typst 0.13 e 0.14, nomes que começam por letra acentuada vão para depois do Z; o 0.15 ordena certo.
- *Tese no Typst 0.13:* o campo `type` é descartado pelo próprio compilador (sai sem `Tese (Doutorado…)`).
- *Sem suporte:* legislação, jurisprudência, atos administrativos e documentos de cartório (NBR 6023, 7.11) não têm campos no Typst: escreva a referência à mão. Data incerta (`[s. d.]`, `c1993`, `[197-]`) e `[S. l.: s. n.]` em fotografia, blog ou carta também não são bem tratadas.

=== citation.typ - Citações e Referências

*Forma padrão é `@chave` (com `.bib`).* Em todas as funções abaixo, `ano`,
`pagina`, `volume` etc. aceitam int ou string.

*Auxiliares integrados ao `.bib` (parte da forma padrão, não fallback):*

```typst
// Autor na frase, página posicional opcional — "Silva (2023, p. 45)"
// Para 2–3 autores troca sozinha o ";" do Typst pelo "e" da sentença
// (Lima e Serrano (2024); Cruz, Correa e Costa (1998)). O `@chave` e o
// `#cite(<chave>, form: "prose")` nativos NÃO fazem essa troca: use `pag`.
// autor: (opcional) só para outra grafia da frase. O ano vem do .bib.
#let pag(chave, autor: none, ..args)   // #pag(<lima2024>)  ->  Lima e Serrano (2024)

// Citação de citação (apud): fonte consultada é chave do .bib;
// a original (não acessada) vai como texto. Página posicional opcional.
#let apud(autor-original, ano-original, chave-consultada,
          pagina-original: none, ..args)   // #apud("Freire", 1994, <silva2023>, 25)
```

*Fallback — autor-data manual (obra fora do `.bib`), COM integração `.bib`:*

`citar`, `citar-autor`, `citar-indireto`, `citar-entidade`, `citar-titulo` e
`citar-apud` recebem autor/entidade/título como *texto* — modo fallback para
obras que não estão num `.bib`. Mas também aceitam um `<chave>` de entrada
`.bib` nesse mesmo argumento: nesse caso a função delega para `#cite()`
nativo, autor/ano vêm do `.bib` (`ano`/`ano-secundario` são ignorados), a
citação entra automaticamente na bibliografia e o texto renderizado vira link
clicável — sem precisar de `pag`/`apud`. Use `pagina:` nomeado (não
posicional) nesse modo, já que o 2º argumento posicional é sempre
interpretado como `ano`:
```typst
#citar(<silva2023>, pagina: "45")            // -> (Silva, 2023, p. 45), citado no .bib
#citar-autor(<silva2023>, pagina: "45")      // -> Silva (2023, p. 45), citado no .bib
#citar-apud("Freire", 1994, <silva2023>, pagina: "25")  // fonte consultada = .bib
```

```typst
// Entre parênteses — (Silva, 2023, p. 45). volume/localizacao para
// fontes paginadas por v./t. ou não paginadas; traducao e grifo no fim, nesta
// ordem: "tradução nossa, grifo nosso" (NBR 10520:2023, 7.1.5 e 7.1.6).
// grifo: "nosso" ou "próprio"; traducao: "nossa" ou "própria".
// autor aceita <chave> do .bib (ver acima).
#let citar(autor: none, ano: none, pagina: none, volume: none,
           localizacao: none, grifo: none, traducao: none, ..args)

// Autor na sentença — "Silva (2023, p. 45)". autor aceita <chave> do .bib.
#let citar-autor(autor: none, ano: none, pagina: none, volume: none, ..args)

// Citação indireta (paráfrase) — página opcional (NBR 10520:2023, 7.2)
// autor aceita <chave> do .bib.
#let citar-indireto(autor: none, ano: none, pagina: none, ..args)

// Citação de citação (apud) com strings — página da fonte original e consultada.
// autor-secundario (fonte CONSULTADA) aceita <chave> do .bib.
#let citar-apud(autor-original: none, ano-original: none, autor-secundario: none,
                ano-secundario: none, pagina-original: none, pagina: none, ..args)

// Entidade coletiva. entidade aceita <chave> do .bib.
#let citar-entidade(entidade: none, ano: none, pagina: none, ..args)

// Obra sem autoria (pelo título). titulo aceita <chave> do .bib.
#let citar-titulo(titulo: none, ano: none, pagina: none, ..args)
```

Os parâmetros dessas funções são nomeados e *também posicionais*: `..args` recebe, na ordem, `autor` e `ano` dados sem nome (`#citar("Silva", 2023, pagina: 45)`); com `<chave>` do `.bib` use `pagina:` nomeado.

*Fallback — autor-data manual (SEM integração `.bib`):*

`citar-multiplos`, `citar-varios` e `citar-etal` continuam string-only — o
caso de uso delas (múltiplos autores de uma obra, várias obras simultâneas,
et al.) já é coberto automaticamente pela sintaxe nativa `@chave` com o CSL
ABNT do pacote quando há `.bib`: `@silva2023@santos2022` sai
`(Santos, 2022; Silva, 2023)` e uma obra de 4 ou mais autores sai
`(Cormen et al., 2012)`.

```typst
// Vários autores de uma MESMA obra (até 3) — (Silva; Santos; Costa, 2023)
#let citar-multiplos(autores, ano, pagina: none)

// Várias OBRAS simultâneas — (Fonseca, 1997; Paiva, 1997; Silva, 1997)
// Ordena por autor (NBR 10520:2023, 6.1.8) e junta os anos do mesmo autor:
// (Dreyfuss, 1989, 1991, 1995; Paiva, 1997). Nomes começando por letra
// acentuada vão para depois do Z (limite do Typst).
#let citar-varios(obras)   // lista de (autor, ano) ou (autor, ano, pagina)

// Mais de 3 autores (et al.)
#let citar-etal(primeiro-autor, ano, pagina: none)
```

*Notas de referência abreviadas (NBR 10520:2023, 8.1.2).* Para notas de rodapé do sistema autor-data (não use com o sistema numérico, 6.2.2). A primeira citação da fonte leva a referência completa na nota (8.1.1); as seguintes podem ser abreviadas com as funções abaixo, que devolvem o texto da nota já terminado em ponto. O autor sai em maiúsculas; `pagina` vira "p. X" e `localizacao` entra como foi escrita:

```typst
// Idem (mesma autoria, documento diferente) — Id., 2006, p. 12.
#let citar-id(ano, pagina: none, localizacao: none)

// Ibidem (mesmo documento da nota anterior) — Ibid., p. 52.
#let citar-ibid(pagina: none, localizacao: none)

// Opus citatum — MINAYO, op. cit., p. 23.
#let citar-opcit(autor, pagina: none, localizacao: none)

// Loco citato — SHAKESPEARE, loc. cit.
#let citar-loccit(autor)

// Passim — BECHARA, 2009, passim.
#let citar-passim(autor, ano)

// Conferre — Cf. BECHARA, 2009, p. 337.
#let citar-cf(autor, ano, pagina: none, localizacao: none)

// Sequentia — FARIA, 1994, p. 17 et seq.
#let citar-etseq(autor, ano, pagina)

// Remissão à nota anterior — FARIA, ref. 8, p. 15.
#let citar-ref(autor, nota, pagina: none, localizacao: none)
```

```typst
Texto com chamada de nota.#footnote[#citar-ibid(pagina: 52)]
Outra chamada.#footnote[#citar-opcit("Minayo", pagina: 23)]
```

*Atenção:* a norma só permite `Id.`, `Ibid.` e `op. cit.` na *mesma página* da citação a que se referem, e `op. cit.` não pode ser usada quando há duas obras do mesmo autor na página (8.1.2.2). O pacote *não* verifica isso: as notas completas são escritas à mão e ele não sabe em que página caiu a anterior. Confira no PDF e, se a nota anterior ficou em outra página, repita a chamada abreviada (`MINAYO, 2021, p. 54.`) em vez de usar a expressão latina.

*Formatação manual de referências (`ano`, `edicao`, `volume`, `numero` aceitam int).* O autor vem como "Sobrenome, Prenome" (vários: "Silva, A.; Santos, B."); só o último sobrenome sai em maiúsculas (`LUCK, Heloisa.`), e entidade (sem vírgula) sai toda em maiúsculas. Faltando local e editora, sai `[S. l.: s. n.]`. As referências saem em espaço simples, alinhadas à margem esquerda (sem recuo), separadas da seguinte por uma linha em branco. O título da seção sozinho vem de `referencias-titulo()` (alias `ref-titulo`). Para referências em lote, prefira o `.bib` (`abnt-bibliography`):

```typst
// Livro
#let ref-livro(
  autor: none,
  titulo: none,
  subtitulo: none,
  edicao: none,    // int ou string
  local: none,
  editora: none,
  ano: none,       // int ou string
)

// Artigo de periódico
#let ref-artigo(
  autor: none,
  titulo: none,
  revista: none,
  local: none,
  volume: none,
  numero: none,
  paginas: none,
  mes: none,
  ano: none,
)

// Documento eletrônico
#let ref-online(
  autor: none,
  titulo: none,
  site: none,
  ano: none,
  url: none,
  data-acesso: none,
)
```

=== numeric.typ - Sistema Numérico de Citações

A NBR 10520:2023 admite dois sistemas de chamada: autor-data (acima) e numérico (seção 6.2). No numérico, as obras recebem números arábicos consecutivos, na ordem da primeira citação; a mesma obra repete o mesmo número, a numeração não reinicia a cada página, e a lista de referências no fim segue a ordem de citação. O formato é `(15, p. 34)` ou em expoente (`¹⁵, p. 34`). *O sistema numérico não pode ser usado quando houver notas* (6.2.2): o pacote não impede nem avisa se houver `#footnote` no documento.

As chaves são *textos* (`"silva2023"`), não `<rótulos>` do `.bib`: este sistema não lê o `.bib`; as referências são dadas à mão em `bibliografia-numerica`.

```typst
// Estilo e delimitador do documento (#show: citacao-num-config); reinicia a numeração.
// estilo: "parentheses" (1) ou "superscript" (expoente); colchetes: "()" ou "[]"
#let citacao-num-config(estilo: "parentheses", colchetes: "()", body)

// Citação numérica simples: (1) ou (1, p. 45)
#let citar-num(chave, pagina: none, volume: none, estilo: auto, colchetes: auto)

// Com o autor na frase: Segundo Silva (1, p. 45)
#let citar-num-linha(chave, pagina: none, volume: none, estilo: auto, colchetes: auto)

// Várias obras de uma vez: (1, 2, 3)
#let citar-num-multiplos(chaves, estilo: auto, colchetes: auto)

// Citação de citação: o 1º argumento é o TEXTO da fonte original (não acessada),
// o 2º é a chave da fonte consultada: (Freire, 1994, p. 13 apud 5, p. 25)
#let citar-num-apud(chave-original, chave-consultada, pagina-original: none, pagina-consultada: none, estilo: auto, colchetes: auto)

// Citação direta curta (entre aspas) e longa (recuo de 4 cm, 10 pt, espaço simples), com o número
#let citacao-num-curta(chave, pagina: none, estilo: auto, colchetes: auto, body)
#let citacao-num-longa(chave, pagina: none, estilo: auto, colchetes: auto, body)

// Lista de referências na ordem de citação: itens = ((chave, conteúdo), ...)
#let bibliografia-numerica(itens, titulo: "REFERÊNCIAS")
```

*Mudança da 0.7.0:* em `citar-num-apud` o primeiro argumento passa a ser o *texto* da chamada original (`"Freire, 1994"`), não uma chave; só a fonte consultada recebe número e vai para a lista (NBR 10520:2023, 7.3). `citacao-num-config` agora aplica de fato o `estilo` e os `colchetes` a todas as funções `citar-num-*` (a menos que a chamada traga os seus), `citar-num-multiplos` sai `(2, 8, 9)` e o número da mesma obra não se repete.

```typst
#show: normas-abnt.with()
#show: citacao-num-config

= Introdução

A metodologia segue estudos anteriores #citar-num("silva2023"), em linha com
#citar-num("santos2022", pagina: "45"). Segundo Silva #citar-num-linha("silva2023", pagina: "78"),
o resultado é consistente; vários autores concordam #citar-num-multiplos(("silva2023", "santos2022")).

Freire afirmou o contrário #citar-num-apud("Freire, 1994", "streck2017", pagina-original: "13", pagina-consultada: "25").

#bibliografia-numerica((
  ("silva2023", [SILVA, J. *Título do livro*. São Paulo: Editora, 2023.]),
  ("santos2022", [SANTOS, M. Artigo importante. *Revista*, v. 1, 2022.]),
  ("streck2017", [STRECK, L. *Hermenêutica*. Porto Alegre: Livraria do Advogado, 2017.]),
))
```

*Utilitários:*

```typst
// Referência numerada individual, para montar a lista à mão
#let ref-numerica(num, conteudo)

// Aviso pronto de que o sistema numérico não admite notas de rodapé
#let aviso-sistema-numerico()

// Número atribuído a uma chave ("?" se ainda não citada) e total de obras citadas até aqui
#let get-citation-number(chave)
#let get-citation-count()

// Reinicia a numeração (por exemplo, em livros com partes independentes)
#let reset-numeric-citations()
```

`citar-num-linha` é idêntica a `citar-num` (mantida por compatibilidade). A entrelinha das citações longas e da lista é simples.

== Templates

Nos blocos `.with(…)` desta seção, os valores são *exemplos*, não os padrões do código. Alguns padrões que diferem do que o bloco mostra: `ano` vale o ano de hoje (`datetime.today().year()`) em `livro`, `periodical`, `relatorio` e `projeto-pesquisa`; `cabecalho` de `livro` vale `none`; `fonte` vale `"Times New Roman"` (`"Arial"` em pôsteres e slides); `autores` e `palavras-chave` valem listas vazias. Os parâmetros omitidos de um bloco valem o padrão do código-fonte (`grep "#let nome(" src/`).

=== thesis.typ - Tese/Dissertação/TCC

Template completo para trabalhos acadêmicos. Os metadados são definidos separadamente com `dados()`:

```typst
// 1. Metadados
#show: dados.with(
  titulo: "Título do Trabalho",
  subtitulo: none,
  autor: "Nome do Autor",
  instituicao: "Universidade Federal",
  faculdade: "Instituto/Faculdade",
  programa: "Programa de Pós-Graduação",
  local: "Cidade",
  ano: 2026,
  natureza: "Dissertação apresentada ao...",
  objetivo: "como requisito parcial para...",
  area: "Área de Concentração",
  orientador: "Prof. Dr. Nome",
  coorientador: none,
  palavras-chave: ("Palavra1", "Palavra2"),
  palavras-chave-en: ("Keyword1", "Keyword2"),
)

// 2. Formatação ABNT
#show: normas-abnt.with(
  fonte: "Times New Roman",  // ou "Arial" (fora do Linux gera 1 aviso: ver fonts.typ)
  quebra-capitulo: true,     // seções primárias em nova página
  paginacao: "auto",         // "auto" | "todas" | "nenhuma"
  frente-verso: false,       // true: margens espelhadas, seções primárias em página ímpar
  cor-links: none,           // none = links externos pretos e sublinhados
  enumeracao: "abnt",        // "abnt" (a), –) ou "latex" (1., a), i), A.)
  arquivo-bibliografia: read("referencias.bib"),  // opcional: gera REFERÊNCIAS no fim
  titulo-bibliografia: "REFERÊNCIAS",  // título da seção de referências
)
```

*Aviso com `fonte: "Arial"`:* fora do Linux, o Typst emite 1 aviso `unknown font family: liberation sans` (a pilha da Arial inclui a "Liberation Sans", o clone métrico instalado nas máquinas Linux). O aviso é aceito de propósito, para o texto não cair numa fonte serifada onde só existe a Liberation Sans; o PDF sai correto, com a Arial. Ver "Pilhas de fonte" em `fonts.typ`.

`@rótulo` de uma seção primária produz "Seção N" (a NBR 14724:2024, 4.2.2, não admite "capítulos"). O nome `quebra-capitulo` ficou por compatibilidade.

Em frente-verso (`frente-verso: true`), os elementos pré-textuais (folha de rosto, folha de aprovação, dedicatória, agradecimentos, epígrafe, resumo, sumário, listas) abrem no anverso, com versos em branco entre eles, e a ficha catalográfica fica no verso da folha de rosto, fora da contagem (ver a nota sobre o número par da Introdução em `page.typ`).

A numeração de páginas é automática (NBR 14724): a contagem começa na folha de
rosto e o número só aparece a partir da primeira seção primária numerada. Não
é preciso `counter(page).update(1)` nem `set page(numbering: ...)`; as funções
`pretextual()`, `textual()` e `postextual()` são mantidas apenas por
compatibilidade.

*Funções auxiliares do template:*

```typst
// Dedicatória
#let dedicatoria(conteudo)

// Agradecimentos
#let agradecimentos(conteudo)

// Epígrafe: citação entre aspas e, ao lado, (Autor); no livro a referência vai em nota (book-epigraph)
#let epigrafe(citacao, autor)

// Obsoletas, mantidas por compatibilidade (a paginação é automática em normas-abnt;
// de efeito real, só pretextual() reinicia o contador de páginas)
#let pretextual()
#let textual()
#let postextual()
```

Ainda no TCC: `capa`, `folha-rosto`, `ficha-catalografica`, `errata`, `folha-aprovacao` e `resumo` (acima), `lista-*` e `sumario` (acima). `abntcc` é o nome antigo de `normas-abnt` (alias de retrocompatibilidade).

=== article.typ - Artigo Científico

Template para artigos conforme NBR 6022. *Espaçamento simples por padrão* (a NBR 6022:2018, 6.1, o recomenda); `espacamento: "1,5"` volta ao 1,5. O título sai em 12 pt, em maiúsculas e negrito, com os dois-pontos colados e o subtítulo na linha seguinte; RESUMO e ABSTRACT saem centralizados, sem recuo, com `Palavras-chave: a; b; c.` em parágrafo próprio.

```typst
#show: artigo.with(
  titulo: "",
  subtitulo: none,
  titulo-en: none,       // Título em outro idioma (itálico, sob o título)
  autores: (),           // Lista de autores com afiliação
  resumo: none,
  resumo-en: none,
  palavras-chave: (),
  palavras-chave-en: (),
  submissao: none,       // Data de submissão (NBR 6022 5.1.4): texto, conteúdo ou datetime
  aprovacao: none,       // Data de aprovação (idem)
  doi: none,             // Identificação e disponibilidade (por exemplo, o DOI)
  agradecimentos: none,  // Texto; impresso depois das referências
  espacamento: "simples", // "simples" ou "1,5"
  fonte: "Times New Roman",
  colunas: 1,            // 1 ou 2 colunas
  arquivo-bibliografia: none,  // read("referencias.bib"): gera REFERÊNCIAS no fim
  titulo-bibliografia: "REFERÊNCIAS",
  enumeracao: "abnt",        // "abnt" (a), –) | "latex" (1., a), i), A.)
)
```

As datas aceitam texto ou `datetime` (`datetime(year: 2026, month: 3, day: 12)` sai "12 de março de 2026"); saem depois do abstract como "Data de submissão: …" e "Data de aprovação: …", mais "DOI: …". Elas são opcionais no código, mas a norma as exige. Com `arquivo-bibliografia`, os agradecimentos saem depois da lista de referências, por ser o último elemento pós-textual.

```typst
// Agradecimentos do artigo (título centralizado, sem quebra de página)
#let agradecimentos-artigo(conteudo)

// Seções sem numeração (heading de nível 1 e 2 sem indicativo)
#let article-section(titulo)
#let article-subsection(titulo)
```

As seções comuns do artigo (`= Introdução`) são numeradas (NBR 6024); `article-section` e `article-subsection` servem para seções sem número.

*Exemplo de autores:*

```typst
#show: artigo.with(
  titulo: "Título do Artigo",
  autores: (
    (name: "Maria da Silva", affiliation: "Universidade Federal de São Paulo"),
    (name: "João Santos", affiliation: "Universidade de São Paulo"),
  ),
  // ...
)
```

=== periodical.typ - Publicação Periódica (NBR 6021:2015)

Template para fascículos de publicações periódicas técnicas e/ou científicas.

```typst
#show: periodical.with(
  titulo: "Revista Brasileira de Ciência",
  subtitulo: none,
  issn: "1234-5679",
  volume: 1,
  numero: 1,
  ano: 2026,
  mes-inicio: 1,        // Janeiro
  mes-fim: 3,           // Março (para trimestral)
  dia: none,            // Dia da edição (periodicidade inferior à mensal, com um só mês)
  local: "São Paulo",
  editora: "Editora Exemplo",   // informativo: nenhum elemento a imprime
  instituicao: "Universidade Federal",
  doi: none,            // informativo: o DOI de cada artigo vai em periodical-article(doi:)
  pagina-inicial: 1,    // Página em que o fascículo começa (continua o volume)
  fonte: "Times New Roman",
  enumeracao: "abnt",
)
```

`titulo`, `subtitulo`, `issn`, `volume`, `numero`, `ano`, `mes-*`, `dia`, `local` e `instituicao` valem como padrão de `periodical-cover()` e `periodical-title-page()`: informe-os só aqui e chame essas duas sem argumentos. A capa não é numerada e a folha de rosto leva o número `pagina-inicial`. A legenda bibliográfica do rodapé traz o intervalo de páginas do artigo ou da seção corrente e não aparece na capa nem na folha de rosto. Os artigos reiniciam a numeração das seções.

*Funções principais:*

```typst
// Capa do fascículo (os parâmetros que ficarem none valem os de periodical())
#periodical-cover(
  titulo: "Título do Periódico",
  issn: "1234-5679",
  volume: 1,
  numero: 1,
  ano: 2026,
  mes-inicio: 1,
  mes-fim: 3,
  instituicao: "Universidade Federal",  // obrigatória (NBR 6021 4.1.1 e), ao pé da capa
)
// Também aceita subtitulo, dia, logo e suplemento.

// Folha de rosto e seu verso
#periodical-title-page()      // paginas: calculado quando omitido
#periodical-title-page-verso(
  ano-copyright: 2026,
  detentor-copyright: "Universidade Federal",
)
// O verso também aceita direitos-reproducao, outros-formatos, catalogacao e creditos.

// Sumário por artigos (editorial, cada artigo e instruções para autores)
#periodical-toc()

// Legenda bibliográfica (para rodapé de cada página)
#bibliographic-legend(
  titulo: "Revista Brasileira de Ciência",
  local: "São Paulo",
  volume: 1,
  numero: 1,
  paginas: "1-154",
  mes-inicio: 1,
  mes-fim: 3,
  ano: 2026,
)
// Resultado: "R. bras. Ci., São Paulo, v. 1, n. 1, p. 1-154, jan./mar. 2026."

// Editorial
#editorial[
  Texto de apresentação do fascículo...
]

// Artigo dentro do periódico
#periodical-article(
  titulo: "Título do Artigo",
  autores: ((name: "Autor", affiliation: "Instituição"),),
  resumo: [Resumo do artigo...],
  palavras-chave: ("palavra um", "palavra dois"),
  submissao: "12 de março de 2026",
  aprovacao: "20 de abril de 2026",
)[
  Conteúdo do artigo...
]

// Instruções editoriais para autores e informações de suplemento
#author-guidelines[Instruções...]
#supplement-info(titulo-principal: "Revista X", titulo-suplemento: "Suplemento Y", volume: 1, ano: 2026, issn: "1234-5679")
```

`periodical-article` tem os mesmos elementos de `artigo()` (subtítulo, título em outro idioma, resumo e abstract, datas, DOI) e o espaçamento do periódico é 1,5 (a NBR 6021 não trata de espaçamento). Cada artigo é uma entrada do sumário.

=== book.typ - Livros e Folhetos (NBR 6029:2023)

Template para livros e folhetos com todos os elementos pré-textuais e pós-textuais.

```typst
#show: livro.with(
  titulo: "Título do Livro",
  subtitulo: none,
  autor: "Nome do Autor",   // texto, conteúdo ou lista de nomes (um por linha)
  editora: "Editora Exemplo",
  local: "São Paulo",
  ano: 2026,
  edicao: none,         // A partir da 2ª edição (número) ou texto ("2ª edição, revista e ampliada")
  volume: none,         // Número ou texto ("Tomo 3")
  isbn: "978-65-00000-00-9",  // ISBN-13 (978/979) ou ISBN-10 válido; conteúdo (ex. [em obtenção]) contorna a validação
  fonte: "Times New Roman",
  cabecalho: none,      // Título corrente (conteúdo, ou (par: ..., impar: ...); auto = título do capítulo)
  paginacao: "auto",    // "auto" | "todas" | "nenhuma"
  frente-verso: false,  // true: margens espelhadas e elementos em página ímpar
  enumeracao: "abnt",        // "abnt" (a), –) | "latex" (1., a), i), A.)
)
```

`titulo`, `subtitulo`, `autor`, `editora`, `local`, `ano`, `edicao`, `volume` e `isbn` valem como padrão de `book-cover`, `book-back-cover`, `half-title-page`, `book-title-page` e `book-title-page-verso`: basta não repeti-los (repetir continua valendo). Com isso o `ano` (padrão: o ano de hoje) sai na capa e na folha de rosto. *ISBN inválido dá erro:* texto que não seja ISBN-13 com prefixo 978/979 e dígito verificador certo, nem ISBN-10 válido, aborta a compilação em `livro()`, `book-title-page-verso()` e `book-back-cover()` com uma mensagem em português; passar conteúdo (`isbn: [em obtenção]`), lista ou `none` contorna. A forma do produto e o ISBN por volume (NBR ISO 2108, 6.4) não são tratados.

`cabecalho` aparece só nos elementos textuais (da página seguinte ao sumário em diante) e nunca na capa, folhas de rosto, páginas em branco nem quarta capa. Com um conteúdo único, ele sai à direita (e, em frente-verso, à esquerda nas páginas pares); com `(par: [Título do livro], impar: auto)`, um conteúdo para cada lado, e `auto` é o título do capítulo corrente. As equações em bloco (`$ ... $`) saem numeradas e `@e1` de equação sai "(1)".

*Frente-verso* (`frente-verso: true`): margens espelhadas; falsa folha de rosto, folha de rosto, errata, dedicatória, agradecimentos, epígrafe, sumário, prefácio/apresentação, posfácio, glossário, partes e capítulos abrem em página ímpar; a quarta capa, em página par. As páginas deixadas em branco não levam cabeçalho nem número. As funções do livro *não terminam* em `pagebreak()`: cada uma abre a própria página; uma `#pagebreak()` solta antes de um elemento ímpar deixa uma página em branco com cabeçalho e número (use `pagebreak(weak: true)`).

*Elementos pré-textuais:*

```typst
// Capa
#book-cover(
  autor: "Nome do Autor",
  titulo: "Título",
  subtitulo: "Subtítulo",
  editora: "Editora",
  logo-editora: none,   // logomarca da editora
  edicao: 2,
  local: "São Paulo",
  ano: 2026,
)

// Folha de guarda (capa dura): uma página sem cabeçalho nem número, em branco ou com conteúdo
#book-guarda()

// Orelha (opcional, 6029 4.1.5): página estreita, sem cabeçalho nem número; uma chamada por orelha
#book-orelha(
  biografia: [Dados biográficos do autor...],
  comentario: [Comentário sobre a obra...],
  largura: 9cm,         // também aceita publico: e outros:
)

// Falsa folha de rosto (opcional); serie vai no verso
#half-title-page(titulo: "Título", serie: "Coleção Exemplo, v. 3")

// Folha de rosto (anverso)
#book-title-page(
  autor: "Nome do Autor",
  titulo: "Título",
  subtitulo: "Subtítulo",
  colaboradores: [Tradução de João Silva],
  edicao: 2,
  volume: 1,
  editora: "Editora",
  local: "São Paulo",
  ano: 2026,
)

// Folha de rosto (verso com ficha catalográfica)
#book-title-page-verso(
  ano-copyright: 2026,
  detentor-copyright: "Nome do Autor",
  licenca: [CC BY 4.0],            // símbolo e texto da licença (Creative Commons), sem imagem pronta
  titulo-original: "Original Title",  // Se tradução (sai sempre "Título original:")
  ficha-catalografica: [Dados de catalogação...],
  bibliotecario: "Nome do Bibliotecário - CRB-0/0000",
)
// Também aceita direitos-reproducao, outros-formatos, creditos, isbn e dados-editora.

// Errata (logo após a folha de rosto): referência e itens (página, linha, errado, correto)
#book-errata(
  referencia: [SILVA, J. *Título*. São Paulo: Editora, 2026.],
  itens: ((pagina: 10, linha: 3, errado: "erro", correto: "certo"),),
)

// Dedicatória, agradecimentos, epígrafe
#book-dedication[Aos meus pais...]
#book-acknowledgments[Agradeço a...]
#book-epigraph("Citação inspiradora", [ADAMS, D. *O guia do mochileiro*. 2. ed. São Paulo: Arqueiro, 2009.])

// Prefácio e apresentação (sem indicativo de seção)
#book-preface[Prefácio...]
#book-presentation[Apresentação...]

// Listas (não saem se estiverem vazias)
#book-list-illustrations()
#book-list-tables()
#book-list-quadros()
#book-list-abbreviations((
  "ABNT": "Associação Brasileira de Normas Técnicas",
  "NBR": "Norma Brasileira",
))
#book-list-symbols((
  ($alpha$, "Coeficiente alfa"),
  ($beta$, "Coeficiente beta"),
))

// Sumário
#book-toc()
```

`book-epigraph` põe a referência da epígrafe em *nota de rodapé* (NBR 6029, 4.2.1.6): `autor` recebe a referência completa (NBR 6023) ou só o nome. `em-nota: false` volta a imprimir `(autor)` ao lado da citação.

A numeração das ilustrações é por tipo (o Typst numera por `kind`): para "Mapa 1", "Gráfico 1", "Mapa 2" use `container(tipo: "mapa", suplemento: "Mapa", ...)` e `book-list-illustrations(tipo: "mapa", titulo: "LISTA DE MAPAS")`. Sem tipos próprios, suplementos diferentes do mesmo tipo dividem a mesma contagem.

*Elementos pós-textuais:*

```typst
// Posfácio
#book-postface[Considerações finais...]

// Glossário
#book-glossary((
  "Termo 1": "Definição do termo 1",
  "Termo 2": "Definição do termo 2",
))

// Apêndice (elaborado pelo autor); rotulo: "ap-a" permite @ap-a ("Apêndice A")
#book-appendix(letra: "A", titulo: "Questionário Aplicado", rotulo: "ap-a")[
  Conteúdo do apêndice...
]

// Anexo (documento externo); letra: none para anexo único
#book-annex(letra: "A", titulo: "Documento de Referência")[
  Conteúdo do anexo...
]

// Índice remissivo, montado pelos #idx(...) do texto (páginas automáticas)
#book-index()

// ou manual: pares (termo, páginas), ordenados pela NBR 6033
#book-index((
  ("Algoritmo", "15, 23, 45"),
  ("Banco de dados", "34-38"),
))

// Colofão (última página)
#book-colophon[
  Este livro foi composto em Times New Roman.
  Impresso na Gráfica Exemplo em janeiro de 2026.
]

// Quarta capa (coloque no FIM do documento): ISBN, código de barras, resumo, endereço da editora
#book-back-cover(resumo: [Resumo do livro...])
```

As subdivisões (`==`) dentro de `book-appendix` e `book-annex` saem *sem número*; o apêndice só leva a letra no título. `book-index(canto: "letras")` ou `"entradas"` imprime o canto da página do índice (NBR 6034, 6.5; ver `indice`). A sobrecapa (NBR 6029, 4.1.1) é a soma de `book-cover()`, `book-orelha()` e `book-back-cover()`, na ordem da sua gráfica.

*Funções de compatibilidade e auxiliares:* `book-start-numbering()` é uma função *vazia* (a numeração é automática, ver `paginacao`); `book-equation(body)` continua válida, mas redundante (as equações em bloco já saem numeradas).

*Limite conhecido:* em frente-verso, as orelhas contam como páginas físicas do PDF e deslocam a paridade (a falsa folha de rosto pode abrir na página 5 com a 4 em branco); quem imprime as orelhas à parte não é afetado.

=== research-project.typ - Projeto de Pesquisa (NBR 15287:2025)

Template para projetos de pesquisa. Os dados do projeto (`titulo`, `subtitulo`, `autor`, `instituicao`, `local`, `ano`, `tipo-projeto`, `orientador`, `coorientador`, `coordenador`, `volume`) valem como padrão de `project-cover()` e `project-title-page()`: informe-os só aqui. A numeração de página é do template: arábica, canto superior direito, contada desde a folha de rosto e visível a partir da primeira seção primária numerada. Quem fazia `counter(page).update(1)` à mão antes da Introdução deve removê-lo (a Introdução do exemplo, antes página 1, passou a página 3).

```typst
#show: projeto-pesquisa.with(
  titulo: "",          // Título do projeto
  subtitulo: none,     // Subtítulo
  autor: "",           // Autor(es) - pode ser string ou array
  instituicao: "",     // Nome da entidade
  local: "",           // Cidade
  ano: 2026,           // Ano de entrega
  tipo-projeto: none,  // Tipo de projeto
  orientador: none,    // Orientador
  coorientador: none,  // Coorientador
  coordenador: none,   // Coordenador
  volume: none,        // Número do volume
  frente-verso: false, // true: margens espelhadas; folha de rosto, sumário, listas e seções primárias em página ímpar
  fonte: "Times New Roman",
  arquivo-bibliografia: none,  // read("referencias.bib"): gera REFERÊNCIAS no fim
  titulo-bibliografia: "REFERÊNCIAS",
  enumeracao: "abnt",        // "abnt" (a), –) | "latex" (1., a), i), A.)
)
```

*Funções principais:*

```typst
// Capa específica para projeto (o que ficar none vale o de projeto-pesquisa())
#project-cover(
  instituicao: none,
  autor: none,
  titulo: none,
  subtitulo: none,
  volume: none,
  local: none,
  ano: none,
)

// Folha de rosto específica (marca a folha de rosto: a contagem começa aqui)
#project-title-page(
  autor: none,
  titulo: none,
  subtitulo: none,
  volume: none,
  tipo-projeto: none,
  instituicao: none,
  orientador: none,
  coorientador: none,
  coordenador: none,
  local: none,
  ano: none,
)

// Cronograma do projeto
#cronograma-simples(
  titulo: "CRONOGRAMA",
  atividades: ("Revisão bibliográfica", "Coleta de dados", "Análise"),
  periodos: ("jan.", "fev.", "mar.", "abr.", "maio", "jun."),
  marcacoes: (
    (true, true, false, false, false, false),
    (false, true, true, true, false, false),
    (false, false, false, true, true, true),
  ),
)

// Recursos do projeto: itens são pares (descrição, valor); total opcional (titulo: "RECURSOS")
#recursos(
  itens: (
    ("Material de consumo", 500.00),
    ("Equipamentos", 2000.00),
    ("Serviços", 1500.00),
  ),
  total: 4000.00,
)

// Glossário, apêndice e anexo
#glossario-projeto(("Termo": "Definição"))
#apendice("A", "Título do Apêndice")
#anexo("A", "Título do Anexo")
```

`cronograma-simples` e `recursos` criam o próprio título (não escreva `= Cronograma` antes). Com mais de 6 períodos de rótulo maior que 4 caracteres (por exemplo, 12 meses por extenso), o cabeçalho dos períodos sai na vertical, para o rótulo não se partir em sílabas. Os valores de `recursos` saem com ponto decimal, sem formatação de moeda.

=== technical-report.typ - Relatório Técnico (NBR 10719:2015)

Template para relatórios técnicos e/ou científicos. *Espaçamento simples por padrão* (a NBR 10719:2015, 5.1, o recomenda); `espacamento: "1,5"` volta ao 1,5. O template *não imprime capa nem folha de rosto sozinho*: chame `report-cover()` e `report-title-page()` depois do `#show:`. Os parâmetros que descrevem o relatório valem como padrão dessas duas funções (informe-os só em `relatorio()`; repetir também funciona e o valor da chamada prevalece). A contagem de páginas começa na folha de rosto, com ou sem capa (a Introdução do exemplo, antes numerada 8, passou a 7).

```typst
#show: relatorio.with(
  titulo: "",             // Título do relatório
  subtitulo: none,        // Subtítulo
  numero-relatorio: none, // Número do relatório
  codigo-relatorio: none, // Código de identificação (ver report-code)
  instituicao: "",        // Órgão responsável
  endereco-instituicao: none,
  titulo-projeto: none,   // Projeto relacionado
  autores: (),            // Lista de autores (texto, ou (name:, qualification:))
  classificacao: none,    // Classificação de segurança
  issn: none,
  local: "",
  ano: 2026,
  volume: none,
  titulo-volume: none,    // Título específico do volume
  pagina-inicial: none,   // Continua a numeração de um volume anterior (a folha de rosto passa a valer este número)
  fonte: "Times New Roman",
  espacamento: "simples", // "simples" ou "1,5"
  paginacao: "auto",      // "auto" | "todas" | "nenhuma"
  frente-verso: false,    // true: margens espelhadas, elementos pré-textuais no anverso
  arquivo-bibliografia: none,  // read("referencias.bib"): gera REFERÊNCIAS no fim
  titulo-bibliografia: "REFERÊNCIAS",
  enumeracao: "abnt",        // "abnt" (a), –) | "latex" (1., a), i), A.)
)
```

As equações em bloco (`$ x = y $`) saem numeradas `(1)` à direita (NBR 10719, 5.7); para desligar, `#set math.equation(numbering: none)`. As referências saem no fim do documento; como a 4.2.3 manda a ordem referências, glossário, apêndice, anexo, índice, quem tem algum desses elementos deve chamar `referencias-relatorio()` no ponto certo (antes do glossário e do apêndice). `arquivo-bibliografia` com caminho em string aborta cedo: use `read(...)`.

*Funções principais:*

```typst
// Capa do relatório (o que ficar none vale o de relatorio())
#report-cover(
  instituicao: none,
  endereco-instituicao: none,
  numero-relatorio: none,
  issn: none,
  titulo: none,
  subtitulo: none,
  classificacao: none,
  ano: none,
)

// Folha de rosto (a contagem de páginas começa aqui)
#report-title-page(
  instituicao: none,
  titulo-projeto: none,
  titulo: none,
  subtitulo: none,
  volume: none,
  titulo-volume: none,
  codigo-relatorio: none,
  classificacao: none,
  autores: none,
  local: none,
  ano: none,
  pagina-inicial: none,
)

// Verso da folha de rosto: equipe técnica e/ou dados de catalogação.
// A NBR 10719 (4.2.1.1.2 b e 4.2.3.6) exige os dados de catalogação OU o formulário
// de identificação: um dos dois. Sem parâmetros, não imprime nada.
#report-title-page-verso(
  equipe-tecnica: ((funcao: "Coordenador", nome: "Nome"),),
  dados-catalogacao: [Dados de catalogação...],
)

// Errata (logo depois da folha de rosto; sem itens, não imprime nada)
#errata(
  referencia: [SILVA, M. *Relatório*. São Paulo, 2026.],
  itens: (
    (pagina: 10, linha: 5, errado: "erro", correto: "correto"),
  ),
)

// Agradecimentos e resumo do relatório
#agradecimentos-relatorio[Agradecemos...]
#resumo-relatorio(palavras-chave: ("palavra um", "palavra dois"))[Resumo do relatório...]

// Formulário de identificação (Anexo A da norma): quadro com os campos na ordem da norma;
// sem nenhum campo, não imprime nada
#formulario-identificacao(
  titulo: "Título",
  classificacao: "Ostensivo",
  numero-relatorio: "001/2026",
  tipo-relatorio: "Parcial",
  data: "Janeiro 2026",
  titulo-projeto: "Projeto X",
  numero-projeto: "P-123",
  autores: ("Ana Silva",),
  instituicao-executora: "Instituto Y, Rua Z, 100",
  instituicao-patrocinadora: "Agência W",
  texto-resumo: [Resumo...],
  palavras-chave: ("palavra um", "palavra dois"),
  paginas: "150",
)
// Também aceita subtitulo, numero-classificacao, edicao, volume, issn, tiragem, preco,
// distribuidor, observacoes, distribuicao e instituicoes (lista antiga, vale como executora).

// Referências na posição certa (usa arquivo-bibliografia de relatorio())
#referencias-relatorio()

// Código de identificação formatado (devolve texto; serve para codigo-relatorio:)
#report-code(
  codigo-instituicao: "INPE",
  categoria: "RPE",
  ano: 2026,
  assunto: "EST",
  sequencia: 1,       // número ou texto, com 3 dígitos; none omite
  separador: "-",
)
// Resultado: INPE-RPE-2026-EST-001
```

A `errata` serve também para o TCC (ver `title-page.typ`).

=== poster.typ - Pôster Científico (NBR 15437:2006)

Template para pôsteres técnicos e científicos. O pôster é *uma folha*: o conteúdo que passar da altura vira uma segunda página, sem aviso (ajuste `tamanho-corpo`, `num-colunas` ou o texto). Título em maiúsculas, centralizado, sem justificar nem hifenizar, com os dois-pontos colados e o subtítulo na linha seguinte; os autores são centralizados, com as afiliações numeradas por instituição distinta; `titulo` vazio aborta a compilação (a norma o exige, 4.1). Afiliação, contato e referências nunca ficam abaixo de 20 pt (legível a 1 m, 5.3).

```typst
#show: poster.with(
  titulo: "Título do pôster",     // Título (obrigatório)
  subtitulo: none,     // Subtítulo
  autores: ((name: "Ana Silva", affiliation: "Universidade X"),),  // Lista de autores (a norma os exige)
  instituicao: none,   // Instituição
  contato: none,       // Contato
  texto-resumo: none,  // Resumo (até 100 palavras; o template não conta)
  palavras-chave: (),  // Palavras-chave (saem separadas por ponto e vírgula)
  num-colunas: 3,      // Número de colunas
  equilibrar-colunas: true,  // true: reparte o conteúdo por igual entre as colunas
  largura: 90cm,       // Largura do pôster (a norma pede 60 a 90 cm)
  altura: 120cm,       // Altura do pôster (90 a 120 cm)
  fonte: "Arial",
  tamanho-titulo: 72pt,
  tamanho-corpo: 24pt,
  fundo: white,
  cor-texto: black,    // Cor do texto corrido: com fundo escuro, use um tom claro
  cor-destaque: rgb("#003366"),
)
```

Com `equilibrar-colunas: false`, a 1ª coluna enche até o fim da página (use `colbreak()` para escolher onde a coluna muda); o equilíbrio é uma estimativa: com itens que não partem (uma imagem alta), a coluna pode estourar, e nesse caso use `false` e `colbreak()`. Com fundo escuro, a caixa do resumo e `poster-highlight` mantêm fundo claro e texto preto, e o título da seção usa branco ou preto conforme a cor.

*Variantes de tamanho:*

```typst
// Pôster A0 (84,1cm x 118,9cm)
#show: poster-a0.with(titulo: "Título", autores: ((name: "Ana Silva"),))

// Pôster de 60cm x 90cm (o menor formato da norma, 5.2); mantém o nome poster-a1.
// O A1 da ISO (59,4 x 84,1 cm) ficaria abaixo do mínimo da norma. 2 colunas.
#show: poster-a1.with(titulo: "Título", autores: ((name: "Ana Silva"),))

// Pôster acadêmico com orientador e logotipos
#show: academic-poster.with(
  titulo: "Título",
  autores: ((name: "Ana Silva", affiliation: "Universidade X"),),
  orientador: "Prof. Dr. Nome",
  logo: rect(width: 3cm, height: 2cm),   // logotipo à esquerda do título (um image(...))
  logo-direita: none,                    // segundo logotipo, à direita
  largura-logo: 10cm,                    // tamanho máximo de cada logotipo (10 x 6 cm)
  altura-logo: 6cm,
  departamento: "Departamento de Computação",
)
```

`poster-a0` e `poster-a1` só repassam os parâmetros `titulo`, `subtitulo`, `autores`, `instituicao`, `contato`, `texto-resumo`, `palavras-chave`, `num-colunas`, `fonte` e `cor-destaque`; para os demais use `poster()` com `largura` e `altura`. `academic-poster` aceita os mesmos parâmetros de `poster()` mais os acima. Um logotipo sozinho deixa um vão do mesmo tamanho do outro lado, para o título ficar centralizado; `logo:` não duplica mais o logotipo à direita (para o segundo, `logo-direita:`).

*Funções auxiliares:*

```typst
// Seção com caixa colorida (cor-destaque: auto herda a do pôster)
#poster-section(titulo: "RESULTADOS")[
  Conteúdo da seção...
]

// Caixa de destaque (fundo claro, texto preto)
#poster-highlight[
  Texto importante a destacar...
]

// Figura ou tabela para pôster: "Figura 1 – Título" ou "Tabela 1 – Título" em cima
// (pelo tipo do conteúdo), Fonte embaixo (a norma a exige)
#poster-figure(
  rect(width: 8cm, height: 5cm),
  legenda: "Resultados obtidos",
  origem: "Elaborado pelo autor",
)

// Referências compactas (sem recuo e sem justificar, mínimo de 20 pt)
#poster-references((
  [SILVA, M. Título. 2024.],
  [SANTOS, J. Outro título. 2023.],
))
```

As seções podem partir entre colunas: uma seção maior que uma coluna continua na seguinte (e na segunda página, se preciso).

=== slides.typ - Apresentações (Touying)

*Não existe norma ABNT para slides.* O template segue boas práticas acadêmicas, não uma exigência normativa; as únicas normas aplicáveis são a NBR 6023 (referências) e a NBR 10520 (citações), quando houver citações na apresentação. O template usa o pacote Touying (0.7.4) e a `lib.typ` reexporta os nomes dele (`pause`, `only`, `uncover`, `alert`, `speaker-note`, `config-common`...). Tamanhos: corpo 25 pt, títulos 30 pt, rodapé do tema 15 pt; os textos auxiliares dos `slide-*` ficam em 16 pt ou mais.

```typst
#show: slides.with(
  titulo: "Introdução ao Machine Learning",
  subtitulo: "Conceitos Fundamentais",
  autor: "Prof. Dr. Carlos Eduardo Silva",  // nome ou lista de nomes
  orientador: none,
  instituicao: "Universidade Federal de Exemplo",
  departamento: "Departamento de Ciência da Computação",
  data: datetime(year: 2025, month: 8, day: 20),  // datetime ("20 de agosto de 2025"), texto ou conteúdo
  logo: none,                // imagem; passe image(..., alt: "...")
  proporcao: "16-9",         // "L-A": "16-9", "4-3", "16-10"...
  fonte: "Arial",
  cor-primaria: cores-clean.primary,
  cor-secundaria: cores-clean.secondary,   // cor do texto secundário da capa: contraste >= 4,5:1
)

// Defesa de TCC, dissertação ou tese: os mesmos parâmetros, mais coorientador, grau,
// programa (com ele o rodapé diz "Defesa de Dissertação/Tese", sem ele "Defesa de TCC")
// e banca (lista de nomes, no slide final "Obrigado!", sempre anexado)
#show: slides-defesa.with(
  titulo: "Título da defesa",
  autor: "Nome do Autor",
  orientador: "Prof. Dr. Orientador",
  coorientador: none,
  instituicao: "Universidade Federal de Exemplo",
  grau: "Bacharel em Ciência da Computação",
  programa: none,
  banca: ("Prof. Dr. A", "Profa. Dra. B"),
  data: datetime(year: 2025, month: 8, day: 20),
)
```

*Notas do apresentador.* `slides(..config)` repassa a configuração ao Touying: `config-common(show-notes-on-second-screen: right)` mostra as `#speaker-note[...]` ao lado do slide; sem isso elas não aparecem no PDF.

*Slides auxiliares* (`titulo:` vira um `==` de verdade e entra no índice do PDF; todos têm cabeçalho, rodapé e número; `cor-primaria: auto` lê a cor do tema):

```typst
// Sumário/agenda: cerca de 6 itens cabem na página
#let slide-sumario(titulo: "Sumário", itens: (), cor-primaria: auto)

// Divisor de seção (`= Título` também cria um, no estilo do tema)
#let slide-secao(titulo: "", subtitulo: none, cor-primaria: auto)

// Citação em destaque: usa `citar` do pacote, (Mitchell, 1997, p. 2); citações longas diminuem sozinhas
#let slide-citacao(quote: "", autor: "", ano: "", pagina: none, cor-primaria: auto)

// Referências digitadas por você, formatadas pela NBR 6023 (sem recuo): cerca de 5 cabem
#let slide-referencias(titulo: "Referências", itens: ())

// Figura de terceiros com fonte; passe image(..., alt: "descrição"); imagens altas diminuem sozinhas
#let slide-figura(titulo: none, imagem: none, legenda: none, origem: none, ano-fonte: none)

// Duas colunas
#let slide-comparativo(titulo: "", titulo-esquerda: "", conteudo-esquerda: [], titulo-direita: "", conteudo-direita: [], cor-primaria: auto)

// Metodologia
#let slide-metodologia(titulo: "Metodologia", tipo-pesquisa: none, abordagem: none, procedimentos: (), instrumentos: (), cor-primaria: auto)

// Resultados com destaque numérico: itens são pares (valor, descrição)
#let slide-resultado-numerico(titulo: "Resultados", itens: (), cor-primaria: auto)

// Muda de slide de forma explícita (equivale a `== Título`)
#let novo-slide(titulo: none, ..corpo)
```

```typst
#slide-sumario(titulo: "Roteiro", itens: ("Introdução", "Método", "Resultados"))

== Introdução

Texto do slide.

#pause

Segundo passo do slide.

#slide-resultado-numerico(itens: (("92%", "acurácia"), (3, "rodadas")))

#slide-citacao(quote: "Citação literal.", autor: "Mitchell", ano: "1997", pagina: "2")
```

*Revelação progressiva:* `slide-pause`, `slide-only` e `slide-uncover` são aliases de `pause`, `only` e `uncover` do Touying. *Cores:* `cores-usp`, `cores-unicamp`, `cores-unesp`, `cores-ufrj`, `cores-ufmg`, `cores-ufrgs`, `cores-ufsc`, `cores-ufpr`, `cores-unb`, `cores-ufpe`, `cores-academico`, `cores-moderno` e `cores-clean` são dicionários `(primary:, secondary:)`. São *sugestões*, sem fonte oficial (confira o manual de identidade da sua instituição): a cor secundária vira cor de texto na capa, então sete delas foram escurecidas até o contraste de 4,5:1 sobre branco (WCAG AA) e não são o tom exato da marca. Outros: `nota-sem-norma-abnt()` insere a nota de que não há norma de slides, e `aviso-citacoes()`, um aviso sobre citações (a aplicação da formatação é do autor).

*Limites conhecidos:*
- *PDF/UA-1.* `--pdf-standard ua-1` reprova os dois exemplos de slides: o Touying usa `==` para os slides e o PDF/UA-1 exige um título de nível 1 primeiro. Emitir o título da apresentação como nível 1 com `<touying:hidden>` passa no UA-1, mas o tema mostra o último título de nível 1 no cabeçalho de todos os slides; por isso foi revertido. Para acessibilidade, passe `alt:` em toda imagem e no logo.
- *Fonte.* A fonte padrão é a Arial, *sem reserva*: acrescentar "Liberation Sans" geraria um aviso em todo Mac. É diferente de `normas-abnt`, onde a Arial é opcional e a pilha tem "Liberation Sans" (aceitando o aviso). Em Linux sem Arial, o Typst avisa e cai numa fonte serifada: passe `fonte: "Liberation Sans"`.
- *Estouro de página.* Sumário com mais de 6 itens, referências com mais de 5 e comparativo ou metodologia com texto longo ainda passam da página (o conteúdo que sobra vai para outra página, sem título nem rodapé). Encolher esconderia `#pause` e `#only`, por isso esses slides não se ajustam sozinhos; cada slide deve caber na página, inclusive o conteúdo ainda oculto por `#pause`.
- A capa é o slide 1 do contador "N / total", que conta slides, não páginas; "Obrigado!" fica no masculino e o slide final de `slides-defesa` não pode ser desligado; `= Título` e `slide-secao` são dois estilos de divisor de seção.

== Elementos Pós-textuais

=== index.typ - Índice (NBR 6034:2004)

Funções para criar índices remissivos. As entradas são registradas no texto e o índice é montado no fim. Entradas que diferem só por caixa ou acento (`Algoritmo`/`algoritmo`, `Álgebra`/`Algebra`) viram uma só (o texto mostrado é a primeira grafia registrada); a ordem e a letra do cabeçalho seguem a NBR 6033 (ver `sorting.typ`).

```typst
// Registrar entrada no índice (no texto) — termo, subtermo, subsubtermo,
// exibicao (texto mostrado, se diferente do termo) e volume (NBR 6034, 6.12 c)
#let idx(termo, subtermo: none, subsubtermo: none, exibicao: none, volume: none)

// Entrada sem exibir texto (para um termo que já aparece no texto)
#let index-entry(termo, subtermo: none, subsubtermo: none, volume: none)

// Remissivas
#let index-see(de, para)        // "ver"
#let index-see-also(de, para)   // "ver também"

// Gerar índice
#let indice(
  titulo: "ÍNDICE",        // none omite o título (e o vão)
  nota: none,              // nota explicativa do padrão adotado, antes das entradas (6.3)
  rotulo-tipo: none,       // "DE ASSUNTOS", "ONOMÁSTICO"...
  entradas-ver: (),
  entradas-ver-tambem: (),
  colunas: 2,
  cabecalhos-letras: true,
  canto: none,             // "letras" ou "entradas": letras do canto da página (6.5)
)

// Variantes de índice: só mudam o título; todas listam as mesmas entradas registradas
#let indice-assuntos(entradas-ver: (), entradas-ver-tambem: (), colunas: 2)
#let indice-onomastico(entradas-ver: (), entradas-ver-tambem: (), colunas: 2)
#let indice-autores(entradas-ver: (), colunas: 2)
#let indice-geral(entradas-ver: (), entradas-ver-tambem: (), colunas: 2)

// Entrada manual, para controle total
#let manual-index-entry(termo: none, qualificador: none, paginas: none, subentradas: ())
```

*Exemplo:*

```typst
A #idx("algoritmo") é uma sequência de instruções...
O #idx("algoritmo", subtermo: "de ordenação", exibicao: [Quicksort]) é eficiente...
Um #idx("algoritmo", subtermo: "de ordenação", subsubtermo: "por comparação", exibicao: [Mergesort]) também.

// Entrada sem exibir texto
#index-entry("termo", subtermo: "de teste")

// Em documento de mais de um volume
#idx("Idade Média", volume: 2)

// Remissivas
#let entradas-ver = (
  index-see("Aviação", "Aeronáutica"),  // "ver"
)
#let entradas-ver-tambem = (
  index-see-also("Férias", "Licença"),  // "ver também"
)

// Gerar índice
#indice(
  rotulo-tipo: "DE ASSUNTOS",
  entradas-ver: entradas-ver,
  entradas-ver-tambem: entradas-ver-tambem,
  colunas: 2,
  cabecalhos-letras: true,
)
```

`idx(...)[texto]` (com corpo) *não existe*: para exibir outro texto use `exibicao:`. As remissivas de termos sem entrada também saem. Como o registro é um `state` único e sem tipo, `indice-onomastico`, `indice-autores`, `indice-assuntos` e `indice-geral` só mudam o título: todas listam todos os termos registrados.

*Volume e canto.* `idx(volume:)` agrupa as páginas por volume: `Idade Média, v. 2, 1-2; v. 3, 3` (número vira "v. N"; texto como `"pt. 1"` vai como dado). `indice(canto: "letras")` imprime, no canto superior externo de cada página do índice, as letras iniciais (`A`, `B–E`); `"entradas"` imprime a primeira e a última entradas da página (NBR 6034, 6.5). O canto usa a margem externa da página (direita nas ímpares e esquerda nas pares em frente-verso), preserva o número de página e abre uma página nova.

*Continuação.* Um termo com subentradas não se parte entre colunas; o que é mais alto que uma coluna começa uma coluna nova e é fatiado, com o cabeçalho (e o subcabeçalho) repetido e "(continuação)" em cada parte (NBR 6034, 6.8).

*Limites:* termos dados como conteúdo (`idx([*x*])`) ainda são ordenados e agrupados pelo `repr` do conteúdo (a letra do cabeçalho sai "S" para `strong`): prefira texto simples e use `exibicao:` para a forma mostrada; o primeiro termo do índice, se for gigante, começa na 1ª coluna da 1ª página, que tem o título acima, e a sobra pode cair sem cabeçalho; o tamanho da coluna vem da altura da página menos as margens `top` e `bottom`.

=== spine.typ - Lombada (NBR 12225:2004)

Funções para criar lombada de encadernação. A `lombada()` é uma página *em retrato* (largura × altura da lombada), com o texto do alto para o pé (NBR 12225, 4.1.2.2), sem página em branco depois. Quem imprime não precisa mais girar a folha (até a 0.6.0 era uma faixa horizontal).

```typst
// Gera página com lombada para impressão
#lombada(
  autor: "SILVA",          // texto ou lista de nomes (separados por "; " na descendente; um abaixo do outro na horizontal)
  titulo: "TÍTULO DO TRABALHO",
  volume: 1,
  fasciculo: 3,            // sai "fasc. 3"
  ano: 2026,
  instituicao: "UFSC",
  logo: none,
  orientacao: "descendente",  // ou "horizontal"
  largura-lombada: 2cm,
  altura-lombada: 29.7cm,
  espaco-reservado: 30mm,  // Espaço em branco no pé para etiquetas (o logo fica acima)
)

// Preview da lombada no documento (mesmos parâmetros, menos orientacao)
#lombada-preview(
  autor: "SILVA",
  titulo: "TÍTULO DO TRABALHO",
  ano: 2026,
  instituicao: "UFSC",
)

// Título de margem de capa (para documentos finos); o volume sai como "- v. 2"
#margem-capa(
  titulo: "TÍTULO",
  volume: 1,
  largura-margem: 1.5cm,
)
```

```typst
// Texto girado 90° (do alto para o pé), para compor a lombada em outro contexto
#let spine-text-descending(autor: none, titulo: none, volume: none, fasciculo: none, ano: none)
```

A instituição continua entre os elementos por ser opcional (a norma lista só volume, fascículo e data). `lombada(orientacao: "horizontal")` também troca as dimensões da página. A lombada não está ligada aos templates.

== Módulos Utilitários

=== dates.typ - Datas e Horas (NBR 5892:2019)

Funções para formatação de datas e horas conforme a norma brasileira. As funções de data com dia, mês e ano exigem o ano com quatro dígitos (3.1.3: 2018, não 18) e dão erro caso contrário.

```typst
// Formatar data
#format-date-mixed(4, 4, 2018)   // "4 de abril de 2018"
#format-date-short(4, 4, 2018)   // "4 abr. 2018"
#format-date-numeric(4, 4, 2018) // "04.04.2018"

// A partir de datetime
#format-date(datetime.today(), format: "mixed")  // ou "short", "numeric"

// Formatar hora
#format-time-abbrev(8, 21, second: 32)  // "8 h 21 min 32 s"
#format-time-digital(8, 21, second: 32) // "08:21:32"
#format-time(datetime(hour: 8, minute: 21, second: 32))  // a partir de datetime ("abbrev" ou "digital")

// Data e hora juntas (3.3.1)
#format-date-time(4, 4, 2018, 8, 21)  // "4 de abril de 2018, às 8 h 21 min"

// Dia da semana (3.3.2): 0 = domingo; calendário juliano até 4/10/1582
#get-weekday(4, 4, 2018)     // 3
#format-weekday(4, 4, 2018)  // "quarta-feira" (também format: "abbrev1" ou "abbrev2")

// Nomes e abreviaturas de meses
#get-month-name(3)     // "março"
#get-month-abbrev(1)   // "jan."
#get-month-abbrev(5)   // "maio" (não abreviado)

// Intervalo de meses (para legendas bibliográficas)
#format-month-range(1, 3)  // "jan./mar."

// Séculos e milênios (romanos)
#format-century(20)              // "século XX"
#format-century(21, abbreviated: true)  // "séc. XXI"
#format-millennium(2, bc: true)  // "II milênio a.C."
#to-roman(2026)                  // "MMXXVI"

// Data de acesso para documentos eletrônicos
#access-date(15, 1, 2026)  // "Acesso em: 15 jan. 2026."
#access-date-from(datetime.today())

// Data atual
#today()  // Data de hoje formatada
```

*Constantes exportadas:* `month-abbreviations`, `month-names` (e `month-names-full`, mesmo valor), `weekday-names`, `weekday-abbrev1` e `weekday-abbrev2`. Os rótulos de mês dos exemplos (cronograma etc.) devem seguir a norma: `jan.` e `maio` (e não `Jan`/`Mai`).

=== abbreviations.typ - Abreviação de Títulos (NBR 6032:1989)

Funções para abreviar títulos de periódicos e publicações seriadas. O dicionário (`abbreviation-dict`) tem as 799 entradas da lista brasileira da norma, com a caixa e os acentos dela: substantivo em maiúscula e adjetivo em minúscula (`R. bras. Biol.`, `B. estat. IBGE`).

```typst
// Abreviar título completo
#abbreviate-title("Revista Brasileira de Biologia")
// Resultado: "R. bras. Biol."

#abbreviate-title("Memorias do Instituto Oswaldo Cruz")
// Resultado: "Mem. Inst. Oswaldo Cruz"

// Obter abreviatura de uma palavra (com a caixa da norma)
#get-abbreviation("Revista")     // "R."
#get-abbreviation("Brasileiro")  // "bras."
#get-abbreviation("Biologia")    // "Biol."

// Plural com traço-de-união
#abbreviate-plural("Acad.")  // "Acad-s"

// Palavra composta
#abbreviate-compound("médico-sanitárias")  // "méd.-sanit."

// Com identificação do editor (títulos genéricos)
#abbreviate-with-editor("Boletim Estatístico", "IBGE")
// Resultado: "B. estat. IBGE"
```

`abbreviate-title(title, suppress-articles: true, plural: false)`: o plural (`Acad-s`) é opcional na norma (2.1.5) e vem desligado; `plural: true` o marca. `get-abbreviation(word, preserve-case: false)`: com `preserve-case: true`, a inicial da abreviatura acompanha a da palavra digitada. Título de uma só palavra não se abrevia (2.2.1); palavra de cinco letras ou mais fora da lista fica inteira; `can-abbreviate("Café")` é `false` (palavras de menos de cinco letras não se abreviam, 2.1.2).

*Mudança da 0.7.0:* `abbreviation-dict` mudou de formato. Antes: chave → texto; agora: chave (minúscula e sem acento) → `(substantivo, adjetivo)`, em que o adjetivo é a forma própria quando difere da do substantivo, ou `none`. `abbreviation-extensions` guarda as abreviaturas do pacote que não constam da norma (mesmo formato), e `get-abbreviation` devolve a caixa da norma.

*Auxiliares exportadas:* `can-abbreviate(word)`, `should-suppress(word)` (artigos e preposições a suprimir), e as constantes `no-abbreviate`, `suppressible-words` e `abbreviation-examples`.

*Dicionário de abreviaturas disponíveis (amostra):*

#table(
  columns: (auto, auto, auto, auto),
  stroke: none,
  inset: 6pt,
  table.hline(stroke: 1pt),
  [*Palavra*], [*Abrev.*], [*Palavra*], [*Abrev.*],
  table.hline(stroke: 0.5pt),
  [Revista], [R.], [Boletim], [B.],
  [Brasileiro], [bras.], [Nacional], [nac.],
  [Ciência], [Ci.], [Cultura], [Cult.],
  [Instituto], [Inst.], [Universidade], [Univ.],
  [Biologia], [Biol.], [Geografia], [Geogr.],
  [Economia], [Econ.], [Medicina], [Med.],
  table.hline(stroke: 1pt),
)

== Funções auxiliares exportadas

Funções e constantes de apoio que a `lib.typ` também exporta (os templates as usam; raramente se chamam à mão). As demais funções exportadas estão nas seções de cada módulo acima.

#table(
  columns: (5.5cm, 3.6cm, 1fr),
  stroke: none,
  inset: 5pt,
  table.hline(stroke: 1pt),
  [*Nome*], [*Módulo*], [*O que faz*],
  table.hline(stroke: 0.5pt),
  [`compare-strings(a, b)`], [`sorting.typ`], [Compara duas strings palavra por palavra: devolve -1, 0 ou 1.],
  [`make-entry(text, entry-type:)`], [`sorting.typ`], [Monta uma entrada com o tipo de `entry-types`, para ordenar homógrafas.],
  [`sort-homographs(entries)`], [`sorting.typ`], [Ordena homógrafas: autor, entidade, assunto, título (6033, 4.2).],
  [`extract-number(text)`, `starts-with-number(text)`], [`sorting.typ`], [Valor numérico do começo de um texto; diz se o texto começa por número.],
  [`definite-articles`, `indefinite-articles`, `all-articles`], [`sorting.typ`], [Listas de artigos, por idioma, ignorados na ordenação.],
  [`index-entries`], [`index.typ`], [`state` com as entradas registradas por `idx()` e `index-entry()`.],
  [`manual-index-entry(...)`], [`index.typ`], [Entrada de índice com controle total (ver `index.typ`).],
  [`inline-comment(comment)`, `margin-note(note)`], [`proofreading.typ`], [Comentário em linha e caixa de anotação na margem (ver `proofreading.typ`).],
  [`abnt-frente-verso`, `abre-anverso()`, `marcar-ficha()`, `marcar-folha-rosto()`], [`page.typ`], [Marcas de contagem e de impressão frente-verso (ver `page.typ`).],
  [`abnt-leading(k)`, `abnt-top-edge`, `abnt-bottom-edge`], [`spacing.typ`], [Cálculo da entrelinha (ver `spacing.typ`).],
  [`isbn-groups`, `isbn-groups-979`, `isbn-country(isbn)`], [`identifiers.typ`], [Grupos de registro do ISBN e o país ou grupo de um ISBN.],
  [`abbreviation-dict`, `abbreviation-extensions`, `abbreviation-examples`, `no-abbreviate`, `suppressible-words`], [`abbreviations.typ`], [Dados das abreviaturas (ver `abbreviations.typ`).],
  [`can-abbreviate(word)`, `should-suppress(word)`], [`abbreviations.typ`], [Diz se a palavra pode ser abreviada ou se é suprimida no título.],
  [`month-names`, `month-abbreviations`, `weekday-names`...], [`dates.typ`], [Nomes e abreviaturas de meses e dias da semana.],
  [`nature-block(body)`, `section-spacing`], [`spacing.typ`], [Bloco da natureza do trabalho (recuo 8 cm) e espaço vertical entre seções; sem uso nos templates.],
  [`abnt-fonts`, `abnt-font-sizes`, `abnt-line-spacing`], [`fonts.typ`, `spacing.typ`], [Constantes informativas; nenhum módulo as lê.],
  table.hline(stroke: 1pt),
)

Além das funções do pacote, a `lib.typ` reexporta os nomes do Touying (`pause`, `only`, `uncover`, `alert`, `speaker-note`, `config-common`, entre outros), porque o template de slides os usa. Os nomes que começam por `_` (`_resolve`, `_abnt-titulo`...) são internos: saem na importação porque o Typst não tem privacidade, mas não fazem parte da interface e podem mudar.

= Exemplos Completos

== TCC Completo

Veja o arquivo `examples/tcc-exemplo.typ` para um exemplo completo de Trabalho de Conclusão de Curso.

== Estrutura Recomendada

```
meu-tcc/
├── abntyp/           # Pacote
├── imagens/            # Suas imagens
├── main.typ            # Documento principal
├── capitulos/
│   ├── introducao.typ
│   ├── fundamentacao.typ
│   ├── metodologia.typ
│   ├── resultados.typ
│   └── conclusao.typ
└── referencias.bib     # Bibliografia
```

*main.typ:*

```typst
#import "abntyp/lib.typ": *

// Metadados (capa, folha de rosto e resumo leem daqui)
#show: dados.with(
  titulo: "Título do trabalho",
  autor: "Nome do Autor",
  instituicao: "Universidade Federal de Jataí",
  local: "Jataí",
  ano: 2026,
  palavras-chave: ("palavra um", "palavra dois"),
  palavras-chave-en: ("keyword one", "keyword two"),
)

#show: normas-abnt.with(
  arquivo-bibliografia: read("referencias.bib"),
)

// Pré-textuais
#capa()
#folha-rosto()
#folha-aprovacao()
#resumo[Texto do resumo.]
#resumo-en[Abstract text.]
#sumario()

// Textuais (a paginação é automática: número visível a partir da Introdução)
#include "capitulos/introducao.typ"
#include "capitulos/fundamentacao.typ"
#include "capitulos/metodologia.typ"
#include "capitulos/resultados.typ"
#include "capitulos/conclusao.typ"

// Pós-textuais: as REFERÊNCIAS são geradas automaticamente no fim
// (arquivo-bibliografia); apêndices e anexos entram antes delas, se houver.
```

= Aliases (nomes curtos)

As funções mais usadas do ABNTyp têm aliases curtos equivalentes (a lista abaixo é completa: são 36 aliases; a maioria das funções, como `capa`, `sumario`, `container` e `citar`, não tem alias). Use qualquer uma das formas --- ambas produzem o mesmo resultado.

=== Citações e texto (quotes.typ)

- `citacao-curta` → `ccurta`
- `citacao-longa` → `clonga`
- `interpolacao` → `interp`
- `grifo-nosso` → `gnosso`
- `grifo-do-autor` → `gautor`

=== Sistema autor-data (citation.typ)

- `citar-autor` → `cautor`
- `citar-indireto` → `cindireto`
- `citar-apud` → `capud`
- `citar-multiplos` → `cmultiplos`
- `citar-varios` → `cvarios`
- `citar-etal` → `cetal`
- `citar-entidade` → `centidade`
- `citar-titulo` → `ctitulo`
- `referencias-titulo` → `ref-titulo`

=== Sistema numérico (numeric.typ)

- `citar-num` → `cnum`
- `citar-num-linha` → `cnlinha`
- `citar-num-multiplos` → `cnmultiplos`
- `citar-num-apud` → `cnapud`
- `citacao-num-curta` → `cncurta`
- `citacao-num-longa` → `cnlonga`
- `bibliografia-numerica` → `bibnum`

=== Elementos pré-textuais

- `folha-rosto` → `rosto`
- `ficha-catalografica` → `ficha`
- `dedicatoria` → `dedica`
- `agradecimentos` → `agradece`
- `lista-siglas` → `siglas`
- `lista-simbolos` → `simbolos`

=== Outros (nomes antigos e atalhos)

- `normas-abnt` → `abntcc` (nome da 0.1.2)
- `titulo-sem-num` → `secao`
- `abnt-cite-setup` → `configurar-citacoes-abnt` (no-op)
- `small-text` → `footnote-text` e `caption-text`
- `pause` → `slide-pause`, `only` → `slide-only`, `uncover` → `slide-uncover` (Touying)
- `month-names` → `month-names-full`

= Perguntas Frequentes

== Como mudar a fonte para Arial?

```typst
#show: normas-abnt.with(
  // ...
  fonte: "Arial",
)
```

Fora do Linux (macOS e Windows), isso gera *1 aviso* na compilação: `unknown font family: liberation sans`. O aviso é esperado e aceito de propósito: a pilha da Arial inclui a "Liberation Sans" (o clone métrico da Arial), para que o texto não caia numa fonte serifada onde só existe a Liberation Sans; o PDF sai correto, com a Arial. Com a Times New Roman (o padrão) não há aviso. A NBR 14724:2024 não exige Times nem Arial; ver "Pilhas de fonte" em `fonts.typ`.

== Como usar numeração romana nos pré-textuais?

Por padrão (`paginacao: "auto"`), os elementos pré-textuais são contados mas não numerados, conforme a NBR 14724:2024; o número aparece a partir da primeira seção primária numerada. O pacote não oferece numeração romana automática. Se a sua instituição a exige, desligue a paginação automática e controle a numeração manualmente (atenção: reiniciar o contador antes da Introdução, como abaixo, contraria a 5.3 da norma, pela qual todas as folhas a partir da folha de rosto são contadas em sequência; com ele, a Introdução vira a página 1 e as listas e o sumário apontam números que a norma não prevê):

```typst
#show: normas-abnt.with(paginacao: "nenhuma", /* ... */)

// Após a folha de rosto
#set page(numbering: "i")
#counter(page).update(1)

// Antes da introdução
#set page(numbering: "1", number-align: top + right)
#counter(page).update(1)
```

== Como criar seção sem numeração?

```typst
#titulo-sem-num("REFERÊNCIAS")
```

`secao` é mantido como alias de `titulo-sem-num` por compatibilidade:

```typst
#secao("REFERÊNCIAS")
```

== Como ajustar o recuo da citação longa?

A NBR 10520:2023 (7.1.1) *recomenda* o recuo de 4 cm da margem esquerda para a citação longa, e `citacao-longa` o aplica; o pacote não tem parâmetro para alterá-lo (o "deve" da norma é para o recuo padronizado, a letra menor, o espaço simples e a ausência de aspas). Para um bloco recuado qualquer (que não seja citação ABNT), use `indented-block`:

```typst
#indented-block(recuo: 5cm)[
  Texto do bloco...
]
```

== Posso usar arquivo .bib para referências?

Sim! O pacote inclui suporte a arquivos `.bib` com formatação automática ABNT. Existem duas formas de usar:

*Opção 1: Via template*

```typst
#show: normas-abnt.with(
  // ... outros parâmetros ...
  arquivo-bibliografia: read("referencias.bib"),
  titulo-bibliografia: "REFERÊNCIAS",  // opcional
)
```

*Opção 2: Diretamente no documento*

```typst
// No final do documento:
#abnt-bibliography(read("referencias.bib"))
```

Na opção 1, as REFERÊNCIAS são geradas automaticamente no fim do documento; não chame `#abnt-bibliography` nem `#referencias` de novo. O parâmetro deve ser `read(...)`: um caminho em string resolve relativo ao pacote e dá erro explicativo.

O pacote usa um arquivo CSL baseado nas normas NBR 6023:2018 e NBR 10520:2023.

*Limitações conhecidas:*
- O campo `subtitle` do BibTeX é descartado; escreva `title = {Título: subtítulo}`, e título e subtítulo saem juntos em negrito (limitação do formato CSL)
- Títulos de obras sem autor devem ter a primeira palavra em MAIÚSCULAS no arquivo .bib, e `shorttitle` para a chamada no texto
- Capítulo de livro: `@inbook` (não `@incollection`); teses: `publisher` e `type` completo; trabalho em evento: `eventtitle` e `venue` (ver `bibliography.typ`)
- Legislação, jurisprudência, atos e documentos de cartório não têm suporte: escreva a referência à mão

Para casos especiais, você pode usar as funções de formatação manual (`ref-livro`, `ref-artigo`, `ref-online`).

= Limitações Conhecidas

O que o pacote ainda não faz ou faz com ressalva. Cada item remete à seção do módulo.

*Paginação e frente-verso*
- Em frente-verso, a Introdução pode cair no anverso (página ímpar do PDF) com *número par*: a ficha catalográfica, no verso da folha de rosto, não é contada (NBR 14724:2024, 5.3), mas ocupa uma página física, e a posição do número segue a página física. É o efeito de seguir a norma ao pé da letra (`page.typ`).
- Em frente-verso, as *orelhas* (`book-orelha`) contam como páginas físicas do PDF e deslocam a paridade; quem as imprime à parte não é afetado (`book.typ`).
- No livro, uma `#pagebreak()` solta antes de um elemento que abre em página ímpar deixa uma página em branco *com* cabeçalho e número; use `pagebreak(weak: true)` (`book.typ`).
- Reiniciar o contador de páginas à mão antes da Introdução (FAQ da numeração romana) contraria a 5.3 da norma.

*Tabelas e ilustrações*
- Em tabela longa com `table.hline` escrito à mão e *sem* `table.header`, o traço inicial reaparece no alto das páginas seguintes, sem o cabeçalho (`tables.typ`).
- Tabela longa só quebra entre páginas sob `with-abnt-setup`; fora dele, não quebra (`setup.typ`).
- `container` com `tipo` diferente de imagem, tabela e quadro exige `suplemento:`; sem ele a numeração se repete (`figures.typ`).

*Índice e ordenação*
- Termos de índice dados como conteúdo (`idx([*x*])`) ainda são ordenados e agrupados pelo `repr` do conteúdo (`index.typ`).
- `indice-onomastico`, `indice-autores`, `indice-assuntos` e `indice-geral` só mudam o título: o registro não tem tipo (`index.typ`).
- A ordem da NBR 6033 tem casos não tratados (exemplo 3.6.2 da norma, `A e B`, `La Rochefoucault` sem vírgula, hífen) (`sorting.typ`).

*Identificadores*
- A forma do produto e o ISBN por volume (NBR ISO 2108, 6.4) não são tratados; o ISBN inválido dá erro em `livro()`, `book-title-page-verso()` e `book-back-cover()` (`book.typ`).
- `format-isbn` só separa os elementos nos comprimentos dados: não tem a tabela de intervalos da Agência do ISBN (`identifiers.typ`).

*Referências e citações*
- Legislação, jurisprudência, atos administrativos e documentos de cartório não têm campos no Typst: escreva a referência à mão. Data incerta (`[s. d.]`, `c1993`) não é bem tratada (`bibliography.typ`).
- O Typst 0.13 descarta o `type` de tese, e a desambiguação por iniciais (`Barbosa, C., 1958`) e a ordem de nomes acentuados dependem da versão do compilador (`bibliography.typ`).
- No sistema numérico, a proibição de notas de rodapé (10520, 6.2.2) é do autor: o pacote não a impede (`numeric.typ`).
- `citar-id`, `citar-ibid` e `citar-opcit` não verificam se a nota anterior está na mesma página, como a norma exige (`citation.typ`).
- `@a @b` nativo separa por `;` os anos do mesmo autor (`Dreyfuss, 1989; 1991`); `citar-varios` junta (`Dreyfuss, 1989, 1991`) (`citation.typ`).

*Slides*
- `--pdf-standard ua-1` reprova os dois exemplos de slides (o Touying exige um título de nível 1 primeiro); `<touying:hidden>` passa no UA-1, mas põe o título da apresentação no cabeçalho de todos os slides, por isso foi revertido.
- Sumário com mais de 6 itens, referências com mais de 5 e comparativo ou metodologia com texto longo ainda passam da página (`slides.typ`).

*Estrutura*
- O pacote não recusa mais de cinco níveis de seção, que a NBR 6024 não admite (`headings.typ`).
- `titulo-sem-num` produz "Seção Título" em `@rótulo`, não "Seção X": não há número.

= Changelog

== Versão 0.7.0 (Outubro 2026)

Resultado de uma revisão do pacote contra o texto das normas. Esta entrada lista o que muda na saída ou no uso, para quem atualiza da 0.6.0.

*Quebras de API (o documento antigo pode precisar de ajuste):*

- `#sub[…]` do pacote (sublinhado) virou `#sublinhado[…]`; `#sub[…]` volta a ser o subscrito nativo do Typst. Sem a troca o texto sai subscrito, sem erro.
- `abnt-page-setup`, `abnt-font-setup`, `abnt-spacing-setup`, `abnt-heading-setup`, `abnt-footnote-setup`, `abnt-figure-setup`, `abnt-table-setup`, `abnt-page-numbering`, `pretextual-numbering`, `start-arabic-numbering` e `no-page-numbering` recebem `body`: use `#show: abnt-page-setup.with(…)`. A chamada antiga `#abnt-page-setup()` (que não fazia nada) agora dá `missing argument: body`.
- `container()` sem `fonte:` (nem `origem:`) aborta com mensagem em português; `fonte: none` dispensa.
- ISBN inválido (texto que não seja ISBN-13 978/979 com dígito certo nem ISBN-10 válido) dá erro em `livro()`, `book-title-page-verso()` e `book-back-cover()`; passar conteúdo (`[em obtenção]`) contorna.
- `format-isbn` com grupo + registrante + publicação que não somam 9 dígitos dá erro; `validate-isbn` recusa o que não é 978/979; `format-date-numeric`, `format-date-mixed` e `format-date-short` dão erro com ano de menos de quatro dígitos.
- Sistema numérico: o número da obra deixa de repetir (antes, com cinco ou mais obras novas a saída era `(5) (5) (5)` e o Typst avisava que o layout não convergia); agora `(1) (2) (3) (4) (5) (6) (7) (1) (8)`. `citacao-num-curta` tira os espaços das pontas do conteúdo e usa “ ” explícitas.
- `citar-num-apud`: o primeiro argumento é o *texto* da chamada original (`"Freire, 1994"`), não uma chave; só a fonte consultada entra na lista.
- `abbreviation-dict` mudou de formato (chave → `(substantivo, adjetivo)`); `get-abbreviation` devolve a caixa da norma (`bras.`, não `Bras.`).
- `sort-key` devolve uma chave opaca (não imprimir); glossário, lista de siglas, índice e `book-index` ordenam pela NBR 6033.
- `artigo()` e `relatorio()` saem em espaço *simples* por padrão; `espacamento: "1,5"` volta ao anterior.
- `projeto-pesquisa`: a numeração de página vem do template e conta desde a folha de rosto; quem fazia `counter(page).update(1)` à mão deve removê-lo.
- `periodical-toc()` não usa mais `outline`; `periodical()` ganhou `pagina-inicial`; em `periodical-cover` e `periodical-title-page`, `titulo` passou de `""` a `none`.
- Livro: as funções não terminam mais em `pagebreak()` (cada uma abre a própria página); `book-epigraph` põe a referência em nota de rodapé (`em-nota: false` volta ao anterior); `book-start-numbering()` é função vazia; as subdivisões de `book-appendix` e `book-annex` saem sem número; `cabecalho` aceita `(par:, impar:)` e `auto`.
- Relatório: `report-cover()` não marca mais a folha de rosto (a contagem começa na folha de rosto: a Introdução do exemplo passou de 8 a 7); `report-code()` devolve texto; `arquivo-bibliografia` com caminho em string aborta cedo.
- Pôster: `poster-a1` passa de 59,4 × 84,1 a 60 × 90 cm; `academic-poster(logo:)` não duplica mais o logotipo (use `logo-direita:`); `poster()` e `academic-poster()` abortam com `titulo` vazio.
- `lombada()` sai em retrato (largura × altura), com o texto do alto para o pé.
- `ref-livro`, `ref-artigo` e `ref-online` mudaram de saída e de layout (último sobrenome em maiúsculas, sem recuo).
- Slides: um `==` escrito antes de `slide-*(titulo: "X")` agora mostra os dois títulos (use `titulo: ""` ou retire o `==`); `slide-*(cor-primaria:)` passa a ser `auto`.
- Listas vazias (`lista-ilustracoes`, `lista-tabelas`, `lista-quadros`, `lista-siglas`, `lista-simbolos`) não imprimem mais nada, nem o título.

*Mudanças na saída visível:*

- Entrelinha calibrada pelo Word: 20,7 pt em 12 pt (13,8 pt no espaço simples, 27,6 pt no duplo), igual em Times e em Arial; o espaço entre parágrafos é igual à entrelinha.
- Vão antes do título de nível 1: 51,01 pt, maior que o do nível 2 (42,30 pt); o título de nível 1 abre a página no topo da mancha. Títulos nunca ficam sozinhos no pé da página (o `tcc-exemplo` passou de 19 a 20 páginas).
- Títulos sem indicativo numérico (REFERÊNCIAS, APÊNDICE, ANEXO, GLOSSÁRIO) centralizados; segunda linha de título e de nota de rodapé sob a primeira letra.
- Legendas e listas de ilustrações com travessão (`Figura 1 – Título`); "Fonte:" e "Nota:" alinhadas à esquerda da ilustração; sumário com indicativos na margem, títulos em coluna e entradas em espaço simples.
- Palavras-chave separadas por `;` com ponto final (TCC, artigo, relatório, periódico, pôster); título da capa e natureza em 12 pt (TCC e projeto de pesquisa).
- Ficha catalográfica fora da contagem de páginas; em frente-verso, elementos pré-textuais no anverso (mais páginas em branco), e a Introdução pode cair no anverso com número par.
- `@rótulo` de seção primária do TCC diz "Seção N" (era "Capítulo N"); `@rótulo` de `apendice`, `anexo` e `titulo-sem-num` passa a funcionar (sob `with-abnt-setup`).
- Lista de siglas em ordem alfabética; referências sem recuo francês, em espaço simples, com linha em branco entre elas, em pt-BR; chamadas e notas conforme a 10520:2023 (`tradução nossa, grifo nosso`).
- `tabela()` desenha os três traços da IBGE e repete o cabeçalho; tabela de várias páginas com "(continua)", "(continuação)" e "(conclusão)"; o último `table.hline` escrito à mão sai só na última página; tabela maior que a página quebra (sob `with-abnt-setup`).
- Índice: entradas que diferem só por caixa ou acento viram uma; termos com subentradas inteiros na coluna, "(continuação)" nos maiores que uma coluna.
- Artigo: título de 12 pt, `TÍTULO:` com subtítulo na linha seguinte, RESUMO e ABSTRACT centralizados. Periódico: legenda com o intervalo de páginas do artigo, sem rodapé na capa e na folha de rosto, sumário por artigos. Livro: cabeçalho só nos elementos textuais, sem cabeçalho e número em páginas em branco, `©` no verso. Pôster: colunas equilibradas, título e autores centralizados, afiliações numeradas. Slides: data em português, capa em 1 página, rodapé com o contador separado do autor, texto auxiliar de contraste >= 4,5:1.
- Chamadas com página: o CSL deixa de somar dois espaços antes de "p." (`(Silva; Santos, 2023, p. 45)`); `cronograma-simples` com mais de 6 períodos de rótulo maior que 4 caracteres escreve o cabeçalho na vertical; o aviso do sistema numérico passa de `gray` a `luma(60)` (contraste).
- `fonte: "Arial"` fora do Linux gera 1 aviso `unknown font family: liberation sans` (aceito de propósito); as pilhas de fonte não citam mais famílias que não existem em nenhum ambiente (`Linux Libertine`, `Linux Biolinum`, `Noto Sans`).

*Funções e parâmetros novos:*

- Núcleo: `folha-aprovacao(data:, banca:)`; `volume:` em `capa()`, `folha-rosto()` e `dados()`; `lista-ilustracoes(tipo:, titulo:)`; `lista-siglas(titulo:)`; `errata` documentada para o TCC; `glossario(quebra:)`; `container(suplemento:)` para outros tipos; `indice(titulo: none)`, `indice(nota:, canto:)`, `idx(subsubtermo:, volume:)`; `sinal-convencional` e `nota-sinais`; `tabela(moldura:, continuacao:)`; `sort-initial`; `abnt-leading`, `abnt-top-edge`, `abnt-bottom-edge`.
- Referências e citações: `citar-id`, `citar-ibid`, `citar-opcit`, `citar-loccit`, `citar-passim`, `citar-cf`, `citar-etseq`, `citar-ref`; `volume`, `localizacao`, `grifo` e `traducao` em `citacao-curta`, `citacao-longa` e `citar`; `citacao-num-config` aplica de fato o `estilo` e os `colchetes`; `format-date-time`, `get-weekday`, `format-weekday`, `to-roman`; `suprimir-espaco`, `retirar-e-unir`, `mark-titlecase` e outros sinais da NBR 6025; `review-legend` em três blocos.
- Templates: `espacamento` em `artigo()` e `relatorio()`; `submissao`, `aprovacao`, `doi`, `titulo-en`, `agradecimentos` em `artigo()` e `agradecimentos-artigo`; `pagina-inicial` e `dia` em `periodical()`; `frente-verso` em `projeto-pesquisa()`; `referencias-relatorio()`, `titulo-volume`, `pagina-inicial` e os campos novos de `formulario-identificacao`; `equilibrar-colunas`, `cor-texto`, `logo-direita`, `largura-logo` e `altura-logo` no pôster.
- Livro: `book-orelha`, `book-errata`, `book-guarda`, `book-list-quadros`; `serie` em `half-title-page`; `licenca` e `isbn` em `book-title-page-verso`; `rotulo` em `book-appendix` e `book-annex`; `em-nota` em `book-epigraph`; `canto` em `book-index`.
- Lombada: `fasciculo:`, vários autores em `autor:`.
- Slides: `slides(..config)` repassa configuração ao Touying (notas do apresentador); `data:` aceita texto, conteúdo ou `datetime`; `autor:` aceita lista.

== Versão 0.6.0 (Outubro 2026)

- `normas-abnt` ganhou o parâmetro `quebra-capitulo: true` (passa para `level-1-pagebreak`; `false` desliga a quebra de página antes de capítulos).
- Paginação automática conforme a NBR 14724:2024 em `normas-abnt`: contagem a partir da folha de rosto, número visível só a partir da primeira seção primária numerada, canto superior direito. Parâmetro `paginacao: "auto" | "todas" | "nenhuma"`. Antes, `textual()`/`postextual()` usavam `set page` dentro de função e não tinham efeito nas páginas seguintes.
- `normas-abnt` ganhou `frente-verso: true` (margens espelhadas, número à esquerda nas páginas pares, seções primárias em página ímpar).
- `relatorio` (NBR 10719) ganhou `paginacao` e `frente-verso`; `livro` (NBR 6029) ganhou `paginacao` (contagem desde a primeira folha do miolo, número visível após o sumário, rodapé centralizado). Helpers em `core/page.typ`: `abnt-numero-pagina`, `abnt-margens`, `marcar-folha-rosto`.
- `livro` ganhou `frente-verso`: margens espelhadas; falsa folha de rosto, folha de rosto, dedicatória, agradecimentos, epígrafe, prefácio/apresentação, partes e capítulos em página ímpar.
- `container`: devolve um único `figure` (o `<label>` após a chamada e o `@rótulo` funcionam); legenda acima (`figure.caption(position: top)`; também aplicada a figuras e tabelas nativas); `fonte` como nome preferido de `origem`; novo `posicao`; "Nota" centralizada (também `nota-figura`).
- `imagem()`: `pagina: auto` não quebra mais; caminho em string agora dá erro explicativo (use `read(..., encoding: none)`).
- Novos: `alineas`/`subalineas`; `parte` (numerada, no sumário e em referências); `quebra-pagina(fraco:, para:)`; `novo-slide()`.
- `with-abnt-setup` e todos os templates (`normas-abnt`, `artigo`, `relatorio`, `projeto-pesquisa`, `livro`, `periodical`): parâmetro `enumeracao` — `"abnt"` (padrão: alíneas `a)`, `b)`, `c)` e subalíneas com travessão, NBR 6024) ou `"latex"` (`1.`, `a)`, `i)`, `A.`); nova função `numeracao-enum(esquema)` e módulo `core/lists.typ`; links externos sublinhados (`cor-links`); formatação de `parte`.
- `slides`: removido o import do tema `university` do Touying, que sobrescrevia `slide` do tema `simple`.
- `normas-abnt(arquivo-bibliografia:)` exige `read(...)`; caminho em string dá erro explicativo.
- Palavras-chave: uma única palavra (string) é aceita em `resumo`, `resumo-en`, `artigo`, `periodical` e `relatorio`.
- Corrigido crash do template `relatorio` sem `autores`.
- Corrigido crash do template `artigo` quando chamado sem `autores`.
- `citacao-curta`, `citacao-longa`, `citar`, `citar-autor`, `citar-indireto`, `citar-entidade`, `citar-titulo` e `citar-apud` agora aceitam um `<chave>` de entrada `.bib` no lugar do autor/entidade/título em texto. Antes, essas funções só imprimiam texto formatado e nunca chamavam `#cite()` — então, mesmo citando uma obra que estava no `.bib`, a referência não entrava na lista de referências e o texto da citação não era um link clicável. Agora, passando a chave (ex.: `#citacao-longa(<silva2023>, pagina: "45")[...]`), a função delega para `#cite()` nativo: a entrada é adicionada automaticamente à bibliografia e o texto renderizado vira link clicável, com a formatação ABNT preservada. Uso com string (sem `.bib`) continua funcionando sem mudanças.

== Versão 0.1.5 (Junho 2026)

- `#pag(<chave>)` ganhou o parâmetro opcional `autor:` para citações na sentença com 2–3 autores. O motor de citações do Typst (Hayagriva) junta os sobrenomes sempre com `;`, mas a NBR 10520:2023 pede `e` na frase (`Lima; Serrano` entre parênteses, mas `Lima e Serrano` na sentença). Informe a grafia da frase em `autor:` — o ano continua vindo do `.bib`: `#pag(<lima2024>, autor: "Lima e Serrano")` → Lima e Serrano (2024)
- Nova função `#glossario(itens)` (genérica), que faltava: cria o título "GLOSSÁRIO" (sem indicativo numérico, entra no sumário) e lista os termos em ordem alfabética. Antes só existiam `glossario-projeto` (template de projeto) e `book-glossary` (livro), e a documentação referia `#glossario` por engano. Corrigido o exemplo na introdução.

== Versão 0.1.4 (Junho 2026)

- Corrigido o carregamento do estilo `abnt.csl` no Typst 0.14 — removidos elementos vazios (`<else/>`, `<single/>`, `<text value=""/>`) que impediam o Typst de ler o CSL
- `#referencias(...)` agora aceita `read(...)` para resolver o arquivo `.bib` relativo ao documento do usuário
- Caixa do sobrenome conforme NBR 10520:2023 — inicial maiúscula na chamada (na frase e entre parênteses), CAIXA ALTA apenas na lista de referências
- Novas funções de citação com leitura do `.bib`:
  - `#pag(<chave>)` — autor na frase, com página opcional
  - `#apud("Original", ano, <chave-consultada>)` — citação de citação (apud)
  - `citar-varios(...)` — várias obras numa única chamada (autor-data)
- `et al.` automático para 4+ autores (removido `et-al-use-last` do CSL)
- Página em `citar-autor(...)`
- "p." nas páginas de artigos em publicação periódica
- `configurar-citacoes-abnt` agora é no-op — o estilo ABNT é aplicado automaticamente pelo `#referencias`
- Documentação: caminho `@chave` apresentado primeiro e `#citar*` como fallback; quadro-resumo de citações tornado quebrável entre páginas; regra mental (`#pag` / `@` / `#apud`) destacada; novo exemplo `examples/citacao-autordata-exemplo.typ`

== Versão 0.1.3 (Abril 2026)

- `#titulo-sem-num()` — novo nome para títulos sem numeração (Referências, Apêndices, etc.)
  - `#secao` mantido como alias de retrocompatibilidade
- `#apendice("A", "Título")` e `#anexo("A", "Título")` — headings com suplemento correto para `@label`
  - Referências cruzadas agora produzem "Apêndice A" e "Anexo A" em vez de "Capítulo A"
- `#sub`, `#risc`, `#caps` — atalhos de formatação inline (sublinhado, riscado, versalete); a partir da 0.7.0 o sublinhado é `#sublinhado`, e `#sub` é o subscrito nativo do Typst
- `suplemento-nivel1` em `with-abnt-setup()` — "Seção" para artigos/projetos, "Capítulo" para TCC/relatórios/livros (a partir da 0.7.0 o TCC diz "Seção": a NBR 14724:2024, 4.2.2, não admite "capítulos")
- Corrigido `textual()` — não reinicia mais o contador de páginas (conformidade NBR 14724:2024)
- Renomeado `abntcc` → `normas-abnt` (nome mais descritivo para o template principal de TCC/tese)
- Fallback de fontes para Typst.app e Linux:
  - Times New Roman → Times → Libertinus Serif → New Computer Modern
  - Arial → Helvetica → Liberation Sans → New Computer Modern
  - (pilhas atuais, da 0.7.0; as da 0.1.3 citavam "Linux Libertine", "Linux Biolinum" e "Noto Sans", que não existem em nenhum ambiente do Typst e geravam aviso em toda compilação)
- Documentação: seção de citações (3.2) reorganizada com estrutura clara por tipo e sistema

== Versão 0.1.2 (Março 2026)

- Aliases curtos para todas as funções principais
  - Citações: `ccurta`, `clonga`, `cautor`, `capud`, `cmultiplos`, `cetal`, etc.
  - Numérico: `cnum`, `cnmultiplos`, `cncurta`, `cnlonga`, `bibnum`, etc.
  - Elementos: `rosto`, `ficha`, `dedica`, `agradece`, `siglas`, `simbolos`
  - Texto: `interp`, `gnosso`, `gautor`
- `citacao-curta` e `citacao-longa` aceitam parâmetros posicionais via `..args`
  - `#citacao-curta("Silva", 2023, 45)[texto]` (posicional)
  - `#citacao-curta(autor: "Silva", ano: 2023)[texto]` (nomeado)
- Parâmetros numéricos (`ano`, `pagina`, `volume`, etc.) documentados como `int` (sem aspas)
- Documentação atualizada: guia-rapido, manual-implementacao, introducao-abntyp, README

== Versão 0.1.1 (Março 2026)

- Nova função `dados()` para metadados centralizados
  - Armazena título, autor, instituição, etc. em state compartilhado
  - Elementos pré-textuais (`capa()`, `folha-rosto()`, `resumo()`, etc.) leem automaticamente do state
  - Aceita uso via `#show: dados.with(...)` ou chamada direta
  - Valida parâmetros desconhecidos com `panic()`
  - Configura metadados do PDF automaticamente
- Novo módulo `setup.typ` com `with-abnt-setup()` (interno)
  - Configuração unificada de página, fonte, parágrafos, headings, listas e rodapé
  - Elimina ~720 linhas de duplicação entre 6 templates
- Citações diretas (`citacao-curta`, `citacao-longa`): parâmetros `autor`, `ano`, `pagina` agora todos nomeados e opcionais
  - Permite uso sem referência: `#citacao-curta()[texto]`
  - Aspas tipográficas \u{201C}...\u{201D} (eram ASCII)
- `resumo()` e `resumo-en()` leem `palavras-chave` do state quando não passadas explicitamente
- `capa()` e `folha-rosto()` usam `_resolve()` para ler do state; título+subtítulo via `_render-titulo()`
- `_str-safe()` aceita tipo `content` (retorna diretamente em vez de `repr()`)
- Lombada (`spine.typ`): helper `_to-str()` e variáveis `ano-str`/`vol-str` eliminam duplicação
- Índice (`index.typ`): `num-colunas` renomeado para `colunas`; `from`/`to` renomeados para `de`/`para`
- `footnote-text` e `caption-text` são aliases de `small-text` (sem duplicação)
- Sumário (`toc.typ`): show rules extraídas em `_abnt-outline-rules()`
- `normas-abnt()` simplificado: recebia apenas `fonte` e `arquivo-bibliografia` (hoje tem mais parâmetros: ver `thesis.typ`)
- Dependência `touying` restaurada em `typst.toml` (hoje o `typst.toml` não declara `[dependencies]`; o `touying` é importado direto em `slides.typ`)

== Versão 0.1.0 (Janeiro 2026)

- Versão inicial
- Implementação dos módulos core (page, fonts, spacing)
- Elementos pré-textuais (capa, folha de rosto, resumo, sumário)
- Elementos textuais (seções, citações, figuras, tabelas)
- Templates para tese/TCC e artigo

== Marcos de desenvolvimento anteriores à publicação (numeração interna)

As quatro entradas abaixo (0.5.0 a 0.2.0) são marcos do desenvolvimento, numerados à parte da série publicada (as tags do repositório são v0.1.3, v0.1.4, v0.1.5 e v0.6.0). Elas ficavam intercaladas na lista das versões e fora de ordem; as datas são as do texto original e não foram conferidas com o histórico do repositório.

=== Marco 0.5.0 (Fevereiro 2026)

- Conformidade de headings com NBR 6024:2012 em todos os templates
  - Indicativo numérico agora herda a formatação do nível (negrito, itálico, etc.)
  - Adicionado nível 5 (quinário: minúsculas, itálico) nos templates thesis, technical-report, research-project e book
  - Corrigida hierarquia dos níveis 2 e 3 no template book (estavam invertidos)
  - Corrigido nível 2 nos templates article e periodical (agora MAIÚSCULAS sem negrito)
- Indentação de parágrafos (`all: true`)
  - Todos os templates agora usam `first-line-indent: (amount: 1.25cm, all: true)` para indentar todos os parágrafos, inclusive o primeiro após títulos (o recuo de 1,25 cm é convenção adotada pelo pacote; a NBR 14724:2024 não traz essa medida)
  - Show rules para excluir containers (heading, figure, raw, outline, terms) da indentação
  - Configuração de recuo para listas, enumerações e termos em todos os templates
- Sumário conforme NBR 6027:2012 (`toc.typ`)
  - Entradas do sumário agora espelham a formatação dos headings (5 níveis)
  - Nível 1: MAIÚSCULAS + negrito; Nível 2: MAIÚSCULAS; Nível 3: negrito; Nível 4: normal; Nível 5: itálico
- Funções renomeadas para português (nomes públicos)
  - Templates: `normas-abnt`, `artigo`, `relatorio`, `projeto-pesquisa`, `livro`, `slides`, `slides-defesa`
  - Elementos: `capa()`, `folha-rosto()`, `ficha-catalografica()`, `resumo()`, `sumario()`
  - Citações: `citar()`, `citar-autor()`, `citar-multiplos()`, `citar-etal()`, `citar-apud()`, etc.
  - Citações diretas: `citacao-curta()`, `citacao-longa()`, `supressao`, `interpolacao()`, `grifo-nosso()`, `grifo-do-autor()`
  - Referências: `ref-livro()`, `ref-artigo()`, `ref-online()`, `referencias-titulo()`
  - Sub-funções internas de templates mantêm nomes em inglês

=== Marco 0.4.0 (Janeiro 2026)

- Novo template `research-project.typ`: projetos de pesquisa conforme NBR 15287:2025
  - Template completo com capa e folha de rosto específicas
  - Função `cronograma-simples()` e recursos do projeto
  - Glossário, apêndices e anexos
- Novo template `technical-report.typ`: relatórios técnicos conforme NBR 10719:2015
  - Capa e folha de rosto com código de identificação
  - Classificação de segurança
  - Errata e formulário de identificação
  - Verso da folha de rosto com equipe técnica
- Novo template `poster.typ`: pôsteres científicos conforme NBR 15437:2006
  - Templates para A0, A1 e dimensões personalizadas
  - Variante para pôsteres acadêmicos com orientador
  - Funções para seções, destaques e referências
  - Dimensões recomendadas (60-90cm x 90-120cm)
- Novo módulo `index.typ`: índices conforme NBR 6034:2004
  - Registro de entradas no texto com `#idx()`
  - Remissivas "ver" e "ver também"
  - Índices alfabéticos, de assuntos, onomástico e de autores
  - Subcabeçalhos e agrupamento por letras
- Novo módulo `spine.typ`: lombada conforme NBR 12225:2004
  - Lombada descendente e horizontal
  - Espaço reservado de 30mm para etiquetas
  - Preview da lombada no documento
  - Título de margem de capa para documentos finos

=== Marco 0.3.0 (Janeiro 2026)

- Novo módulo `dates.typ`: representação de datas e horas conforme NBR 5892:2019
  - Formatação de datas em formatos misto, resumido e numérico
  - Formatação de horas em formatos abreviado e digital
  - Abreviaturas de meses conforme a norma
  - Funções para séculos e milênios
  - Intervalos de meses para legendas bibliográficas
- Novo módulo `abbreviations.typ`: abreviação de títulos conforme NBR 6032:1989
  - Dicionário completo de abreviaturas padrão
  - Função automática para abreviar títulos de periódicos
  - Suporte a plurais com traço-de-união
  - Tratamento de palavras compostas
- Novo template `periodical.typ`: publicações periódicas conforme NBR 6021:2015
  - Template para fascículos de periódicos
  - Capa com ISSN, volume, número e data
  - Legenda bibliográfica automática
  - Suporte a editorial e artigos
- Novo template `book.typ`: livros e folhetos conforme NBR 6029:2023
  - Elementos de capa e contracapa
  - Folha de rosto (anverso e verso)
  - Elementos pré-textuais completos (dedicatória, agradecimentos, epígrafe, listas)
  - Elementos pós-textuais (posfácio, glossário, apêndice, anexo, índice, colofão)
  - Título corrente configurável
  - Paginação conforme a norma

=== Marco 0.2.0 (Janeiro 2026)

- Novo módulo `sorting.typ`: ordenação alfabética conforme NBR 6033:1989
  - Funções para ordenar listas ignorando artigos e acentos
  - Suporte a índices alfabéticos com cabeçalhos
  - Tratamento de homógrafas por tipo de entrada
- Novo módulo `proofreading.typ`: símbolos de revisão conforme NBR 6025:2002
  - Marcações de texto (deletar, inserir, substituir, transpor)
  - Marcações tipográficas (itálico, negrito, caixa alta/baixa)
  - Marcações de parágrafo (novo parágrafo, alinhar, centralizar)
  - Controle de alterações (adicionado, removido, modificado)
- Novo módulo `identifiers.typ`: ISBN e ISSN
  - Validação de ISBN-10 e ISBN-13 conforme NBR ISO 2108:2006
  - Validação de ISSN conforme NBR 10525:2005
  - Funções de formatação e exibição
  - Cálculo de dígitos verificadores
  - Conversão ISBN-10 para ISBN-13

= Licença

MIT License

Copyright (c) 2026

== Atribuições

O arquivo `abnt.csl` foi adaptado do projeto #link("https://github.com/virgilinojuca/csl-abnt")[csl-abnt] (CC0/domínio público), desenvolvido por:

- *Jucá da Costa* (\@virgilinojuca)
- *Antenor Aguiar C. A. Matos* (\@AAguiarCAM)

O arquivo original foi disponibilizado sob licença CC0 (domínio público) e é redistribuído neste pacote sob licença MIT.

== Texto da Licença

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
