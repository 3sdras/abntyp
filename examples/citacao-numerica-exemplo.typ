// Exemplo de Uso do Sistema Numérico de Citações
//
// ============================================================================
// SOBRE O SISTEMA NUMÉRICO (NBR 10520:2023, seção 6.2.2)
// ============================================================================
//
// A NBR 10520:2023 PERMITE dois sistemas de chamada para citações:
// 1. Sistema autor-data (mais comum no Brasil)
// 2. Sistema numérico (permitido pela norma)
//
// Este exemplo demonstra o uso do sistema numérico, inspirado no
// abntex2-num.bst do projeto abntex2 para LaTeX.
//
// IMPORTANTE: O sistema numérico NÃO pode ser usado quando houver notas
// de rodapé no documento (NBR 10520:2023, seção 6.2.2).
//
// ============================================================================

// COMO COMPILAR: este exemplo importa ../lib.typ, que fica FORA da pasta
// examples/; por isso o Typst precisa saber onde está a raiz do pacote:
//   da raiz do pacote:        typst compile --root . examples/citacao-numerica-exemplo.typ
//   de dentro de examples/:   typst compile --root .. citacao-numerica-exemplo.typ
// (sem --root, o Typst recusa o import: "cannot read file outside of project root")
// Se você COPIAR este arquivo para o seu projeto, troque o import abaixo por
//   #import "@preview/abntyp:0.6.0": *
// e compile com `typst compile citacao-numerica-exemplo.typ` (este exemplo não
// lê arquivos auxiliares: as referências são escritas à mão, abaixo).

#import "../lib.typ": *

// Formatação ABNT (página, fonte, títulos, número de página). O sistema
// numérico é configurado logo depois.
#show: normas-abnt.with(fonte: "Times New Roman", quebra-capitulo: false)

// Configurar sistema numérico (aqui: chamada entre parênteses, como (1);
// o padrão alternativo é o expoente: citacao-num-config(estilo: "superscript"))
#show: citacao-num-config

// ============================================================================
// TÍTULO
// ============================================================================

#align(center)[
  #text(weight: "bold")[
    EXEMPLO DE CITAÇÃO NO SISTEMA NUMÉRICO
  ]

  Demonstração do sistema numérico de citações conforme NBR 10520:2023
]

// ============================================================================
// CONTEÚDO
// ============================================================================

= Introdução

Este documento demonstra o uso do sistema numérico de citações, conforme permitido pela NBR 10520:2023, seção 6.2.2. O sistema numérico utiliza números arábicos consecutivos para indicar as fontes, que são listadas ao final do documento na ordem em que foram citadas.

A principal vantagem do sistema numérico é a limpeza visual do texto, sem a interrupção de nomes e datas. Porém, conforme a norma, *este sistema não pode ser usado quando houver notas de rodapé*, pois haveria conflito na numeração. (Para um aviso pronto sobre isso, existe `aviso-sistema-numerico()`.)

= Exemplos de citação

== Citação simples

A metodologia utilizada foi baseada em estudos anteriores #citar-num("silva2023"). Os resultados foram consistentes com a literatura #citar-num("santos2022").

== Citação com página

Conforme demonstrado na pesquisa #citar-num("silva2023", pagina: "45"), "os resultados indicam uma correlação positiva entre as variáveis analisadas".

== Citação com volume e página

O conceito foi originalmente proposto #citar-num("enciclopedia2020", volume: "2", pagina: "123-125") e posteriormente expandido por outros autores.

== Citações múltiplas

Diversos estudos confirmam esta hipótese #citar-num-multiplos(("silva2023", "santos2022", "costa2021")).

== Citação no texto (autor mencionado)

Segundo Silva #citar-num-linha("silva2023", pagina: "78"), a abordagem proposta apresenta vantagens significativas em relação aos métodos tradicionais.

== Citação de citação (apud)

Freire afirmou que a educação é um ato político #citar-num-apud("Freire, 1994", "streck2017", pagina-original: "13", pagina-consultada: "25").

= Citações diretas

== Citação curta (até 3 linhas)

#citacao-num-curta("rocha2022", pagina: "67")[A tecnologia transformou profundamente as relações sociais no século XXI.]

== Citação longa (mais de 3 linhas)

#citacao-num-longa("silva2023", pagina: "89-90")[A teleconferência permite ao indivíduo participar de um encontro nacional ou regional sem a necessidade de deixar seu local de origem. Tipos comuns de teleconferência incluem o uso de televisão, telefone e computador. Através de audioconferência, utilizando a companhia local de telefone, um sinal de áudio pode ser emitido em um salão de qualquer dimensão.]

= Formato sobrescrito

A NBR 10520:2023 também permite o formato sobrescrito (expoente) para citações numéricas. Veja exemplos:

O estudo comprovou a hipótese#citar-num("costa2021", estilo: "superscript"). Outros autores#citar-num("oliveira2020", pagina: "34", estilo: "superscript") chegaram a conclusões similares.

*Nota:* No formato sobrescrito, não deve haver espaço entre o texto e o número.

= Comparação dos formatos

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: left,
  [*Formato parênteses (padrão)*], [*Formato sobrescrito*],
  [O resultado foi positivo (1).], [O resultado foi positivo#super[1].],
  [Conforme Silva (1, p. 45).], [Conforme Silva#super[1], p. 45.],
  [(1, 2, 3)], [#super[1, 2, 3]],
)

#pagebreak()

// ============================================================================
// REFERÊNCIAS
// ============================================================================

#bibliografia-numerica(
  (
    ("silva2023", [SILVA, João Carlos; SANTOS, Maria Helena. *Metodologia científica*: fundamentos e aplicações. 5. ed. São Paulo: Atlas, 2023.]),
    ("santos2022", [SANTOS, Pedro Augusto. Análise comparativa de algoritmos de ordenação. *Revista Brasileira de Computação*, Brasília, v. 15, n. 2, p. 35-48, maio/ago. 2022.]),
    ("costa2021", [COSTA, Pedro Henrique. *Fundamentos de estatística*. Rio de Janeiro: LTC, 2021.]),
    ("oliveira2020", [OLIVEIRA, Ana Paula. Análise de dados qualitativos. *Cadernos de Pesquisa*, São Paulo, v. 50, n. 175, p. 30-52, jan./mar. 2020.]),
    ("enciclopedia2020", [ENCICLOPÉDIA Brasileira de Ciências. São Paulo: Companhia das Letras, 2020. 5 v.]),
    ("streck2017", [STRECK, Danilo R.; REDIN, Euclides; ZITKOSKI, Jaime José (org.). *Dicionário Paulo Freire*. 3. ed. Belo Horizonte: Autêntica, 2017.]),
    ("rocha2022", [ROCHA, Maria Helena. Transformações sociais na era digital. *Revista Brasileira de Sociologia*, Brasília, v. 10, n. 2, p. 45-78, 2022.]),
  ),
)

#v(2em)

// ============================================================================
// NOTAS SOBRE A IMPLEMENTAÇÃO
// ============================================================================

#line(length: 100%)

#text(size: 10pt)[
  *Notas sobre esta implementação:*

  1. O sistema numérico foi implementado inspirado no `abntex2-num.bst` do projeto abntex2 para LaTeX.

  2. Conforme NBR 10520:2023, seção 6.2.2, o sistema numérico é *permitido* pela norma, mas não pode ser usado simultaneamente com notas de rodapé.

  3. A numeração não reinicia a cada página (conforme a norma).

  4. Referências repetidas recebem o mesmo número da primeira ocorrência.

  5. As referências são listadas na ordem de citação no texto (mais intuitivo para o sistema numérico).
]
