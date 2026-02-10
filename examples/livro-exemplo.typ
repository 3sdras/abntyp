// Exemplo de Livro conforme NBR 6029:2023
//
// ============================================================================
// Este exemplo demonstra o uso do template book do ABNTypst para criar
// livros e folhetos em conformidade com a NBR 6029:2023.
//
// Elementos demonstrados:
// - book-cover() - Capa
// - book-back-cover() - Quarta capa com ISBN
// - half-title-page() - Falsa folha de rosto
// - book-title-page() - Folha de rosto
// - book-title-page-verso() - Verso com copyright
// - book-dedication() - Dedicatória
// - book-acknowledgments() - Agradecimentos
// - book-epigraph() - Epígrafe
// - book-list-illustrations() - Lista de ilustrações
// - book-list-tables() - Lista de tabelas
// - book-list-abbreviations() - Lista de siglas
// - book-toc() - Sumário
// - book-preface() - Prefácio
// - Capítulos com seções numeradas
// - book-glossary() - Glossário
// - book-appendix() - Apêndice
// - book-index() - Índice remissivo
// - book-colophon() - Colofão
//
// ============================================================================

#import "../lib.typ": *

// Configuração do documento usando o template book
#show: livro.with(
  title: "Fundamentos de Programação",
  subtitle: "Uma Abordagem Prática",
  author: "Prof. Dr. Ricardo Mendes Silva",
  publisher: "Editora Universitária",
  location: "São Paulo",
  year: 2026,
  edition: 2,
  isbn: "978-65-00000-00-0",
  font: "Times New Roman",
  running-header: "Fundamentos de Programação",
)

// ============================================================================
// CAPA E QUARTA CAPA
// ============================================================================

// Primeira capa
#book-cover(
  author: "Prof. Dr. Ricardo Mendes Silva",
  title: "Fundamentos de Programação",
  subtitle: "Uma Abordagem Prática",
  publisher: "Editora Universitária",
  edition: 2,
  location: "São Paulo",
  year: 2026,
)

// Quarta capa (contracapa)
#book-back-cover(
  isbn: "978-65-00000-00-0",
  summary: [
    *Fundamentos de Programação: Uma Abordagem Prática* é um livro didático destinado a estudantes de cursos superiores de Computação, Engenharia e áreas afins que estão iniciando seus estudos em programação.

    Com linguagem clara e exemplos práticos, esta segunda edição atualizada aborda os conceitos essenciais da programação de computadores, incluindo algoritmos, estruturas de dados básicas, funções e tratamento de erros. Todos os exemplos são apresentados em Python 3.12, uma das linguagens mais utilizadas no ensino e na indústria.

    *Destaques desta edição:*
    - Conteúdo atualizado para Python 3.12
    - Novos exercícios práticos em cada capítulo
    - Projetos integradores ao final de cada parte
    - Material de apoio online com vídeos e exercícios interativos

    *Sobre o autor:*
    Ricardo Mendes Silva é Doutor em Ciência da Computação pela Universidade de São Paulo e Professor Titular da Universidade Federal de Exemplo. Possui mais de 20 anos de experiência no ensino de programação e é autor de diversos livros na área.
  ],
  publisher-address: [
    *Editora Universitária*

    Rua das Publicações, 500 -- Centro

    CEP 01000-000 -- São Paulo/SP

    www.editorauniversitaria.com.br

    contato\@editorauniversitaria.com.br
  ],
)

// ============================================================================
// ELEMENTOS PRÉ-TEXTUAIS
// ============================================================================

// Falsa folha de rosto
#half-title-page(title: "Fundamentos de Programação")

// Folha de rosto - anverso
#book-title-page(
  author: "Prof. Dr. Ricardo Mendes Silva",
  title: "Fundamentos de Programação",
  subtitle: "Uma Abordagem Prática",
  collaborators: [
    Revisão técnica: Profa. Dra. Ana Paula Ferreira

    Ilustrações: Carlos Eduardo Martins
  ],
  edition: 2,
  publisher: "Editora Universitária",
  location: "São Paulo",
  year: 2026,
)

// Folha de rosto - verso
#book-title-page-verso(
  copyright-year: 2026,
  copyright-holder: "Ricardo Mendes Silva",
  reproduction-rights: [
    Todos os direitos reservados. É proibida a reprodução total ou parcial desta obra sem autorização prévia e por escrito do autor e da editora.
  ],
  credits: [
    *Coordenação editorial:* Maria Helena Santos

    *Revisão:* João Carlos Andrade

    *Projeto gráfico e diagramação:* Studio Design Editorial

    *Capa:* Agência Criativa Visual

    1ª edição: 2022

    2ª edição: 2026

    Dados Internacionais de Catalogação na Publicação (CIP)
  ],
  catalog-card: [
    #set text(size: 9pt)
    #set par(leading: 0.8em)
    Silva, Ricardo Mendes

    #h(1em) Fundamentos de programação: uma abordagem prática / Ricardo Mendes Silva. -- 2. ed. -- São Paulo: Editora Universitária, 2026.

    #h(1em) 320 p. : il.

    #h(1em) ISBN 978-65-00000-00-0

    #h(1em) 1. Programação de computadores. 2. Python (Linguagem de programação). 3. Algoritmos. 4. Estruturas de dados. I. Título.

    #align(right)[CDD 005.133]
  ],
  librarian: "Bibliotecária responsável: Ana Maria Costa -- CRB-8/12345",
  publisher-info: [
    Editora Universitária Ltda.

    Rua das Publicações, 500 -- Centro -- São Paulo/SP -- CEP 01000-000

    Tel: (11) 3000-0000 -- www.editorauniversitaria.com.br
  ],
)

// Dedicatória
#book-dedication[
  Aos meus alunos, que ao longo de duas décadas de magistério me ensinaram a arte de ensinar.

  À minha família, pelo apoio incondicional.
]

// Agradecimentos
#book-acknowledgments[
  Agradeço primeiramente aos estudantes que utilizaram a primeira edição deste livro e contribuíram com sugestões valiosas para esta nova edição.

  À Profa. Dra. Ana Paula Ferreira, pela cuidadosa revisão técnica e pelas sugestões que enriqueceram significativamente o conteúdo.

  Aos colegas do Departamento de Ciência da Computação da Universidade Federal de Exemplo, pelas discussões sobre metodologias de ensino de programação.

  À equipe da Editora Universitária, pela competência e dedicação em todas as etapas do processo editorial.

  Por fim, à minha esposa Mariana e aos meus filhos Pedro e Julia, pela paciência durante os meses de preparação desta edição.
]

// Epígrafe
#book-epigraph(
  "Programas devem ser escritos para pessoas lerem, e apenas incidentalmente para máquinas executarem.",
  "Harold Abelson e Gerald Jay Sussman",
)

// Lista de ilustrações
#book-list-illustrations()

// Lista de tabelas
#book-list-tables()

// Lista de abreviaturas e siglas
#book-list-abbreviations((
  "API": "Application Programming Interface (Interface de Programação de Aplicativos)",
  "CPU": "Central Processing Unit (Unidade Central de Processamento)",
  "IDE": "Integrated Development Environment (Ambiente de Desenvolvimento Integrado)",
  "OOP": "Object-Oriented Programming (Programação Orientada a Objetos)",
  "RAM": "Random Access Memory (Memória de Acesso Aleatório)",
  "SQL": "Structured Query Language (Linguagem de Consulta Estruturada)",
))

// Sumário
#book-toc(depth: 3)

// Prefácio
#book-preface(title: "PREFÁCIO À SEGUNDA EDIÇÃO")[
  É com grande satisfação que apresento a segunda edição de *Fundamentos de Programação: Uma Abordagem Prática*. Desde a publicação da primeira edição em 2022, o livro tem sido adotado em dezenas de instituições de ensino superior em todo o Brasil, e o feedback dos professores e estudantes foi fundamental para esta nova versão.

  Esta edição traz atualizações importantes: todos os exemplos foram revisados para Python 3.12, novos exercícios práticos foram adicionados ao final de cada capítulo, e um novo capítulo sobre boas práticas de programação foi incluído. Além disso, o material de apoio online foi expandido com videoaulas e exercícios interativos.

  A abordagem didática permanece a mesma: apresentar os conceitos de forma gradual, com muitos exemplos práticos e exercícios que permitem ao estudante consolidar o aprendizado. Acredito que a melhor forma de aprender programação é programando, e por isso cada conceito é acompanhado de exemplos que o leitor pode executar e modificar.

  Espero que este livro continue contribuindo para a formação de novos programadores e que esta segunda edição atenda ainda melhor às necessidades de estudantes e professores.

  #v(2em)

  #align(right)[
    *Ricardo Mendes Silva*

    São Paulo, janeiro de 2026
  ]
]

// ============================================================================
// ELEMENTOS TEXTUAIS - CAPÍTULOS
// ============================================================================

// Inicia numeração das páginas
#counter(page).update(1)
#set page(numbering: "1", number-align: bottom + center)

= Introdução à Programação

A programação de computadores é uma das habilidades mais importantes do século XXI. Em um mundo cada vez mais digital, compreender como os computadores funcionam e ser capaz de criar programas não é mais uma competência exclusiva de especialistas em tecnologia, mas uma ferramenta valiosa para profissionais de todas as áreas.

== O que é Programação?

Programar é o ato de criar um conjunto de instruções que um computador pode executar para realizar uma tarefa específica. Essas instruções são escritas em uma linguagem de programação, que serve como intermediária entre o raciocínio humano e a linguagem binária que o computador compreende.

#figure(
  table(
    columns: (auto, 1fr),
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Conceito*], [*Descrição*],
    table.hline(stroke: 0.75pt),
    [Algoritmo], [Sequência finita de passos para resolver um problema],
    [Programa], [Implementação de um algoritmo em uma linguagem de programação],
    [Código-fonte], [Texto do programa escrito pelo programador],
    [Compilação], [Tradução do código-fonte para linguagem de máquina],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Conceitos fundamentais de programação],
  kind: table,
)

== Por que Python?

Python é uma linguagem de programação de alto nível, interpretada e de propósito geral. Criada por Guido van Rossum e lançada em 1991, Python tornou-se uma das linguagens mais populares do mundo, sendo amplamente utilizada em:

- Desenvolvimento web (Django, Flask);
- Ciência de dados e aprendizado de máquina (NumPy, Pandas, TensorFlow);
- Automação e scripts;
- Desenvolvimento de jogos;
- Aplicações científicas.

A escolha de Python para este livro se deve à sua sintaxe clara e legível, que permite ao estudante focar nos conceitos de programação sem se preocupar excessivamente com detalhes sintáticos complexos.

== Configurando o Ambiente

Para começar a programar em Python, você precisará instalar o interpretador Python e, opcionalmente, um ambiente de desenvolvimento integrado (IDE). Recomendamos o Visual Studio Code ou o PyCharm Community Edition.

=== Instalação do Python

Acesse o site oficial (python.org) e baixe a versão mais recente do Python 3. Durante a instalação no Windows, certifique-se de marcar a opção "Add Python to PATH".

=== Seu Primeiro Programa

Abra o terminal ou prompt de comando e digite `python` para iniciar o interpretador interativo. Em seguida, digite:

```python
print("Olá, mundo!")
```

Ao pressionar Enter, você verá a mensagem "Olá, mundo!" impressa na tela. Parabéns, você acabou de executar seu primeiro programa em Python!

= Variáveis e Tipos de Dados

Variáveis são um dos conceitos mais fundamentais em programação. Elas permitem armazenar valores na memória do computador e referenciá-los posteriormente através de um nome.

== Declaração de Variáveis

Em Python, variáveis são criadas no momento em que você atribui um valor a elas. Não é necessário declarar o tipo da variável explicitamente:

```python
nome = "Maria"        # string
idade = 25            # inteiro
altura = 1.65         # float
estudante = True      # booleano
```

== Tipos de Dados Básicos

Python possui diversos tipos de dados embutidos. Os mais comuns são:

#figure(
  table(
    columns: (auto, auto, auto),
    stroke: none,
    table.hline(stroke: 1.5pt),
    [*Tipo*], [*Descrição*], [*Exemplo*],
    table.hline(stroke: 0.75pt),
    [`int`], [Números inteiros], [`42`, `-7`, `0`],
    [`float`], [Números decimais], [`3.14`, `-0.5`],
    [`str`], [Texto (strings)], [`"Olá"`, `'Python'`],
    [`bool`], [Valores lógicos], [`True`, `False`],
    [`list`], [Listas ordenadas], [`[1, 2, 3]`],
    [`dict`], [Dicionários], [`{"a": 1, "b": 2}`],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Tipos de dados básicos em Python],
  kind: table,
)

== Operações com Variáveis

Python suporta as operações aritméticas básicas:

```python
a = 10
b = 3

soma = a + b          # 13
subtracao = a - b     # 7
multiplicacao = a * b # 30
divisao = a / b       # 3.333...
divisao_inteira = a // b  # 3
resto = a % b         # 1
potencia = a ** b     # 1000
```

= Estruturas de Controle

Estruturas de controle permitem alterar o fluxo de execução de um programa, possibilitando a criação de lógicas condicionais e repetições.

== Estrutura Condicional: if

A estrutura `if` permite executar um bloco de código apenas se uma condição for verdadeira:

```python
idade = 18

if idade >= 18:
    print("Você é maior de idade")
else:
    print("Você é menor de idade")
```

== Estruturas de Repetição

=== Laço for

O laço `for` é utilizado para iterar sobre uma sequência:

```python
frutas = ["maçã", "banana", "laranja"]

for fruta in frutas:
    print(f"Eu gosto de {fruta}")
```

=== Laço while

O laço `while` executa enquanto uma condição for verdadeira:

```python
contador = 0

while contador < 5:
    print(contador)
    contador += 1
```

// ============================================================================
// ELEMENTOS PÓS-TEXTUAIS
// ============================================================================

// Referências (manual para exemplo de livro)
#pagebreak()
#heading(level: 1, numbering: none, "REFERÊNCIAS")

#set par(hanging-indent: 1.25cm, first-line-indent: 0pt)

ABELSON, Harold; SUSSMAN, Gerald Jay. *Structure and Interpretation of Computer Programs*. 2nd ed. Cambridge: MIT Press, 1996.

CORMEN, Thomas H. et al. *Algoritmos*: teoria e prática. 3. ed. Rio de Janeiro: Elsevier, 2012.

DOWNEY, Allen B. *Think Python*: how to think like a computer scientist. 2nd ed. Sebastopol: O'Reilly, 2015.

LUTZ, Mark. *Learning Python*. 5th ed. Sebastopol: O'Reilly, 2013.

PYTHON SOFTWARE FOUNDATION. *Python 3.12 Documentation*. 2024. Disponível em: https://docs.python.org/3.12/. Acesso em: 15 jan. 2026.

RAMALHO, Luciano. *Python Fluente*. 2. ed. São Paulo: Novatec, 2023.

// Glossário
#book-glossary((
  "Algoritmo": "Sequência finita e ordenada de passos para resolver um problema ou realizar uma tarefa.",
  "Argumento": "Valor passado para uma função quando ela é chamada.",
  "Bug": "Erro em um programa que causa comportamento inesperado.",
  "Código-fonte": "Texto de um programa escrito em uma linguagem de programação.",
  "Compilador": "Programa que traduz código-fonte para linguagem de máquina.",
  "Debug": "Processo de identificar e corrigir erros em um programa.",
  "Função": "Bloco de código reutilizável que realiza uma tarefa específica.",
  "Indentação": "Espaçamento no início de uma linha para indicar estrutura do código.",
  "Interpretador": "Programa que executa código-fonte linha a linha.",
  "Loop": "Estrutura que repete um bloco de código múltiplas vezes.",
  "Parâmetro": "Variável listada na definição de uma função.",
  "String": "Sequência de caracteres (texto).",
  "Variável": "Nome que referencia um valor armazenado na memória.",
))

// Apêndice
#book-appendix(letter: "A", title: "INSTALAÇÃO DO PYTHON")[
  == Windows

  + Acesse python.org/downloads
  + Clique em "Download Python 3.12.x"
  + Execute o instalador
  + Marque a opção "Add Python to PATH"
  + Clique em "Install Now"

  == macOS

  + Abra o Terminal
  + Instale o Homebrew (se ainda não tiver): `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  + Execute: `brew install python`

  == Linux (Ubuntu/Debian)

  ```bash
  sudo apt update
  sudo apt install python3 python3-pip
  ```
]

#book-appendix(letter: "B", title: "TABELA ASCII")[
  A tabela ASCII (American Standard Code for Information Interchange) define a correspondência entre caracteres e valores numéricos.

  #figure(
    table(
      columns: (auto, auto, auto, auto, auto, auto),
      stroke: 0.5pt,
      inset: 4pt,

      [*Dec*], [*Char*], [*Dec*], [*Char*], [*Dec*], [*Char*],
      [65], [A], [78], [N], [97], [a],
      [66], [B], [79], [O], [98], [b],
      [67], [C], [80], [P], [99], [c],
      [68], [D], [81], [Q], [100], [d],
      [69], [E], [82], [R], [101], [e],
    ),
    caption: [Excerto da tabela ASCII],
    kind: table,
  )
]

// Índice remissivo
#book-index((
  ("algoritmo", "1, 15, 23"),
  ("argumento", "45, 48"),
  ("booleano", "18, 25"),
  ("compilação", "5"),
  ("dicionário", "67-75"),
  ("else", "28"),
  ("estrutura de controle", "27-38"),
  ("float", "17"),
  ("for", "31-34"),
  ("função", "43-55"),
  ("if", "27-30"),
  ("indentação", "8, 27"),
  ("int", "16"),
  ("interpretador", "6"),
  ("lista", "59-66"),
  ("loop", "31"),
  ("parâmetro", "46"),
  ("print", "7, 9"),
  ("Python", "3-5"),
  ("string", "17, 77-85"),
  ("variável", "15-22"),
  ("while", "35-38"),
))

// Colofão
#book-colophon[
  Este livro foi composto em tipos Times New Roman, corpo 12pt.

  Impresso em papel offset 90g/m² pela Gráfica Universitária.

  São Paulo, 2026.
]
