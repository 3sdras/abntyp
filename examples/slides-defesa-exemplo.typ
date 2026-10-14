// Exemplo de Apresentacao de Slides para Defesa de TCC
//
// ============================================================================
// IMPORTANTE: NAO EXISTE NORMA ABNT PARA SLIDES
// ============================================================================
//
// A ABNT (Associacao Brasileira de Normas Tecnicas) NAO possui nenhuma norma
// especifica para apresentacoes de slides. Isso significa que:
//
// - Nao ha regras oficiais para fonte, tamanho ou espacamento em slides
// - Nao ha exigencia normativa para layout ou estrutura
// - Nao ha padrao ABNT para cores ou elementos visuais
//
// Este template segue BOAS PRATICAS academicas comuns no Brasil, mas NAO
// representa uma exigencia normativa da ABNT.
//
// As UNICAS normas ABNT aplicaveis em slides sao:
// - NBR 6023:2018 - Referencias (se houver slide de referencias)
// - NBR 10520:2023 - Citacoes (formato autor-data para citacoes no texto)
//
// ============================================================================

// COMO COMPILAR: este exemplo importa ../lib.typ, que fica FORA da pasta
// examples/; por isso o Typst precisa saber onde está a raiz do pacote:
//   da raiz do pacote:        typst compile --root . examples/slides-defesa-exemplo.typ
//   de dentro de examples/:   typst compile --root .. slides-defesa-exemplo.typ
// (sem --root, o Typst recusa o import: "cannot read file outside of project root")
// Se você COPIAR este arquivo para o seu projeto, troque o import abaixo por
//   #import "@preview/abntyp:0.6.0": *
// e compile com `typst compile slides-defesa-exemplo.typ`. Arquivos que o exemplo lê (referencias.bib,
// imagens de ../docs/figuras/), se houver, precisam ir junto, com os caminhos ajustados.

#import "../lib.typ": *

// Usar o template de defesa
#show: slides-defesa.with(
  titulo: "Sistema de Recomendação de Filmes Baseado em Aprendizado de Máquina",
  subtitulo: "Uma abordagem usando filtragem colaborativa",
  autor: "Maria Silva Santos",
  orientador: "Prof. Dr. João Carlos Oliveira",
  coorientador: "Profa. Dra. Ana Paula Costa",
  instituicao: "Universidade Federal de Exemplo",
  departamento: "Departamento de Ciência da Computação",
  programa: none, // Deixar none para TCC de graduacao
  grau: "Bacharel em Ciência da Computação",
  banca: (
    "Prof. Dr. João Carlos Oliveira (Orientador)",
    "Profa. Dra. Maria Lúcia Ferreira",
    "Prof. Dr. Pedro Henrique Lima",
  ),
  data: datetime(year: 2025, month: 3, day: 15),
  cor-primaria: cores-academico.primary,
  cor-secundaria: cores-academico.secondary,
)

// ============================================================================
// SUMARIO DA APRESENTACAO
// ============================================================================

#slide-sumario(
  itens: (
    "Introdução e Motivação",
    "Objetivos",
    "Fundamentação Teórica",
    "Metodologia",
    "Resultados",
    "Conclusão",
  ),
)

// ============================================================================
// SECAO 1: INTRODUCAO
// ============================================================================

#slide-secao(
  titulo: "Introdução",
  subtitulo: "Contexto e Motivação",
)

== Contexto

- Crescimento exponencial de conteúdo digital
- Dificuldade dos usuários em encontrar conteúdo relevante
- Sistemas de recomendação como solução

#pause

- Plataformas de vídeo e de comércio eletrônico usam recomendações para organizar o catálogo
- Netflix Prize (2006-2009): concurso que popularizou o problema

== Problema de Pesquisa

#align(center)[
  #box(
    width: 80%,
    inset: 1em,
    stroke: 2pt + cores-academico.primary,
    radius: 5pt,
  )[
    #text(size: 20pt)[
      *Como desenvolver um sistema de recomendação de filmes que seja eficiente e preciso, utilizando técnicas de filtragem colaborativa?*
    ]
  ]
]

// ============================================================================
// SECAO 2: OBJETIVOS
// ============================================================================

#slide-secao(titulo: "Objetivos")

== Objetivo Geral

Desenvolver um sistema de recomendação de filmes baseado em filtragem colaborativa utilizando o dataset MovieLens.

== Objetivos Específicos

+ Analisar as principais técnicas de sistemas de recomendação
+ Implementar algoritmo de filtragem colaborativa
+ Avaliar a precisão do sistema usando métricas padrão
+ Comparar resultados com abordagens existentes

// ============================================================================
// SECAO 3: FUNDAMENTACAO TEORICA
// ============================================================================

#slide-secao(
  titulo: "Fundamentação Teórica",
  subtitulo: "Conceitos e Trabalhos Relacionados",
)

// O titulo do slide vem de `titulo:`; sem `==` antes
#slide-comparativo(
  titulo: "Tipos de Sistemas de Recomendação",
  titulo-esquerda: "Filtragem Colaborativa",
  conteudo-esquerda: [
    - Baseada em similaridade entre usuários
    - Não requer conhecimento do conteúdo
    - Problema do "cold start"
  ],
  titulo-direita: "Filtragem por Conteúdo",
  conteudo-direita: [
    - Baseada em características dos itens
    - Requer metadados detalhados
    - Limitada a itens similares
  ],
)

// Citação em slide: escreva o sobrenome só com a inicial maiúscula (NBR 10520:2023).
// A frase abaixo é ILUSTRATIVA (não é literal): numa apresentação real, copie a
// frase exata da fonte, com a página.
#slide-citacao(
  quote: "A filtragem colaborativa é uma das técnicas mais bem-sucedidas para construir sistemas de recomendação, baseando-se na premissa de que usuários com comportamentos similares no passado terão preferências similares no futuro.",
  autor: "Ricci",
  ano: "2015",
  pagina: "35",
)

== Trabalhos Relacionados

#table(
  columns: (auto, 1fr, auto),
  inset: 8pt,
  align: horizon,
  [*Autor*], [*Contribuição*], [*Ano*],
  [Koren], [Fatoração de matrizes para Netflix Prize], [2009],
  [He et al.], [Neural Collaborative Filtering], [2017],
  [Zhang et al.], [Deep Learning para recomendação], [2019],
)

// ============================================================================
// SECAO 4: METODOLOGIA
// ============================================================================

#slide-metodologia(
  tipo-pesquisa: "Pesquisa aplicada, de natureza quantitativa",
  abordagem: "Experimental",
  procedimentos: (
    "Revisão bibliográfica",
    "Implementação do algoritmo",
    "Experimentos computacionais",
    "Análise estatística dos resultados",
  ),
  instrumentos: (
    "Python + bibliotecas (NumPy, Pandas, Scikit-learn)",
    "Dataset MovieLens 100K",
    "Métricas: RMSE, MAE, Precisão@K",
  ),
)

#slide-resultado-numerico(
  titulo: "Dataset MovieLens 100K",
  itens: (
    ("100K", "Avaliações"),
    ("943", "Usuários"),
    ("1.682", "Filmes"),
    ("1-5", "Escala de notas"),
  ),
)

// ============================================================================
// SECAO 5: RESULTADOS
// ============================================================================

#slide-secao(
  titulo: "Resultados",
  subtitulo: "Experimentos e Análise",
)

#slide-resultado-numerico(
  titulo: "Resultados Obtidos",
  itens: (
    ("0,89", "RMSE"),
    ("0,71", "MAE"),
    ("78%", "Precisão@10"),
  ),
)

== Comparação com a Literatura

#table(
  columns: (1fr, auto, auto, auto),
  inset: 10pt,
  align: (left, center, center, center),
  [*Método*], [*RMSE*], [*MAE*], [*Precisão\@10*],
  [Baseline (média)], [1,12], [0,94], [52%],
  [SVD clássico], [0,93], [0,74], [71%],
  [*Nossa abordagem*], [*0,89*], [*0,71*], [*78%*],
  [Estado da arte], [0,85], [0,68], [82%],
)

#pause

#align(center)[
  #text(fill: rgb("#006600"), weight: "bold", size: 18pt)[
    Melhoria de 4,3% em relação ao SVD clássico!
  ]
]

// ============================================================================
// SECAO 6: CONCLUSAO
// ============================================================================

#slide-secao(titulo: "Conclusão")

== Contribuições

- Implementação funcional de sistema de recomendação
- Resultados competitivos com estado da arte
- Código disponibilizado como software livre

== Limitações

- Avaliado apenas em dataset padrão (MovieLens)
- Não considera aspectos temporais
- Problema do cold start não tratado

== Trabalhos Futuros

- Incorporar deep learning (NCF)
- Avaliar em datasets maiores
- Implementar sistema hibrido

// ============================================================================
// REFERENCIAS (digitadas por voce; formate pela NBR 6023:2018)
// ============================================================================

#slide-referencias(
  itens: (
    [KOREN, Y.; BELL, R.; VOLINSKY, C. Matrix factorization techniques for recommender systems. *Computer*, v. 42, n. 8, p. 30-37, 2009.],
    [HE, X. et al. Neural collaborative filtering. In: *WWW '17*, p. 173-182, 2017.],
    [RICCI, F. et al. *Recommender Systems Handbook*. 2. ed. New York: Springer, 2015.],
    [ZHANG, S. et al. Deep learning based recommender system: a survey and new perspectives. *ACM Computing Surveys*, v. 52, n. 1, p. 1-38, 2019.],
  ),
)

// O slide final de "Obrigado! Perguntas?" é gerado automaticamente
// pelo template slides-defesa
