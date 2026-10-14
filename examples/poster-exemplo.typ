// Exemplo de Pôster Técnico e Científico conforme NBR 15437:2006
//
// ============================================================================
// Este exemplo demonstra o uso do template poster do ABNTyp para criar
// pôsteres científicos em conformidade com a NBR 15437:2006.
//
// Elementos demonstrados:
// - Título grande e legível (o título leva os dois pontos; o subtítulo vem abaixo)
// - Autores com afiliações (numeradas por instituição distinta)
// - Orientador (academic-poster)
// - Resumo com palavras-chave
// - Colunas equilibradas (as seções partem entre as colunas)
// - Seções coloridas (poster-section) e caixas de destaque (poster-highlight),
//   que herdam a cor-destaque do pôster
// - Tabelas e figuras com identificação em cima e fonte embaixo (poster-figure)
// - Referências compactas (poster-references)
//
// Outros formatos (cada um é um documento próprio, com o mesmo conteúdo):
// - poster.with(...)           sem orientador nem logotipo (90 x 120 cm)
// - poster-a0.with(...)        A0 (84,1 x 118,9 cm)
// - poster-a1.with(...)        60 x 90 cm (o A1 ISO, 59,4 x 84,1 cm, fica abaixo do
//                              mínimo da NBR 15437 5.2)
// - academic-poster.with(logo: image("logo.png"), logo-direita: image(...))
//   logotipos reduzidos ao tamanho máximo (largura-logo, altura-logo)
//
// ============================================================================

// COMO COMPILAR: este exemplo importa ../lib.typ, que fica FORA da pasta
// examples/; por isso o Typst precisa saber onde está a raiz do pacote:
//   da raiz do pacote:        typst compile --root . examples/poster-exemplo.typ
//   de dentro de examples/:   typst compile --root .. poster-exemplo.typ
// (sem --root, o Typst recusa o import: "cannot read file outside of project root")
// Se você COPIAR este arquivo para o seu projeto, troque o import abaixo por
//   #import "@preview/abntyp:0.7.0": *
// e compile com `typst compile poster-exemplo.typ`. Arquivos que o exemplo lê (referencias.bib,
// imagens de ../docs/figuras/), se houver, precisam ir junto, com os caminhos ajustados.

#import "../lib.typ": *

// Configuração do documento usando o template academic-poster
// (inclui campo para orientador)
#show: academic-poster.with(
  titulo: "Análise de Sentimentos em Redes Sociais",
  subtitulo: "uma abordagem com Deep Learning",
  autores: (
    (
      name: "Lucas Henrique Almeida",
      affiliation: "Universidade Federal de Exemplo",
    ),
    (
      name: "Beatriz Costa Mendes",
      affiliation: "Universidade Federal de Exemplo",
    ),
  ),
  orientador: "Prof. Dr. Ricardo Oliveira Silva",
  departamento: "Departamento de Ciência da Computação",
  contato: "lucas.almeida@ufe.edu.br | beatriz.mendes@ufe.edu.br",
  texto-resumo: [
    Este trabalho apresenta uma abordagem de deep learning para análise de sentimentos em postagens de redes sociais em português brasileiro. Utilizando uma arquitetura BERT adaptada (BERTimbau), o modelo alcançou 89,3% de acurácia na classificação de sentimentos em três categorias: positivo, negativo e neutro. O dataset utilizado contém 50.000 tweets coletados entre 2021 e 2022.
  ],
  palavras-chave: ("análise de sentimentos", "deep learning", "BERT", "redes sociais", "PLN"),
  num-colunas: 3,
  largura: 90cm,
  altura: 120cm,
  fonte: "Arial",
  tamanho-titulo: 72pt,
  tamanho-corpo: 24pt,
  cor-destaque: rgb("#1a5276"),
)

// ============================================================================
// CONTEÚDO DO PÔSTER
// ============================================================================

#poster-section(titulo: "Introdução")[
  A análise de sentimentos é uma tarefa fundamental do Processamento de Linguagem Natural (PLN) que busca identificar e extrair opiniões subjetivas em textos (Liu, 2012).

  Com o crescimento exponencial das redes sociais, milhões de opiniões são compartilhadas diariamente, criando uma fonte rica de dados para:

  - Monitoramento de marcas
  - Análise de opinião pública
  - Detecção de crises
  - Pesquisas de mercado

  *Objetivo:* Desenvolver um modelo de deep learning para classificação de sentimentos em português brasileiro com alta acurácia.
]

#poster-section(titulo: "Metodologia")[
  == Dataset

  - *Fonte:* Twitter/X (API Acadêmica)
  - *Período:* janeiro/2021 a dezembro/2022
  - *Total:* 50.000 tweets em português
  - *Anotação:* Três anotadores humanos
  - *Concordância:* Kappa = 0,82

  == Pré-processamento

  + Remoção de URLs, menções e hashtags
  + Normalização de emojis
  + Correção ortográfica
  + Tokenização com BERTimbau

  == Arquitetura do Modelo

  Modelo BERT (Devlin et al., 2018) pré-treinado em português, o BERTimbau (Souza et al., 2020):

  #poster-highlight[
    *BERTimbau-Large* + Camada de classificação

    - 24 camadas transformer
    - 1024 dimensões ocultas
    - 16 cabeças de atenção
    - Fine-tuning: 3 épocas, lr=2e-5
  ]
]

#poster-section(titulo: "Resultados")[
  == Métricas de Desempenho

  #poster-figure(
    table(
      columns: (1fr, auto, auto, auto),
      stroke: none,
      inset: 8pt,
      align: (left, center, center, center),
      table.hline(stroke: 1.5pt),
      [*Classe*], [*Precisão*], [*Recall*], [*F1-Score*],
      table.hline(stroke: 0.75pt),
      [Positivo], [0,91], [0,88], [0,89],
      [Negativo], [0,87], [0,92], [0,89],
      [Neutro], [0,88], [0,86], [0,87],
      [*Média*], [*0,89*], [*0,89*], [*0,89*],
      table.hline(stroke: 1.5pt),
    ),
    legenda: "Métricas de desempenho por classe",
    origem: "Elaborado pelos autores (2026)",
  )

  #poster-highlight[
    *Acurácia Global: 89,3%*

    Superando o baseline (SVM + TF-IDF) em 12,7 pontos percentuais
  ]

  == Comparação com Outros Modelos

  #poster-figure(
    table(
      columns: (1fr, auto),
      stroke: none,
      inset: 8pt,
      align: (left, center),
      table.hline(stroke: 1.5pt),
      [*Modelo*], [*Acurácia*],
      table.hline(stroke: 0.75pt),
      [SVM + TF-IDF], [76,6%],
      [LSTM], [81,2%],
      [BERT Multilíngue], [85,4%],
      [*BERTimbau (nosso)*], [*89,3%*],
      table.hline(stroke: 1.5pt),
    ),
    legenda: "Comparativo de desempenho",
    origem: "Elaborado pelos autores (2026)",
  )
]

#poster-section(titulo: "Discussão")[
  == Principais Contribuições

  - Modelo estado-da-arte para português brasileiro
  - Dataset anotado disponibilizado publicamente
  - Pipeline reproduzível de pré-processamento

  == Análise de Erros

  Os principais erros ocorreram em:

  - *Sarcasmo e ironia:* 34% dos erros
  - *Gírias regionais:* 22% dos erros
  - *Textos muito curtos:* 18% dos erros

  #poster-highlight[
    *Trabalhos Futuros:*
    - Incorporar detecção de sarcasmo
    - Expandir para outras redes sociais
    - Desenvolver API pública
  ]
]

#poster-section(titulo: "Conclusão")[
  Este trabalho demonstrou que modelos de deep learning baseados em BERT adaptados para o português brasileiro superam significativamente abordagens tradicionais na tarefa de análise de sentimentos.

  O modelo desenvolvido atinge *89,3% de acurácia*, representando um avanço importante para aplicações de PLN em português.

  #v(0.5em)

  #align(center)[
    #box(
      fill: rgb("#1a5276").lighten(85%),
      inset: 1em,
      radius: 5pt,
    )[
      *Código e Dataset disponíveis em:*

      github.com/exemplo/sentimentos-br
    ]
  ]
]

#poster-references((
  [DEVLIN, J. et al. BERT: pre-training of deep bidirectional transformers for language understanding. *arXiv*, 2018.],
  [LIU, B. Sentiment analysis and opinion mining. *Synthesis Lectures on HLT*, Morgan & Claypool, 2012.],
  [SOUZA, F. et al. BERTimbau: pretrained BERT models for Brazilian Portuguese. *BRACIS*, 2020.],
))
