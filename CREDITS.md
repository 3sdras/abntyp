# Créditos e Agradecimentos

## abnTeX2

O **ABNTypst** (ABNTypst Biblioteca Normativa Typst) começou como uma adaptação do projeto **[abnTeX2](https://github.com/abntex/abntex2)** (ABsurdas Normas para TeX), o pacote LaTeX para formatação de documentos técnicos e científicos brasileiros em conformidade com as normas ABNT.

O abnTeX2 é mantido por **Lauro César Araujo** e a equipe abnTeX2, e está disponível sob a licença LPPL (LaTeX Project Public License).

Agradecemos especialmente:

- **Lauro César Araujo** ([@laurocesar](https://github.com/laurocesar)) - Mantenedor principal do abnTeX2
- **Equipe abnTeX2** - Pelo desenvolvimento contínuo e suporte à comunidade

### Elementos Adaptados do abnTeX2

Os seguintes aspectos do ABNTypst foram pegos do abnTeX2 e adaptados:

1. **Estrutura de documentação**
   - Organização em manuais e modelos canônicos
   - Exemplos completos para cada tipo de documento
   - Arquivos de referências compartilhados

2. **Modelos canônicos**
   - Trabalho acadêmico (tese, dissertação, TCC)
   - Artigo científico
   - Relatório técnico
   - Projeto de pesquisa
   - Livro

3. **Sistema numérico de citações**
   - Implementação inspirada no `abntex2-num.bst`
   - Opções de formato (parênteses e sobrescrito)
   - Documentação sobre uso e restrições

4. **Nomenclatura e convenções**
   - Nomes de funções e parâmetros em português
   - Comentários explicativos referenciando as normas ABNT
   - Avisos sobre limitações e casos especiais

---

## Projeto abnTeX Original

O abnTeX2 é uma evolução do projeto **abnTeX** original, desenvolvido entre 2001-2003 pelo grupo abnTeX no Código Livre. Agradecemos aos integrantes originais:

- Gerald Weber
- Miguel Frasson
- Leslie H. Watter
- Bruno Parente Lima
- Flávio de Vasconcellos Corrêa
- Otavio Real Salvador
- Renato Machnievscz

E todos os demais contribuidores que tornaram possível a produção de trabalhos acadêmicos conforme as normas ABNT com LaTeX.

## Uma breve introdução ao LaTeX 2ε

O documento `docs/introducao-abntypst.typ` é uma adaptação do trabalho **"Breve Introdução ao LaTeX 2ε"** do professor **Lenimar Nunes de Andrade**, do Departamento de Matemática da Universidade Federal da Paraíba.

O trabalho original, disponível em ftp://mat.ufpb.br/pub/textos/tex/, é um tutorial didático que há décadas auxilia estudantes brasileiros a aprenderem LaTeX. Nossa adaptação transpõe esse excelente material para o contexto do Typst e das normas ABNT, mantendo o estilo pedagógico e a estrutura do original.

Agradecemos ao professor Lenimar Nunes de Andrade pela contribuição inestimável à comunidade acadêmica brasileira e por disponibilizar seu trabalho livremente.

---

## Recursos Utilizados

### Claude Code

O **[Claude Code](https://claude.ai/claude-code)** é uma ferramenta de programação assistida por IA da Anthropic. Todas as versões iniciais do código do ABNTypst, incluindo os templates, funções, documentação e o documento `introducao-abntypst.typ`, foram desenvolvidas via Claude Code (modelo Claude Opus 4.5), bem como boa parte da revisão.

Agradecemos à equipe da Anthropic pelo desenvolvimento desta ferramenta que potencializa significativamente a produtividade.

### Typst

O **[Typst](https://typst.app)** é o sistema de tipografia sobre o qual o ABNTypst foi construído. Agradecemos à equipe Typst pelo excelente trabalho.

### CSL ABNT

O arquivo `abnt.csl` foi adaptado do projeto **[csl-abnt](https://github.com/virgilinojuca/csl-abnt)**, disponibilizado sob licença CC0 (domínio público).

Agradecemos a:

- **@virgilinojuca** - Criador original do estilo CSL ABNT
- **@AAguiarCAM** - Contribuições e melhorias

### Touying

O template de slides utiliza o pacote **[Touying](https://github.com/touying-typ/touying)** para Typst, que fornece funcionalidades avançadas para apresentações.

---

## Comunidade

Agradecemos à comunidade acadêmica brasileira que utiliza e contribui para ferramentas de formatação ABNT, especialmente:

- **Grupo abnTeX2** no Google Groups - Discussões e suporte
- **Comunidade Typst** - Feedback e sugestões
- **Usuários** que reportam bugs e sugerem melhorias

---

## Normas ABNT

Este projeto implementa normas publicadas pela **ABNT (Associação Brasileira de Normas Técnicas)**. As normas são propriedade da ABNT e este projeto apenas implementa suas especificações técnicas para formatação de documentos.

Para acesso às normas oficiais, consulte: https://www.abnt.org.br/

---

## Como Contribuir

Se você deseja contribuir com o projeto, consulte o arquivo [README.md](README.md) para instruções.

Todas as contribuições são bem-vindas e serão devidamente creditadas.

---

## Licença

O ABNTypst é distribuído sob a licença **MIT**, que permite uso, modificação e redistribuição livre, desde que mantidos os créditos apropriados.

```
MIT License

Copyright (c) 2024-2026 Esdras

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

_Última atualização: Janeiro de 2026_
