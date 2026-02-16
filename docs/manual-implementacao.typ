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
  #text(size: 11pt)[Versão 0.5.0]

  #v(1fr)
  #text(size: 11pt)[Fevereiro 2026]
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

#show: abntcc.with(
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  autor: "Cláudio Código",
  instituicao: "Universidade Federal de Jataí",
  faculdade: "Instituto de Ciências Exatas e Tecnológicas",
  programa: "PROFMAT - Programa de Mestrado Profissional em Rede em Matemática",
  local: "Jataí",
  ano: 2026,
  orientador: "Prof. Dr. Esdras Teixeira Costa",
)

#capa(
  instituicao: "Universidade Federal de Jataí",
  faculdade: "Instituto de Ciências Exatas e Tecnológicas",
  autor: "Cláudio Código",
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  local: "Jataí",
  ano: 2026,
)

#folha-rosto(
  autor: "Cláudio Código",
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  natureza: "Dissertação apresentada ao PROFMAT da Universidade Federal de Jataí",
  objetivo: "como requisito parcial para obtenção do título de Mestre.",
  orientador: "Prof. Dr. Esdras Teixeira Costa",
  local: "Jataí",
  ano: 2026,
)

#resumo(palavras-chave: ("Palavra1", "Palavra2", "Palavra3"))[
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
  legenda: 10pt,     // Legendas
  titulo-capa: 14pt, // Título na capa
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

*Indentação de parágrafos (`all: true`):*

A norma ABNT exige recuo de 1,25cm em _todos_ os parágrafos, inclusive o primeiro após um título. Por padrão, o Typst segue a convenção anglo-saxônica e não indenta o primeiro parágrafo. Os templates do ABNTypst usam `first-line-indent` com `all: true` para corrigir isso:

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
#set enum(indent: 2em, body-indent: 0.5em)
#set terms(indent: 0em, hanging-indent: 2em, separator: [: ])
```

Todas essas configurações são aplicadas automaticamente ao usar qualquer template (`abntcc`, `artigo`, `relatorio`, etc.). Se estiver montando o documento manualmente sem template, inclua-as no preâmbulo.

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
#let capa(
  instituicao: none,  // Nome da instituição
  faculdade: none,    // Faculdade/Unidade
  programa: none,     // Programa/Curso
  autor: none,        // Nome do autor
  titulo: none,       // Título do trabalho
  subtitulo: none,    // Subtítulo (opcional)
  local: none,        // Cidade
  ano: none,          // Ano
)
```

*Exemplo:*

```typst
#capa(
  instituicao: "Universidade Federal de Jataí",
  faculdade: "Instituto de Ciências Exatas e Tecnológicas",
  programa: "PROFMAT - Programa de Mestrado Profissional em Rede em Matemática",
  autor: "Cláudio Código",
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  local: "Jataí",
  ano: 2026,
)
```

=== title-page.typ - Folha de Rosto

Cria a folha de rosto conforme NBR 14724.

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
  local: none,        // Cidade
  ano: none,          // Ano
)
```

*Exemplo:*

```typst
#folha-rosto(
  autor: "Cláudio Código",
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],
  natureza: "Dissertação apresentada ao PROFMAT - Programa de Mestrado Profissional em Rede em Matemática do Instituto de Ciências Exatas e Tecnológicas da Universidade Federal de Jataí",
  objetivo: "como requisito parcial para obtenção do título de Mestre.",
  area: "Matemática",
  orientador: "Prof. Dr. Esdras Teixeira Costa",
  local: "Jataí",
  ano: 2026,
)
```

*Ficha catalográfica (verso):*

```typst
#let ficha-catalografica(conteudo)
```

=== abstract.typ - Resumo e Abstract

Cria páginas de resumo conforme NBR 6028.

```typst
// Resumo em português
#let resumo(conteudo, palavras-chave: ())

// Abstract em inglês
#let abstract(conteudo, palavras-chave: ())

// Resumo em outra língua
#let foreign-abstract(
  titulo: "ABSTRACT",
  conteudo: none,
  palavras-chave: (),
  rotulo-palavras-chave: "Keywords",
)
```

*Exemplo:*

```typst
#resumo(
  palavras-chave: ("ABNT", "Typst", "Formatação", "Trabalho acadêmico"),
)[
  Este trabalho apresenta o desenvolvimento do pacote ABNTypst para formatação de documentos acadêmicos conforme as normas da ABNT, utilizando o sistema de composição tipográfica Typst. O objetivo é fornecer uma alternativa moderna e acessível para a produção de trabalhos acadêmicos no Brasil...
]

#abstract(
  palavras-chave: ("ABNT", "Typst", "Formatting", "Academic work"),
)[
  This work presents the development of the ABNTypst package for formatting academic documents according to ABNT standards, using the Typst typesetting system. The objective is to provide a modern and accessible alternative for the production of academic works in Brazil...
]
```

=== toc.typ - Sumário e Listas

Cria sumário e listas conforme NBR 6027. O sumário formata automaticamente as entradas espelhando a hierarquia visual dos headings (NBR 6027:2012): nível 1 em maiúsculas e negrito, nível 2 em maiúsculas sem negrito, nível 3 em minúsculas e negrito, nível 4 em minúsculas sem negrito, nível 5 em minúsculas e itálico.

```typst
// Sumário
#let sumario(
  titulo: "SUMÁRIO",
  profundidade: 3,
)

// Lista de ilustrações
#let lista-ilustracoes()

// Lista de tabelas
#let lista-tabelas()

// Lista de siglas
#let lista-siglas(itens)  // itens: dicionário sigla -> significado

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
#let unnumbered-section(titulo, nivel: 1)

// Título pré-textual (não aparece no sumário)
#let pretextual-title(titulo)
```

=== quotes.typ - Citações

Formata citações conforme NBR 10520.

*Citação direta curta (até 3 linhas):*

```typst
#let citacao-curta(texto, autor: none, ano: none, pagina: none)
```

*Exemplo:*
```typst
Conforme o autor, #citacao-curta("a formatação adequada é essencial", autor: "SILVA", ano: "2023", pagina: "42").
```

*Citação direta longa (mais de 3 linhas):*

```typst
#let citacao-longa(body, autor: none, ano: none, pagina: none)
```

*Exemplo:*
```typst
#citacao-longa(autor: "SILVA", ano: "2023", pagina: "42-43")[
  A formatação adequada dos trabalhos acadêmicos é essencial para a clareza e a credibilidade da comunicação científica. As normas ABNT estabelecem padrões que facilitam a leitura e a compreensão dos textos.
]
```

*Citações indiretas:*

```typst
// Citação com autor no texto: "Segundo Silva (2023)..."
#let citar-autor(autor, ano)

// Citação com autor fora do texto: "... (SILVA, 2023)"
#let cite-parenthetical(autor, ano, pagina: none)

// Citação de citação (apud)
#let citar-apud(autor-original, ano-original, autor-secundario, ano-secundario, pagina: none)
```

*Elementos especiais:*

```typst
// Supressão de texto: [...]
#let supressao

// Interpolação: [texto adicionado]
#let interpolacao(text)

// Grifo nosso
#let grifo-nosso(text)

// Grifo do autor
#let grifo-do-autor(text)
```

=== figures.typ - Container, Imagem, Quadro e Ilustrações

Formata figuras, quadros e ilustrações conforme NBR 14724 e IBGE.

```typst
// Container genérico (única forma de criar um figure ABNT)
// O supplement é inferido do kind: image→"Figura", table→"Tabela", "quadro"→"Quadro"
#let container(
  body,              // Conteúdo (imagem, quadro, tabela, etc.)
  legenda: none,     // Título (aparece acima)
  origem: none,      // Fonte (aparece abaixo)
  nota: none,        // Nota explicativa (aparece abaixo da fonte)
  kind: image,       // Tipo: image, table, "quadro"
  supplement: auto,  // Inferido do kind (ou definido manualmente)
  ..args,            // Repassados ao figure()
)

// Wrapper para image() em português
#let imagem(source, ..args)

// Quadro: tabela textual com bordas fechadas (wrapper para table())
#let quadro(..args)

// Fonte da figura (para uso avulso)
#let fonte(content)

// Nota da figura (para uso avulso)
#let nota-figura(content)
```

*Exemplo — Figura:*

```typst
#container(legenda: [Comparação de desempenho], origem: [Elaborado pelo autor (2026).]) [
  #imagem("grafico.png", width: 80%)
]
```

*Exemplo — Quadro:*

```typst
#container(legenda: [Glossário de termos], kind: "quadro", origem: [Elaborado pelo autor.]) [
  #quadro(columns: 2,
    [*Termo*], [*Definição*],
    [Algoritmo], [Sequência finita de instruções],
  )
]
```

=== tables.typ - Tabelas

Formata tabelas conforme IBGE e NBR 14724.

```typst
// Tabela IBGE (sem bordas laterais) — usar dentro de container()
#let tabela(..args)

// Nota de tabela
#let nota-tabela(content)
```

*Exemplo de tabela IBGE:*

```typst
#container(
  legenda: [Complexidade dos algoritmos de ordenação],
  kind: table,
  origem: [Adaptado de Cormen et al. (2012).],
)[
  #tabela(
    columns: 3,
    table.hline(stroke: 1.5pt),
    [*Algoritmo*], [*Melhor caso*], [*Pior caso*],
    table.hline(stroke: 0.75pt),
    [Quicksort], [O(n log n)], [O(n²)],
    [Mergesort], [O(n log n)], [O(n log n)],
    [Heapsort], [O(n log n)], [O(n log n)],
    table.hline(stroke: 1.5pt),
  )
]
```

== References (Referências)

=== bibliography.typ - Bibliografia Automática

Integração com arquivos `.bib` para formatação automática de referências.

```typst
// Bibliografia com formatação ABNT
#let abnt-bibliography(
  arquivo,                      // Arquivo .bib ou .yaml
  titulo: "REFERÊNCIAS",        // Título da seção
  full: false,                  // Mostrar todas ou só citadas
)

// Configuração de citações autor-data
#let abnt-cite-setup(body)

// Versão simplificada
#let referencias(arquivo, titulo: "REFERÊNCIAS")
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
#let citar(autor, ano, pagina: none)

// Citação com autor no texto
#let citar-autor(autor, ano)

// Múltiplos autores (até 3)
#let citar-multiplos(autores, ano, pagina: none)

// Mais de 3 autores (et al.)
#let citar-etal(primeiro-autor, ano, pagina: none)

// Entidade coletiva
#let citar-entidade(entidade, ano, pagina: none)

// Obra sem autoria (pelo título)
#let citar-titulo(titulo, ano, pagina: none)
```

*Formatação manual de referências:*

```typst
// Livro
#let ref-livro(
  autor: none,
  titulo: none,
  subtitulo: none,
  edicao: none,
  local: none,
  editora: none,
  ano: none,
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

== Templates

=== thesis.typ - Tese/Dissertação/TCC

Template completo para trabalhos acadêmicos.

```typst
#show: abntcc.with(
  titulo: "",          // Título
  subtitulo: none,     // Subtítulo
  autor: "",           // Autor
  instituicao: "",     // Instituição
  faculdade: none,     // Faculdade
  programa: none,      // Programa
  local: "",           // Cidade
  ano: 2026,           // Ano
  natureza: none,      // Natureza
  objetivo: none,      // Objetivo
  area: none,          // Área
  orientador: none,    // Orientador
  coorientador: none,  // Coorientador
  palavras-chave: (),  // Palavras-chave
  palavras-chave-en: (),  // Keywords
  fonte: "Times New Roman",
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
#show: artigo.with(
  titulo: "",
  subtitulo: none,
  autores: (),         // Lista de autores com afiliação
  resumo: none,
  resumo-en: none,
  palavras-chave: (),
  palavras-chave-en: (),
  fonte: "Times New Roman",
  colunas: 1,          // 1 ou 2 colunas
)
```

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
  issn: "1234-5678",
  volume: 1,
  numero: 1,
  ano: 2026,
  mes-inicio: 1,        // Janeiro
  mes-fim: 3,           // Março (para trimestral)
  local: "São Paulo",
  editora: "Editora Exemplo",
  instituicao: "Universidade Federal",
  doi: none,
  fonte: "Times New Roman",
)
```

*Funções principais:*

```typst
// Capa do fascículo
#periodical-cover(
  titulo: "Título do Periódico",
  issn: "1234-5678",
  volume: 1,
  numero: 1,
  ano: 2026,
  mes-inicio: 1,
  mes-fim: 3,
)

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
  resumo: [...],
  palavras-chave: ("palavra1", "palavra2"),
)[
  Conteúdo do artigo...
]
```

=== book.typ - Livros e Folhetos (NBR 6029:2023)

Template para livros e folhetos com todos os elementos pré-textuais e pós-textuais.

```typst
#show: livro.with(
  titulo: "Título do Livro",
  subtitulo: none,
  autor: "Nome do Autor",
  editora: "Editora Exemplo",
  local: "São Paulo",
  ano: 2026,
  edicao: none,         // A partir da 2ª edição
  volume: none,
  isbn: "978-85-00000-00-0",
  fonte: "Times New Roman",
  cabecalho: "Título do Livro",  // Título corrente
)
```

*Elementos pré-textuais:*

```typst
// Capa
#book-cover(
  autor: "Nome do Autor",
  titulo: "Título",
  subtitulo: "Subtítulo",
  editora: "Editora",
  edicao: 2,
  local: "São Paulo",
  ano: 2026,
)

// Falsa folha de rosto (opcional)
#half-title-page(titulo: "Título")

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
  titulo-original: "Original Title",  // Se tradução
  ficha-catalografica: [...],
  bibliotecario: "Nome do Bibliotecário - CRB-0/0000",
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
#book-appendix(letra: "A", titulo: "Questionário Aplicado")[
  Conteúdo do apêndice...
]

// Anexo (documento externo)
#book-annex(letra: "A", titulo: "Documento de Referência")[
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
  fonte: "Times New Roman",
)
```

*Funções principais:*

```typst
// Capa específica para projeto
#project-cover(
  instituicao: none,
  autor: none,
  titulo: none,
  subtitulo: none,
  volume: none,
  local: none,
  ano: none,
)

// Folha de rosto específica
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
#cronograma(
  titulo: "CRONOGRAMA",
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
  itens: (
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
#show: relatorio.with(
  titulo: "",             // Título do relatório
  subtitulo: none,        // Subtítulo
  numero-relatorio: none, // Número do relatório
  codigo-relatorio: none, // Código de identificação
  instituicao: "",        // Órgão responsável
  endereco-instituicao: none,
  titulo-projeto: none,   // Projeto relacionado
  autores: (),            // Lista de autores
  classificacao: none,    // Classificação de segurança
  issn: none,
  local: "",
  ano: 2026,
  volume: none,
  fonte: "Times New Roman",
)
```

*Funções principais:*

```typst
// Capa do relatório
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

// Folha de rosto
#report-title-page(
  instituicao: none,
  titulo-projeto: none,
  titulo: none,
  subtitulo: none,
  volume: none,
  codigo-relatorio: none,
  classificacao: none,
  autores: ((name: "Nome", qualification: "Cargo"),),
  local: none,
  ano: none,
)

// Verso da folha de rosto
#report-title-page-verso(
  technical-team: ((role: "Coordenador", name: "Nome"),),
  cataloging-data: [...],
)

// Errata
#errata(
  referencia: [SILVA, M. *Relatório*. São Paulo, 2026.],
  itens: (
    (pagina: 10, linha: 5, errado: "erro", correto: "correto"),
  ),
)

// Formulário de identificação
#formulario-identificacao(
  titulo: "Título",
  classificacao: "Ostensivo",
  numero-relatorio: "001/2026",
  tipo-relatorio: "Parcial",
  data: "Janeiro 2026",
  autores: (),
  instituicoes: (),
  texto-resumo: [...],
  palavras-chave: ("Palavra1", "Palavra2"),
  paginas: "150",
)

// Código de identificação formatado
#report-code(
  institution-code: "INPE",
  category: "RPE",
  ano: 2026,
  subject: "EST",
  sequence: 1,
)
// Resultado: INPE-RPE-2026-EST-001
```

=== poster.typ - Pôster Científico (NBR 15437:2006)

Template para pôsteres técnicos e científicos.

```typst
#show: poster.with(
  titulo: "",          // Título (obrigatório)
  subtitulo: none,     // Subtítulo
  autores: (),         // Lista de autores
  instituicao: none,   // Instituição
  contato: none,       // Contato
  texto-resumo: none,  // Resumo (até 100 palavras)
  palavras-chave: (),  // Palavras-chave
  num-colunas: 3,      // Número de colunas
  largura: 90cm,       // Largura do pôster
  altura: 120cm,       // Altura do pôster
  fonte: "Arial",
  tamanho-titulo: 72pt,
  tamanho-corpo: 24pt,
  fundo: white,
  cor-destaque: rgb("#003366"),
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
  orientador: "Prof. Dr. Nome",
  logo: image("logo.png", width: 3cm),
  departamento: "Departamento de Computação",
  ...
)
```

*Funções auxiliares:*

```typst
// Seção com caixa colorida
#poster-section(titulo: "RESULTADOS")[
  Conteúdo da seção...
]

// Caixa de destaque
#poster-highlight[
  Texto importante a destacar...
]

// Figura para pôster
#poster-figure(
  image("grafico.png"),
  legenda: "Resultados obtidos",
  origem: "Elaborado pelo autor",
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
O #idx("algoritmo", subtermo: "de ordenação")[Quicksort] é eficiente...

// Entrada sem exibir texto
#index-entry("termo", subtermo: none)

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
  num-colunas: 2,
  cabecalhos-letras: true,
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
  autor: "SILVA",
  titulo: "TÍTULO DO TRABALHO",
  volume: 1,
  ano: 2026,
  instituicao: "UFSC",
  logo: none,
  orientacao: "descendente",  // ou "horizontal"
  largura-lombada: 2cm,
  altura-lombada: 29.7cm,
  espaco-reservado: 30mm,  // Espaço para etiquetas
)

// Preview da lombada no documento
#lombada-preview(
  autor: "SILVA",
  titulo: "TÍTULO DO TRABALHO",
  ano: 2026,
  instituicao: "UFSC",
)

// Título de margem de capa (para documentos finos)
#margem-capa(
  titulo: "TÍTULO",
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

#show: abntcc.with(...)

// Pré-textuais
#capa(...)
#folha-rosto(...)
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
#show: abntcc.with(
  // ...
  fonte: "Arial",
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
#show: abntcc.with(
  // ... outros parâmetros ...
  arquivo-bibliografia: "referencias.bib",
  titulo-bibliografia: "REFERÊNCIAS",  // opcional
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

Para casos especiais, você pode usar as funções de formatação manual (`ref-livro`, `ref-artigo`, `ref-online`)

= Changelog

== Versão 0.5.0 (Fevereiro 2026)

- Conformidade de headings com NBR 6024:2012 em todos os templates
  - Indicativo numérico agora herda a formatação do nível (negrito, itálico, etc.)
  - Adicionado nível 5 (quinário: minúsculas, itálico) nos templates thesis, technical-report, research-project e book
  - Corrigida hierarquia dos níveis 2 e 3 no template book (estavam invertidos)
  - Corrigido nível 2 nos templates article e periodical (agora MAIÚSCULAS sem negrito)
- Indentação de parágrafos conforme ABNT (`all: true`)
  - Todos os templates agora usam `first-line-indent: (amount: 1.25cm, all: true)` para indentar todos os parágrafos, inclusive o primeiro após títulos
  - Show rules para excluir containers (heading, figure, raw, outline, terms) da indentação
  - Configuração de recuo para listas, enumerações e termos em todos os templates
- Sumário conforme NBR 6027:2012 (`toc.typ`)
  - Entradas do sumário agora espelham a formatação dos headings (5 níveis)
  - Nível 1: MAIÚSCULAS + negrito; Nível 2: MAIÚSCULAS; Nível 3: negrito; Nível 4: normal; Nível 5: itálico
- Funções renomeadas para português (nomes públicos)
  - Templates: `abntcc`, `artigo`, `relatorio`, `projeto-pesquisa`, `livro`, `slides`, `slides-defesa`
  - Elementos: `capa()`, `folha-rosto()`, `ficha-catalografica()`, `resumo()`, `sumario()`
  - Citações: `citar()`, `citar-autor()`, `citar-multiplos()`, `citar-etal()`, `citar-apud()`, etc.
  - Citações diretas: `citacao-curta()`, `citacao-longa()`, `supressao`, `interpolacao()`, `grifo-nosso()`, `grifo-do-autor()`
  - Referências: `ref-livro()`, `ref-artigo()`, `ref-online()`, `referencias-titulo()`
  - Sub-funções internas de templates mantêm nomes em inglês

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
