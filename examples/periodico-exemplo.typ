// Exemplo de Publicação Periódica Técnica e/ou Científica conforme NBR 6021:2015
//
// ============================================================================
// Este exemplo demonstra o uso do template periodical do ABNTypst para criar
// fascículos de periódicos científicos em conformidade com a NBR 6021:2015.
//
// Elementos demonstrados:
// - periodical-cover() - Capa com ISSN, volume, número
// - periodical-title-page() - Folha de rosto
// - periodical-title-page-verso() - Verso com expediente
// - periodical-toc() - Sumário
// - editorial() - Editorial
// - periodical-article() - Artigos com resumos
// - bibliographic-legend() - Legenda bibliográfica no rodapé
// - author-guidelines() - Normas para autores
//
// ============================================================================

#import "../lib.typ": *

// Configuração do documento usando o template periodical
#show: periodical.with(
  title: "Revista Brasileira de Tecnologia e Inovação",
  subtitle: "Brazilian Journal of Technology and Innovation",
  issn: "2965-0000",
  volume: 8,
  number: 2,
  year: 2026,
  month-start: 5,  // maio
  month-end: 8,    // agosto
  location: "Cidade",
  publisher: "Editora Universitária",
  institution: "Universidade Federal de Exemplo",
  font: "Times New Roman",
)

// ============================================================================
// ELEMENTOS PRÉ-TEXTUAIS
// ============================================================================

// Capa do fascículo
#periodical-cover(
  title: "Revista Brasileira de Tecnologia e Inovação",
  subtitle: "Brazilian Journal of Technology and Innovation",
  issn: "2965-0000",
  volume: 8,
  number: 2,
  year: 2026,
  month-start: 5,
  month-end: 8,
)

// Folha de rosto - anverso
#periodical-title-page(
  title: "Revista Brasileira de Tecnologia e Inovação",
  issn: "2965-0000",
  volume: 8,
  number: 2,
  pages: "1-180",
  year: 2026,
  month-start: 5,
  month-end: 8,
  location: "Cidade",
)

// Folha de rosto - verso (expediente)
#periodical-title-page-verso(
  copyright-year: 2026,
  copyright-holder: "Universidade Federal de Exemplo",
  reproduction-rights: [
    É permitida a reprodução parcial ou total desta obra, desde que citada a fonte e que não seja para venda ou qualquer fim comercial.
  ],
  credits: [
    *CORPO EDITORIAL*

    *Editor-Chefe*
    Prof. Dr. Ricardo Mendes Albuquerque
    Universidade Federal de Exemplo

    *Editores Associados*
    Profa. Dra. Carla Regina Sousa -- UFE
    Prof. Dr. Marcos Antonio Lima -- UFRJ
    Profa. Dra. Patrícia Helena Costa -- USP

    *Conselho Editorial*
    Prof. Dr. André Luiz Ferreira -- UNICAMP
    Profa. Dra. Beatriz Santos Oliveira -- UFMG
    Prof. Dr. Carlos Eduardo Martins -- UFRGS
    Profa. Dra. Diana Cristina Pereira -- UnB
    Prof. Dr. Eduardo Felipe Silva -- UFSC
    Prof. Dr. Fernando José Ribeiro -- PUC-Rio

    *Secretaria Editorial*
    Ana Paula Rodrigues
    E-mail: rbti\@ufe.edu.br

    *Revisão de Português*
    Prof. Me. João Carlos Andrade

    *Revisão de Inglês*
    Profa. Dra. Michelle Santos

    *Diagramação*
    Núcleo de Editoração -- UFE

    *Periodicidade:* Quadrimestral

    *Indexação:* Latindex, DOAJ, Redalyc, Google Scholar
  ],
  cataloging: [
    #set text(size: 9pt)
    Revista Brasileira de Tecnologia e Inovação / Universidade Federal de Exemplo. -- v. 1, n. 1 (2019)- . -- Cidade: Editora Universitária, 2019-

    #h(1em) Quadrimestral
    #h(1em) ISSN 2965-0000

    #h(1em) 1. Tecnologia - Periódicos. 2. Inovação - Periódicos.
    I. Universidade Federal de Exemplo.

    #align(right)[CDD 600]
  ],
)

// Sumário
#periodical-toc()

// Editorial
#editorial[
  Prezados leitores,

  É com grande satisfação que apresentamos o segundo número do volume 8 da Revista Brasileira de Tecnologia e Inovação, correspondente ao período de maio a agosto de 2026.

  Este fascículo traz contribuições significativas para o avanço do conhecimento nas áreas de tecnologia da informação, engenharia de software e inovação tecnológica. Os artigos selecionados passaram por rigoroso processo de avaliação por pares, garantindo a qualidade científica que nossos leitores esperam.

  Destacamos o artigo de abertura, que aborda o uso de aprendizado de máquina para detecção de anomalias em sistemas industriais, tema de grande relevância no contexto da Indústria 4.0. O segundo artigo apresenta uma análise sobre práticas de DevOps em empresas brasileiras, oferecendo insights valiosos para profissionais e pesquisadores da área. O terceiro trabalho investiga o impacto de interfaces conversacionais na experiência do usuário, contribuindo para o campo emergente da interação humano-computador mediada por inteligência artificial.

  Agradecemos aos autores que confiaram seus trabalhos à nossa revista, aos avaliadores que dedicaram tempo e expertise para garantir a qualidade das publicações, e aos leitores que acompanham nossa trajetória.

  Desejamos uma excelente leitura!

  #v(1em)

  *Prof. Dr. Ricardo Mendes Albuquerque*

  Editor-Chefe
]

// ============================================================================
// ARTIGOS
// ============================================================================

// Artigo 1
#pagebreak()
#periodical-article(
  title: "Detecção de Anomalias em Sistemas Industriais utilizando Aprendizado de Máquina",
  authors: (
    (name: "André Luiz Pereira", affiliation: "Doutor em Engenharia de Produção, Professor Adjunto da Universidade Federal de Exemplo. E-mail: andre.pereira@ufe.edu.br"),
    (name: "Juliana Costa Ribeiro", affiliation: "Mestranda em Ciência da Computação, Universidade Federal de Exemplo. E-mail: juliana.ribeiro@ufe.edu.br"),
  ),
  abstract-pt: [
    Este artigo apresenta uma abordagem baseada em aprendizado de máquina para detecção de anomalias em sistemas industriais no contexto da Indústria 4.0. O método proposto utiliza uma combinação de autoencoders e redes LSTM para identificar padrões anômalos em séries temporais de sensores. Os experimentos foram realizados com dados reais de uma planta industrial do setor petroquímico, alcançando taxa de detecção de 94,7% com apenas 2,3% de falsos positivos. Os resultados demonstram que a abordagem proposta supera métodos estatísticos tradicionais e pode ser integrada a sistemas de manutenção preditiva.
  ],
  keywords-pt: ("Detecção de anomalias", "Aprendizado de máquina", "Indústria 4.0", "Manutenção preditiva", "Séries temporais"),
  abstract-en: [
    This paper presents a machine learning approach for anomaly detection in industrial systems in the context of Industry 4.0. The proposed method uses a combination of autoencoders and LSTM networks to identify anomalous patterns in sensor time series. Experiments were conducted with real data from a petrochemical plant, achieving a detection rate of 94.7% with only 2.3% false positives. The results demonstrate that the proposed approach outperforms traditional statistical methods and can be integrated into predictive maintenance systems.
  ],
  keywords-en: ("Anomaly detection", "Machine learning", "Industry 4.0", "Predictive maintenance", "Time series"),
)[
  = Introdução

  A transformação digital da indústria, conhecida como Indústria 4.0, tem proporcionado a geração de grandes volumes de dados provenientes de sensores e sistemas de monitoramento. Neste cenário, a detecção automática de anomalias torna-se fundamental para garantir a continuidade operacional e a segurança dos processos industriais.

  Os métodos tradicionais de detecção de anomalias, baseados em limiares estáticos ou regras definidas por especialistas, apresentam limitações significativas quando aplicados a sistemas complexos com múltiplas variáveis interdependentes. Técnicas de aprendizado de máquina oferecem alternativas promissoras ao permitir a identificação de padrões sutis e não-lineares nos dados.

  Este trabalho propõe uma arquitetura híbrida que combina autoencoders para redução de dimensionalidade e extração de características com redes LSTM para modelagem temporal. A abordagem foi validada em cenário real de uma planta petroquímica.

  = Metodologia

  == Arquitetura Proposta

  A arquitetura proposta consiste em duas etapas principais: (1) pré-processamento e normalização dos dados de sensores; (2) modelo híbrido autoencoder-LSTM para detecção de anomalias.

  O autoencoder é treinado para reconstruir as leituras normais dos sensores. Anomalias são identificadas quando o erro de reconstrução excede um limiar adaptativo calculado com base na distribuição dos erros durante o treinamento.

  == Dataset

  O dataset utilizado contém 6 meses de leituras de 45 sensores de uma unidade de destilação, totalizando aproximadamente 2,6 milhões de registros. O conjunto foi dividido em 70% para treinamento, 15% para validação e 15% para teste.

  = Resultados

  Os resultados obtidos demonstram a eficácia da abordagem proposta. A taxa de detecção (recall) alcançou 94,7%, com precisão de 91,2% e taxa de falsos positivos de apenas 2,3%.

  A comparação com métodos baseline (limiar estatístico, Isolation Forest e One-Class SVM) mostrou ganhos significativos, especialmente na redução de falsos positivos, crítica para aplicações industriais onde alarmes frequentes levam à dessensibilização dos operadores.

  = Conclusão

  Este trabalho apresentou uma abordagem eficaz para detecção de anomalias em ambientes industriais utilizando técnicas de deep learning. Os resultados validam a aplicabilidade do método em cenários reais e indicam potencial para integração com sistemas de manutenção preditiva.

  Trabalhos futuros incluem a extensão da abordagem para detecção em tempo real com latência mínima e a investigação de técnicas de explicabilidade para auxiliar operadores na interpretação dos alertas.

  = Referências

  #set par(hanging-indent: 1.25cm, first-line-indent: 0pt)

  CHANDOLA, V.; BANERJEE, A.; KUMAR, V. Anomaly detection: a survey. *ACM Computing Surveys*, v. 41, n. 3, p. 1-58, 2009.

  GOODFELLOW, I.; BENGIO, Y.; COURVILLE, A. *Deep Learning*. Cambridge: MIT Press, 2016.

  LEE, J. et al. Industrial artificial intelligence for Industry 4.0-based manufacturing systems. *Manufacturing Letters*, v. 18, p. 20-23, 2018.
]

// Artigo 2
#pagebreak()
#periodical-article(
  title: "Práticas de DevOps em Empresas Brasileiras de Desenvolvimento de Software",
  authors: (
    (name: "Marcos Vinícius Santos", affiliation: "Doutorando em Engenharia de Software, Universidade Estadual de Modelo. E-mail: marcos.santos@uem.edu.br"),
    (name: "Fernanda Cristina Lima", affiliation: "Professora Associada, Departamento de Computação, Universidade Estadual de Modelo. E-mail: fernanda.lima@uem.edu.br"),
    (name: "Paulo Roberto Oliveira", affiliation: "Professor Titular, Departamento de Computação, Universidade Estadual de Modelo. E-mail: paulo.oliveira@uem.edu.br"),
  ),
  abstract-pt: [
    Este artigo investiga a adoção de práticas DevOps em empresas brasileiras de desenvolvimento de software. Foi conduzido um survey com 247 profissionais de 89 organizações de diferentes portes e setores. Os resultados indicam que 68% das empresas participantes adotam pelo menos parcialmente práticas DevOps, com destaque para integração contínua (82%), controle de versão (95%) e containerização (61%). Os principais benefícios reportados incluem redução no tempo de entrega, melhoria na qualidade do software e maior colaboração entre equipes. As barreiras mais citadas foram resistência cultural, falta de habilidades técnicas e complexidade de ferramentas. O estudo contribui para a compreensão do estado atual da adoção de DevOps no contexto brasileiro.
  ],
  keywords-pt: ("DevOps", "Engenharia de software", "Práticas ágeis", "Integração contínua", "Survey"),
  abstract-en: [
    This paper investigates the adoption of DevOps practices in Brazilian software development companies. A survey was conducted with 247 professionals from 89 organizations of different sizes and sectors. Results indicate that 68% of participating companies at least partially adopt DevOps practices, with emphasis on continuous integration (82%), version control (95%), and containerization (61%). The main reported benefits include reduced delivery time, improved software quality, and greater collaboration between teams. The most cited barriers were cultural resistance, lack of technical skills, and tool complexity. The study contributes to understanding the current state of DevOps adoption in the Brazilian context.
  ],
  keywords-en: ("DevOps", "Software engineering", "Agile practices", "Continuous integration", "Survey"),
)[
  = Introdução

  DevOps é um conjunto de práticas que visa unificar o desenvolvimento de software (Dev) e as operações de TI (Ops), promovendo maior colaboração, automação e entrega contínua de valor. Originado na comunidade de software por volta de 2009, o movimento DevOps ganhou ampla adoção global na última década.

  Apesar da crescente importância do DevOps para a competitividade das organizações de software, poucos estudos investigaram sistematicamente sua adoção no contexto brasileiro. Este trabalho busca preencher essa lacuna através de um survey abrangente com profissionais da indústria nacional.

  = Metodologia

  == Design do Survey

  O questionário foi desenvolvido com base em frameworks estabelecidos de avaliação de maturidade DevOps, como o modelo CALMS (Culture, Automation, Lean, Measurement, Sharing) e relatórios como o DORA State of DevOps.

  O instrumento final contém 45 questões organizadas em seções: perfil do respondente, características da organização, práticas adotadas, benefícios percebidos e barreiras encontradas.

  == Coleta de Dados

  A coleta ocorreu entre março e maio de 2025, através de formulário online divulgado em comunidades de desenvolvedores, eventos de tecnologia e redes profissionais. Foram obtidas 247 respostas válidas de 89 organizações distintas.

  = Resultados

  == Adoção de Práticas

  Os resultados mostram alta adoção de práticas fundamentais: controle de versão (95%), integração contínua (82%) e testes automatizados (74%). Práticas mais avançadas como deployment contínuo (47%) e infraestrutura como código (51%) apresentam adoção moderada.

  == Benefícios Percebidos

  Os principais benefícios reportados foram: redução do tempo de entrega (87%), melhoria na qualidade (79%), maior colaboração (76%) e detecção mais rápida de problemas (71%).

  == Barreiras

  As principais barreiras identificadas incluem: resistência cultural à mudança (63%), falta de habilidades técnicas (58%), complexidade de ferramentas (52%) e falta de apoio da gestão (41%).

  = Discussão

  Os resultados indicam que a adoção de DevOps no Brasil segue tendência similar à observada em estudos internacionais, embora com algumas particularidades. A alta adoção de práticas básicas sugere que as organizações brasileiras reconhecem o valor do DevOps, mas enfrentam desafios na implementação de práticas mais avançadas.

  A resistência cultural emerge como o principal obstáculo, corroborando a literatura que enfatiza DevOps como uma transformação cultural antes de ser uma mudança tecnológica.

  = Conclusão

  Este estudo apresentou um panorama da adoção de DevOps em empresas brasileiras de desenvolvimento de software. Os resultados contribuem para a compreensão das práticas adotadas, benefícios alcançados e barreiras enfrentadas pelas organizações no contexto nacional.

  = Referências

  #set par(hanging-indent: 1.25cm, first-line-indent: 0pt)

  FORSGREN, N.; HUMBLE, J.; KIM, G. *Accelerate*: the science of lean software and DevOps. Portland: IT Revolution, 2018.

  KIM, G. et al. *The DevOps Handbook*: how to create world-class agility, reliability, and security in technology organizations. Portland: IT Revolution, 2016.

  HUMBLE, J.; FARLEY, D. *Continuous Delivery*: reliable software releases through build, test, and deployment automation. Boston: Addison-Wesley, 2010.
]

// Artigo 3
#pagebreak()
#periodical-article(
  title: "Impacto de Interfaces Conversacionais na Experiência do Usuário em Aplicativos Bancários",
  authors: (
    (name: "Carolina Beatriz Mendes", affiliation: "Mestre em Design de Interação, Pesquisadora na Universidade Federal de Exemplo. E-mail: carolina.mendes@ufe.edu.br"),
    (name: "Roberto Carlos Ferreira", affiliation: "Doutor em Ciência da Computação, Professor Associado da Universidade Federal de Exemplo. E-mail: roberto.ferreira@ufe.edu.br"),
  ),
  abstract-pt: [
    Este artigo investiga o impacto de interfaces conversacionais (chatbots) na experiência do usuário em aplicativos bancários móveis. Um estudo experimental com 120 participantes comparou a realização de tarefas bancárias comuns utilizando interface tradicional (menus e botões) versus interface conversacional. Os resultados indicam que a interface conversacional apresentou maior satisfação percebida (4,2 vs 3,6 na escala SUS) e menor carga cognitiva, especialmente para tarefas complexas como consulta de extratos e contestação de transações. Entretanto, a interface tradicional mostrou-se superior para tarefas simples e frequentes, como transferências. Recomenda-se a adoção de interfaces híbridas que permitam ao usuário escolher o modo de interação conforme o contexto da tarefa.
  ],
  keywords-pt: ("Chatbot", "Experiência do usuário", "Interface conversacional", "Mobile banking", "Usabilidade"),
  abstract-en: [
    This paper investigates the impact of conversational interfaces (chatbots) on user experience in mobile banking applications. An experimental study with 120 participants compared common banking tasks using traditional interface (menus and buttons) versus conversational interface. Results indicate that the conversational interface showed higher perceived satisfaction (4.2 vs 3.6 on SUS scale) and lower cognitive load, especially for complex tasks such as statement queries and transaction disputes. However, the traditional interface proved superior for simple and frequent tasks such as transfers. Hybrid interfaces that allow users to choose the interaction mode according to task context are recommended.
  ],
  keywords-en: ("Chatbot", "User experience", "Conversational interface", "Mobile banking", "Usability"),
)[
  = Introdução

  O setor bancário tem investido significativamente em interfaces conversacionais como forma de melhorar o atendimento ao cliente e reduzir custos operacionais. Chatbots baseados em inteligência artificial são cada vez mais comuns em aplicativos móveis de instituições financeiras, prometendo interações mais naturais e intuitivas.

  Entretanto, a literatura sobre a eficácia dessas interfaces no contexto específico de aplicativos bancários ainda é limitada. Este estudo busca investigar empiricamente em quais cenários as interfaces conversacionais oferecem vantagens em relação às interfaces tradicionais baseadas em menus.

  = Metodologia

  == Participantes

  Participaram do estudo 120 adultos (62 mulheres, 58 homens), com idades entre 22 e 58 anos (M=34,2, DP=9,8), todos usuários regulares de aplicativos bancários móveis.

  == Design Experimental

  O estudo utilizou design within-subjects, com cada participante realizando 6 tarefas em ambas as interfaces (tradicional e conversacional), em ordem contrabalanceada. As tarefas incluíam: consulta de saldo, transferência PIX, pagamento de boleto, consulta de extrato detalhado, contestação de transação e configuração de alertas.

  == Métricas

  Foram coletadas métricas objetivas (tempo de conclusão, taxa de sucesso, número de erros) e subjetivas (SUS, NASA-TLX, preferência declarada).

  = Resultados

  == Desempenho por Tipo de Tarefa

  A análise revelou interação significativa entre tipo de interface e complexidade da tarefa. Para tarefas simples (saldo, transferência), a interface tradicional apresentou tempo médio de conclusão 23% menor. Para tarefas complexas (extrato detalhado, contestação), a interface conversacional foi 18% mais rápida e apresentou 31% menos erros.

  == Satisfação e Carga Cognitiva

  A satisfação geral medida pela escala SUS foi significativamente maior para a interface conversacional (4,2 vs 3,6, p\<0,01). A carga cognitiva, medida pelo NASA-TLX, foi menor na interface conversacional para tarefas complexas.

  == Preferências

  Quando questionados sobre preferências, 45% indicaram preferir interface híbrida, 32% interface conversacional e 23% interface tradicional.

  = Discussão

  Os resultados sugerem que interfaces conversacionais não são universalmente superiores, mas oferecem vantagens específicas para tarefas que envolvem navegação complexa ou necessidade de contextualização. A preferência por interfaces híbridas indica que usuários valorizam a flexibilidade de escolha.

  = Conclusão

  Este estudo contribui para a compreensão de quando e como interfaces conversacionais agregam valor em aplicativos bancários. Recomenda-se que designers considerem a natureza das tarefas ao decidir onde implementar chatbots, priorizando cenários de alta complexidade e baixa frequência.

  = Referências

  #set par(hanging-indent: 1.25cm, first-line-indent: 0pt)

  FØLSTAD, A.; BRANDTZÆG, P. B. Chatbots and the new world of HCI. *Interactions*, v. 24, n. 4, p. 38-42, 2017.

  LUGER, E.; SELLEN, A. "Like having a really bad PA": the gulf between user expectation and experience of conversational agents. *CHI '16*, p. 5286-5297, 2016.

  NORMAN, D. *The Design of Everyday Things*. Revised edition. New York: Basic Books, 2013.
]

// ============================================================================
// NORMAS PARA AUTORES
// ============================================================================

#pagebreak()
#author-guidelines[
  = Escopo e Política Editorial

  A *Revista Brasileira de Tecnologia e Inovação* (RBTI) é um periódico científico de acesso aberto que publica artigos originais nas áreas de Ciência da Computação, Engenharia de Software, Sistemas de Informação e áreas correlatas. A revista adota o processo de avaliação por pares duplo-cego.

  = Tipos de Contribuições

  - *Artigos Originais:* pesquisas inéditas com contribuição científica significativa (6.000 a 10.000 palavras);
  - *Artigos de Revisão:* revisões sistemáticas ou meta-análises (8.000 a 12.000 palavras);
  - *Comunicações Breves:* relatos preliminares ou notas técnicas (2.000 a 4.000 palavras).

  = Formatação

  Os manuscritos devem ser submetidos em formato Word (.docx) ou LaTeX, seguindo o template disponível no site da revista. Elementos obrigatórios:

  - Título em português e inglês;
  - Resumo em português (150-250 palavras) com 3-5 palavras-chave;
  - Abstract em inglês (150-250 palavras) com 3-5 keywords;
  - Referências formatadas conforme ABNT NBR 6023:2018.

  = Processo de Submissão

  Submissões devem ser realizadas exclusivamente pelo sistema OJS da revista:

  https://rbti.ufe.edu.br/submissao

  = Contato

  Dúvidas podem ser encaminhadas para: rbti\@ufe.edu.br
]
