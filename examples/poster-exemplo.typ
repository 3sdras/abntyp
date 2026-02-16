// Exemplo de Pôster Técnico e Científico conforme NBR 15437:2006
//
// ============================================================================
// Este exemplo demonstra o uso do template poster do ABNTypst para criar
// pôsteres científicos em conformidade com a NBR 15437:2006.
//
// Elementos demonstrados:
// - Título grande e legível
// - Autores com afiliações
// - Orientador (academic_poster)
// - Resumo com palavras-chave
// - Seções coloridas (poster-section)
// - Caixas de destaque (poster-highlight)
// - Figuras com legendas (poster-figure)
// - Referências compactas (poster-references)
// - Variantes de tamanho: poster, academic-poster, poster-a0, poster-a1
//
// ============================================================================

#import "../lib.typ": *

// Configuração do documento usando o template academic-poster
// (inclui campo para orientador)
#show: academic-poster.with(
  titulo: "Análise de Sentimentos em Redes Sociais",
  subtitulo: "uma abordagem com Deep Learning",
  autores: (
    (
      name: "Lucas Henrique Almeida",
      affiliation: "Graduando em Ciência da Computação, Universidade Federal de Exemplo",
    ),
    (
      name: "Beatriz Costa Mendes",
      affiliation: "Graduanda em Ciência da Computação, Universidade Federal de Exemplo",
    ),
  ),
  orientador: "Prof. Dr. Ricardo Oliveira Silva",
  instituicao: "Universidade Federal de Exemplo",
  departamento: "Departamento de Ciência da Computação",
  contato: "lucas.almeida@ufe.edu.br | beatriz.mendes@ufe.edu.br",
  texto-resumo: [
    Este trabalho apresenta uma abordagem de deep learning para análise de sentimentos em postagens de redes sociais em português brasileiro. Utilizando uma arquitetura BERT adaptada (BERTimbau), o modelo alcançou 89,3% de acurácia na classificação de sentimentos em três categorias: positivo, negativo e neutro. O dataset utilizado contém 50.000 tweets coletados entre 2022 e 2024.
  ],
  palavras-chave: ("Análise de sentimentos", "Deep Learning", "BERT", "Redes sociais", "PLN"),
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

#poster-section(titulo: "Introdução", cor-destaque: rgb("#1a5276"))[
  A análise de sentimentos é uma tarefa fundamental do Processamento de Linguagem Natural (PLN) que busca identificar e extrair opiniões subjetivas em textos.

  Com o crescimento exponencial das redes sociais, milhões de opiniões são compartilhadas diariamente, criando uma fonte rica de dados para:

  - Monitoramento de marcas
  - Análise de opinião pública
  - Detecção de crises
  - Pesquisas de mercado

  *Objetivo:* Desenvolver um modelo de deep learning para classificação de sentimentos em português brasileiro com alta acurácia.
]

#poster-section(titulo: "Metodologia", cor-destaque: rgb("#1a5276"))[
  == Dataset

  - *Fonte:* Twitter/X (API Acadêmica)
  - *Período:* Janeiro/2022 a Dezembro/2024
  - *Total:* 50.000 tweets em português
  - *Anotação:* Três anotadores humanos
  - *Concordância:* Kappa = 0,82

  == Pré-processamento

  + Remoção de URLs, menções e hashtags
  + Normalização de emojis
  + Correção ortográfica
  + Tokenização com BERTimbau

  == Arquitetura do Modelo

  #poster-highlight(cor-destaque: rgb("#1a5276"))[
    *BERTimbau-Large* + Camada de classificação

    - 24 camadas transformer
    - 1024 dimensões ocultas
    - 16 cabeças de atenção
    - Fine-tuning: 3 épocas, lr=2e-5
  ]
]

#poster-section(titulo: "Resultados", cor-destaque: rgb("#1a5276"))[
  == Métricas de Desempenho

  #table(
    columns: (1fr, auto, auto, auto),
    stroke: 0.5pt,
    inset: 8pt,
    align: (left, center, center, center),

    [*Classe*], [*Precisão*], [*Recall*], [*F1-Score*],
    [Positivo], [0,91], [0,88], [0,89],
    [Negativo], [0,87], [0,92], [0,89],
    [Neutro], [0,88], [0,86], [0,87],
    [*Média*], [*0,89*], [*0,89*], [*0,89*],
  )

  #v(0.5em)

  #poster-highlight(cor-destaque: rgb("#1a5276"))[
    *Acurácia Global: 89,3%*

    Superando o baseline (SVM + TF-IDF) em 12,7 pontos percentuais
  ]

  == Comparação com Outros Modelos

  #poster-figure(
    table(
      columns: (1fr, auto),
      stroke: 0.5pt,
      inset: 8pt,
      align: (left, center),

      [*Modelo*], [*Acurácia*],
      [SVM + TF-IDF], [76,6%],
      [LSTM], [81,2%],
      [BERT Multilíngue], [85,4%],
      [*BERTimbau (nosso)*], [*89,3%*],
    ),
    legenda: "Comparativo de desempenho",
  )
]

#poster-section(titulo: "Discussão", cor-destaque: rgb("#1a5276"))[
  == Principais Contribuições

  - Modelo estado-da-arte para português brasileiro
  - Dataset anotado disponibilizado publicamente
  - Pipeline reproduzível de pré-processamento

  == Análise de Erros

  Os principais erros ocorreram em:

  - *Sarcasmo e ironia:* 34% dos erros
  - *Gírias regionais:* 22% dos erros
  - *Textos muito curtos:* 18% dos erros

  #poster-highlight(cor-destaque: rgb("#1a5276"))[
    *Trabalhos Futuros:*
    - Incorporar detecção de sarcasmo
    - Expandir para outras redes sociais
    - Desenvolver API pública
  ]
]

#poster-section(titulo: "Conclusão", cor-destaque: rgb("#1a5276"))[
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
  [SOUZA, F. et al. BERTimbau: pretrained BERT models for Brazilian Portuguese. *BRACIS*, 2020.],
  [LIU, B. Sentiment analysis and opinion mining. *Synthesis Lectures on HLT*, Morgan & Claypool, 2012.],
  [SANTOS, P. A. Análise comparativa de algoritmos de ordenação. *Rev. Bras. Comp.*, v. 15, n. 2, 2022.],
))
