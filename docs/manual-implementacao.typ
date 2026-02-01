// Manual de Implementação do ABNTypst
// Documentação completa do pacote

#set document(
  title: "Manual de Implementação do ABNTypst",
  author: "ABNTypst",
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
  #text(size: 24pt, weight: "bold")[ABNTypst]

  #v(1cm)
  #text(size: 14pt)[Formatação de Documentos Acadêmicos]
  #text(size: 14pt)[conforme Normas ABNT para Typst]

  #v(2cm)
  #text(size: 12pt)[Manual de Implementação]

  #v(1cm)
  #text(size: 11pt)[Versão 0.4.0]

  #v(1fr)
  #text(size: 11pt)[Janeiro 2026]
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

O *ABNTypst* (ABNTypst Biblioteca Normativa Typst) é um pacote para o sistema de composição tipográfica Typst que implementa as normas da Associação Brasileira de Normas Técnicas (ABNT) para formatação de documentos acadêmicos.

== Por que usar o ABNTypst?

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

- Typst versão 0.11 ou superior
- Fontes: Times New Roman ou Arial (opcionais, mas recomendadas)

== Instalação Local

Clone ou baixe o repositório e coloque a pasta `abntypst` no seu projeto:

```
seu-projeto/
├── abntypst/
│   ├── lib.typ
│   └── src/
│       └── ...
└── seu-documento.typ
```

No seu documento:

```typst
#import "abntypst/lib.typ": *
```

== Instalação como Pacote (futura)

Quando publicado no repositório oficial do Typst:

```typst
#import "@preview/abntypst:0.1.0": *
```

= Guia Rápido

== Documento Mínimo

```typst
#import "abntypst/lib.typ": *

#show: thesis.with(
  title: "Uma proposta de pacote para normas ABNT em Typst",
  subtitle: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  author: "Cláudio Código",
  institution: "Universidade Federal de Jataí",
  faculty: "Instituto de Ciências Exatas e Tecnológicas",
  program: "PROFMAT - Programa de Mestrado Profissional em Rede em Matemática",
  location: "Jataí",
  year: 2026,
  advisor: "Prof. Dr. Esdras Teixeira Costa",
)

#cover(
  institution: "Universidade Federal de Jataí",
  faculty: "Instituto de Ciências Exatas e Tecnológicas",
  author: "Cláudio Código",
  title: "Uma proposta de pacote para normas ABNT em Typst",
  subtitle: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  location: "Jataí",
  year: 2026,
)

#title-page(
  author: "Cláudio Código",
  title: "Uma proposta de pacote para normas ABNT em Typst",
  subtitle: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  nature: "Dissertação apresentada ao PROFMAT da Universidade Federal de Jataí",
  objective: "como requisito parcial para obtenção do título de Mestre.",
  advisor: "Prof. Dr. Esdras Teixeira Costa",
  location: "Jataí",
  year: 2026,
)

#resumo(keywords: ("Palavra1", "Palavra2", "Palavra3"))[
  Texto do resumo...
]

#sumario()

// Inicia numeração arábica
#counter(page).update(1)
#set page(numbering: "1", number-align: top + right)

= Introdução

Seu texto aqui...

= Conclusão

Conclusão do trabalho...

#heading(level: 1, numbering: none, "REFERÊNCIAS")

// Lista de referências...
```

= Referência dos Módulos

== Core (Núcleo)

Os módulos core definem as configurações básicas de formatação.

=== page.typ - Configuração de Página

Configura o formato e margens da página conforme NBR 14724.

*Função principal:*

```typst
#let abnt-page-setup(
  paper: "a4",
  margin-top: 3cm,
  margin-bottom: 2cm,
  margin-left: 3cm,
  margin-right: 2cm,
)
```

*Parâmetros:*
- `paper`: Formato do papel (padrão: "a4")
- `margin-top`: Margem superior (padrão: 3cm)
- `margin-bottom`: Margem inferior (padrão: 2cm)
- `margin-left`: Margem esquerda (padrão: 3cm)
- `margin-right`: Margem direita (padrão: 2cm)

*Funções auxiliares:*

```typst
// Aplica configuração de página ao corpo
#let with-abnt-page(body)

// Inicia numeração arábica (para seção textual)
#let start-arabic-numbering()

// Configura numeração no canto superior direito
#let abnt-page-numbering()

// Remove numeração (para capa, folha de rosto)
#let no-page-numbering()
```

=== fonts.typ - Configuração de Fontes

Define fontes e tamanhos conforme ABNT.

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
  cover-title: 14pt, // Título na capa
)
```

*Funções:*

```typst
// Aplica fonte padrão (Times New Roman, 12pt, pt-BR)
#let abnt-font-setup(font-family: "Times New Roman")

// Aplica fonte ao corpo do documento
#let with-abnt-font(font-family: "Times New Roman", body)

// Texto em tamanho reduzido (10pt)
#let small-text(body)

// Texto para notas de rodapé
#let footnote-text(body)

// Texto para legendas
#let caption-text(body)
```

=== spacing.typ - Configuração de Espaçamentos

Define espaçamentos entre linhas e parágrafos.

*Constantes:*

```typst
#let abnt-line-spacing = (
  normal: 1.5em,  // Texto principal
  single: 1em,    // Espaçamento simples
  double: 2em,    // Espaçamento duplo
)
```

*Funções:*

```typst
// Aplica espaçamento padrão (1,5 entre linhas, recuo 1,25cm)
#let abnt-spacing-setup()

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
#let indented-block(indent: 4cm, body)

// Bloco para natureza do trabalho (recuo 8cm)
#let nature-block(body)
```

=== sorting.typ - Ordenação Alfabética (NBR 6033:1989)

Funções para ordenação alfabética em listas, índices, catálogos e bibliografias.

*Funções principais:*

```typst
// Remove acentos para ordenação
#let remove-accents(text)

// Remove artigo inicial (A, O, The, etc.)
#let remove-initial-article(text, keep-articles-in-names: false)

// Gera chave de ordenação
#let sort-key(text, ignore-articles: true)

// Ordena lista alfabeticamente conforme NBR 6033
#let sort-alphabetically(items, ignore-articles: true, key: none)

// Lista ordenada alfabeticamente
#let alphabetical-list(items, numbered: false, ignore-articles: true)

// Índice alfabético com cabeçalhos de letras
#let alphabetical-index(items, show-letters: true)

// Ordena lista mista (números primeiro, depois letras)
#let sort-mixed(items)
```

*Exemplo:*

```typst
// Ordenar ignorando artigos
#let lista = ("O gato", "A casa", "Zebra", "Árvore")
#sort-alphabetically(lista)
// Resultado: ("Árvore", "A casa", "O gato", "Zebra")

// Criar índice alfabético
#alphabetical-index((
  ("Algoritmo", 15),
  ("Banco de dados", 23),
  ("Árvore", 18),
))
```

*Constantes de tipos de entrada (para homógrafas):*

```typst
#let entry-types = (
  author-person: 1,    // Autor (nome próprio)
  author-entity: 2,    // Autor (entidade coletiva)
  subject: 3,          // Assunto
  title: 4,            // Título
)
```

=== proofreading.typ - Revisão de Originais (NBR 6025:2002)

Símbolos e sinais para revisão de originais e provas.

*Marcações de texto:*

```typst
// Marcar para suprimir (deletar)
#let delete(body)

// Marcar para inserção
#let insert(body)

// Substituir texto
#let replace-text(old, new)

// Indicar transposição
#let transpose(a, b)

// Unir (remover espaço)
#let join-space()

// Separar (adicionar espaço)
#let separate()

// Ver original
#let see-original()

// Indicar dúvida
#let query()

// Manter original (correção indevida)
#let keep-original(body)
```

*Marcações tipográficas:*

```typst
// Marcar para itálico
#let mark-italic(body)

// Marcar para negrito
#let mark-bold(body)

// Marcar para normal
#let mark-normal(body)

// Caixa alta (maiúsculas)
#let mark-uppercase(body)

// Caixa baixa (minúsculas)
#let mark-lowercase(body)

// Versal versalete
#let mark-smallcaps(body)
```

*Marcações de parágrafo:*

```typst
// Novo parágrafo
#let new-paragraph()

// Centralizar
#let center-text()

// Alinhar à esquerda
#let align-left()

// Alinhar à direita
#let align-right()
```

*Controle de alterações:*

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
O texto foi #delete[removido] e #insert[inserido].

#replace-text("antigo", "novo")

#attention[Este trecho precisa de revisão.]

#review-note[Texto principal][Verificar fonte]
```

=== identifiers.typ - ISBN e ISSN

Identificadores padrão internacionais conforme NBR ISO 2108:2006 (ISBN) e NBR 10525:2005 (ISSN).

*Funções ISBN:*

```typst
// Calcula dígito verificador ISBN-13
#let isbn-check-digit(digits)

// Valida ISBN-13
#let validate-isbn(isbn)

// Valida ISBN-10
#let validate-isbn10(isbn)

// Converte ISBN-10 para ISBN-13
#let isbn10-to-isbn13(isbn10)

// Formata ISBN com hífens
#let format-isbn(isbn, group: none, registrant-len: 4, publication-len: 4)

// Exibe ISBN formatado
#let display-isbn(isbn, format: true, product-form: none)

// Bloco de múltiplos ISBN (para ficha catalográfica)
#let isbn-block(isbns)

// Adiciona ISBN a referência
#let ref-isbn(isbn)
```

*Exemplo ISBN:*

```typst
// Validar ISBN
#validate-isbn("978-0-11-000222-4") // true

// Exibir ISBN
#display-isbn("978-85-1234-567-8")
// ISBN 978-85-1234-567-8

#display-isbn("978-85-1234-567-8", product-form: "e-book")
// ISBN 978-85-1234-567-8 (e-book)

// Múltiplos formatos
#isbn-block((
  ("978-85-1234-567-8", "brochura"),
  ("978-85-1234-568-5", "capa dura"),
  ("978-85-1234-569-2", "e-book"),
))
```

*Funções ISSN:*

```typst
// Calcula dígito verificador ISSN
#let issn-check-digit(digits)

// Valida ISSN
#let validate-issn(issn)

// Formata ISSN com hífen
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
#issn-meta-tag("1234-5678")
// <META SCHEME="ISSN" NAME="identifier" CONTENT="1234-5678">

// Múltiplos suportes
#issn-multiple((
  ("0100-1965", "impresso"),
  ("1518-8353", "online"),
))
```

*Funções de conveniência para referências:*

```typst
// Em referência de livro
SILVA, Maria. *Manual de normas*. São Paulo: Atlas, 2023. #ref-isbn("978-85-1234-567-8")

// Em referência de periódico
CIÊNCIA DA INFORMAÇÃO. Brasília: IBICT, 1972-. #ref-issn("0100-1965")
```

== Elements (Elementos Pré-textuais)

=== cover.typ - Capa

Cria a capa do trabalho conforme NBR 14724.

```typst
#let cover(
  institution: none,  // Nome da instituição
  faculty: none,      // Faculdade/Unidade
  program: none,      // Programa/Curso
  author: none,       // Nome do autor
  title: none,        // Título do trabalho
  subtitle: none,     // Subtítulo (opcional)
  location: none,     // Cidade
  year: none,         // Ano
)
```

*Exemplo:*

```typst
#cover(
  institution: "Universidade Federal de Jataí",
  faculty: "Instituto de Ciências Exatas e Tecnológicas",
  program: "PROFMAT - Programa de Mestrado Profissional em Rede em Matemática",
  author: "Cláudio Código",
  title: "Uma proposta de pacote para normas ABNT em Typst",
  subtitle: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  location: "Jataí",
  year: 2026,
)
```

=== title-page.typ - Folha de Rosto

Cria a folha de rosto conforme NBR 14724.

```typst
#let title-page(
  author: none,       // Nome do autor
  title: none,        // Título
  subtitle: none,     // Subtítulo
  nature: none,       // Natureza do trabalho
  objective: none,    // Objetivo (obtenção de grau)
  institution: none,  // Instituição
  area: none,         // Área de concentração
  advisor: none,      // Orientador
  co-advisor: none,   // Coorientador
  location: none,     // Cidade
  year: none,         // Ano
)
```

*Exemplo:*

```typst
#title-page(
  author: "Cláudio Código",
  title: "Uma proposta de pacote para normas ABNT em Typst",
  subtitle: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  nature: "Dissertação apresentada ao PROFMAT - Programa de Mestrado Profissional em Rede em Matemática do Instituto de Ciências Exatas e Tecnológicas da Universidade Federal de Jataí",
  objective: "como requisito parcial para obtenção do título de Mestre.",
  area: "Matemática",
  advisor: "Prof. Dr. Esdras Teixeira Costa",
  location: "Jataí",
  year: 2026,
)
```

*Ficha catalográfica (verso):*

```typst
#let catalog-card(content)
```

=== abstract.typ - Resumo e Abstract

Cria páginas de resumo conforme NBR 6028.

```typst
// Resumo em português
#let resumo(content, keywords: ())

// Abstract em inglês
#let abstract(content, keywords: ())

// Resumo em outra língua
#let foreign-abstract(
  title: "ABSTRACT",
  content: none,
  keywords: (),
  keyword-label: "Keywords",
)
```

*Exemplo:*

```typst
#resumo(
  keywords: ("ABNT", "Typst", "Formatação", "Trabalho acadêmico"),
)[
  Este trabalho apresenta o desenvolvimento do pacote ABNTypst para formatação de documentos acadêmicos conforme as normas da ABNT, utilizando o sistema de composição tipográfica Typst. O objetivo é fornecer uma alternativa moderna e acessível para a produção de trabalhos acadêmicos no Brasil...
]

#abstract(
  keywords: ("ABNT", "Typst", "Formatting", "Academic work"),
)[
  This work presents the development of the ABNTypst package for formatting academic documents according to ABNT standards, using the Typst typesetting system. The objective is to provide a modern and accessible alternative for the production of academic works in Brazil...
]
```

=== toc.typ - Sumário e Listas

Cria sumário e listas conforme NBR 6027.

```typst
// Sumário
#let sumario(
  title: "SUMÁRIO",
  depth: 3,
)

// Lista de ilustrações
#let lista-ilustracoes()

// Lista de tabelas
#let lista-tabelas()

// Lista de siglas
#let lista-siglas(items)  // items: dicionário sigla -> significado

// Lista de símbolos
#let lista-simbolos(items)
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

== Text (Elementos Textuais)

=== headings.typ - Seções e Subseções

Formata títulos de seção conforme NBR 6024.

*Formatação automática:*

```typst
// Aplica formatação ABNT aos headings
#let with-abnt-headings(body)
```

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

*Seção sem numeração:*

```typst
// Para Introdução, Conclusão, Referências
#let unnumbered-section(title, level: 1)

// Título pré-textual (não aparece no sumário)
#let pretextual-title(title)
```

=== quotes.typ - Citações

Formata citações conforme NBR 10520.

*Citação direta curta (até 3 linhas):*

```typst
#let quote-short(text, author: none, year: none, page: none)
```

*Exemplo:*
```typst
Conforme o autor, #quote-short("a formatação adequada é essencial", author: "SILVA", year: "2023", page: "42").
```

*Citação direta longa (mais de 3 linhas):*

```typst
#let quote-long(body, author: none, year: none, page: none)
```

*Exemplo:*
```typst
#quote-long(author: "SILVA", year: "2023", page: "42-43")[
  A formatação adequada dos trabalhos acadêmicos é essencial para a clareza e a credibilidade da comunicação científica. As normas ABNT estabelecem padrões que facilitam a leitura e a compreensão dos textos.
]
```

*Citações indiretas:*

```typst
// Citação com autor no texto: "Segundo Silva (2023)..."
#let cite-author(author, year)

// Citação com autor fora do texto: "... (SILVA, 2023)"
#let cite-parenthetical(author, year, page: none)

// Citação de citação (apud)
#let cite-apud(original-author, original-year, secondary-author, secondary-year, page: none)
```

*Elementos especiais:*

```typst
// Supressão de texto: [...]
#let ellipsis

// Interpolação: [texto adicionado]
#let interpolation(text)

// Grifo nosso
#let emphasis-mine(text)

// Grifo do autor
#let emphasis-original(text)
```

=== figures.typ - Figuras e Ilustrações

Formata figuras conforme NBR 14724 e IBGE.

```typst
// Figura padrão ABNT
#let abnt-figure(
  body,           // Conteúdo (imagem)
  caption: none,  // Título
  source: none,   // Fonte
  label: none,    // Rótulo para referência
)

// Quadro (informações textuais)
#let abnt-quadro(body, caption: none, source: none)

// Gráfico
#let abnt-grafico(body, caption: none, source: none)

// Fonte da figura
#let fonte(content)

// Nota da figura
#let nota-figura(content)
```

*Exemplo:*

```typst
#figure(
  image("grafico.png", width: 80%),
  caption: [Comparação de desempenho dos algoritmos],
)

#fonte[Elaborado pelo autor (2026).]
```

=== tables.typ - Tabelas

Formata tabelas conforme IBGE e NBR 14724.

```typst
// Tabela ABNT/IBGE
#let abnt-table(
  caption: none,   // Título
  source: none,    // Fonte
  columns: auto,   // Colunas
  ..args,          // Conteúdo da tabela
)

// Tabela com figure
#let tabela(body, caption: none, source: none)

// Tabela estilo IBGE (linhas horizontais apenas)
#let ibge-table(
  columns: auto,
  header: (),      // Lista de cabeçalhos
  body-rows: (),   // Lista de linhas
)

// Nota de tabela
#let nota-tabela(content)
```

*Exemplo de tabela IBGE:*

```typst
#figure(
  table(
    columns: 3,
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Algoritmo*], [*Melhor caso*], [*Pior caso*],
    table.hline(stroke: 0.75pt),
    [Quicksort], [O(n log n)], [O(n²)],
    [Mergesort], [O(n log n)], [O(n log n)],
    [Heapsort], [O(n log n)], [O(n log n)],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Complexidade dos algoritmos de ordenação],
  kind: table,
)

#fonte[Adaptado de Cormen et al. (2012).]
```

== References (Referências)

=== bibliography.typ - Bibliografia Automática

Integração com arquivos `.bib` para formatação automática de referências.

```typst
// Bibliografia com formatação ABNT
#let abnt-bibliography(
  file,                         // Arquivo .bib ou .yaml
  title: "REFERÊNCIAS",         // Título da seção
  full: false,                  // Mostrar todas ou só citadas
)

// Configuração de citações autor-data
#let abnt-cite-setup(body)

// Versão simplificada
#let referencias(file, title: "REFERÊNCIAS")
```

*Uso com citações:*

```typst
// No início do documento (opcional, para estilo de citação):
#show: abnt-cite-setup

// No texto, use a sintaxe padrão do Typst:
Conforme @silva2023, a metodologia é importante.
Outros autores @santos2022[p. 45] concordam.

// No final do documento:
#abnt-bibliography("referencias.bib")
```

*Tipos de documento suportados:*
- `@book` - Livros
- `@article` - Artigos de periódico
- `@thesis` / `@phdthesis` / `@mastersthesis` - Teses e dissertações
- `@inproceedings` - Trabalhos em eventos
- `@incollection` - Capítulos de livro
- `@online` / `@webpage` - Documentos eletrônicos
- `@techreport` - Relatórios técnicos e normas

=== citation.typ - Citações e Referências

Funções auxiliares para o sistema autor-data conforme NBR 6023 e NBR 10520.

```typst
// Citação autor-data básica
#let cite-ad(author, year, page: none)

// Citação com autor no texto
#let cite-text(author, year)

// Múltiplos autores (até 3)
#let cite-multiple(authors, year, page: none)

// Mais de 3 autores (et al.)
#let cite-etal(first-author, year, page: none)

// Entidade coletiva
#let cite-entity(entity, year, page: none)

// Obra sem autoria (pelo título)
#let cite-title(title, year, page: none)
```

*Formatação manual de referências:*

```typst
// Livro
#let ref-book(
  author: none,
  title: none,
  subtitle: none,
  edition: none,
  location: none,
  publisher: none,
  year: none,
)

// Artigo de periódico
#let ref-article(
  author: none,
  title: none,
  journal: none,
  location: none,
  volume: none,
  number: none,
  pages: none,
  month: none,
  year: none,
)

// Documento eletrônico
#let ref-online(
  author: none,
  title: none,
  site: none,
  year: none,
  url: none,
  access-date: none,
)
```

== Templates

=== thesis.typ - Tese/Dissertação/TCC

Template completo para trabalhos acadêmicos.

```typst
#show: thesis.with(
  title: "",           // Título
  subtitle: none,      // Subtítulo
  author: "",          // Autor
  institution: "",     // Instituição
  faculty: none,       // Faculdade
  program: none,       // Programa
  location: "",        // Cidade
  year: 2026,          // Ano
  nature: none,        // Natureza
  objective: none,     // Objetivo
  area: none,          // Área
  advisor: none,       // Orientador
  co-advisor: none,    // Coorientador
  keywords-pt: (),     // Palavras-chave
  keywords-en: (),     // Keywords
  font: "Times New Roman",
)
```

*Funções auxiliares do template:*

```typst
// Dedicatória
#let dedicatoria(content)

// Agradecimentos
#let agradecimentos(content)

// Epígrafe
#let epigrafe(quote, author)
```

=== article.typ - Artigo Científico

Template para artigos conforme NBR 6022.

```typst
#show: article.with(
  title: "",
  subtitle: none,
  authors: (),         // Lista de autores com afiliação
  abstract-pt: none,
  abstract-en: none,
  keywords-pt: (),
  keywords-en: (),
  font: "Times New Roman",
  columns: 1,          // 1 ou 2 colunas
)
```

*Exemplo de autores:*

```typst
#show: article.with(
  title: "Título do Artigo",
  authors: (
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
  title: "Revista Brasileira de Ciência",
  subtitle: none,
  issn: "1234-5678",
  volume: 1,
  number: 1,
  year: 2026,
  month-start: 1,       // Janeiro
  month-end: 3,         // Março (para trimestral)
  location: "São Paulo",
  publisher: "Editora Exemplo",
  institution: "Universidade Federal",
  doi: none,
  font: "Times New Roman",
)
```

*Funções principais:*

```typst
// Capa do fascículo
#periodical-cover(
  title: "Título do Periódico",
  issn: "1234-5678",
  volume: 1,
  number: 1,
  year: 2026,
  month-start: 1,
  month-end: 3,
)

// Legenda bibliográfica (para rodapé de cada página)
#bibliographic-legend(
  title: "Revista Brasileira de Ciência",
  location: "São Paulo",
  volume: 1,
  number: 1,
  pages: "1-154",
  month-start: 1,
  month-end: 3,
  year: 2026,
)
// Resultado: "R. bras. Ci., São Paulo, v. 1, n. 1, p. 1-154, jan./mar. 2026."

// Editorial
#editorial[
  Texto de apresentação do fascículo...
]

// Artigo dentro do periódico
#periodical-article(
  title: "Título do Artigo",
  authors: ((name: "Autor", affiliation: "Instituição"),),
  abstract-pt: [...],
  keywords-pt: ("palavra1", "palavra2"),
)[
  Conteúdo do artigo...
]
```

=== book.typ - Livros e Folhetos (NBR 6029:2023)

Template para livros e folhetos com todos os elementos pré-textuais e pós-textuais.

```typst
#show: book.with(
  title: "Título do Livro",
  subtitle: none,
  author: "Nome do Autor",
  publisher: "Editora Exemplo",
  location: "São Paulo",
  year: 2026,
  edition: none,        // A partir da 2ª edição
  volume: none,
  isbn: "978-85-00000-00-0",
  font: "Times New Roman",
  running-header: "Título do Livro",  // Título corrente
)
```

*Elementos pré-textuais:*

```typst
// Capa
#book-cover(
  author: "Nome do Autor",
  title: "Título",
  subtitle: "Subtítulo",
  publisher: "Editora",
  edition: 2,
  location: "São Paulo",
  year: 2026,
)

// Falsa folha de rosto (opcional)
#half-title-page(title: "Título")

// Folha de rosto (anverso)
#book-title-page(
  author: "Nome do Autor",
  title: "Título",
  subtitle: "Subtítulo",
  collaborators: [Tradução de João Silva],
  edition: 2,
  volume: 1,
  publisher: "Editora",
  location: "São Paulo",
  year: 2026,
)

// Folha de rosto (verso com ficha catalográfica)
#book-title-page-verso(
  copyright-year: 2026,
  copyright-holder: "Nome do Autor",
  original-title: "Original Title",  // Se tradução
  catalog-card: [...],
  librarian: "Nome do Bibliotecário - CRB-0/0000",
)

// Dedicatória, agradecimentos, epígrafe
#book-dedication[Aos meus pais...]
#book-acknowledgments[Agradeço a...]
#book-epigraph("Citação inspiradora", "Autor da Citação")

// Listas
#book-list-illustrations()
#book-list-tables()
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

*Elementos pós-textuais:*

```typst
// Posfácio
#book-postface[Considerações finais...]

// Glossário
#book-glossary((
  "Termo 1": "Definição do termo 1",
  "Termo 2": "Definição do termo 2",
))

// Apêndice (elaborado pelo autor)
#book-appendix(letter: "A", title: "Questionário Aplicado")[
  Conteúdo do apêndice...
]

// Anexo (documento externo)
#book-annex(letter: "A", title: "Documento de Referência")[
  Conteúdo do anexo...
]

// Índice remissivo
#book-index(entries: (
  ("Algoritmo", "15, 23, 45"),
  ("Banco de dados", "34-38"),
))

// Colofão (última página)
#book-colophon[
  Este livro foi composto em Times New Roman.
  Impresso na Gráfica Exemplo em janeiro de 2026.
]
```

=== research-project.typ - Projeto de Pesquisa (NBR 15287:2025)

Template para projetos de pesquisa.

```typst
#show: research-project.with(
  title: "",           // Título do projeto
  subtitle: none,      // Subtítulo
  author: "",          // Autor(es) - pode ser string ou array
  institution: "",     // Nome da entidade
  location: "",        // Cidade
  year: 2026,          // Ano de entrega
  project-type: none,  // Tipo de projeto
  advisor: none,       // Orientador
  co-advisor: none,    // Coorientador
  coordinator: none,   // Coordenador
  volume: none,        // Número do volume
  font: "Times New Roman",
)
```

*Funções principais:*

```typst
// Capa específica para projeto
#project-cover(
  institution: none,
  author: none,
  title: none,
  subtitle: none,
  volume: none,
  location: none,
  year: none,
)

// Folha de rosto específica
#project-title-page(
  author: none,
  title: none,
  subtitle: none,
  volume: none,
  project-type: none,
  institution: none,
  advisor: none,
  co-advisor: none,
  coordinator: none,
  location: none,
  year: none,
)

// Cronograma do projeto
#cronograma(
  title: "CRONOGRAMA",
  activities: ("Revisão bibliográfica", "Coleta de dados", "Análise"),
  periods: ("Jan", "Fev", "Mar", "Abr", "Mai", "Jun"),
  schedule: (
    (true, true, false, false, false, false),
    (false, true, true, true, false, false),
    (false, false, false, true, true, true),
  ),
)

// Recursos do projeto
#recursos(
  items: (
    ("Material de consumo", 500.00),
    ("Equipamentos", 2000.00),
    ("Serviços", 1500.00),
  ),
)

// Glossário, apêndice e anexo
#glossario-projeto(("Termo": "Definição"))
#apendice("A", "Título do Apêndice")
#anexo("A", "Título do Anexo")
```

=== technical-report.typ - Relatório Técnico (NBR 10719:2015)

Template para relatórios técnicos e/ou científicos.

```typst
#show: technical-report.with(
  title: "",              // Título do relatório
  subtitle: none,         // Subtítulo
  report-number: none,    // Número do relatório
  report-code: none,      // Código de identificação
  institution: "",        // Órgão responsável
  institution-address: none,
  project-title: none,    // Projeto relacionado
  authors: (),            // Lista de autores
  classification: none,   // Classificação de segurança
  issn: none,
  location: "",
  year: 2026,
  volume: none,
  font: "Times New Roman",
)
```

*Funções principais:*

```typst
// Capa do relatório
#report-cover(
  institution: none,
  institution-address: none,
  report-number: none,
  issn: none,
  title: none,
  subtitle: none,
  classification: none,
  year: none,
)

// Folha de rosto
#report-title-page(
  institution: none,
  project-title: none,
  title: none,
  subtitle: none,
  volume: none,
  report-code: none,
  classification: none,
  authors: ((name: "Nome", qualification: "Cargo"),),
  location: none,
  year: none,
)

// Verso da folha de rosto
#report-title-page-verso(
  technical-team: ((role: "Coordenador", name: "Nome"),),
  cataloging-data: [...],
)

// Errata
#errata(
  reference: [SILVA, M. *Relatório*. São Paulo, 2026.],
  items: (
    (page: 10, line: 5, wrong: "erro", correct: "correto"),
  ),
)

// Formulário de identificação
#formulario-identificacao(
  title: "Título",
  classification: "Ostensivo",
  report-number: "001/2026",
  report-type: "Parcial",
  date: "Janeiro 2026",
  authors: (),
  institutions: (),
  abstract-text: [...],
  keywords: ("Palavra1", "Palavra2"),
  pages: "150",
)

// Código de identificação formatado
#report-code(
  institution-code: "INPE",
  category: "RPE",
  year: 2026,
  subject: "EST",
  sequence: 1,
)
// Resultado: INPE-RPE-2026-EST-001
```

=== poster.typ - Pôster Científico (NBR 15437:2006)

Template para pôsteres técnicos e científicos.

```typst
#show: poster.with(
  title: "",           // Título (obrigatório)
  subtitle: none,      // Subtítulo
  authors: (),         // Lista de autores
  institution: none,   // Instituição
  contact: none,       // Contato
  abstract-text: none, // Resumo (até 100 palavras)
  keywords: (),        // Palavras-chave
  columns: 3,          // Número de colunas
  width: 90cm,         // Largura do pôster
  height: 120cm,       // Altura do pôster
  font: "Arial",
  title-size: 72pt,
  body-size: 24pt,
  background: white,
  accent-color: rgb("#003366"),
)
```

*Variantes de tamanho:*

```typst
// Pôster A0 (84,1cm x 118,9cm)
#show: poster-a0.with(...)

// Pôster A1 (59,4cm x 84,1cm)
#show: poster-a1.with(...)

// Pôster acadêmico com orientador e logo
#show: academic-poster.with(
  advisor: "Prof. Dr. Nome",
  logo: image("logo.png", width: 3cm),
  department: "Departamento de Computação",
  ...
)
```

*Funções auxiliares:*

```typst
// Seção com caixa colorida
#poster-section(title: "RESULTADOS")[
  Conteúdo da seção...
]

// Caixa de destaque
#poster-highlight[
  Texto importante a destacar...
]

// Figura para pôster
#poster-figure(
  image("grafico.png"),
  caption: "Resultados obtidos",
  source: "Elaborado pelo autor",
)

// Referências compactas
#poster-references((
  [SILVA, M. Título. 2024.],
  [SANTOS, J. Outro título. 2023.],
))
```

== Elementos Pós-textuais

=== index.typ - Índice (NBR 6034:2004)

Funções para criar índices remissivos.

```typst
// Registrar entrada no índice (no texto)
A #idx("algoritmo") é uma sequência de instruções...
O #idx("algoritmo", subterm: "de ordenação")[Quicksort] é eficiente...

// Entrada sem exibir texto
#index-entry("termo", subterm: none)

// Remissivas
#let see-entries = (
  index-see("Aviação", "Aeronáutica"),  // "ver"
)
#let see-also-entries = (
  index-see-also("Férias", "Licença"),  // "ver também"
)

// Gerar índice
#indice(
  type-label: "DE ASSUNTOS",
  see-entries: see-entries,
  see-also-entries: see-also-entries,
  columns: 2,
  letter-headers: true,
)

// Variantes de índice
#indice-assuntos(...)
#indice-onomastico(...)
#indice-autores(...)
#indice-geral(...)
```

=== spine.typ - Lombada (NBR 12225:2004)

Funções para criar lombada de encadernação.

```typst
// Gera página com lombada para impressão
#lombada(
  author: "SILVA",
  title: "TÍTULO DO TRABALHO",
  volume: 1,
  year: 2026,
  institution: "UFSC",
  logo: none,
  orientation: "descendente",  // ou "horizontal"
  spine-width: 2cm,
  spine-height: 29.7cm,
  reserved-space: 30mm,  // Espaço para etiquetas
)

// Preview da lombada no documento
#lombada-preview(
  author: "SILVA",
  title: "TÍTULO DO TRABALHO",
  year: 2026,
  institution: "UFSC",
)

// Título de margem de capa (para documentos finos)
#margem-capa(
  title: "TÍTULO",
  volume: 1,
)
```

== Módulos Utilitários

=== dates.typ - Datas e Horas (NBR 5892:2019)

Funções para formatação de datas e horas conforme a norma brasileira.

```typst
// Formatar data
#format-date-mixed(4, 4, 2018)   // "4 de abril de 2018"
#format-date-short(4, 4, 2018)   // "4 abr. 2018"
#format-date-numeric(4, 4, 2018) // "04.04.2018"

// A partir de datetime
#format-date(datetime.today(), format: "mixed")

// Formatar hora
#format-time-abbrev(8, 21, second: 32)  // "8 h 21 min 32 s"
#format-time-digital(8, 21, second: 32) // "08:21:32"

// Abreviaturas de meses
#get-month-abbrev(1)   // "jan."
#get-month-abbrev(5)   // "maio" (não abreviado)

// Intervalo de meses (para legendas bibliográficas)
#format-month-range(1, 3)  // "jan./mar."

// Séculos e milênios
#format-century(20)              // "século XX"
#format-century(21, abbreviated: true)  // "séc. XXI"
#format-millennium(2, bc: true)  // "II milênio a.C."

// Data de acesso para documentos eletrônicos
#access-date(15, 1, 2026)  // "Acesso em: 15 jan. 2026."
#access-date-from(datetime.today())

// Data atual
#today()  // Data de hoje formatada
```

=== abbreviations.typ - Abreviação de Títulos (NBR 6032:1989)

Funções para abreviar títulos de periódicos e publicações seriadas.

```typst
// Abreviar título completo
#abbreviate-title("Revista Brasileira de Biologia")
// Resultado: "R. bras. Biol."

#abbreviate-title("Memorias do Instituto Oswaldo Cruz")
// Resultado: "Mem. Inst. Oswaldo Cruz"

// Obter abreviatura de uma palavra
#get-abbreviation("Revista")     // "R."
#get-abbreviation("Brasileiro")  // "bras."
#get-abbreviation("Biologia")    // "Biol."

// Plural com traço-de-união
#abbreviate-plural("Acad.")  // "Acad-s"

// Palavra composta
#abbreviate-compound("médico-sanitárias")  // "med.-sanit."

// Com identificação do editor (títulos genéricos)
#abbreviate-with-editor("Boletim Estatístico", "IBGE")
// Resultado: "B. estat. IBGE"
```

*Dicionário de abreviaturas disponíveis:*

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

= Exemplos Completos

== TCC Completo

Veja o arquivo `examples/tcc-exemplo.typ` para um exemplo completo de Trabalho de Conclusão de Curso.

== Estrutura Recomendada

```
meu-tcc/
├── abntypst/           # Pacote
├── imagens/            # Suas imagens
├── main.typ            # Documento principal
├── capitulos/
│   ├── introducao.typ
│   ├── fundamentacao.typ
│   ├── metodologia.typ
│   ├── resultados.typ
│   └── conclusao.typ
└── referencias.bib     # Bibliografia (futuro)
```

*main.typ:*

```typst
#import "abntypst/lib.typ": *

#show: thesis.with(...)

// Pré-textuais
#cover(...)
#title-page(...)
#resumo(...)
#abstract(...)
#sumario()

// Textuais
#counter(page).update(1)
#set page(numbering: "1", number-align: top + right)

#include "capitulos/introducao.typ"
#include "capitulos/fundamentacao.typ"
#include "capitulos/metodologia.typ"
#include "capitulos/resultados.typ"
#include "capitulos/conclusao.typ"

// Pós-textuais
#heading(level: 1, numbering: none, "REFERÊNCIAS")
// ...
```

= Perguntas Frequentes

== Como mudar a fonte para Arial?

```typst
#show: thesis.with(
  // ...
  font: "Arial",
)
```

== Como usar numeração romana nos pré-textuais?

Por padrão, os elementos pré-textuais não são numerados. Se quiser usar romanos:

```typst
// Após a folha de rosto
#set page(numbering: "i")
#counter(page).update(1)

// Antes da introdução
#set page(numbering: "1")
#counter(page).update(1)
```

== Como criar seção sem numeração?

```typst
#heading(level: 1, numbering: none, "REFERÊNCIAS")
```

Ou use a função auxiliar:

```typst
#unnumbered-section("REFERÊNCIAS")
```

== Como ajustar o recuo da citação longa?

O padrão é 4cm. Para alterar:

```typst
#indented-block(indent: 5cm)[
  Texto da citação...
]
```

== Posso usar arquivo .bib para referências?

Sim! O pacote inclui suporte a arquivos `.bib` com formatação automática ABNT. Existem duas formas de usar:

*Opção 1: Via template*

```typst
#show: thesis.with(
  // ... outros parâmetros ...
  bibliography-file: "referencias.bib",
  bibliography-title: "REFERÊNCIAS",  // opcional
)
```

*Opção 2: Diretamente no documento*

```typst
// No final do documento:
#abnt-bibliography("referencias.bib")
```

O pacote usa um arquivo CSL baseado nas normas NBR 6023:2018 e NBR 10520:2023.

*Limitações conhecidas:*
- Subtítulos aparecem em negrito junto com o título (limitação do formato CSL)
- Títulos de obras sem autor devem ter a primeira palavra em MAIÚSCULAS no arquivo .bib
- Legislação tem suporte limitado

Para casos especiais, você pode usar as funções de formatação manual (`ref-book`, `ref-article`, `ref-online`)

= Changelog

== Versão 0.4.0 (Janeiro 2026)

- Novo template `research-project.typ`: projetos de pesquisa conforme NBR 15287:2025
  - Template completo com capa e folha de rosto específicas
  - Funções para cronograma e recursos do projeto
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

== Versão 0.3.0 (Janeiro 2026)

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

== Versão 0.2.0 (Janeiro 2026)

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

== Versão 0.1.0 (Janeiro 2026)

- Versão inicial
- Implementação dos módulos core (page, fonts, spacing)
- Elementos pré-textuais (capa, folha de rosto, resumo, sumário)
- Elementos textuais (seções, citações, figuras, tabelas)
- Templates para tese/TCC e artigo

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
