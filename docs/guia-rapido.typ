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

Pelo Typst Universe (recomendado; funciona também no typst.app):

```typst
#import "@preview/abntyp:0.6.0": *
```

Ou, com a pasta `abntyp` copiada para o seu projeto:

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

Outros pré-textuais: `ficha-catalografica[...]`,
`errata(...)`, `folha-aprovacao(data:, banca:)`,
`dedicatoria[...]`, `agradecimentos[...]`,
`epigrafe(...)`, `resumo-en[...]`,
`lista-ilustracoes()`, `lista-tabelas()` e
`lista-siglas(...)`. Lista sem itens não imprime
nada. Obra em vários volumes: `volume: 2` em
`dados()`.

== Seções (NBR 6024)

```typst
= Seção Primária      // MAIÚSCULAS, negrito
== Seção Secundária   // MAIÚSCULAS
=== Seção Terciária   // minúsculas, negrito
==== Seção Quaternária // minúsculas, normal
===== Seção Quinária  // minúsculas, itálico
```

== Citações (NBR 10520)

*Forma padrão --- `.bib` com `@chave`* (recomendada): sobrenome, ano e "et al."
vêm da entrada; a lista monta-se sozinha. Basta um `#referencias(read("refs.bib"))`
no documento.
```typst
@silva2023              // (Silva, 2023)
@silva2023[p. 45]       // (Silva, 2023, p. 45)
@silva2023 @santos2022  // (Santos; Costa, 2022; Silva, 2023) — várias obras
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

A função `#container()` insere qualquer elemento com título e numeração --- figuras, tabelas e quadros --- e cuida da legenda ("Figura 1 – Título"), da fonte e da nota. O parâmetro `tipo` (`"imagem"`, `"tabela"` ou `"quadro"`) escolhe o tipo. A `fonte:` é obrigatória (NBR 14724, 5.8); `fonte: none` a dispensa.

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
    [*Col 1*], [*Col 2*], [*Col 3*],
    [Dado], [Dado], [Dado],
  ),
)
```

Sem `table.hline`, a `tabela()` desenha os três traços da IBGE e repete o cabeçalho; tabela de várias páginas ganha "(continua)", "(continuação)" e "(conclusão)". A legenda sai acima; fonte e nota, abaixo. O parâmetro `posicao` (`"aqui"`, `"topo"`, `"fundo"`, `"auto"`) controla onde o elemento fica.
Dica: para tabelas grandes, monte no seu programa preferido, tire um print e peça o código em Typst a uma IA.

== Referências

NBR 6023, 6.3: margem esquerda, sem recuo,
espaço simples, linha em branco entre elas.

```typst
#titulo-sem-num[REFERÊNCIAS]

#set par(
  first-line-indent: 0pt,
  justify: false,
  leading: abnt-leading(1),
  spacing: abnt-leading(2),
)

SILVA, João. *Título*.
São Paulo: Editora, 2023.
```

== Configurações

*Impressão frente-verso* (também em `relatorio` e `livro`):
```typst
#show: normas-abnt.with(frente-verso: true)
```
Margens espelhadas, número no canto superior esquerdo nas páginas pares (no `livro`, o número fica centralizado no rodapé), pré-textuais e capítulos em página ímpar. A ficha catalográfica, no verso da folha de rosto, não é contada; por isso a Introdução, em página ímpar, pode receber número par.

*Listas numeradas:* `+` sai como alínea `a)`, `b)` e, aninhado, subalínea com travessão (NBR 6024). Para o esquema `1.`, `a)`, `i)`, `A.` do LaTeX: `normas-abnt.with(enumeracao: "latex")`. O parâmetro vale para todos os templates (`artigo`, `relatorio`, `livro`...).

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
Fora do Linux, isso gera 1 aviso inofensivo
(`unknown font family: liberation sans`).

*Margens padrão:*
- Superior: 3 cm
- Inferior: 2 cm
- Esquerda: 3 cm
- Direita: 2 cm

*Espaçamento:*
- Texto: 1,5 entre linhas (20,7 pt em 12 pt)
- Artigo e relatório: simples (13,8 pt);
  `espacamento: "1,5"` volta ao 1,5
- Citação longa, notas, referências: simples
- Espaço entre parágrafos = entrelinha
- Recuo do parágrafo: 1,25 cm (convenção do
  pacote; as normas não o fixam)
- Citação longa: recuo de 4 cm da margem

== Slides

Sem norma ABNT; usa o Touying (já incluído):

```typst
#show: slides-defesa.with(
  titulo: "Título",
  autor: "Nome",
  instituicao: "Universidade",
  data: datetime(year: 2026, month: 3, day: 15),
)

== Introdução

- Contexto
#pause
- Problema
```

`data:` aceita `datetime`, texto ou conteúdo;
`autor:`, um nome ou uma lista. Slides prontos:
`slide-sumario`, `slide-secao`, `slide-citacao`,
`slide-figura`, `slide-comparativo`,
`slide-metodologia`, `slide-resultado-numerico`,
`slide-referencias`. Cada slide deve caber na
página. O `--pdf-standard ua-1` não passa nos
slides (o Touying exige um título de nível 1
antes).

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

- NBR 14724:2024 - Trabalhos acadêmicos
- NBR 6023:2018 - Referências
- NBR 10520:2023 - Citações
- NBR 6024:2012 - Seções
- NBR 6027:2012 - Sumário
- NBR 6028:2021 - Resumo
- NBR 6022:2018 - Artigo
- NBR 6021:2015 - Publicação periódica
- NBR 6029:2023 - Livros e folhetos
- NBR 10719:2015 - Relatório técnico
- NBR 15287:2025 - Projeto de pesquisa
- NBR 15437:2006 - Pôsteres
- NBR 6034:2004 - Índice
- NBR 12225:2004 - Lombada
- NBR 5892:2019 - Datas e horas
- NBR 6025:2002 - Revisão de originais
- NBR 6032:1989 - Abreviação de títulos
- NBR 6033:1989 - Ordem alfabética
- NBR ISO 2108:2006 - ISBN
- NBR 10525:2005 - ISSN
- IBGE (1993) - Tabelas

]
