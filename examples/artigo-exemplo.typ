// Exemplo de Artigo Científico conforme NBR 6022:2018
//
// ============================================================================
// Este exemplo demonstra o uso do template article do ABNTypst para criar
// artigos científicos em conformidade com a NBR 6022:2018.
//
// Elementos demonstrados:
// - Título e subtítulo
// - Múltiplos autores com afiliações (footnotes)
// - Resumo em português com palavras-chave
// - Abstract em inglês com keywords
// - Seções sem numeração (article-section)
// - Citações (sistema autor-data)
// - Figuras e tabelas
// - Referências automáticas via arquivo .bib
//
// ============================================================================

#import "../lib.typ": *

// Configuração do documento usando o template article
#show: artigo.with(
  titulo: "Impacto da Inteligência Artificial na Educação Superior",
  subtitulo: "uma revisão sistemática da literatura",
  autores: (
    (
      name: "Maria Eduarda Oliveira",
      affiliation: "Doutoranda em Educação, Universidade Federal de Exemplo. E-mail: maria.oliveira@ufe.edu.br",
    ),
    (
      name: "João Pedro Santos",
      affiliation: "Professor Doutor, Departamento de Ciência da Computação, Universidade Federal de Exemplo. E-mail: joao.santos@ufe.edu.br",
    ),
    (
      name: "Ana Carolina Ferreira",
      affiliation: "Mestranda em Tecnologia Educacional, Universidade Estadual de Modelo. E-mail: ana.ferreira@uem.edu.br",
    ),
  ),
  resumo: [
    Este artigo apresenta uma revisão sistemática da literatura sobre o impacto da inteligência artificial (IA) na educação superior. A pesquisa analisou 85 estudos publicados entre 2019 e 2024, identificando as principais aplicações de IA no contexto universitário, incluindo sistemas tutores inteligentes, avaliação automatizada, personalização do aprendizado e análise preditiva de desempenho acadêmico. Os resultados indicam que a IA tem potencial significativo para melhorar a qualidade do ensino e a experiência dos estudantes, embora existam desafios relacionados à ética, privacidade de dados e formação docente. Conclui-se que a integração efetiva da IA na educação superior requer políticas institucionais claras e investimento em capacitação tecnológica.
  ],
  resumo-en: [
    This article presents a systematic literature review on the impact of artificial intelligence (AI) in higher education. The research analyzed 85 studies published between 2019 and 2024, identifying the main applications of AI in the university context, including intelligent tutoring systems, automated assessment, personalized learning, and predictive analysis of academic performance. The results indicate that AI has significant potential to improve teaching quality and student experience, although there are challenges related to ethics, data privacy, and teacher training. It is concluded that the effective integration of AI in higher education requires clear institutional policies and investment in technological training.
  ],
  palavras-chave: ("Inteligência artificial", "Educação superior", "Tecnologia educacional", "Aprendizado personalizado", "Revisão sistemática"),
  palavras-chave-en: ("Artificial intelligence", "Higher education", "Educational technology", "Personalized learning", "Systematic review"),
  fonte: "Times New Roman",
  colunas: 1,
  // Para usar bibliografia automática, descomente a linha abaixo:
  // arquivo-bibliografia: "examples/referencias.bib",
)

// ============================================================================
// ELEMENTOS TEXTUAIS
// ============================================================================

= Introdução

A transformação digital tem impactado profundamente todos os setores da sociedade, e a educação não é exceção. Nos últimos anos, a inteligência artificial (IA) emergiu como uma das tecnologias mais promissoras para revolucionar os processos de ensino e aprendizagem nas instituições de educação superior. Segundo Oliveira e Costa (2021), a IA oferece possibilidades inéditas de personalização e adaptação do ensino às necessidades individuais dos estudantes.

O crescente interesse pela aplicação de IA na educação é evidenciado pelo aumento exponencial de publicações científicas sobre o tema. Conforme apontam Santos (2022), as pesquisas nessa área cresceram mais de 300% entre 2015 e 2022, refletindo tanto o avanço tecnológico quanto a busca por soluções inovadoras para os desafios educacionais contemporâneos.

Neste contexto, o presente artigo tem como objetivo realizar uma revisão sistemática da literatura sobre o impacto da inteligência artificial na educação superior, identificando as principais aplicações, benefícios e desafios dessa integração tecnológica.

= Referencial Teórico

== Inteligência Artificial: Conceitos Fundamentais

A inteligência artificial pode ser definida como o campo da ciência da computação dedicado ao desenvolvimento de sistemas capazes de executar tarefas que normalmente requerem inteligência humana. De acordo com Cormen et al. (2012), os algoritmos de IA incluem técnicas de aprendizado de máquina, processamento de linguagem natural, visão computacional e sistemas especialistas.

No contexto educacional, a IA manifesta-se principalmente através de sistemas adaptativos que ajustam o conteúdo e a metodologia de ensino com base no perfil e no desempenho do estudante. Silva e Santos (2023) destacam que esses sistemas utilizam algoritmos de recomendação similares aos empregados por plataformas de streaming, mas adaptados para fins pedagógicos.

== Aplicações de IA na Educação Superior

As principais aplicações de IA na educação superior podem ser categorizadas em quatro grandes áreas:

+ *Sistemas Tutores Inteligentes (STI):* Plataformas que simulam a interação com um tutor humano, oferecendo feedback personalizado e adaptando o ritmo de aprendizagem às necessidades do estudante.

+ *Avaliação Automatizada:* Ferramentas que utilizam processamento de linguagem natural para avaliar textos dissertativos, reduzindo a carga de trabalho docente e fornecendo feedback mais rápido aos estudantes.

+ *Análise de Aprendizagem:* Sistemas que coletam e analisam dados sobre o comportamento e o desempenho dos estudantes, permitindo intervenções pedagógicas precoces.

+ *Assistentes Virtuais:* Chatbots e agentes conversacionais que respondem dúvidas frequentes e auxiliam os estudantes em tarefas administrativas.

= Metodologia

A pesquisa adotou o protocolo de revisão sistemática proposto por Kitchenham e Charters (2007), amplamente utilizado em estudos de engenharia de software e tecnologia educacional. A busca foi realizada nas bases de dados Scopus, Web of Science e IEEE Xplore, utilizando os descritores "artificial intelligence" AND "higher education" AND ("teaching" OR "learning").

== Critérios de Seleção

Foram incluídos artigos que atenderam aos seguintes critérios:

- Publicados entre janeiro de 2019 e dezembro de 2024;
- Escritos em inglês, português ou espanhol;
- Focados em aplicações práticas de IA na educação superior;
- Publicados em periódicos revisados por pares ou anais de conferências.

Foram excluídos estudos teóricos sem validação empírica, artigos de revisão anteriores e publicações duplicadas.

== Processo de Análise

A análise dos dados seguiu abordagem qualitativa, com categorização temática dos estudos selecionados. Dois pesquisadores independentes realizaram a extração de dados, com resolução de divergências por consenso.

#figure(
  table(
    columns: (auto, auto, auto),
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Base de Dados*], [*Resultados Iniciais*], [*Após Triagem*],
    table.hline(stroke: 0.75pt),
    [Scopus], [1.245], [42],
    [Web of Science], [987], [28],
    [IEEE Xplore], [534], [15],
    [*Total*], [*2.766*], [*85*],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Resultados da busca nas bases de dados],
  kind: table,
)

#fonte[Elaborado pelos autores (2026).]

= Resultados e Discussão

A análise dos 85 estudos selecionados revelou tendências significativas na aplicação de IA na educação superior. A distribuição temporal mostrou crescimento consistente, com 67% dos estudos publicados entre 2022 e 2024.

== Principais Achados

Os sistemas tutores inteligentes representaram a aplicação mais frequente (38% dos estudos), seguidos por ferramentas de avaliação automatizada (25%), análise de aprendizagem (22%) e assistentes virtuais (15%).

Quanto aos impactos positivos identificados, destacam-se:

- Aumento de 23% nas taxas de conclusão de disciplinas (média dos estudos);
- Redução de 40% no tempo de feedback para atividades avaliativas;
- Melhoria na satisfação dos estudantes com a experiência de aprendizagem.

No entanto, os estudos também apontaram desafios importantes. A questão da privacidade de dados foi mencionada em 72% das publicações como uma preocupação crítica. Além disso, 58% dos estudos indicaram resistência inicial de docentes à adoção de ferramentas de IA.

#figure(
  image("../docs/figuras/placeholder.svg", width: 80%),
  caption: [Distribuição das aplicações de IA na educação superior],
)

#fonte[Elaborado pelos autores (2026).]

#nota-figura[Os percentuais referem-se ao total de 85 estudos analisados.]

== Implicações para a Prática

Os resultados sugerem que a implementação bem-sucedida de IA na educação superior depende de três fatores principais: (1) infraestrutura tecnológica adequada; (2) formação continuada de docentes; e (3) políticas institucionais que equilibrem inovação e ética.

Conforme destacam Ferreira (2020), a formação docente é particularmente crítica, pois os professores precisam compreender não apenas como utilizar as ferramentas de IA, mas também suas limitações e potenciais vieses.

= Considerações Finais

Este estudo apresentou uma revisão sistemática sobre o impacto da inteligência artificial na educação superior, analisando 85 publicações dos últimos cinco anos. Os resultados evidenciam que a IA tem potencial transformador para o ensino universitário, oferecendo possibilidades de personalização, automação e análise que eram impensáveis há poucos anos.

Entretanto, a integração efetiva dessas tecnologias requer atenção cuidadosa aos desafios identificados, particularmente no que concerne à ética, privacidade e formação docente. As instituições de educação superior que desejam beneficiar-se da IA devem desenvolver políticas claras, investir em capacitação e manter o foco na qualidade pedagógica, evitando a adoção tecnológica acrítica.

Como limitação deste estudo, destaca-se a restrição linguística que pode ter excluído publicações relevantes em outros idiomas. Pesquisas futuras podem ampliar o escopo geográfico e linguístico, além de investigar longitudinalmente os efeitos da IA sobre a aprendizagem dos estudantes.

// ============================================================================
// REFERÊNCIAS
// ============================================================================

// OPÇÃO 1: Bibliografia automática
// Se você usou o parâmetro bibliography-file no template, as referências
// são inseridas automaticamente. Também pode usar diretamente:
// #abnt-bibliography("examples/referencias.bib")

// OPÇÃO 2: Referências manuais (demonstração abaixo)

#heading(level: 1, numbering: none, "REFERÊNCIAS")

#set par(hanging-indent: 1.25cm, first-line-indent: 0pt)

CORMEN, Thomas H. et al. *Algoritmos*: teoria e prática. 3. ed. Rio de Janeiro: Elsevier, 2012.

FERREIRA, Lucas Mendes. *Sistemas distribuídos para processamento de big data*. 2020. 150 f. Dissertação (Mestrado em Ciência da Computação) -- Universidade Federal de São Paulo, São José dos Campos, 2020.

IBGE. *Pesquisa Nacional por Amostra de Domicílios Contínua*. Rio de Janeiro: IBGE, 2023. Disponível em: https://www.ibge.gov.br/. Acesso em: 15 out. 2023.

OLIVEIRA, Ana Paula; COSTA, Ricardo. Inteligência artificial aplicada à educação. *Ciência da Informação*, São Paulo, v. 50, n. 3, p. 123-145, 2021.

SANTOS, Pedro Augusto. Análise comparativa de algoritmos de ordenação. *Revista Brasileira de Computação*, Brasília, v. 15, n. 2, p. 35-48, maio/ago. 2022.

SILVA, João Carlos; SANTOS, Maria Helena. *Metodologia científica*: fundamentos e aplicações. 5. ed. São Paulo: Atlas, 2023.
