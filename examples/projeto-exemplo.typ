// Exemplo de Projeto de Pesquisa conforme NBR 15287:2025
//
// ============================================================================
// Este exemplo demonstra o uso do template research-project do ABNTyp para
// criar projetos de pesquisa em conformidade com a NBR 15287:2025.
//
// Elementos demonstrados:
// - projeto-pesquisa() - Dados do projeto e numeração de páginas (a capa e a folha
//   de rosto os usam, sem repetir)
// - project-cover() - Capa
// - project-title-page() - Folha de rosto com orientador
// - Elementos textuais obrigatórios (tema, problema, hipóteses, objetivos,
//   justificativa, referencial teórico, metodologia)
// - cronograma-simples() - Cronograma com atividades × períodos
// - Tabela de recursos (orçamento) com legenda e fonte; `recursos(itens: ((descrição,
//   valor), ...))` também existe, mas produz uma tabela simples, sem legenda
// - glossario-projeto() - Glossário
// - apendice() e anexo()
// - Referências automáticas (abnt-bibliography com read("referencias.bib")); as
//   obras são citadas no texto com #pag(<chave>) ou @chave
//
// ============================================================================

// COMO COMPILAR: este exemplo importa ../lib.typ, que fica FORA da pasta
// examples/; por isso o Typst precisa saber onde está a raiz do pacote:
//   da raiz do pacote:        typst compile --root . examples/projeto-exemplo.typ
//   de dentro de examples/:   typst compile --root .. projeto-exemplo.typ
// (sem --root, o Typst recusa o import: "cannot read file outside of project root")
// Se você COPIAR este arquivo para o seu projeto, troque o import abaixo por
//   #import "@preview/abntyp:0.7.0": *
// e compile com `typst compile projeto-exemplo.typ`. Arquivos que o exemplo lê (referencias.bib,
// imagens de ../docs/figuras/), se houver, precisam ir junto, com os caminhos ajustados.

#import "../lib.typ": *

// Configuração do documento usando o template research-project
#show: projeto-pesquisa.with(
  titulo: "Desenvolvimento de Aplicativo Mobile para Gestão de Saúde Mental",
  subtitulo: "uma abordagem baseada em técnicas de terapia cognitivo-comportamental",
  autor: "Carolina Beatriz Fernandes",
  instituicao: "Universidade Federal de Exemplo",
  local: "Cidade",
  ano: 2026,
  tipo-projeto: "Projeto de pesquisa apresentado ao Programa de Pós-Graduação em Ciência da Computação da Universidade Federal de Exemplo como requisito para qualificação no Mestrado.",
  orientador: "Prof. Dr. Marcelo Augusto Ribeiro",
  coorientador: "Profa. Dra. Juliana Costa (Psicologia)",
  fonte: "Times New Roman",
  // Bibliografia automática no fim do documento: arquivo-bibliografia: read("referencias.bib").
  // Aqui as referências saem antes do glossário e dos apêndices (NBR 15287: referências,
  // glossário, apêndice, anexo), com abnt-bibliography(...) na posição certa, mais abaixo.
)

// ============================================================================
// ELEMENTOS PRÉ-TEXTUAIS
// ============================================================================

// Capa (entidade, autor, título, subtítulo, local e ano vêm de projeto-pesquisa())
#project-cover()

// Folha de rosto (tipo de projeto, orientador e coorientador também; a contagem de
// páginas começa aqui, e o número aparece a partir da Introdução)
#project-title-page()

// Sumário
#sumario()

// ============================================================================
// ELEMENTOS TEXTUAIS
// ============================================================================

= Introdução

== Tema

O presente projeto de pesquisa situa-se na interseção entre Ciência da Computação e Psicologia da Saúde, focando especificamente no desenvolvimento de tecnologias móveis para suporte à saúde mental. A pesquisa aborda o desenvolvimento de um aplicativo mobile que implementa técnicas validadas de Terapia Cognitivo-Comportamental (TCC) para auxiliar indivíduos no gerenciamento de ansiedade e depressão leve a moderada.

A saúde mental tornou-se uma preocupação global de saúde pública, especialmente após a pandemia de COVID-19, o que aumenta a demanda por intervenções acessíveis e de baixo custo, como os aplicativos móveis @mendes2023.

== Problema de Pesquisa

Diante do cenário apresentado, emerge a seguinte questão norteadora desta pesquisa:

*Como desenvolver um aplicativo mobile que implemente técnicas de Terapia Cognitivo-Comportamental de forma eficaz, acessível e cientificamente validada para auxiliar no gerenciamento de ansiedade e depressão em adultos jovens?*

Esta questão desdobra-se em questionamentos secundários:

- Quais técnicas de TCC são mais adequadas para implementação em formato digital?
- Como garantir a aderência dos usuários ao uso contínuo do aplicativo?
- Quais métricas devem ser utilizadas para avaliar a eficácia da intervenção digital?
- Como equilibrar personalização algorítmica com segurança clínica?

== Hipóteses

A partir do problema de pesquisa, formulam-se as seguintes hipóteses:

*Hipótese Principal (H1):* O uso regular de um aplicativo mobile baseado em TCC, por um período mínimo de 8 semanas, produz redução estatisticamente significativa nos escores de ansiedade e depressão medidos por instrumentos padronizados (PHQ-9 e GAD-7).

*Hipóteses Secundárias:*

- *H2:* A gamificação de exercícios de TCC aumenta a aderência ao tratamento em comparação com interfaces tradicionais.
- *H3:* A personalização do conteúdo com base no perfil do usuário melhora os resultados clínicos.
- *H4:* O monitoramento passivo de padrões de uso do smartphone pode identificar precocemente episódios de piora sintomática.

= Objetivos

== Objetivo Geral

Desenvolver e validar um aplicativo mobile para dispositivos Android e iOS que implemente técnicas de Terapia Cognitivo-Comportamental para auxiliar adultos jovens (18-35 anos) no gerenciamento de sintomas de ansiedade e depressão leve a moderada.

== Objetivos Específicos

+ Realizar revisão sistemática da literatura sobre aplicativos de saúde mental e intervenções digitais baseadas em TCC;

+ Identificar e selecionar as técnicas de TCC mais adequadas para implementação digital, em colaboração com profissionais de Psicologia;

+ Projetar a arquitetura do sistema e a interface do usuário seguindo princípios de design centrado no usuário e acessibilidade;

+ Implementar o aplicativo utilizando tecnologias cross-platform (React Native) com backend em cloud;

+ Desenvolver algoritmos de personalização de conteúdo baseados em machine learning;

+ Conduzir estudo piloto com 50 participantes para avaliação de usabilidade e aceitação;

+ Realizar ensaio clínico randomizado com 200 participantes para validação da eficácia;

+ Publicar os resultados em periódicos científicos da área.

= Justificativa

A relevância desta pesquisa fundamenta-se em três dimensões principais: científica, social e tecnológica.

== Relevância Científica

Apesar do crescente número de aplicativos de saúde mental disponíveis nas lojas de aplicativos, poucos possuem validação científica adequada. #pag(<mendes2023>) destacam que a maioria dos aplicativos disponíveis não foi desenvolvida com base em evidências científicas nem passou por avaliação rigorosa de eficácia.

Esta pesquisa contribuirá para o avanço do conhecimento ao:

- Desenvolver metodologia de implementação de técnicas de TCC em formato digital;
- Propor modelo de validação científica para aplicativos de saúde mental;
- Investigar o papel da personalização algorítmica em intervenções psicológicas.

== Relevância Social

O Brasil enfrenta uma crise de saúde mental agravada pela escassez de profissionais especializados e pela dificuldade de acesso a tratamentos. Há escassez de psicólogos em relação à demanda, com distribuição desigual entre regiões urbanas e rurais.

Um aplicativo validado cientificamente pode:

- Democratizar o acesso a técnicas terapêuticas baseadas em evidências;
- Servir como ferramenta complementar ao tratamento tradicional;
- Reduzir o estigma associado à busca de ajuda profissional;
- Alcançar populações geograficamente isoladas.

== Relevância Tecnológica

Do ponto de vista tecnológico, este projeto aborda desafios relevantes para a área de Computação:

- Implementação de algoritmos de personalização em tempo real;
- Desenvolvimento de sistemas de monitoramento passivo respeitando a privacidade;
- Integração de técnicas de processamento de linguagem natural para análise de diários;
- Design de interfaces acessíveis para públicos diversos.

= Referencial Teórico

== Terapia Cognitivo-Comportamental

A Terapia Cognitivo-Comportamental é uma abordagem psicoterapêutica estruturada, orientada para objetivos, que foca na modificação de padrões disfuncionais de pensamento e comportamento. Desenvolvida por Aaron Beck na década de 1960, a TCC tornou-se um dos tratamentos mais pesquisados e validados empiricamente para transtornos de ansiedade e depressão.

Conforme #pag(<beck2021>), as principais técnicas da TCC incluem:

- *Reestruturação cognitiva:* identificação e modificação de pensamentos automáticos negativos;
- *Ativação comportamental:* planejamento de atividades prazerosas e significativas;
- *Exposição gradual:* enfrentamento progressivo de situações temidas;
- *Técnicas de relaxamento:* respiração diafragmática, relaxamento muscular progressivo;
- *Resolução de problemas:* desenvolvimento de habilidades de enfrentamento.

== Intervenções Digitais em Saúde Mental

As intervenções digitais em saúde mental, também conhecidas como e-mental health, têm crescido exponencialmente na última década. #pag(<costa2022>) classifica estas intervenções em três categorias:

+ *Intervenções autoguiadas:* o usuário navega pelo conteúdo de forma independente;
+ *Intervenções guiadas:* há suporte de um profissional de saúde, mesmo que remoto;
+ *Intervenções híbridas:* combinam elementos autoguiados com sessões presenciais.

A eficácia de intervenções digitais baseadas em TCC tem sido demonstrada em diversos estudos. Os resultados de #pag(<costa2022>) apontam efeito favorável dos aplicativos de TCC no tratamento de ansiedade, o que sustenta a hipótese H1.

== Personalização e Machine Learning

A personalização de intervenções de saúde mental utilizando técnicas de machine learning representa uma fronteira promissora de pesquisa. Algoritmos de recomendação podem adaptar o conteúdo apresentado ao usuário com base em seu perfil, preferências e progresso no tratamento.

#pag(<ribeiro2024>) mostram que sistemas adaptativos podem otimizar a sequência de atividades, melhorando a aderência; a proposta é estender essa ideia aos exercícios terapêuticos.

= Metodologia

== Tipo de Pesquisa

Esta pesquisa caracteriza-se como aplicada, de natureza quali-quantitativa, com delineamento experimental. O desenvolvimento seguirá a metodologia Design Science Research (DSR), apropriada para pesquisas que envolvem a criação de artefatos tecnológicos.

== Etapas da Pesquisa

=== Etapa 1: Revisão Sistemática

Será conduzida revisão sistemática seguindo o protocolo PRISMA, com busca nas bases PubMed, PsycINFO, IEEE Xplore e ACM Digital Library.

=== Etapa 2: Design e Prototipação

O design do aplicativo seguirá processo iterativo de Design Centrado no Usuário, incluindo:

- Criação de personas e jornadas de usuário;
- Prototipação de baixa fidelidade (wireframes);
- Testes de usabilidade com 10 participantes;
- Prototipação de alta fidelidade;
- Novos testes de usabilidade.

=== Etapa 3: Desenvolvimento

O aplicativo será desenvolvido utilizando:

- *Frontend:* React Native (cross-platform);
- *Backend:* Node.js com Express;
- *Banco de dados:* PostgreSQL + Redis;
- *Cloud:* AWS (EC2, S3, Lambda);
- *ML:* TensorFlow Lite para modelos on-device.

=== Etapa 4: Estudo Piloto

Estudo piloto com 50 participantes para avaliação de:

- Usabilidade (System Usability Scale - SUS);
- Aceitação tecnológica (TAM);
- Identificação de bugs e melhorias.

=== Etapa 5: Ensaio Clínico

Ensaio clínico randomizado controlado com:

- *Amostra:* 200 participantes (100 grupo experimental, 100 grupo controle);
- *Critérios de inclusão:* adultos 18-35 anos, escores PHQ-9 entre 5-14, GAD-7 entre 5-14;
- *Intervenção:* uso do aplicativo por 8 semanas;
- *Controle:* lista de espera com acesso a materiais psicoeducativos;
- *Medidas:* PHQ-9, GAD-7, WHOQOL-BREF em baseline, 4 semanas e 8 semanas;
- *Análise:* ANOVA de medidas repetidas, análise de intenção de tratar.

== Aspectos Éticos

O projeto será submetido ao Comitê de Ética em Pesquisa da instituição. Todos os participantes assinarão Termo de Consentimento Livre e Esclarecido. Os dados serão anonimizados e armazenados em conformidade com a LGPD.

// cronograma-simples() já traz o título da seção
#cronograma-simples(
  titulo: "CRONOGRAMA",
  atividades: (
    "Revisão sistemática da literatura",
    "Seleção de técnicas de TCC",
    "Design e prototipação",
    "Desenvolvimento do aplicativo",
    "Testes de qualidade",
    "Estudo piloto",
    "Análise do estudo piloto",
    "Ajustes no aplicativo",
    "Recrutamento para ensaio clínico",
    "Condução do ensaio clínico",
    "Análise dos dados",
    "Redação da dissertação",
    "Defesa",
  ),
  // Períodos = meses do projeto (1 a 12). Se preferir nomes de mês, use as
  // abreviaturas da NBR 5892 ("jan.", "fev.", ..., "maio", ...), que ocupam mais
  // espaço: com 12 colunas elas não cabem ("maio" é cortado); use poucos períodos.
  periodos: ("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"),
  marcacoes: (
    (true, true, false, false, false, false, false, false, false, false, false, false),  // Revisão
    (true, true, false, false, false, false, false, false, false, false, false, false),  // Seleção TCC
    (false, true, true, true, false, false, false, false, false, false, false, false),   // Design
    (false, false, true, true, true, true, false, false, false, false, false, false),    // Desenvolvimento
    (false, false, false, false, true, true, false, false, false, false, false, false),  // Testes
    (false, false, false, false, false, true, true, false, false, false, false, false),  // Piloto
    (false, false, false, false, false, false, true, false, false, false, false, false), // Análise piloto
    (false, false, false, false, false, false, true, true, false, false, false, false),  // Ajustes
    (false, false, false, false, false, false, false, true, false, false, false, false), // Recrutamento
    (false, false, false, false, false, false, false, true, true, true, false, false),   // Ensaio
    (false, false, false, false, false, false, false, false, false, true, true, false),  // Análise
    (false, false, false, false, false, false, false, false, false, true, true, true),   // Redação
    (false, false, false, false, false, false, false, false, false, false, false, true), // Defesa
  ),
)

// Tabela de recursos
#heading(level: 1, "RECURSOS")

#figure(
  table(
    columns: (1fr, auto),
    stroke: none,
    inset: 6pt,
    align: (left, right),

    table.hline(stroke: 1pt),
    [*Descrição*], [*Valor (R\$)*],
    table.hline(stroke: 0.5pt),

    [Equipamentos (notebooks, smartphones para teste)], [15.000,00],
    [Infraestrutura de cloud (AWS) - 12 meses], [8.000,00],
    [Licenças de software (Figma, Adobe, etc.)], [3.000,00],
    [Participação em eventos científicos], [5.000,00],
    [Material de escritório e impressões], [500,00],
    [Incentivos para participantes do estudo], [10.000,00],
    [Revisão de inglês para publicações], [2.000,00],
    [Taxas de publicação (open access)], [6.000,00],
    [Reserva para imprevistos], [1.500,00],

    table.hline(stroke: 0.5pt),
    [*Total*], [*51.000,00*],
    table.hline(stroke: 1pt),
  ),
  caption: [Orçamento previsto para o projeto],
  kind: table,
)

#fonte[Elaborado pela autora (2026).]

*Fonte de financiamento:* Bolsa CAPES/CNPq + Edital de fomento à pesquisa da instituição.

// ============================================================================
// ELEMENTOS PÓS-TEXTUAIS
// ============================================================================

// Referências: só as obras citadas no texto saem. O .bib é lido com read() (relativo
// a este arquivo). Vêm antes do glossário, do apêndice e do anexo (NBR 15287 4.2.3).
#abnt-bibliography(read("referencias.bib"))

// Glossário
#glossario-projeto((
  "API": "Application Programming Interface - conjunto de protocolos para construção de software.",
  "AWS": "Amazon Web Services - plataforma de computação em nuvem.",
  "Backend": "Parte do sistema responsável pelo processamento de dados no servidor.",
  "Cross-platform": "Tecnologia que permite desenvolver aplicativos para múltiplas plataformas.",
  "Frontend": "Parte do sistema com a qual o usuário interage diretamente.",
  "GAD-7": "Generalized Anxiety Disorder 7-item scale - escala de avaliação de ansiedade.",
  "LGPD": "Lei Geral de Proteção de Dados - legislação brasileira sobre privacidade.",
  "Machine Learning": "Aprendizado de máquina - técnicas que permitem sistemas aprenderem com dados.",
  "PHQ-9": "Patient Health Questionnaire 9-item - instrumento de triagem para depressão.",
  "React Native": "Framework JavaScript para desenvolvimento de aplicativos móveis.",
  "TCC": "Terapia Cognitivo-Comportamental - abordagem psicoterapêutica baseada em evidências.",
  "Wireframe": "Esboço visual de baixa fidelidade de uma interface.",
))

// Apêndice
#apendice("A", "Roteiro de Entrevista para Estudo Piloto")

*Questões sobre Usabilidade:*

+ Você conseguiu navegar pelo aplicativo sem dificuldade?
+ Alguma função não ficou clara para você?
+ O que você mudaria na interface?
+ As instruções dos exercícios foram compreensíveis?

*Questões sobre Aceitação:*

+ Você usaria este aplicativo regularmente?
+ Recomendaria o aplicativo para outras pessoas?
+ O que mais gostou no aplicativo?
+ O que menos gostou?

*Questões sobre Conteúdo:*

+ Os exercícios propostos foram úteis para você?
+ Sentiu falta de algum tipo de conteúdo?
+ O nível de dificuldade foi adequado?

// Anexo
#anexo("A", "Escala PHQ-9")

A escala PHQ-9 (Patient Health Questionnaire) é um instrumento de autorrelato composto por 9 itens que avaliam a presença e gravidade de sintomas depressivos nas últimas duas semanas. Cada item é pontuado de 0 (nenhum dia) a 3 (quase todos os dias), resultando em escore total de 0 a 27.

*Interpretação dos escores:*

- 0-4: Mínimo ou nenhum sintoma
- 5-9: Sintomas leves
- 10-14: Sintomas moderados
- 15-19: Sintomas moderadamente graves
- 20-27: Sintomas graves

*Nota:* O instrumento completo está disponível mediante solicitação ao autor ou pode ser acessado em: www.phqscreeners.com

#anexo("B", "Escala GAD-7")

A escala GAD-7 (Generalized Anxiety Disorder) é um instrumento de autorrelato composto por 7 itens que avaliam a presença e gravidade de sintomas de ansiedade nas últimas duas semanas.

*Interpretação dos escores:*

- 0-4: Ansiedade mínima
- 5-9: Ansiedade leve
- 10-14: Ansiedade moderada
- 15-21: Ansiedade grave

*Nota:* O instrumento completo está disponível mediante solicitação ao autor ou pode ser acessado em: www.phqscreeners.com
