// Guia Rápido do ABNTyp

#set document(title: "Guia Rápido - ABNTyp")
#set page(paper: "a4", margin: 2cm)
#set text(font: "Times New Roman", size: 11pt, lang: "pt")
#set par(justify: true)

#align(center)[
  #text(size: 18pt, weight: "bold")[Guia Rápido do ABNTyp]
  #v(0.5em)
  #text(size: 11pt)[Formatação ABNT para Typst]
]

#v(1em)

#columns(2, gutter: 1cm)[

== Instalação

Coloque a pasta `abntyp` no seu projeto e importe:

```typst
#import "abntyp/lib.typ": *
```

== Documento Básico

```typst
#show: dados.with(
  titulo: "Título",
  autor: "Seu Nome",
  instituicao: "Universidade",
  local: "Cidade",
  ano: 2026,
  orientador: "Prof. Dr. Nome",
  palavras-chave: ("A", "B"),
)

#show: normas-abnt.with()

#capa()
#folha-rosto()

#resumo[Texto do resumo...]

#sumario()

= Introdução

Texto...
```

A função `dados()` armazena os metadados
e `normas-abnt()` aplica a formatação ABNT.
Os elementos `capa()`, `folha-rosto()` e
`resumo()` leem tudo automaticamente.
A numeração de páginas também é automática
(contagem a partir da folha de rosto, número
visível a partir da Introdução).

== Seções (NBR 6024)

```typst
= Seção Primária      // NEGRITO
== Seção Secundária   // MAIÚSCULAS
=== Seção Terciária   // negrito
==== Seção Quaternária // normal
===== Seção Quinária  // itálico
```

== Citações (NBR 10520)

*Forma padrão --- `.bib` com `@chave`* (recomendada): sobrenome, ano e "et al."
vêm da entrada; a lista monta-se sozinha. Basta um `#referencias(read("refs.bib"))`
no documento.
```typst
@silva2023              // (Silva, 2023)
@silva2023[p. 45]       // (Silva, 2023, p. 45)
@silva2023 @santos2022  // (Santos, 2022; Silva, 2023) — várias obras
@cormen2012             // (Cormen et al., 2012) — et al. automático
#pag(<silva2023>, 45)   // Silva (2023, p. 45) — autor na frase
#pag(<lima2024>, autor: "Lima e Serrano")  // Lima e Serrano (2024) — 2–3 autores na frase
#apud("Freire", 1994, <silva2023>, 25)  // (Freire, 1994 apud Silva, 2023, p. 25)
```

*Citação direta curta (até 3 linhas):*
```typst
#citacao-curta("Silva", 2023, 42)[texto da citação].
#citacao-curta()[sic transit gloria mundi]   // sem fonte
```

*Citação direta longa (mais de 3 linhas):*
```typst
#citacao-longa("Silva", 2023)[
  Texto longo da citação com mais de três linhas...
]
```

*Fallback --- autor-data manual (só para obras fora do `.bib`):* recebem autor e
ano como texto. Referência completa no Manual de Implementação.
```typst
#citar("Silva", 2023, pagina: 45)        // (Silva, 2023, p. 45)
#citar-autor("Silva", 2023, pagina: 45)  // Silva (2023, p. 45)
#citar-etal("Silva", 2023)               // (Silva et al., 2023)
```

== Figuras, tabelas e quadros

A função `#figure()` é nativa do Typst e serve como contêiner genérico para qualquer elemento com título e numeração --- figuras, tabelas, quadros, etc. O parâmetro `kind` diferencia o tipo.

=== Figura

```typst
#container(
  legenda: [Título da figura],
  fonte: [Elaborado pelo autor.],
  imagem(read("fig.png", encoding: none), largura: 80%),
) <fig:exemplo>

Veja a @fig:exemplo.
```

=== Tabela (padrão IBGE)

```typst
#container(
  legenda: [Título da tabela],
  tipo: "tabela",
  fonte: [Fonte dos dados.],
  tabela(
    columns: 3,
    table.hline(stroke: 1.5pt),
    [*Col 1*], [*Col 2*], [*Col 3*],
    table.hline(stroke: 0.75pt),
    [Dado], [Dado], [Dado],
    table.hline(stroke: 1.5pt),
  ),
)
```

A legenda sai acima; fonte e nota, abaixo. O parâmetro `posicao` (`"aqui"`, `"topo"`, `"fundo"`, `"auto"`) controla onde o elemento fica.
Dica: para tabelas grandes, monte no seu programa preferido, tire um print e peça o código em Typst a uma IA.

== Referências

```typst
#heading(level: 1,
  numbering: none,
  "REFERÊNCIAS")

#set par(
  hanging-indent: 1.25cm,
  first-line-indent: 0pt,
)

SILVA, João. *Título*.
São Paulo: Editora, 2023.
```

== Configurações

*Impressão frente-verso* (também em `relatorio` e `livro`):
```typst
#show: normas-abnt.with(frente-verso: true)
```
Margens espelhadas, número à esquerda nas páginas pares e capítulos em página ímpar.

*Listas numeradas:* `+` sai como alínea `a)`, `b)` e, aninhado, subalínea com travessão (NBR 6024). Para o esquema `1.`, `a)`, `i)`, `A.` do LaTeX: `normas-abnt.with(enumeracao: "latex")`. Em `artigo`, `relatorio` e `livro`, use `#set enum(full: true, numbering: numeracao-enum("latex"))` logo após o `#show:`.

*Numeração de páginas:* `paginacao: "auto"` (padrão), `"todas"` ou `"nenhuma"`.

*Bibliografia automática:*
```typst
#show: normas-abnt.with(
  arquivo-bibliografia: read("referencias.bib"),
)
```

*Partes (livros):* `#parte[Título]` gera "Parte 1: Título", no sumário e em `@rótulo`.

*Quebra de página:* `#quebra-pagina()` ou `#quebra-pagina(para: "impar")`.

*Fonte Arial:*
```typst
#show: normas-abnt.with(fonte: "Arial")
```

*Margens padrão:*
- Superior: 3 cm
- Inferior: 2 cm
- Esquerda: 3 cm
- Direita: 2 cm

*Espaçamento:*
- Texto: 1,5 entre linhas
- Citação longa: simples
- Recuo parágrafo: 1,25 cm
- Citação longa: 4 cm

== Aliases (nomes curtos)

Todas as funções principais possuem aliases curtos. Use qualquer uma das formas:

```
citacao-curta → ccurta
citacao-longa → clonga
citar-autor   → cautor
citar-apud    → capud
citar-multiplos → cmultiplos
citar-etal    → cetal
folha-rosto   → rosto
ficha-catalografica → ficha
dedicatoria   → dedica
agradecimentos → agradece
lista-siglas  → siglas
lista-simbolos → simbolos
citar-num     → cnum
citar-num-multiplos → cnmultiplos
citacao-num-curta → cncurta
citacao-num-longa → cnlonga
bibliografia-numerica → bibnum
```

== Normas Implementadas

- NBR 14724:2024 - Trabalhos
- NBR 6023:2018 - Referências
- NBR 10520:2023 - Citações
- NBR 6024:2012 - Seções
- NBR 6027:2012 - Sumário
- NBR 6028:2021 - Resumo
- NBR 6022:2018 - Artigo
- IBGE - Tabelas

]
