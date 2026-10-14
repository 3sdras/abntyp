// ============================================================================
// EXEMPLO DE DISSERTAÇÃO DE MESTRADO USANDO ABNTyp
// ============================================================================
//
// Este arquivo é um exemplo completo de dissertação de mestrado formatada
// conforme as normas ABNT, usando o pacote ABNTyp.
//
// COMO USAR:
// ----------
// 1. Copie este arquivo e renomeie para seu projeto
// 2. Modifique os dados (título, autor, instituição, etc.)
// 3. Substitua o conteúdo de exemplo pelo seu texto
//
// COMO COMPILAR: este exemplo importa ../lib.typ, que fica FORA da pasta
// examples/; por isso o Typst precisa saber onde está a raiz do pacote:
//   da raiz do pacote:        typst compile --root . examples/tcc-exemplo.typ
//   de dentro de examples/:   typst compile --root .. tcc-exemplo.typ
//   visualização ao vivo:     typst watch --root . examples/tcc-exemplo.typ
// (sem --root, o Typst recusa o import: "cannot read file outside of project root")
//
// REQUISITOS:
// - Typst instalado (https://typst.app)
// - Se você COPIAR este arquivo para o seu projeto, troque o import da seção
//   "CONFIGURAÇÃO INICIAL" por   #import "@preview/abntyp:0.6.0": *
//   (o pacote é baixado sozinho; não é preciso copiar nenhuma pasta)
//
// ESTRUTURA DO DOCUMENTO:
// - Elementos pré-textuais (capa, folha de rosto, resumo, sumário)
// - Elementos textuais (introdução, desenvolvimento, conclusão)
// - Elementos pós-textuais (referências, apêndices, anexos)
//
// ============================================================================


// ============================================================================
// CONFIGURAÇÃO INICIAL
// ============================================================================
//
// Em Typst, usamos #import para carregar pacotes externos.
// O caminho "../lib.typ" assume que este arquivo está na pasta examples/
// do repositório do pacote. No SEU projeto, use o pacote publicado:
//   #import "@preview/abntyp:0.6.0": *
// (ou, com uma cópia local do ABNTyp na raiz do projeto:
//   #import "abntyp/lib.typ": *)
//
// O asterisco (*) significa "importar tudo" do pacote.

#import "../lib.typ": *


// ----------------------------------------------------------------------------
// DADOS DO TRABALHO
// ----------------------------------------------------------------------------
//
// #show: dados.with(...) define os metadados do trabalho.
// Título, autor, instituição, etc. são definidos aqui UMA VEZ.
// Os elementos (capa, folha de rosto, resumo) leem automaticamente.
//
// MODIFIQUE os valores abaixo com seus dados reais.

#show: dados.with(
  // --- Dados básicos do trabalho ---
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  // DICA: Se não tiver subtítulo, remova ou comente a linha abaixo
  subtitulo: "implementação e validação em documentos acadêmicos",

  // --- Dados do autor ---
  autor: "Cláudio Código",

  // --- Dados da instituição ---
  instituicao: "Universidade Federal de Jataí",
  faculdade: "Instituto de Ciências Exatas e Tecnológicas",
  programa: "PROFMAT - Programa de Mestrado Profissional em Rede em Matemática",
  // DICA para graduação:
  //   programa: "Curso de Bacharelado em Matemática",

  // --- Local e data ---
  local: "Jataí",
  ano: 2026,

  // --- Natureza do trabalho ---
  // Para DISSERTAÇÃO de mestrado:
  // A natureza NÃO repete a instituição: o nome dela sai logo depois do objetivo,
  // seguido da área de concentração (NBR 14724:2024, 4.2.1.1.1).
  natureza: "Dissertação apresentada ao PROFMAT - Programa de Mestrado Profissional em Rede em Matemática do Instituto de Ciências Exatas e Tecnológicas",
  objetivo: "como requisito parcial para obtenção do título de Mestre.",
  area: "Ensino de Matemática",

  // Para TCC de graduação (descomente e adapte):
  // natureza: "Trabalho de Conclusão de Curso apresentado ao Curso de Licenciatura em Matemática da Universidade Federal de Jataí",
  // objetivo: "como requisito parcial para obtenção do grau de Licenciado em Matemática.",

  // Para TESE de doutorado (descomente e adapte):
  // natureza: "Tese apresentada ao Programa de Pós-Graduação em Matemática da Universidade Federal de Jataí",
  // objetivo: "como requisito parcial para obtenção do título de Doutor em Matemática.",

  // --- Orientação ---
  orientador: "Prof. Dr. Esdras Teixeira Costa",
  // DICA: Se tiver coorientador, descomente:
  // coorientador: "Prof. Dr. Nome do Coorientador",

  // --- Palavras-chave ---
  // Iniciais minúsculas, exceto nomes próprios (NBR 6028:2021, 4.1.7); o template
  // as separa por ponto e vírgula e põe o ponto final.
  palavras-chave: ("normas técnicas", "ABNT", "Typst", "trabalhos acadêmicos"),
  palavras-chave-en: ("technical standards", "ABNT", "Typst", "academic works"),
)

// ----------------------------------------------------------------------------
// FORMATAÇÃO ABNT
// ----------------------------------------------------------------------------
//
// #show: normas-abnt.with(...) aplica a formatação ABNT ao documento:
//   - Fonte (Times New Roman ou Arial), margens, espaçamento, headings, etc.
//
// Os dados do trabalho já foram definidos acima em dados().

#show: normas-abnt.with(
  // Opções: "Times New Roman" (padrão) ou "Arial"
  fonte: "Times New Roman",

  // Bibliografia automática (opcional): se você tiver um arquivo .bib, passe o
  // CONTEÚDO dele (o caminho em string dá erro):
  // arquivo-bibliografia: read("referencias.bib"),
)


// ============================================================================
// PARTE 2: CAPA E FOLHA DE ROSTO
// ============================================================================
//
// A capa e a folha de rosto são elementos obrigatórios (NBR 14724:2024).
// Elas contêm informações essenciais sobre o trabalho.

// ----------------------------------------------------------------------------
// CAPA E FOLHA DE ROSTO
// ----------------------------------------------------------------------------
// Todos os dados vêm automaticamente do dados() acima.
// Não é preciso repetir título, autor, instituição, etc.

#capa()
#folha-rosto()

// Verso da folha de rosto: ficha catalográfica (obrigatória, NBR 14724:2024
// 4.2.1.2). Ela é elaborada pela biblioteca da instituição: o conteúdo abaixo é
// só um modelo fictício. A ficha não entra na contagem das páginas (14724 5.3).
#ficha-catalografica[
  #set par(first-line-indent: 0pt, justify: false)
  Código, Cláudio.

  #h(1em) Uma proposta de pacote para normas ABNT em Typst: implementação e validação em documentos acadêmicos / Cláudio Código. -- Jataí, 2026.

  #h(1em) #context counter(page).final().first() f. : il.

  #h(1em) Orientador: Prof. Dr. Esdras Teixeira Costa. Dissertação (Mestrado) -- Universidade Federal de Jataí, Instituto de Ciências Exatas e Tecnológicas, PROFMAT, 2026.

  #h(1em) 1. Normas técnicas. 2. Typst. 3. Trabalhos acadêmicos. I. Costa, Esdras Teixeira. II. Título.

  #align(right)[CDD 005.52]
]

// Folha de aprovação (obrigatória, NBR 14724:2024 4.2.1.3). Autor, título,
// natureza, instituição e área vêm de dados(). `data:` é a data da defesa (sem
// ela, a folha traz uma linha para preencher à mão); `banca:` lista os membros,
// cada um com uma linha para assinatura.
#folha-aprovacao(
  data: "15 de março de 2026",
  banca: (
    (titulacao: "Prof. Dr.", nome: "Esdras Teixeira Costa", instituicao: "Universidade Federal de Jataí (orientador)"),
    (titulacao: "Profa. Dra.", nome: "Helena Modelo Andrade", instituicao: "Universidade Federal de Jataí"),
    (titulacao: "Prof. Dr.", nome: "Rafael Exemplo Nogueira", instituicao: "Universidade Estadual de Modelo"),
  ),
)


// ============================================================================
// PARTE 3: ELEMENTOS PRÉ-TEXTUAIS OPCIONAIS
// ============================================================================
//
// Os elementos abaixo são OPCIONAIS. Inclua apenas os que forem relevantes.
// Se não quiser algum elemento, comente ou remova o bloco correspondente.

// ----------------------------------------------------------------------------
// DEDICATÓRIA (opcional)
// ----------------------------------------------------------------------------
// A dedicatória é uma homenagem a pessoas especiais.
// - Não tem título
// - Texto alinhado à direita, na parte inferior da página
// - Redação livre

#dedicatoria[
  Dedico este trabalho aos meus pais,
  que sempre acreditaram em mim.
]


// ----------------------------------------------------------------------------
// AGRADECIMENTOS (opcional)
// ----------------------------------------------------------------------------
// Os agradecimentos reconhecem pessoas e instituições que contribuíram.
// - Título "AGRADECIMENTOS" centralizado
// - Texto em parágrafos normais
//
// DICA: Mencione orientador, família, colegas, instituições de fomento, etc.

#agradecimentos[
  Agradeço primeiramente a Deus por me dar força e sabedoria durante esta jornada.

  Ao meu orientador, Prof. Dr. Esdras Teixeira Costa, pela paciência, dedicação e valiosas contribuições que tornaram este trabalho possível.

  À minha família, pelo apoio incondicional e compreensão nos momentos de ausência.

  Aos colegas do PROFMAT, pelas discussões, parcerias e amizade ao longo desses anos.

  À Universidade Federal de Jataí e ao Instituto de Ciências Exatas e Tecnológicas, por proporcionar um ambiente de aprendizado de qualidade.

  À CAPES pelo apoio ao PROFMAT.
]


// ----------------------------------------------------------------------------
// EPÍGRAFE (opcional)
// ----------------------------------------------------------------------------
// A epígrafe é uma citação inspiradora relacionada ao tema ou à jornada.
// - Sem título
// - Texto alinhado à direita, na parte inferior
// - Deve indicar a autoria

#epigrafe(
  "A educação é a arma mais poderosa que você pode usar para mudar o mundo.",
  "Nelson Mandela",
)


// ----------------------------------------------------------------------------
// LISTAS (opcionais)
// ----------------------------------------------------------------------------
// Inclua apenas se o seu trabalho tiver muitos desses elementos.
// DICA: Se tiver menos de 5 figuras/tabelas, a lista pode ser desnecessária.

// Lista de ilustrações (figuras, gráficos, etc.)
// Descomente se necessário:
// #lista-ilustracoes()

// Lista de tabelas
// Descomente se necessário:
// #lista-tabelas()

// Lista de abreviaturas e siglas
// Descomente e adapte se necessário:
// #lista-siglas((
//   "ABNT": "Associação Brasileira de Normas Técnicas",
//   "TCC": "Trabalho de Conclusão de Curso",
//   "NBR": "Norma Brasileira",
//   // Adicione suas siglas aqui
// ))

// Lista de símbolos (para trabalhos com muitos símbolos matemáticos)
// Descomente se necessário:
// #lista-simbolos((
//   [$alpha$]: "Nível de significância",
//   [$beta$]: "Coeficiente de regressão",
//   // Adicione seus símbolos aqui
// ))


// ============================================================================
// PARTE 4: RESUMO E ABSTRACT
// ============================================================================
//
// O resumo e o abstract são elementos OBRIGATÓRIOS no trabalho acadêmico
// (NBR 14724:2024, 4.2.1.7 e 4.2.1.8); a NBR 6028:2021 diz como redigi-los.
//
// ESTRUTURA SUGERIDA (pode variar conforme a área):
// 1. Contexto/problema
// 2. Objetivo do trabalho
// 3. Metodologia utilizada
// 4. Principais resultados
// 5. Conclusão
//
// EXTENSÃO: 150 a 500 palavras para trabalhos acadêmicos
// PALAVRAS-CHAVE: logo abaixo do resumo, separadas por ponto e vírgula e
// terminadas por ponto (NBR 6028:2021, 4.1.7); a norma não fixa a quantidade

// ----------------------------------------------------------------------------
// RESUMO (em português)
// ----------------------------------------------------------------------------

// Palavras-chave vêm automaticamente do dados()
#resumo[
  // DICA: Escreva em parágrafo único, sem recuo, texto corrido.
  // Evite citações, fórmulas e abreviaturas no resumo.

  A formatação de documentos acadêmicos no Brasil segue as normas da Associação Brasileira de Normas Técnicas (ABNT), que estabelecem padrões para apresentação de trabalhos como TCCs, dissertações e teses. Este trabalho tem como objetivo apresentar o desenvolvimento de um sistema para automatizar a formatação de documentos acadêmicos conforme as normas ABNT, utilizando a linguagem de composição tipográfica Typst. A metodologia adotada consistiu na análise detalhada das normas vigentes, identificação dos requisitos de formatação e implementação de templates e funções específicas para cada elemento do documento. Os resultados obtidos demonstram que é possível produzir documentos acadêmicos corretamente formatados de maneira mais simples e eficiente que as soluções tradicionais baseadas em LaTeX ou processadores de texto convencionais. Conclui-se que o Typst, combinado com o pacote desenvolvido, oferece uma alternativa viável e moderna para a produção de trabalhos acadêmicos no Brasil, reduzindo o tempo gasto com formatação e permitindo que os autores concentrem seus esforços no conteúdo.
]


// ----------------------------------------------------------------------------
// ABSTRACT (em inglês)
// ----------------------------------------------------------------------------
// O abstract é a tradução do resumo para inglês (obrigatório).
// Se seu programa exigir resumo em outra língua, use a função foreign-abstract.

#resumo-en[
  The formatting of academic documents in Brazil follows the standards of the Brazilian Association of Technical Standards (ABNT), which establishes guidelines for the presentation of works such as undergraduate theses, master's dissertations, and doctoral theses. This work aims to present the development of a system to automate the formatting of academic documents according to ABNT standards, using the Typst typesetting language. The methodology adopted consisted of a detailed analysis of current standards, identification of formatting requirements, and implementation of specific templates and functions for each document element. The results obtained demonstrate that it is possible to produce correctly formatted academic documents more simply and efficiently than traditional solutions based on LaTeX or conventional word processors. It is concluded that Typst, combined with the developed package, offers a viable and modern alternative for the production of academic works in Brazil, reducing the time spent on formatting and allowing authors to focus their efforts on content.
]


// ============================================================================
// PARTE 5: SUMÁRIO E NUMERAÇÃO
// ============================================================================

// ----------------------------------------------------------------------------
// SUMÁRIO
// ----------------------------------------------------------------------------
// O sumário é gerado automaticamente com base nos títulos (=, ==, ===, etc.)
// Ele lista todas as seções com seus números de página.

#sumario()


// ----------------------------------------------------------------------------
// INÍCIO DA PARTE TEXTUAL
// ----------------------------------------------------------------------------
// A contagem de páginas já vem da folha de rosto (NBR 14724:2024) e a numeração
// aparece automaticamente a partir da primeira seção numerada
// (normas-abnt(paginacao: "auto")). Alternativas: "todas" ou "nenhuma".
// Não é preciso marcar o início da parte textual: basta começar pela Introdução.


// ============================================================================
// PARTE 6: SEÇÕES E TÍTULOS
// ============================================================================
//
// Em Typst, usamos = para criar títulos de seção:
//   = Título         → Seção primária (1, 2, 3...)
//   == Título        → Seção secundária (1.1, 1.2...)
//   === Título       → Seção terciária (1.1.1, 1.1.2...)
//   ==== Título      → Seção quaternária (1.1.1.1...)
//   ===== Título     → Seção quinária (1.1.1.1.1...)
//
// A formatação segue a NBR 6024:2012:
//   - Primária: NEGRITO, MAIÚSCULAS
//   - Secundária: MAIÚSCULAS, sem negrito
//   - Terciária: negrito, minúsculas
//   - Quaternária: sem negrito, minúsculas
//   - Quinária: itálico (se necessário)

= Introdução

// Seu texto começa aqui. Cada parágrafo é separado por uma linha em branco.
// O recuo da primeira linha (1,25cm) é aplicado automaticamente.

Esta seção apresenta a introdução do trabalho, incluindo a contextualização do tema, a definição do problema de pesquisa, os objetivos e a justificativa.

// DICA: Em Typst, você pode usar *negrito* e _itálico_ facilmente:
// *Este texto fica em negrito*
// _Este texto fica em itálico_
// *_Este texto fica em negrito e itálico_*

A formatação de documentos acadêmicos é uma etapa importante na produção de trabalhos científicos. No Brasil, as normas da *Associação Brasileira de Normas Técnicas* (ABNT) estabelecem os padrões que devem ser seguidos para garantir a uniformidade e a qualidade na apresentação dos trabalhos acadêmicos.


== Contextualização

// Esta é uma seção secundária (nível 2)

A produção de trabalhos acadêmicos no Brasil requer o cumprimento de diversas normas técnicas que regulamentam desde a estrutura geral do documento até detalhes específicos como margens, fontes, citações e referências. Entre as principais normas, destacam-se:

// ----------------------------------------------------------------------------
// LISTAS EM TYPST
// ----------------------------------------------------------------------------
// Use - para listas não ordenadas (com marcadores)
// Use + para listas ordenadas (numeradas)

- NBR 14724:2024 -- Trabalhos acadêmicos: apresentação
- NBR 6023:2018 -- Referências: elaboração
- NBR 10520:2023 -- Citações em documentos
- NBR 6024:2012 -- Numeração progressiva das seções
- NBR 6028:2021 -- Resumo, resenha e recensão

// DICA: O travessão (--) é usado para separar elementos em listas descritivas.


== Problema de Pesquisa

// Defina claramente o problema que seu trabalho pretende resolver.

Apesar da existência de ferramentas como processadores de texto convencionais e sistemas como LaTeX, a formatação de documentos conforme as normas ABNT ainda representa um desafio para muitos estudantes e pesquisadores. Os processadores de texto tradicionais oferecem flexibilidade, mas exigem configuração manual detalhada. O LaTeX, embora poderoso, possui uma curva de aprendizado íngreme.

Diante desse cenário, surge a seguinte questão de pesquisa: _é possível desenvolver uma ferramenta que automatize a formatação ABNT de forma simples e acessível, sem sacrificar a qualidade tipográfica?_


== Objetivos

=== Objetivo Geral

// O objetivo geral descreve o que você pretende alcançar com o trabalho.

Desenvolver um pacote para a linguagem Typst que implemente as normas ABNT para formatação de trabalhos acadêmicos, proporcionando uma alternativa moderna e acessível às soluções existentes.


=== Objetivos Específicos

// Os objetivos específicos detalham as etapas para alcançar o objetivo geral.
// Use lista numerada (+) para mostrar a sequência lógica.

Os objetivos específicos deste trabalho são:

+ Analisar as normas ABNT vigentes para trabalhos acadêmicos, identificando os requisitos de formatação;
+ Estudar a linguagem Typst e suas capacidades de extensão;
+ Implementar templates para os principais tipos de documentos acadêmicos;
+ Criar funções para automatizar citações e referências;
+ Documentar o pacote desenvolvido com exemplos práticos;
+ Validar a solução através da produção de documentos de teste.


== Justificativa

// A justificativa explica POR QUE este trabalho é relevante.

A escolha do Typst como plataforma para este trabalho justifica-se por suas características inovadoras: sintaxe simples e legível, compilação rápida, visualização em tempo real e capacidade de extensão através de funções e templates. Diferentemente do LaTeX, que utiliza comandos verbosos, o Typst permite uma escrita mais natural e intuitiva.

Além disso, a comunidade acadêmica brasileira carece de ferramentas modernas que facilitem o cumprimento das normas ABNT. Este trabalho pretende preencher essa lacuna, oferecendo uma solução que combine simplicidade de uso com rigor normativo.


== Estrutura do Trabalho

// Descreva brevemente o que cada seção primária aborda. A NBR 6024 chama as
// divisões de "seções"; por isso @rótulo escreve "Seção 2" (e não "Capítulo 2").

Este trabalho está estruturado em cinco seções primárias. A @sec-fundamentacao apresenta a fundamentação teórica, revisando as normas ABNT e conceitos de tipografia digital. A @sec-metodologia descreve a metodologia utilizada no desenvolvimento. A @sec-resultados apresenta os resultados obtidos. Por fim, a @sec-conclusao traz as conclusões e sugestões para trabalhos futuros.


// ============================================================================
// PARTE 7: CITAÇÕES
// ============================================================================
//
// As citações seguem a NBR 10520:2023.
// O sistema autor-data é o mais comum em trabalhos acadêmicos no Brasil.
//
// TIPOS DE CITAÇÃO:
// 1. Citação direta curta (até 3 linhas) - entre aspas, no texto
// 2. Citação direta longa (mais de 3 linhas) - destacada, recuo 4cm
// 3. Citação indireta (paráfrase) - sem aspas
// 4. Citação de citação (apud) - quando não se tem acesso ao original

= Fundamentação Teórica <sec-fundamentacao>

Esta seção apresenta os conceitos fundamentais para o desenvolvimento do trabalho, incluindo uma revisão das normas ABNT e dos princípios de tipografia digital.


== Normas ABNT para Trabalhos Acadêmicos

As normas da ABNT para trabalhos acadêmicos formam um conjunto integrado de diretrizes que abrangem desde a estrutura geral do documento até detalhes específicos de formatação.


=== Estrutura do Trabalho Acadêmico

Conforme a NBR 14724:2024, um trabalho acadêmico deve conter elementos pré-textuais, textuais e pós-textuais. Os elementos pré-textuais incluem capa, folha de rosto, resumo e sumário. Os elementos textuais compreendem introdução, desenvolvimento e conclusão. Os elementos pós-textuais incluem referências, apêndices e anexos.


=== Sistema de Citações

// ----------------------------------------------------------------------------
// CITAÇÃO INDIRETA (paráfrase)
// ----------------------------------------------------------------------------
// Quando você parafraseia, não usa aspas. A referência aparece entre parênteses.

Segundo Silva (2023), a padronização é essencial para a comunicação científica, pois permite que pesquisadores de diferentes instituições compreendam e avaliem os trabalhos de seus pares de forma consistente.

// Outra forma de citar (autor entre parênteses):
A padronização de documentos científicos surgiu da necessidade de facilitar a comunicação entre pesquisadores #citar("Silva", "2023", pagina: "15").


// ----------------------------------------------------------------------------
// CITAÇÃO DIRETA CURTA (até 3 linhas)
// ----------------------------------------------------------------------------
// Use aspas duplas e indique autor, ano e página (a página é obrigatória na
// citação direta, NBR 10520:2023). O texto entre colchetes recebe a chamada
// (Autor, ano, p. N) logo depois das aspas. Não repita o autor na frase.

// Forma posicional: autor, ano e página, nessa ordem:
Sobre o papel das normas, afirma-se que #citacao-curta("Santos", "2022", "45")[as normas técnicas são instrumentos fundamentais para a qualidade e a confiabilidade da produção científica].

// Forma nomeada (equivalente):
A literatura especializada destaca que #citacao-curta(autor: "Santos", ano: "2022", pagina: "45")[as normas técnicas são instrumentos fundamentais para a qualidade e a confiabilidade da produção científica].


// ----------------------------------------------------------------------------
// CITAÇÃO DIRETA LONGA (mais de 3 linhas)
// ----------------------------------------------------------------------------
// Recuo de 4cm, fonte tamanho 10, espaçamento simples, sem aspas.

A importância da normalização para a comunicação científica é amplamente reconhecida na literatura:

#citacao-longa(autor: "Silva", ano: "2023", pagina: "42")[
  A formatação adequada dos trabalhos acadêmicos é essencial para a clareza e a credibilidade da comunicação científica. As normas técnicas estabelecem padrões que facilitam a leitura e a compreensão dos textos, além de permitir a verificação das fontes consultadas. Sem essa padronização, cada instituição ou publicação adotaria critérios próprios, dificultando o intercâmbio de conhecimentos entre diferentes comunidades acadêmicas.
]


// ----------------------------------------------------------------------------
// CITAÇÃO DE CITAÇÃO (apud)
// ----------------------------------------------------------------------------
// Use quando não tiver acesso ao documento original.
// ATENÇÃO: Deve ser evitada. Use apenas quando realmente necessário.

// Exemplo de apud:
Oliveira (1998 apud Santos, 2022, p. 78) já destacava a importância da padronização documental. O uso do apud indica que você está citando um autor (Oliveira) através de outro (Santos), pois não teve acesso direto à obra original.

// Usando a função citar-apud:
Essa perspectiva histórica demonstra que a preocupação com normas técnicas não é recente #citar-apud("Oliveira", "1998", "Santos", "2022", pagina: "78").


// ----------------------------------------------------------------------------
// ELEMENTOS ESPECIAIS EM CITAÇÕES
// ----------------------------------------------------------------------------
// - [...] indica supressão de texto
// - [texto] indica interpolação (acréscimo do autor)
// - Grifo nosso / Grifo do autor

=== Elementos Especiais em Citações

Quando necessário suprimir parte de uma citação, use reticências entre colchetes [...]. Por exemplo: #citacao-curta(autor: "Silva", ano: "2023", pagina: "50")[A normalização [...] é essencial para a ciência].

// DICA: O pacote oferece funções auxiliares:
// #supressao - produz [...]
// #interpolacao("texto") - produz [texto]
// #grifo-nosso("texto") - produz: texto em itálico, grifo nosso
// #grifo-do-autor("texto") - produz: texto em itálico, grifo do autor


== Tipografia Digital

A tipografia digital revolucionou a produção de documentos, permitindo maior controle sobre a apresentação visual do texto. Sistemas como TeX, LaTeX e, mais recentemente, Typst, oferecem recursos avançados de composição tipográfica.


=== Princípios Tipográficos

Os princípios básicos da tipografia incluem legibilidade, hierarquia visual e consistência. A escolha adequada de fontes, tamanhos e espaçamentos contribui significativamente para a qualidade do documento final.


// ============================================================================
// PARTE 8: FIGURAS
// ============================================================================
//
// Figuras devem ter:
// - Legenda na parte SUPERIOR (tipo, número, título)
// - Conteúdo centralizado
// - Fonte na parte INFERIOR
//
// Numeração: automática, sequencial (Figura 1, Figura 2...)

= Metodologia <sec-metodologia>

Esta seção descreve a metodologia utilizada no desenvolvimento do trabalho.


== Classificação da Pesquisa

Quanto à natureza, esta pesquisa classifica-se como aplicada, pois visa gerar conhecimentos para aplicação prática. Quanto aos objetivos, é exploratória e descritiva. Quanto aos procedimentos, utiliza pesquisa bibliográfica e desenvolvimento experimental.


== Etapas do Desenvolvimento

O desenvolvimento do trabalho seguiu as etapas ilustradas na @fig-metodologia.

// ----------------------------------------------------------------------------
// INSERINDO FIGURAS
// ----------------------------------------------------------------------------
// Sintaxe básica:
//   #figure(
//     image("caminho/da/imagem.png", width: 80%),
//     caption: [Título da figura],
//   ) <label>
//
// Para referenciar: @label (ex: @fig-metodologia)

#figure(
  // Se você tiver uma imagem real, use:
  // image("imagens/metodologia.png", width: 80%),

  // Para este exemplo, vamos criar uma figura simples com texto:
  rect(
    width: 80%,
    height: 4cm,
    stroke: 0.5pt,
    [
      #set align(center + horizon)
      #set text(size: 10pt)
      _Espaço para diagrama de metodologia_

      Análise → Design → Implementação → Testes → Documentação
    ]
  ),
  caption: [Etapas do desenvolvimento do pacote ABNTyp],
) <fig-metodologia>

// FONTE: Obrigatória abaixo da figura
#fonte[Elaborado pelo autor (2026).]

// DICA: Se a figura vier de outra fonte:
// #fonte[Adaptado de Silva (2023).]
// #fonte[IBGE (2022).]


== Ferramentas Utilizadas

O desenvolvimento utilizou as seguintes ferramentas e tecnologias:

- *Typst*: linguagem de composição tipográfica
- *Visual Studio Code*: editor de código
- *Git*: controle de versão
- *GitHub*: hospedagem do código-fonte

A @fig-arquitetura apresenta a arquitetura geral do pacote desenvolvido.

#figure(
  rect(
    width: 100%,
    height: 5cm,
    stroke: 0.5pt,
    [
      #set align(center + horizon)
      #set text(size: 9pt)
      _Espaço para diagrama de arquitetura_

      #table(
        columns: 3,
        stroke: none,
        align: center,
        [`lib.typ`], [→], [Ponto de entrada],
        [`src/templates/`], [→], [Templates (thesis, article)],
        [`src/elements/`], [→], [Elementos (capa, resumo)],
        [`src/text/`], [→], [Formatação (citações, figuras)],
        [`src/references/`], [→], [Sistema de referências],
      )
    ]
  ),
  caption: [Arquitetura modular do pacote ABNTyp],
  // O Typst escolhe o tipo da figura pelo conteúdo: como há uma `table` dentro do
  // retângulo, ela viraria "Tabela". `kind: image` + `supplement` fixam "Figura".
  kind: image,
  supplement: [Figura],
) <fig-arquitetura>

#fonte[Elaborado pelo autor (2026).]


// ============================================================================
// PARTE 9: TABELAS
// ============================================================================
//
// Tabelas seguem as normas do IBGE:
// - Bordas apenas horizontais (superior, inferior, após cabeçalho)
// - Sem bordas laterais (esquerda/direita)
// - Legenda na parte SUPERIOR
// - Fonte na parte INFERIOR
// - Cabeçalho em negrito

= Resultados e Discussão <sec-resultados>

Esta seção apresenta os resultados obtidos no desenvolvimento do pacote.


== Funcionalidades Implementadas

A @tab-funcionalidades resume as principais funcionalidades implementadas no pacote.

// ----------------------------------------------------------------------------
// CRIANDO TABELAS ESTILO IBGE
// ----------------------------------------------------------------------------
// Elementos-chave:
// - stroke: none (remove todas as bordas)
// - table.hline(stroke: 1.5pt) para linhas horizontais
// - [*Texto*] para negrito no cabeçalho

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: none,
    align: (center, left, center),

    // Linha superior (mais grossa)
    table.hline(stroke: 1.5pt),

    // Cabeçalho em negrito
    [*Módulo*], [*Descrição*], [*Norma*],

    // Linha após cabeçalho
    table.hline(stroke: 0.75pt),

    // Dados
    [thesis.typ], [Template para TCCs, dissertações e teses], [NBR 14724],
    [article.typ], [Template para artigos científicos], [NBR 6022],
    [quotes.typ], [Formatação de citações], [NBR 10520],
    [bibliography.typ], [Sistema de referências], [NBR 6023],
    [headings.typ], [Numeração progressiva], [NBR 6024],
    [abstract.typ], [Resumo e abstract], [NBR 6028],
    [toc.typ], [Sumário], [NBR 6027],

    // Linha inferior (mais grossa)
    table.hline(stroke: 1.5pt),
  ),
  caption: [Módulos implementados no pacote ABNTyp],
  kind: table,
) <tab-funcionalidades>

#fonte[Elaborado pelo autor (2026).]


== Discussão dos Resultados

Os resultados obtidos demonstram que o Typst é uma plataforma adequada para a implementação de normas de formatação acadêmica. A sintaxe clara e a compilação rápida facilitam o processo de escrita e revisão.

// Exemplo de uso combinado: texto + citação
O pacote desenvolvido apresenta vantagens significativas em relação às soluções existentes, especialmente quanto à curva de aprendizado e ao tempo de compilação. Esses resultados corroboram as observações de #citar-autor("Silva", "2023"), que destacou a importância de ferramentas acessíveis para a comunidade acadêmica.


// ============================================================================
// PARTE 10: EXEMPLO DE SEÇÕES ADICIONAIS
// ============================================================================
//
// Dependendo do seu trabalho, você pode ter capítulos adicionais como:
// - Revisão de Literatura (mais detalhada)
// - Estudo de Caso
// - Análise de Dados
// - Proposta de Solução
// - Validação
// - etc.

== Validação do Pacote

Para validar o pacote desenvolvido, foram produzidos documentos de teste seguindo diferentes tipos de trabalhos acadêmicos.


=== Testes Realizados

Os seguintes testes foram realizados:

+ *Teste de compilação*: verificação da geração correta do PDF;
+ *Teste de conformidade*: verificação do cumprimento das normas ABNT;
+ *Teste de usabilidade*: avaliação da facilidade de uso por usuários novatos;
+ *Teste de desempenho*: medição do tempo de compilação.


=== Resultados dos Testes

Todos os testes apresentaram resultados satisfatórios. Os documentos gerados foram conferidos por inspeção visual, página a página, contra as exigências de cada norma.


// ============================================================================
// PARTE 11: CONCLUSÃO
// ============================================================================

= Conclusão <sec-conclusao>

// A conclusão deve:
// 1. Retomar o objetivo do trabalho
// 2. Sintetizar os principais resultados
// 3. Responder à pergunta de pesquisa
// 4. Apresentar limitações (opcional, mas recomendado)
// 5. Sugerir trabalhos futuros

Este trabalho apresentou o desenvolvimento do pacote ABNTyp, uma solução moderna para formatação de documentos acadêmicos conforme as normas ABNT, utilizando a linguagem Typst.


== Síntese dos Resultados

Os objetivos propostos foram alcançados. O pacote implementa as principais normas ABNT para trabalhos acadêmicos, incluindo:

- Formatação de elementos pré-textuais (capa, folha de rosto, resumo);
- Numeração progressiva de seções conforme NBR 6024;
- Sistema de citações conforme NBR 10520;
- Formatação de figuras e tabelas conforme IBGE;
- Geração automática de sumário conforme NBR 6027.


== Contribuições

As principais contribuições deste trabalho são:

+ Uma alternativa moderna e acessível para formatação ABNT;
+ Redução do tempo gasto com formatação de documentos;
+ Código aberto disponível para a comunidade acadêmica;
+ Documentação completa com exemplos práticos.


== Limitações

Este trabalho apresenta algumas limitações que devem ser consideradas:

- O Typst é uma linguagem relativamente nova, com ecossistema em desenvolvimento;
- Algumas funcionalidades avançadas do LaTeX ainda não estão disponíveis;
- A base de usuários é menor que a de soluções estabelecidas.


== Trabalhos Futuros

Como sugestões para trabalhos futuros, destacam-se:

- Implementação de suporte completo ao sistema numérico de citações;
- Desenvolvimento de templates adicionais (relatórios técnicos, projetos de pesquisa);
- Criação de uma interface gráfica para usuários não técnicos;
- Integração com sistemas de gerenciamento de referências.


// ============================================================================
// PARTE 12: REFERÊNCIAS
// ============================================================================
//
// OPÇÃO 1: Referências automáticas com arquivo .bib
// Se você passou arquivo-bibliografia: read("referencias.bib") a normas-abnt,
// as referências são inseridas automaticamente ao final. Você também pode usar:
//   #abnt-bibliography(read("referencias.bib"))
//
// OPÇÃO 2: Referências manuais (mostrado abaixo)
// Use quando não tiver arquivo .bib ou precisar de controle total.

// A numeração arábica continua sem interrupção nos elementos pós-textuais
// (NBR 14724:2024); nada a marcar.

// ----------------------------------------------------------------------------
// SEÇÃO DE REFERÊNCIAS (manual)
// ----------------------------------------------------------------------------
// A seção de referências:
// - NÃO tem numeração
// - Título "REFERÊNCIAS" centralizado, negrito
// - Entradas em ordem alfabética pelo sobrenome
// - Alinhadas à margem esquerda, SEM recuo, em espaço simples, separadas entre
//   si por uma linha em branco; sem justificar nem hifenizar (NBR 6023:2018, 6.3)

#secao("REFERÊNCIAS")

// O bloco [ ... ] limita o #set ao trecho das referências (um `set` no nível do
// documento valeria até o fim do arquivo).
#[
  #set par(first-line-indent: 0pt, justify: false, leading: abnt-leading(1), spacing: abnt-leading(2))
  #set text(hyphenate: false)

  // DICA: Organize as referências em ordem alfabética pelo sobrenome do primeiro autor.
  // Use *texto* para negrito (títulos de livros, periódicos).

  ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *ABNT NBR 6023*: informação e documentação: referências: elaboração. Rio de Janeiro: ABNT, 2018.

  ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *ABNT NBR 6024*: informação e documentação: numeração progressiva das seções de um documento: apresentação. Rio de Janeiro: ABNT, 2012.

  ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *ABNT NBR 6027*: informação e documentação: sumário: apresentação. Rio de Janeiro: ABNT, 2012.

  ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *ABNT NBR 6028*: informação e documentação: resumo, resenha e recensão: apresentação. Rio de Janeiro: ABNT, 2021.

  ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *ABNT NBR 10520*: informação e documentação: citações em documentos: apresentação. Rio de Janeiro: ABNT, 2023.

  ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. *ABNT NBR 14724*: informação e documentação: trabalhos acadêmicos: apresentação. Rio de Janeiro: ABNT, 2024.

  SANTOS, Maria. *Metodologia da pesquisa científica*. 3. ed. São Paulo: Atlas, 2022.

  SILVA, João. Formatação de trabalhos acadêmicos: desafios e soluções. *Revista Brasileira de Ciência da Informação*, Brasília, v. 15, n. 2, p. 35-48, maio/ago. 2023.
]


// ============================================================================
// PARTE 13: APÊNDICES E ANEXOS (opcionais)
// ============================================================================
//
// APÊNDICE: Material elaborado pelo próprio autor para complementar o trabalho.
//           Exemplos: questionários, formulários, código-fonte, tabelas extensas.
//
// ANEXO: Material NÃO elaborado pelo autor, mas que complementa o trabalho.
//        Exemplos: leis, regulamentos, documentos de terceiros.
//
// Formatação:
// - Título: APÊNDICE A - Título do apêndice (ou ANEXO A - ...)
// - Letras maiúsculas consecutivas (A, B, C...)
// - Sem numeração de seção

// Descomente e adapte conforme necessário:

/*
#pagebreak()
#apendice("A", "Questionário aplicado")

#set par(first-line-indent: 0pt)

Este questionário foi aplicado aos participantes da pesquisa.

*Questionário de Avaliação de Usabilidade*

1. Você já utilizou alguma ferramenta para formatação de documentos acadêmicos?
   ( ) Sim  ( ) Não

2. Se sim, qual ferramenta?
   ( ) Microsoft Word  ( ) LaTeX  ( ) Google Docs  ( ) Outra: ___________

3. Como você avalia a facilidade de uso do ABNTyp?
   ( ) Muito fácil  ( ) Fácil  ( ) Moderado  ( ) Difícil  ( ) Muito difícil

4. O documento gerado atende às normas ABNT?
   ( ) Totalmente  ( ) Parcialmente  ( ) Não atende

5. Você recomendaria esta ferramenta para outros estudantes?
   ( ) Sim  ( ) Não  ( ) Talvez

Observações: _______________________________________________


#pagebreak()
#apendice("B", "Código-fonte do módulo principal")

// Se quiser incluir código, use blocos de código:
```typst
// lib.typ - Ponto de entrada do pacote ABNTyp

#import "src/templates/thesis.typ": *
#import "src/templates/article.typ": *
#import "src/elements/cover.typ": *
// ... resto do código
```


#pagebreak()
#anexo("A", "Norma NBR 14724:2024 (excertos)")

// Aqui você incluiria trechos relevantes da norma, se permitido.
// Lembre-se de respeitar direitos autorais.

[Inserir excertos da norma, se aplicável e permitido.]
*/


// ============================================================================
// PARTE 14: DICAS E TROUBLESHOOTING
// ============================================================================
//
// Esta seção é apenas para referência - NÃO FAZ PARTE DO DOCUMENTO FINAL.
// Delete ou comente esta seção no seu trabalho real.

/*
// ============================================================================
// DICAS PARA INICIANTES EM TYPST
// ============================================================================

1. COMPILAÇÃO
   - Para compilar: typst compile seu-arquivo.typ
   - Para visualização ao vivo: typst watch seu-arquivo.typ
   - O PDF será gerado no mesmo diretório

2. SINTAXE BÁSICA
   - Parágrafos: separe com linha em branco
   - Negrito: *texto*
   - Itálico: _texto_
   - Títulos: = Título (níveis com ==, ===, etc.)
   - Listas não ordenadas: - item
   - Listas ordenadas: + item

3. FUNÇÕES
   - Funções começam com #: #func()
   - Parâmetros nomeados: #func(param: valor)
   - Conteúdo entre colchetes: #func[conteúdo]

4. REFERÊNCIAS CRUZADAS
   - Criar label: <nome-label>
   - Referenciar: @nome-label

5. COMENTÁRIOS
   - Linha única: // comentário
   - Bloco: /* comentário */


// ============================================================================
// ERROS COMUNS E SOLUÇÕES
// ============================================================================

ERRO: "cannot find file"
SOLUÇÃO: Verifique o caminho do import. Use caminho relativo correto.

ERRO: "cannot read file outside of project root" ao compilar um exemplo
SOLUÇÃO: Compile com --root apontando para a raiz do pacote (veja o cabeçalho
         deste arquivo) ou use o import do pacote publicado.

ERRO: "unknown variable: normas-abnt"
SOLUÇÃO: Certifique-se de importar com: #import "@preview/abntyp:0.6.0": *

ERRO: Numeração de páginas incorreta
SOLUÇÃO: A contagem começa na folha de rosto e o número só aparece a partir da
         primeira seção numerada (normas-abnt(paginacao: "auto")). NÃO use
         #counter(page).update(1) na Introdução: ele reinicia a contagem e o
         sumário passa a mostrar a Introdução como página 1.

ERRO: Fonte não encontrada
SOLUÇÃO: Instale Times New Roman ou use fonte: "Arial" no template.

ERRO: Referências não aparecem
SOLUÇÃO: Use referências manuais ou passe arquivo-bibliografia: read("referencias.bib")
         (o caminho em string dá erro; só saem as obras que o texto cita).


// ============================================================================
// PERSONALIZAÇÕES COMUNS
// ============================================================================

// USAR FONTE ARIAL:
#show: normas-abnt.with(
  fonte: "Arial",
  // ... outros parâmetros
)

// ALTERAR MARGENS (não recomendado - ABNT define os valores):
#set page(
  margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm),
)

// ADICIONAR RODAPÉ PERSONALIZADO (o número de página fica no canto superior
// direito, como manda a NBR 14724 5.3: NÃO troque o `header`, que o apagaria).
// O número do contador só pode ser lido dentro de `context`:
#set page(
  footer: context [Rodapé - Página #counter(page).display()],
)


// ============================================================================
// CHECKLIST ANTES DE ENTREGAR
// ============================================================================

[ ] Capa com todos os elementos obrigatórios
[ ] Folha de rosto com natureza do trabalho
[ ] Resumo com 150-500 palavras e palavras-chave
[ ] Abstract em inglês
[ ] Sumário com numeração correta
[ ] Numeração de páginas (pré-textuais contadas e sem número; algarismos arábicos a partir da Introdução)
[ ] Citações formatadas corretamente
[ ] Figuras com legenda acima e fonte abaixo
[ ] Tabelas no formato IBGE
[ ] Referências em ordem alfabética
[ ] Todas as citações têm referência correspondente
[ ] Todas as referências foram citadas no texto
[ ] Revisão ortográfica e gramatical


// ============================================================================
// RECURSOS ADICIONAIS
// ============================================================================

- Documentação do Typst: https://typst.app/docs
- Repositório ABNTyp: [URL do seu repositório]
- abnTeX2 (LaTeX): https://github.com/abntex/abntex2
- Normas ABNT: https://www.abnt.org.br

*/

// ============================================================================
// FIM DO TUTORIAL
// ============================================================================
//
// Parabéns! Se você chegou até aqui, tem tudo o que precisa para criar
// seu TCC, dissertação ou tese com o ABNTyp.
//
// Lembre-se:
// 1. Substitua todos os textos de exemplo pelos seus próprios
// 2. Remova elementos opcionais que não usar (dedicatória, etc.)
// 3. Delete a seção de Dicas/Troubleshooting (ou deixe comentada)
// 4. Compile frequentemente para verificar erros
// 5. Faça backup do seu trabalho!
//
// Bom trabalho!
// ============================================================================
