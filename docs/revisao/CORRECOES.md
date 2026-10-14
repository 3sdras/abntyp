# Correções da revisão do ABNTyp 0.6.0 → 0.7.0

Registro por etapa (plano em `CONSOLIDADO.md` §7 e `PROMPTS-ETAPAS.md`). Nada foi comitado nem tagueado; `typst.toml` não foi tocado.

## Etapa 0 — base visual (13/10/2026)

Arquivos alterados: `src/core/setup.typ`, `src/core/spacing.typ`, `src/core/fonts.typ` e, por consequência do R8b-06, `examples/formatacao-inline-exemplo.typ` (ignorado pelo `.gitignore`, linha 22; não aparece no `git status`). `src/core/page.typ` não precisou de mudança. Testes novos em `docs/revisao/testes-0/` (`passo.typ`, `topo.typ`, `sub.typ`). Revisão do usuário no mesmo dia, antes do commit: devolvi "Liberation Sans" à pilha Arial, tratei o espaço entre parágrafos como achado (NOVO-E0-01) e desfiz a mudança do `nature-block`.

### R1-03 · aviso "unknown font family: linux libertine"
- **Onde:** `setup.typ:55` e `:57` (pilhas de fontes).
- **Antes:** Times: `("Times New Roman", "Times", "Linux Libertine", "New Computer Modern")`; Arial: `("Arial", "Helvetica", "Liberation Sans", "Linux Biolinum", "Noto Sans")`.
- **Depois:** Times: `…, "Libertinus Serif", "New Computer Modern"`; Arial: `("Arial", "Helvetica", "Liberation Sans", "New Computer Modern")`.
- **Por quê:** o Typst avisa para **cada** família da pilha que não existe (testado: `font: ("Arial", "Inexistente")` gera aviso para a segunda, mesmo achando a primeira). As fontes embutidas são só Libertinus Serif, New Computer Modern e DejaVu Sans Mono (`typst fonts --ignore-system-fonts`, igual em 0.13.0, 0.14.1 e 0.15.1). "Linux Biolinum" não existe em nenhum ambiente do Typst e "Noto Sans" não está nesta máquina: os dois saíram. "Liberation Sans" (clone métrico da Arial, padrão em Linux) **ficou**: sem ele, em Linux o texto cairia em serifada sem aviso. O custo é um aviso `unknown font family: liberation sans` para quem usa `fonte: "Arial"` no Mac (decisão do usuário).
- **Verificado:** com Times, 0 avisos nos 3 binários; a matriz dos 13 arquivos (todos em Times): 0 avisos (antes: 7 por versão, todos este). Com `fonte: "Arial"` há 1 aviso (Liberation Sans), aceito.
- **Etapa 6:** o manual (`docs/manual-implementacao.typ:2215-2216`) ainda descreve as pilhas antigas.

### R1-18 · entrelinha calibrada pelo Word (DECISOES #2)
- **Onde:** `spacing.typ:10-18` (novo: `abnt-top-edge = 0.7em`, `abnt-bottom-edge = 0pt`, `abnt-leading(k) = k × 1,15em − (top − bottom)`), `:22`, `:24-25`, `:33`, `:35-36`, `:45-46`, `:52-53`, `:59-60` (helpers); `setup.typ:6` (import), `:67-68` (`top-edge`/`bottom-edge` no `set text`), `:73-74` (`leading` e `spacing`).
- **Antes:** `leading: 1.5em * 0.65` e `1em * 0.65` com bordas automáticas (cap-height da fonte). Medido em 12 pt: corpo 19,65 pt (Times) e 20,30 pt (Arial); "simples" 15,75 / 16,40 pt; duplo 23,55 / 24,20 pt.
- **Depois:** passo = k × 1,15 × corpo com bordas fixas. Medido com `pdftotext -bbox-layout`: corpo **20,70 pt** em Times e em Arial; "simples" **13,80 pt**; duplo **27,60 pt** (os helpers `single-spacing`, `one-half-spacing`, `double-spacing`, `abnt-spacing-setup` e `with-abnt-spacing` também fixam as bordas, para valer fora de `with-abnt-setup`).
- **Verificado:** `passo.typ` (Times e Arial); páginas do `tcc-exemplo` e do `artigo-exemplo` conferidas em imagem.
- **Efeito na saída:** contra a linha de base, o TCC de exemplo passou de 19 para 20 páginas (o sumário transborda uma linha, "REFERÊNCIAS" — ver pendências) e o livro de 26 para 25; os outros 11 arquivos mantêm o número de páginas (o periódico fica em 20, como antes).
- **Fica para as Etapas 2 e 4 (só mudam de valor quando esses arquivos forem trocados para `abnt-leading`):** `leading: 1em * 0.65` / `1.5em * 0.65` em `elements/title-page.typ:58,113`, `elements/abstract.typ:25`, `text/quotes.typ:100`, `templates/periodical.typ:245`, `templates/book.typ:378`, `templates/research-project.typ:210`, `templates/technical-report.typ:336,409` e `examples/citacao-numerica-exemplo.typ:40`. Com as bordas globais em 0,7em esses pontos ficaram ≈ 3 % mais folgados que antes (simples ≈ 13,5 pt, e não 13,8); aceitável só porque nada é publicado antes da Etapa 4, cujo teste de aceitação ganhou `grep "0.65" src/` sem resultado (`PROMPTS-ETAPAS.md`). O `nature-block` (`spacing.typ:~92`, código morto) também tem `1em * 0.65` e entra nesse grep: decidir na Etapa 2, junto com `title-page.typ`. `leading: 1em` em `references/numeric.typ:314,362` e `bibliography.typ:39` e `leading: 1.2em` em pôster/slides não foram tocados.

### R1-19 · título primário no topo da mancha
- **Onde:** `setup.typ:97-99`.
- **Antes:** `v(1.5em)` antes do título; primeira linha a 110,06 pt do topo da página (margem 85,04 pt) → 25 pt de vão.
- **Depois:** `context v(1.5em + par.spacing, weak: true)`; primeira linha em **85,31 pt** (um parágrafo comum no topo da mancha: 85,12 pt; a diferença é a altura da caixa da fonte em negrito). Sem número fixo: acompanha `par.spacing`.
- **Armadilhas achadas:** (1) o `v(1.5em, weak: true)` simples some no topo mas absorve o espaço entre parágrafos e deixava o vão da seção primária (33,79 pt) **menor** que o da secundária (42,30 pt); por isso soma-se `par.spacing`. (2) Dentro do título, `1em` vale 16,8 pt (o Typst aplica 1,4× ao nível 1), logo o `1.5em` original eram 25,2 pt. (3) Primeira tentativa, `1.5em + 14.4pt`, só valia com o espaço de parágrafo padrão (1,2em × 12 pt): descartada.
- **Vãos medidos (linha anterior → título, `level-1-pagebreak: false`):** primária 47,74 → 51,01 pt; secundária 43,95 → 42,30 pt (esta muda por causa do NOVO-E0-01).
- **Verificado:** `topo.typ` com `pb=sim` e `pb=nao`; imagens do `tcc-exemplo` p. 10 e do `artigo-exemplo` p. 2.

### NOVO-E0-01 · espaço entre parágrafos maior que a entrelinha (achado novo, não estava na revisão)
- **Onde:** `setup.typ:74` (`spacing: abnt-leading(1.5)`); `spacing.typ:25,36,46,53,60` (helpers: `spacing` junto com `leading`).
- **Antes:** o pacote não definia `par.spacing`; valia o padrão do Typst (1,2em = 14,4 pt). Passo medido: 20,7 pt dentro do parágrafo e **22,8 pt** entre parágrafos (167,9 → 190,7), o que desfaz a equivalência com o Word, cujos modelos ABNT usam zero entre parágrafos.
- **Depois:** `spacing` = `leading` = `abnt-leading(k)`. Medido em `passo.typ` (Times e Arial): todos os passos, dentro e entre parágrafos, são 20,70 (1,5), 13,80 (simples) e 27,60 pt (duplo).
- **Efeito na saída:** o texto fica mais compacto; também muda o vão dos títulos secundários e seguintes (que somam `v(1.5em)` ao espaço de parágrafo).

### R8b-06 · `sub` sobrescrevia o subscrito nativo
- **Onde:** `fonts.typ:67-69`; `examples/formatacao-inline-exemplo.typ:1,5,7,9,33`.
- **Antes:** `#let sub(body) = underline(body)`; `H#sub[2]O` saía com o "2" sublinhado (imagem conferida).
- **Depois:** `#let sublinhado(body) = underline(body)`; `H#sub[2]O` sai subscrito (`sub.typ`, imagem conferida). **QUEBRA DE API — item destacado da nota da 0.7.0:** quem usava `#sub[…]` do pacote (como sublinhado) precisa trocar por `#sublinhado[…]`; sem a troca o texto sai subscrito, sem erro.
- **Não corrigido (Etapa 6):** `docs/introducao-abntyp.typ:327,344` e `docs/manual-implementacao.typ:2210` ainda dizem `#sub`; o texto "não existem no Typst puro" precisa ser refeito.

### R1-17 · tamanhos 14 pt (título) e 10 pt (natureza) — não corrigido
- **Nada alterado.** Na primeira passada mudei o `nature-block` para 12 pt; desfiz a pedido: é código morto (importado em `title-page.typ:4`, nunca chamado) e não é a correção do R1-17. A natureza que sai na folha de rosto está em `elements/title-page.typ:56-62` (10 pt) e o título 14 pt em `core/metadata.typ:137-138`; os dois são da Etapa 2. O relatório não traz correção pronta para R1-17.

## Verificação da etapa
- Os 12 `.typ` de `examples/` (o prompt fala em 11) e o `testeCit.typ` compilam em **0.14.1, 0.13.0 e 0.15.1**, sem erro e **sem nenhum aviso** (antes: 7 avisos por versão; todos usam Times).
- Mesmo número de páginas nas três versões em todos os arquivos. Contra a linha de base: `tcc-exemplo` 19 → 20 e `livro-exemplo` 26 → 25; os demais iguais.
- Aceitação da etapa: passo do corpo 20,70 pt (Times e Arial), "simples" 13,80 pt em 12 pt (também entre parágrafos), nenhum aviso de fonte com Times. **Passou.**
- Scripts de apoio (scratchpad, fora do pacote): `matrix.sh` (compila tudo nos 3 binários com `TYPST_PACKAGE_CACHE_PATH` próprio) e `medir.py` (passos de linha).

## Pendências e observações
- **Sumário do TCC:** com o passo de 20,7 pt o sumário do `tcc-exemplo` deixa "REFERÊNCIAS" sozinha numa página (p. 9). Regra de espaçamento do sumário é da Etapa 2 (`elements/toc.typ`).
- **Código morto notado, não removido:** `abnt-line-spacing` (`spacing.typ:4-8`, sem uso), `section-spacing`, `nature-block` (importado e não usado em `title-page.typ`).
- **Aviso Arial:** quem usa `fonte: "Arial"` recebe 1 aviso (`liberation sans`) fora do Linux. Aceito; a alternativa é remover a família da pilha.

## Itens a levar adiante (anotados em 13/10/2026)

**Para a nota da 0.7.0 (Etapa 7) e para o manual (Etapa 6)**
- **Aviso da Arial no Mac:** `fonte: "Arial"` gera 1 aviso `unknown font family: liberation sans` fora do Linux. Aceito de propósito (sem "Liberation Sans" o texto cairia em serifada em Linux, sem aviso). O usuário vê o aviso, então precisa estar na nota da versão e no manual.
- **Vão antes do título de nível 1:** 51,01 pt, maior que o do nível 2 (42,30 pt), por causa de `context v(1.5em + par.spacing, weak: true)`. Muda a aparência dos títulos; entra na nota da versão e na descrição de títulos do manual. O título abre a página no topo da mancha (85,31 pt).
- Também no manual: as pilhas de fonte novas (linhas ~2215-2216) e `#sub` → `#sublinhado` (manual:2210, introdução:327 e 344).

**Sobras de `0.65` em `src/` (10 ocorrências; teste de aceitação: `grep -rn "0.65" src/` vazio no fim da Etapa 4)**
- **Etapa 2 (4):** `elements/title-page.typ:58` e `:113`, `elements/abstract.typ:25`, `text/quotes.typ:100`.
- **Etapa 4 (6):** `templates/book.typ:378`, `technical-report.typ:336` e `:409`, `periodical.typ:245`, `research-project.typ:210`, `core/spacing.typ:91` (`nature-block`, código morto: migrar ou remover).
- Enquanto não migram, esses trechos ficam cerca de 3% mais folgados que antes da Etapa 0.

---

## Etapa 1 — o que quebra a compilação ou perde conteúdo (14/10/2026)

Arquivos alterados: `src/templates/thesis.typ`, `book.typ`, `poster.typ`, `research-project.typ`; `src/elements/spine.typ`, `index.typ`; `src/core/sorting.typ`, `setup.typ`; `src/text/headings.typ`. Testes novos em `docs/revisao/testes-1/` (cópias dos testes das Partes 4a, 4b, 7b, 7c e 8a com o caminho `/lib.typ`, mais testes próprios; compilar com `typst compile --root <pacote> docs/revisao/testes-1/<arquivo>.typ`). Sem agentes. Nada comitado; `typst.toml` e os PDFs de `examples/` não foram tocados. `src/references/numeric.typ` já aparecia modificado no `git status` antes da etapa (96 linhas, não é desta sessão) e não foi tocado.

### R1-01 · R4b-01 · epígrafe com colchetes
- **Onde:** `thesis.typ:133` e `book.typ:481`.
- **Antes:** `[(#autor)]` em bloco de conteúdo → texto `[(Autor Z)]`. **Depois:** `(#autor)` → `(Autor Z)`.
- **Verificado:** `testes-1/epigrafe.typ`, texto do PDF e imagem (as duas funções).
- **Não feito:** a 6029 4.2.1.6 pede a referência em nota de rodapé; os parênteses foram mantidos (decisão pendente do relatório: "decidir se mantém os parênteses").

### R4b-13 · lombada horizontal e `lombada-preview` imprimiam o código
- **Onde:** `spine.typ:126-161` (horizontal) e `:203-248` (preview): 19 linhas sem `#` (`if`, `v()`, `rotate`, `line`, `text`, bloco `{ … }`).
- **Antes:** o PDF trazia `if autor != none { text(…) v(0.5em) }` como texto. **Depois:** autor, título, volume/ano/instituição saem renderizados; o preview sai com o texto rotacionado e a régua "30mm".
- **Verificado:** `sp.typ`, `sp2.typ` (os testes originais) e `sp3.typ` (horizontal numa página de 5 cm de altura, onde os 30 mm reservados cabem), por imagem. No `sp2` (página de 3 cm) as linhas se sobrepõem porque os 30 mm reservados não cabem em 3 cm: é a geometria do teste, não o defeito.
- **Não corrigido (fora da etapa):** R4b-14 (sentido de rotação, `margem-capa` com `•`, segunda página em branco do `pagebreak()` final: `sp2` e `sp3` ainda têm 2 páginas).

### R4a-14 · `recursos()` com valores
- **Onde:** `research-project.typ:347`: `if total != none {…} else {…}` → `..if total != none {…} else {…}` (espalha o par de células).
- **Verificado:** `rec.typ` (3 chamadas): tabela com e sem `total:` (Total 2800.5) e lista simples; imagem conferida.
- **Observação (não mexi):** os valores saem com ponto decimal (`2500.5`), sem vírgula nem "R$" formatado.

### R8a-06 · pôster com `autores: ()`
- **Onde:** `poster.typ:57` e `:311` (`poster()` e `academic-poster()`; `poster-a0` e `poster-a1` delegam).
- **Antes:** `error: expected string or array, found none`. **Depois:** `if autores.len() > 0 { … } else { () }` (mesma forma do `artigo`).
- **Verificado:** `pos-autores.typ` compila as 4 funções (A0 e A1 com o tamanho certo no PDF).

### R7c-18 · seção maior que uma coluna perdia texto
- **Onde:** `poster.typ:~207` (`poster-section`) e `:~235` (`poster-highlight`): `box(` → `block(`.
- **Antes (`p05.typ`):** 745 palavras no PDF (de ~2.565) e última linha em y = 3404 pt numa página de 3401,6 pt. **Depois:** 2.565 palavras, última linha em y = 3317 pt; a seção corre pelas 3 colunas e passa à 2ª página; imagem conferida.
- **EFEITO NA SAÍDA:** como as seções agora podem partir entre colunas, o `poster-exemplo` muda de aparência (continua em 1 página e com as 491 palavras): "Resultados" parte entre as colunas 1 e 2, "Referências" idem, e a 3ª coluna fica quase vazia (preenchimento em sequência, que é o R7c-19, não corrigido). Comparei antes e depois por imagem. Alternativa se preferir manter o exemplo como estava: quebrável só quando a seção for maior que a coluna (exige `layout` + `measure`; não fiz).
- **Não alterado:** a caixa do resumo (`poster.typ:178`, `:426`), que é um `box` fora das colunas.

### R8a-07 · `sort-key` com item que é só um artigo
- **Onde:** `sorting.typ:~103`: `if words.len() == 1 { return text }` antes de remover o artigo.
- **Antes:** `error: type none has no method 'trim'` para `"A"`, `"O"`, `"Os"`, `"The"`, `"Un"` (e `sort-mixed`, `sort-alphabetically`, `alphabetical-list/index`). **Depois:** ordena sem erro.
- **Verificado:** `sort-artigo.typ` (antes: erro, confirmado com o arquivo original restaurado; depois: `"a" "o" "os" "the" "un" ""`, listas e índice renderizados).

### R4b-16 · remissivas de termos sem entrada
- **Onde:** `index.typ:141-147` (novo laço antes de "Ordenar termos"): cada `from` de `entradas-ver`/`entradas-ver-tambem` que não está em `grouped` entra como termo sem páginas.
- **Antes:** `index-see("Aviação", "Aeronáutica")` e `index-see-also("Férias", "Licença")` não saíam. **Depois:** saem (`Aviação ver Aeronáutica`; `Férias` / `ver também Licença`).
- **Verificado:** `ix.typ` (o original), texto do PDF.
- **Não corrigido:** R4b-17 (ordem e agrupamento por ponto de código: `Á` e `Ô` em seções próprias; Etapa 3).

### R4b-19 · tabela maior que a página
- **Onde:** `setup.typ:~185` (em `with-abnt-setup`): `show figure.where(kind: table): set block(breakable: true)`.
- **Por que no setup e não em `container`:** testado; um `show`/`set` dentro da função faz o retorno virar "styled" e **`@rótulo` e `<rótulo>` quebram** (`error: cannot reference styled`).
- **Antes (`tb2.typ`):** 1 página, ~11 linhas legíveis e o resto amontoado. **Depois (`tb2-setup.typ`, com o setup):** 21 páginas, cabeçalho `A B` repetido em cada uma, todas as linhas (0 a 399), "Fonte: Autor." só na última, `@longa` resolvido; imagem conferida.
- **NÃO CORRIGIDO:** (1) o `tb2.typ` original, **sem** `with-abnt-setup`, continua em 1 página com as linhas amontoadas: o teste de aceitação só passa com o setup (que todos os templates aplicam); (2) "continua / continuação / conclusão" por página (IBGE 8.3) e o traço do rodapé só na última página não foram feitos; (3) `quadro` (kind `"quadro"`) não foi incluído.

### R8a-05 · `@rótulo` para `apendice`, `anexo`, `titulo-sem-num` (concluído na Etapa 1b, 14/10)
- **Onde:** `setup.typ` (nova regra `show ref` antes de "Parte", ~linhas 168-178), `headings.typ:143-166` (`show heading: set heading(supplement: …)` + `heading(…)` → `heading(…, supplement: …)`; `titulo-sem-num` usa `supplement: [Seção #titulo]`) e as três docstrings.
- **Antes:** `error: cannot reference styled` (o rótulo prendia no elemento estilizado). **Primeira tentativa (Etapa 1):** só trocar para `supplement:` direto levava a `cannot reference heading without numbering`, e concluí, errado, que não havia solução cirúrgica (nem `ref(supplement:)` nem heading numerado com numeração vazia servem). **Correção do usuário:** o erro vem da realização padrão da referência, e uma regra `show ref` a substitui: para heading com `numbering: none`, vira `link(el.location(), texto)`, com `texto` = o suplemento da referência (`@ap[…]`), senão o suplemento do heading, senão o título.
- **Depois (`rotulo-ref.typ`):** "Veja o Apêndice A, o Anexo B e a Seção Referências, além do Capítulo 1"; os 4 links são clicáveis (4 anotações `/Link`); o capítulo seguinte continua "2" (o contador não é tocado); iguais em 0.13.0, 0.14.1 e 0.15.1.
- **Limite:** vale com `with-abnt-setup` (todos os templates e `normas-abnt`); sem ele `@` continua dando erro. `titulo-sem-num` produz "Seção Título" (não "Seção X": não há número).

### R7b-02 · seções dentro de apêndice e anexo
- **Onde:** `book.typ:~627` (`book-appendix`) e `:~637` (`book-annex`): `set heading(numbering: none)` antes de `body`.
- **Antes:** `== Sec ap` saía `1.1 SEC AP` (e `3.3 WINDOWS` no exemplo). **Depois:** sai sem número (`SEC AP`); o capítulo seguinte não é afetado.
- **Verificado:** `eq.typ` (imagem das páginas do apêndice). **Escolha minha:** sem numeração; a alternativa `A.1` (numeração própria) não foi implementada.
- **Efeito na saída:** o `livro-exemplo` (apêndice A com `== Windows/macOS/Linux`) agora sai sem os números "3.3/3.4/3.5". Mesmo número de páginas (25).

### R7b-03 · `book-start-numbering()`
- **Onde:** `book.typ:~688`: o corpo (`counter(page).update(1)` e um `set page` sem efeito) foi removido; a função ficou vazia, por compatibilidade (a introdução, linha 575, diz que ela "continua existindo").
- **Antes (`num1.typ`):** primeiro capítulo impresso 1 (sumário: `Cap um … 1`). **Depois:** 5 e 6, igual a omitir a chamada (`paginacao: "auto"`).

### Verificação da etapa
- Os 12 `.typ` de `examples/` (o prompt fala em 11) e o `testeCit.typ` compilam em **0.14.1, 0.13.0 e 0.15.1** sem erro e **sem nenhum aviso**; mesmas páginas da linha de base de antes da etapa em todos (39 de 39 combinações idênticas: `tcc` 20, `livro` 25, `periodico` 20, `projeto` 21, `relatorio` 19, `artigo` 6, `poster` 1…).
- Os 14 testes de `testes-1/` compilam sem erro e sem aviso nos 3 binários, com as mesmas páginas.
- Aceitação: `rec`, `sp`/`sp2`, `ix`, `t11e`/`pos-autores` (R8a-06), `sort-artigo` (R8a-07), `p05` passam. `tb2` só passa com o setup (ver R4b-19).
- Scripts de apoio no scratchpad (fora do pacote): `matrix.sh` e `t.sh`.

## Etapa 1b — funções avulsas (R1-02), 14/10/2026 (autorizada pelo usuário depois da Etapa 1)

### R1-02 · funções `abnt-*-setup` e de numeração sem efeito
- **Onde:** `core/page.typ` (`abnt-page-setup`, `start-arabic-numbering`, `abnt-page-numbering`, `pretextual-numbering`, `no-page-numbering`), `core/fonts.typ` (`abnt-font-setup`, `abnt-footnote-setup`), `core/spacing.typ` (`abnt-spacing-setup`), `text/figures.typ` (`abnt-figure-setup`), `text/tables.typ` (`abnt-table-setup`), `text/headings.typ` (`abnt-heading-setup`).
- **Antes:** só continham `set`/`show` no próprio corpo, sem devolver nada: `#abnt-page-setup(margem-esquerda: 8cm)` não mudava nada. **Depois:** recebem `body` (último argumento posicional) e o devolvem depois dos `set`/`show`; uso: `#show: abnt-page-setup.with(margem-esquerda: 8cm)`. Chamada antiga `#f()` agora dá `missing argument: body` (erro alto, em vez de não fazer nada).
- **`abnt-heading-setup`:** a versão antiga só imprimia `it.body` (sem o indicativo numérico) e foi **substituída** (65 linhas removidas) por `#let abnt-heading-setup(body) = with-abnt-headings(body)`.
- **Medido (`avulsas-page.typ`, `avulsas-fmt.typ`):** margem esquerda 226,77 pt (8 cm), fonte ArialMT no PDF, número de página no topo à direita, entrelinha 20,70 pt, títulos com `1` e `1.1`, tabela e figura centralizadas, nota de rodapé com filete; imagem conferida; 0 avisos nos 3 binários.
- **Não alterado:** `pretextual()`, `textual()`, `postextual()` (`thesis.typ:84-101`): os exemplos chamam `#textual()` e `#postextual()` sem `body`, e tornar o `set page(numbering…)` efetivo poderia duplicar o número do rodapé automático. Continuam como estão (obsoletas; só o `counter.update` de `pretextual()` vale); decidir na Etapa 2 se saem.
- **Etapa 6:** `docs/manual-implementacao.typ:296-395` mostra as assinaturas sem `body`.
- **QUEBRA DE API — item destacado da nota da 0.7.0:** quem copiou `#abnt-page-setup()` (e `abnt-font-setup`, `abnt-spacing-setup`, `abnt-heading-setup`, `abnt-footnote-setup`, `abnt-figure-setup`, `abnt-table-setup`, `abnt-page-numbering`, `pretextual-numbering`, `start-arabic-numbering`, `no-page-numbering`) da documentação antiga tinha uma chamada que não fazia nada; na 0.7.0 ela vira **erro de compilação** (`missing argument: body`). É mais seguro do que ignorar em silêncio, mas é mudança de comportamento. A chamada correta é `#show: abnt-page-setup.with(...)` (sem parâmetros: `#show: abnt-page-numbering`).

### Fora da lista das Etapas 1 e 1b (não mexi)
- **R2b-01** (`citacao-num-config`, `numeric.typ:81`): fica na Etapa 3 (decisão do usuário, 14/10; `PROMPTS-ETAPAS.md` atualizado).
- **R2-07** (`ref-livro`…) e **R3-01** (`remove-accents`): Etapa 3.
- Backlog (depois da Etapa 5): legendas "continua / continuação / conclusão" da tabela longa; subdivisões de apêndice/anexo como "A.1".
- Código morto notado, não removido: `spine-text-descending` devolve texto horizontal (R4b-14).

### Verificação da Etapa 1b
- Matriz repetida depois da 1b: os 12 exemplos e o `testeCit.typ` em 0.14.1, 0.13.0 e 0.15.1, 39 de 39 sem erro, sem aviso e com as mesmas páginas da linha de base. `rotulo-ref`, `avulsas-page`, `avulsas-fmt`, `tb2-setup`, `eq` e `num1` também iguais nas três versões.

## Etapa 2 — estrutura do TCC (14/10/2026)

Arquivos alterados: `src/core/setup.typ`, `page.typ`, `metadata.typ`; `src/elements/title-page.typ`, `cover.typ`, `abstract.typ`, `toc.typ`; `src/templates/thesis.typ`; `src/text/figures.typ`, `quotes.typ`. Fora da lista da etapa, mas exigidos pelos achados: `setup.typ` (R1-04, R1-06, R1-13, R1-14) e `page.typ` (R1-10, R1-11), como já aconteceu na Etapa 1. `headings.typ` e `lists.typ` **não** foram tocados. Sem agentes. Testes novos em `docs/revisao/testes-2/` (`tcc-completo.typ` com `--input fv=1` para frente-verso, `aprovacao-volume.typ`, `sumarios.typ`). Nada comitado; `typst.toml` e os PDFs de `examples/` não foram tocados (os exemplos foram compilados para o scratchpad).

### R1-04 · títulos sem indicativo numérico centralizados
- **Onde:** `setup.typ:116-117`. **Antes:** `REFERÊNCIAS`, `APÊNDICE A – …`, `ANEXO A – …`, `GLOSSÁRIO` encostados na margem esquerda. **Depois:** `align(center, …)` quando `it.numbering == none` (nível 1). Vale para todos os templates que usam `with-abnt-setup`.
- **Verificado:** `tcc-completo.typ` (imagem), `artigo`, `relatorio`, `citacao-autordata` (REFERÊNCIAS centralizada).
- **Não alterado:** `with-abnt-headings`/`abnt-heading-setup` (`headings.typ:6-80`, cópia antiga das regras, fora dos templates) continua com os títulos à esquerda e sem recuo deslocado.

### R1-13 · título de mais de uma linha sob a primeira letra
- **Onde:** `setup.typ:8-21` (novo `_abnt-titulo`) e os 5 níveis (`:116, 124, 131, 138, 145`). **Antes:** indicativo + `h(0.5em)` + corpo corridos; 2ª linha voltava à margem. **Depois:** `par(hanging-indent: largura do indicativo + 0,5 em)`, largura medida por `measure`.
- **Armadilha:** a primeira tentativa com `grid(columns: (auto, 1fr))` mudou o vão entre título e texto (45,7 → 39,8 pt), porque o grid é bloco e não parágrafo. Com `par(hanging-indent:)` as posições y são **idênticas** à linha de base (medido com `pdftotext -bbox-layout`: 85,31 / 131,02 / 256,12 / 319,12 pt) e a 2ª linha começa em x = 106,0 (a primeira letra do título).

### R1-06 · legenda com travessão, listas com travessão
- **Onde:** `setup.typ:179` (`set figure.caption(position: top, separator: [ – ])`); `toc.typ:58-61` (`_abnt-lista-rules`: `it.indented([#it.prefix() –], it.inner())`) aplicado em `lista-ilustracoes`, `lista-tabelas`, `lista-quadros`. **Antes:** `Figura 1: Título`; nas listas `Figura 1 Título ….. 4`. **Depois:** `Figura 1 – Título` nos dois. O mesmo efeito vale para artigo, periódico, livro, relatório e projeto (legendas).
- **Verificado:** imagem (tcc-completo, livro e artigo no diff de texto); funciona em 0.13.0, 0.14.1 e 0.15.1.

### R1-14 · notas de rodapé com a 2ª linha sob a primeira letra
- **Onde:** `setup.typ:197-205` (`show footnote.entry`: grid de duas colunas, número sobrescrito com `link` à chamada, `column-gutter: 0.05em`). **Antes:** número recuado 1 em e 2ª linha na margem. **Depois:** número na margem (x = 85,04), texto começa em 88,9 e a 2ª linha também. As posições y e o tamanho de fonte são os mesmos da linha de base.
- **Perda:** o número da nota no rodapé continua clicável (leva à chamada), mas não tem mais o "backlink" interno que o Typst põe na realização padrão.

### R1-15 · "Fonte:" e "Nota:" alinhadas à esquerda
- **Onde:** `figures.typ:76, 81` (`container`) e `:173, 180` (`fonte`, `nota-figura`): `align(center)` → `align(left)`. Dentro do `container` o `figure` abraça a largura da ilustração, então "Fonte:" fica na margem esquerda **da ilustração** (imagem conferida com figura estreita), como pede a 14724 5.8. Fora do `container`, `fonte()` e `nota-figura()` usam a margem do texto (como `nota-tabela`).

### R1-07 · palavras-chave
- **Onde:** `abstract.typ:~38` (`join("; ")`). **Antes:** `Palavras-chave: alfa. beta.` **Depois:** `Palavras-chave: gestação; cuidado pré-natal; Aedes aegypti; Brasil.` (e `Keywords: …; ….`). Iniciais minúsculas são do autor: o exemplo (`tcc-exemplo.typ:90-91`, "Palavra-chave 1") fica para a Etapa 6.
- **Não alterado (outras etapas):** o resumo do artigo, do relatório, do periódico e do projeto têm código próprio e ainda separam por ponto (Etapa 4).

### R1-08 · lista de siglas em ordem alfabética
- **Onde:** `toc.typ:192` (`itens.pairs().sorted(key: p => lower(p.at(0)))`). **Antes:** `ZZZ` antes de `AAA`. **Depois:** `AAA`, `MMM`, `ZZZ`. **Limite:** sigla acentuada (`Á`) ainda cai depois do Z (limite do Typst, `DECISOES.md`; a Etapa 3 pode trocar a chave por `sort-key`). A lista de símbolos continua na ordem do texto (4.2.1.12).

### R1-10 · ficha catalográfica fora da contagem
- **Onde:** `page.typ:150-153` (`marcar-ficha`: label `<abnt-ficha>` e `counter(page).update(n => n - 1)`), `title-page.typ:113` (chamada), `page.typ:113-114` (o número não aparece na ficha com `paginacao: "todas"`). **Antes:** folha de rosto = 1, ficha = 2, Introdução = 12 no `tcc-completo`. **Depois:** Introdução = 11; com `paginacao: "todas"` a ficha não leva número e a errata/folha seguinte vem como 2 (imagem conferida).
- **Consequência (para decidir):** em frente-verso a Introdução, que cai numa página ímpar do PDF (anverso), sai com número **par** (20 na p. 23 do PDF), porque a norma manda não contar o verso da folha de rosto e a posição do número segue a página física. Não mudei isso: seguir a 14724 5.3 ao pé da letra produz essa inversão.

### R1-11 · frente-verso: pré-textuais no anverso e ficha no verso
- **Onde:** `page.typ:139-146` (estado `abnt-frente-verso` e `abre-anverso()`: `pagebreak(weak: true, to: "odd")` só se frente-verso), `thesis.typ:73` (`normas-abnt` grava o estado) e `abre-anverso()` no início de `folha-rosto`, `folha-aprovacao`, `dedicatoria`, `agradecimentos`, `epigrafe`, `abstract-page` (resumo e abstract), `sumario`, `abnt-outline`, `lista-ilustracoes`, `lista-tabelas`, `lista-quadros`, `lista-siglas`, `lista-simbolos`. **Antes:** capa p. 1, folha de rosto p. 2 (verso), ficha p. 3 (anverso), dedicatória p. 4. **Depois (`tcc-completo --input fv=1`):** capa p. 1, verso em branco, folha de rosto p. 3, ficha p. 4 (verso), dedicatória p. 5, … todos os elementos em página ímpar; 24 → 34 páginas (as páginas a mais são versos em branco). Sem frente-verso nada muda.
- **Não alterado:** o `livro` tem o seu próprio estado (`book.typ:12`); `pretextual()`/`textual()`/`postextual()` (obsoletas).

### R1-12 · sumário: indicativos à esquerda, títulos em coluna
- **Onde:** `toc.typ:11-56` (`_abnt-outline-rules`: `grid` com coluna do indicativo = largura do indicativo mais extenso, medida em negrito; títulos sem indicativo, como REFERÊNCIAS, começam na coluna dos títulos, como na 6027 5.2). **Antes:** `h(1em)`, `h(2em)`… por nível. **Depois:** `1`, `1.1`, `1.3.1` na margem, títulos alinhados. O estilo por nível (MAIÚSCULAS+negrito, MAIÚSCULAS, negrito, regular, itálico) foi mantido. `sumario(profundidade:)` mede só até a profundidade pedida. Cada entrada passou a ter 1 link (antes ~5 fragmentos por linha: 164 → 31 anotações na página do sumário). Entradas de `parte()` mantêm o formato "Parte 1: Título".
- **Vale para todos os templates** que usam `sumario`/`abnt-outline` (relatório, projeto, periódico); conferidos em imagem (relatório).

### Sumário do `tcc-exemplo` sem "REFERÊNCIAS" sozinha
- **Onde:** `toc.typ:~16` (`set par(leading: abnt-leading(1), spacing: abnt-leading(1))` dentro de `_abnt-outline-rules`). **Antes:** com as entradas em 1,5 o sumário passava uma linha para a p. 9. **Depois:** entradas em espaço simples (a 6027 não pede 1,5); o sumário cabe em 1 página (última entrada a 567 pt). Efeito: `tcc-exemplo` 20 → 19 páginas e `projeto-exemplo` 21 → 20, iguais nos três binários.

### R1-17 · título e natureza em 12 pt
- **Onde:** `metadata.typ` (`_render-titulo`: 14 pt → 12 pt, só `capa` e `folha-rosto` o usam); `title-page.typ:~62` (removido `set text(size: 10pt)` da natureza). **Depois:** título, subtítulo e natureza em 12 pt, natureza em espaço simples. Ficha continua em 10 pt (dados catalográficos são exceção enumerada).
- **Não alterado:** `nature-block` (`spacing.typ:~91`, código morto com `0.65`, Etapa 4).

### `0.65` migrados (teste de aceitação da etapa)
- `title-page.typ` (natureza e ficha), `abstract.typ` (resumo: `abnt-leading(1.5)`, R1-25 — o comentário passou a dizer 1,5), `quotes.typ` (citação longa: `abnt-leading(1)` em `leading` e `spacing`; medido 11,50 pt em 10 pt, recuo 4 cm, igual ao Word). `grep -n "0.65"` nos três arquivos: vazio.

### R1-05 · "Seção" em vez de "Capítulo"
- **Onde:** `thesis.typ:~57` (removido `suplemento-nivel1: "Capítulo"`; vale o padrão "Seção"), docstrings de `thesis.typ` e `setup.typ:43`. **Antes:** `@sec` → "Capítulo 1". **Depois:** "Seção 1" (com `S` maiúsculo, como as seções de nível 2+; o relatório sugeria minúsculo, mas o pacote usa "Seção" em todos os níveis).
- **Não feito:** renomear `quebra-capitulo` (cosmético; exigiria apelido e mais um parâmetro) e o texto do exemplo ("cinco capítulos", `tcc-exemplo.typ:388`): Etapa 6.

### R1-16 · volume, folha de aprovação, errata
- **Volume:** novo parâmetro `volume` em `capa()` e `folha-rosto()` e chave `volume` em `dados()`; sai `v. N` depois do título (capa e folha de rosto). `cover.typ:21,68`, `title-page.typ:19,54`, `metadata.typ:47,65,86`.
- **Folha de aprovação:** nova `folha-aprovacao(…, data:, banca:)` (`title-page.typ:141`): autor, título, natureza (12 pt, caixa de 8 cm), instituição, área, "Aprovada em" (data dada ou linha em branco para preencher) e "BANCA EXAMINADORA" com uma linha de assinatura por membro (`(nome:, titulacao:, instituicao:)` ou texto). Os dados vêm de `dados()`.
- **Errata:** não criei função. `errata(referencia:, itens:)` já existe em `technical-report.typ:347` e `lib.typ` a exporta; ela funciona num TCC (testada em `aprovacao-volume.typ`). Falta só documentá-la para o TCC (Etapa 6). Uma segunda `errata` em `thesis.typ` sobrescreveria a do relatório em silêncio.

### R1-20 · lista por tipo de ilustração
- **Onde:** `toc.typ:118-139`: `lista-ilustracoes(tipo: image, titulo: "LISTA DE ILUSTRAÇÕES")`. `tipo` aceita o `tipo` de um `container` ou uma lista deles (`"imagem"`, `"tabela"` e qualquer kind). **Antes:** `container(tipo: "grafico")` nunca entrava em lista. **Depois:** `#lista-ilustracoes(tipo: "grafico", titulo: "LISTA DE GRÁFICOS")` lista "Gráfico 1 – …" (imagem conferida). O padrão não mudou.
- **Não corrigido:** `container(tipo: "grafico")` sem `suplemento:` ainda rotula "Figura" (`figures.typ:62-66`).

### R1-22 · ordem tradução/grifo
- **Onde:** `quotes.typ:55-56` e `:119-120` (caminho sem `.bib`): `tradução …, grifo …` (a ordem do exemplo da 10520 5.2); comentário "5.1" → "7.1.5". **Não corrigido:** o caminho com `.bib` (`_abnt-cite-supplement`, `citation.typ:36-62`) é da Etapa 3 e ainda imprime `grifo …, tradução …`; até lá os dois caminhos divergem.

### Não corrigido nesta etapa
- **R1-09** (glossário sem acento/caixa): `headings.typ:124`, é da Etapa 3 (a própria Parte 1 manda resolver na Parte 3).
- **R1-21** (extensão do resumo): o Typst não emite aviso sem abortar a compilação (só `panic`), então não há como avisar sem quebrar; só a docstring cita 150–500 palavras.
- **R1-23 a R1-28** (P3): não eram da etapa. `lists.typ` não foi tocado.
- **R1-02** (`pretextual()`/`textual()`/`postextual()`): continuam como estão (obsoletas).
- **Texto e comentários do `tcc-exemplo.typ`** (palavras-chave com maiúscula, "capítulos", `#textual()`): Etapa 6.

### Verificação da etapa
- Os 12 `.typ` de `examples/` e o `testeCit.typ` compilam em **0.14.1, 0.13.0 e 0.15.1**, 39 de 39, sem erro e **sem aviso**, com as mesmas páginas nas três versões. Contra a linha de base: `tcc-exemplo` 20 → 19, `projeto-exemplo` 21 → 20 (sumário em espaço simples); os demais iguais.
- Os três testes de `testes-2/` compilam sem erro nem aviso nos 3 binários (`tcc-completo` 20 páginas e 34 em frente-verso; `aprovacao-volume` 9; `sumarios` 7).
- Aceitação: o `tcc-exemplo` foi conferido em imagem (capa, folha de rosto, dedicatória, agradecimentos, epígrafe, resumo, abstract, sumário), títulos centralizados, legenda com travessão, palavras-chave com `;`, siglas em ordem, ficha fora da contagem, frente-verso, sumário em 1 página; sem `0.65` nos três arquivos.
- Scripts de apoio no scratchpad (fora do pacote): `matrix.sh`, `sheet.sh`, `ys.sh`.

## Quebras de API para a nota da 0.7.0 (resumo; detalhes nos itens indicados)
1. **`#sub[…]` → `#sublinhado[…]`** (R8b-06, Etapa 0): sem a troca o texto sai subscrito, sem erro.
2. **Funções `abnt-*-setup` e de numeração** (R1-02, Etapa 1b): `#abnt-page-setup(...)` e similares deixam de ser chamadas sem efeito e passam a dar erro de compilação; usar `#show: abnt-page-setup.with(...)`.
3. **Saída visível da Etapa 2** (sem quebra de API, mas a nota da versão deve citar): títulos sem número centralizados; legendas e listas com "Figura 1 – Título"; 2ª linha de título e de nota sob a primeira letra; sumário com indicativos na margem, títulos em coluna e entradas em espaço simples; palavras-chave separadas por `;`; título da capa e natureza em 12 pt; `@rótulo` do TCC passa a dizer "Seção N"; ficha fora da contagem; frente-verso com pré-textuais no anverso (mais páginas em branco); siglas em ordem; novas `folha-aprovacao`, `volume:` e `lista-ilustracoes(tipo:)`.

---

## Etapa 3 — referências, citações, abreviaturas, datas, identificadores (14/10/2026)

Dois agentes, com arquivos disjuntos. **A:** `src/references/abnt.csl`, `bibliography.typ`, `citation.typ`, `numeric.typ`, `examples/referencias.bib`. **B:** `src/core/sorting.typ`, `dates.typ`, `identifiers.typ`, `proofreading.typ`, `src/references/abbreviations.typ`. **Eu:** a ligação de `sort-key` a `text/headings.typ`, `elements/toc.typ`, `elements/index.typ`, `templates/book.typ`, `templates/research-project.typ`; os ISBN/ISSN de `examples/livro-exemplo.typ` e `periodico-exemplo.typ`; as chamadas de `citar-num-apud` em `examples/citacao-numerica-exemplo.typ` e `testeCit.typ`. Testes novos em `docs/revisao/testes-e3/{A,B,lig}/` (cada pasta com o que precisa para rodar; `A/bib.typ` pede `--input arq=…`). `typst.toml` e os PDFs de `examples/` não foram tocados; nada comitado. `numeric.typ` já tinha as alterações não comitadas de B58 (convergência dos números); foram preservadas.

Conferência por amostragem do que os agentes entregaram: recompilei `testeCit`, `citacao-numerica`, `citacao-autordata` e `tcc-exemplo`; renderizei a lista de referências do `testeCit`, do `referencias.bib` inteiro, a `review-legend()` (ao lado da imagem da norma) e a página de referências do TCC; rodei `ab.typ` (797 de 797) e `so2.typ` (0 falhas); a matriz abaixo.

### Referências (NBR 6023) — agente A
- **R2-01** `pereira2022`: `@incollection` → `@inbook`. Antes `PEREIRA, Carlos Eduardo; MARTINS, Roberto (ed.). Estruturas… p. 150–180.`; depois `PEREIRA, Carlos Eduardo. Estruturas de dados avançadas. In: MARTINS, Roberto (ed.). Fundamentos de programação. São Paulo: Pearson, 2022. p. 150-180.` (no 0.15.1 o `@incollection` já funcionava; o `@inbook` serve nas três).
- **R2-02/R2-03** `institution`/`school` → `publisher`; `type` completo nas teses. Antes `… Universidade de Brasília. … Tese (Doutorado em Psicologia), Brasília, 2022.` / `Doctoral dissertation`; depois `… 245 f. Tese (Doutorado em Psicologia) – Universidade de Brasília, Brasília, 2022.`; normas `ASSOCIAÇÃO BRASILEIRA DE NORMAS TÉCNICAS. ABNT NBR 6023: … Rio de Janeiro: ABNT, 2018.` `kitchenham2007` (mesmo defeito) virou `@techreport`.
- **R2-04** evento: `abnt.csl` (macro `event` em maiúsculas; `container-title` põe ` [...]` quando há `event`) e `.bib` com `booktitle = {Anais}` + `eventtitle`, `venue`, `eventdate`, `publisher`. Depois `In: SIMPÓSIO BRASILEIRO DE COMPUTAÇÃO, 2023, João Pessoa. Anais [...]. João Pessoa: SBC, 2023. p. 45-52.` O `[...]` sai quando há `eventtitle` (o CSL não compara o texto "Anais"). `souza2020`: `organization = {SBC}` virou `publisher = {Springer}`, `address = {Cham}` (deduzido do DOI; **confira**).
- **R2-05 / DECISOES #4** `bibliography.typ`: `hanging-indent` removido; `leading: abnt-leading(1)`, `spacing: abnt-leading(2)`, `justify: false`, `lang: "pt", region: "BR"`. Medido em 12 pt: 13,8 pt dentro da entrada e 27,6 pt entre entradas (antes 20,4–20,7 e 22,3; sem linha em branco). Fora de `normas-abnt` saía "Acedido"/"(eds..)"; agora "Acesso em"/"(ed.)".
- **R2-06** (1) chave de ordenação = nome inteiro (`author`): `SILVA, Ana`, `SILVA, Ana`, `SILVA, Zeca`. (2) acento depois do Z: só documentado; **o Typst 0.15.1 já ordena certo, o 0.13 e o 0.14 não**.
- **R2-08** entrada por título sem negrito; subtítulo dentro de `title` nos 13 `subtitle` do `.bib`. **R2-09** `page-range-delimiter` "-" (`p. 199-202`). **R2-10** `5th ed.`. **R2-02** `f.` em tese. **R2-14** (só o espaço duplo da tese) corrigido.
- **R2-07** `ref-livro`/`ref-artigo`/`ref-online` reescritas: só o último sobrenome em maiúsculas (`LUCK, Heloisa.`), `[S. l.: s. n.]`, sem `. ,` nem `jan..`, `p. 199-202, 2011.`, `ano` inteiro ou texto, sem recuo, cada referência em bloco com linha em branco simples.
- **R2b-04** `disambiguate-add-givenname`: `(Barbosa, C., 1958)` e `(Barbosa, O., 1958)`. **Desvio do pedido:** sem `disambiguate-add-names` e sem `givenname-disambiguation-rule`, porque no 0.15.1 a lista completa perdia o `a/b` da mesma autoria e ano. **No Typst 0.15.1 a desambiguação por iniciais não vale** (cai em `1958a/b`, como antes); vale em 0.13 e 0.14.
- **R2b-06** `<citation><sort>` com `author` antes de `issued-year`; `citar-varios` ordena por autor. **R2b-05** resolvido só em `citar-varios` (`(Dreyfuss, 1989, 1991, 1995; Paiva, 1997)`); o `@a @b` nativo continua com `;` entre anos do mesmo autor (limite do motor do Typst, documentado).
- **R2b-07** título curto sem `uppercase` e sem `…`: `(Anteprojeto [...], 1987)` com `shorttitle`; sem `shorttitle` sai o título inteiro. **R2b-08** `pag(<chave>)` e `citar-autor(<chave>)` trocam o `;` do motor por ` e `: `Lima e Serrano (2024)`, `Cruz, Correa e Costa (1998)`. **R2b-09** entidades em caixa mista no `.bib`. **R2b-13** seções da norma nos comentários. **R2b-14/R1-22** `tradução nossa, grifo nosso` nos dois caminhos de `citar`.
- **R2b-11** funções novas e aditivas: `citar-id`, `citar-ibid`, `citar-opcit`, `citar-loccit`, `citar-passim`, `citar-cf`, `citar-etseq`, `citar-ref`. **A checagem de "mesma página" não foi feita**: as notas completas são escritas à mão e o pacote não sabe em que página caiu a anterior; documentado na docstring.
- **Sistema numérico (`numeric.typ`):** **R2b-01** `citacao-num-config` grava `estilo`/`colchetes` num `state` global lido por `citar-num` & cia (antes `(1)`, depois `¹`); a proibição de notas (10520 6.2.2) fica só na docstring, o pacote não a impede. **R2b-02** `(2, 8, 9)`. **R2b-03** `citar-num-apud`: só a fonte consultada vai para a lista, a original é texto (`(Freire, 1994, p. 13 apud 5, p. 25)`). **R2b-10** `abnt-leading(1)` (11,1 pt a 10 pt; lista 13,3 pt). `aviso-sistema-numerico()` imprime "seção 6.2.2".
- **R3-19** ISBN de `beck2021` (`…651-9`) e `silva2023` (`…00-3`); os outros 8 do `.bib` conferem.
- **Não corrigido:** R2-11 (`[s. d.]`; o Typst não lê `c1993`/`[197-]`), R2-14 (restante: `org.`, série+número, número com hífen, meses no idioma original), R2-16 (`[S. l.: s. n.]` espúrio em fotografia/blog/carta), R2-15/R2-17/R2-18 (campos que o Typst não entrega), legislação/jurisprudência/atos/cartório (aviso na docstring, decisão do dono), R2b-12 (numérico ligado ao `.bib`), R2b-15 (sobrescrito com `, p. 34`: a revisão não decidiu; **não mexi**).

### Ordenação (NBR 6033) — agente B + ligação minha
- **R3-01** `remove-accents` real (179 caracteres, mais `ß`, `æ`, `œ`, `º`, `ª` e marcas combinantes) e chamada por `sort-key`: `Muller, Müller, Zebra, Álvaro, Ícaro` → `Álvaro, Eva, Ícaro, Muller/Müller, Zebra`. **R3-02** artigo com apóstrofo/hífen sai (`L'enfant`, `al-Khwarizmi`); `La Fontaine, Jean de` mantém o artigo. **R3-03** sigla antes do igual (`ASA` antes de `asa`), numerais por valor e ordinal depois do cardinal (`8, 8., 8º, 8th, 9`), `1.000.000` como um número, símbolos ignorados (`£ 100` ordena pelo 100), homógrafas na ordem autor, entidade, assunto, título.
- **Uso:** `lista.sorted(key: sort-key)`; `sort-key(texto, ignore-articles: false)` para siglas; `sort-initial(texto)` dá a letra do cabeçalho do índice (`"A"`, `"Z"`, `"0-9"`). A chave **não é legível** (códigos de número e `U+0001` no fim): não imprimir.
- **Ligação** (`sort-key` onde havia `.sorted()` cru): `headings.typ` (`glossario`), `research-project.typ` (`glossario-projeto`), `toc.typ` (`lista-siglas`: antes `lower()`, `ignore-articles: false`), `index.typ` (termos, subtermos e letra do cabeçalho com `sort-initial`), `book.typ` (`book-list-abbreviations`, `book-glossary`, letra do `book-index`). **R1-08, R1-09, R4b-17** (a parte da ordem e do agrupamento por letra).
- **Verificado:** `testes-e3/lig/ordem.typ` e `indice.typ`: glossário `Álgebra, Árvore, O Barco, Ômega, Zebra`; siglas `ASA, asa, CAVO, Cavo, IBGE, Ícaro, ISO, UFRJ`; índice com `Á` em "A" e `Ô` em "O", `100 anos` em "0-9", `O Mar` em "M" (artigo ignorado), subtermos `Ácido, Água, Zinco`. Antes `Á` e `Ô` iam depois do Z. `book-index` só ganhou a letra certa: a ordem das entradas dentro da letra continua a que o usuário passa.
- **Não corrigido:** o exemplo 3.6.2 da norma (`A. A. Enterprises`…) está em colunas, não numa ordem única (segui "espaço menor que qualquer letra"); `A e B` perde o `A` (artigo em português); `La Rochefoucault` sem vírgula exige `keep-articles-in-names: true`; `Monte-Alegre` ordena como `montealegre` (hífen é símbolo, 3.6.1); `Brasil-História` sem espaços não é separado.

### Abreviaturas (NBR 6032) — agente B
- **R3-13** `abbreviation-dict` = proposta de 799 chaves `(substantivo, adjetivo)` com os acentos da norma; as entradas antigas sem base na lista foram para `abbreviation-extensions` (22). **Teste de aceitação: `ab.typ` com `norm6032.json` = 797 de 797** (antes 69), 0,36 s.
- **R3-14** `abbreviate-title` aplica 2.1.4/2.2.2.2 (`R. bras. Biol.`), 2.1.7 (compostos: `Atual. méd.-sanit.`), 2.2.1 (`O Jornal`, `O Tico-Tico` inteiros), 2.2.3.1 (`und`→`u.`), 2.2.5 (`B. estat. IBGE`); `abbreviation-examples` bate com a função. Plural 2.1.5 é opcional (`plural: true` → `R. Fed. Acad-s Letras`; padrão `false`: **decisão sua**).
- **`can-abbreviate("Café")` agora é `false`** (4 letras; 2.1.2). A instrução dada ao agente dizia `true` e estava errada: o B18 do CONSOLIDADO trata o `true` como defeito.
- **Muda o tipo** de `abbreviation-dict` (string → `(string, string|none)`) e a caixa devolvida por `get-abbreviation` (`preserve-case: true` restaura a antiga).

### Datas (NBR 5892) — agente B
- **R3-05** `séc. XX`. **R3-06** `32,3 s` (também `12:21:02,5`); novas `format-date-time`, `get-weekday`, `format-weekday`; séculos acima de XXI em romanos (`to-roman` 1–3999). **D4** `format-date-numeric/mixed/short` com ano de menos de 4 dígitos dão **erro** com a mensagem "NBR 5892 3.1.3". Rótulos `"Jan"`/`"Mai"` (D50) não tocados.

### Identificadores — agente B
- **R3-15** `validate-isbn` exige 978/979. **R3-16** `format-isbn` usa `publication-len`; grupo+registrante+publicação que não somam 9 dão erro explícito. **R3-17** `isbn-country` por prefixo (979-10 França; 978-65 "Brasil", não mais "antigo"). **R3-18** `X` do ISSN em maiúscula. **R3-20** seção 6.6, `issns`, docstring de `isbn10-to-isbn13`; `display-isbn` com ISBN-10 mostra `ISBN-10 …; ISBN-13 …`. **R3-19** docstrings com ISBN válidos; nos exemplos, `livro-exemplo.typ` (`978-65-00000-00-9`, linhas 40, 62, 144) e `periodico-exemplo.typ` (`2965-0003`, linhas 25, 45, 56, 115).
- **Nota:** o ISBN `979-10-90636-07-3` usado na revisão tem dígito verificador errado (o certo é `…-07-1`).

### Sinais de revisão (NBR 6025) — agente B
- **R3-08** colchete `[` (parágrafo), `[ ]` (centralizar), `V` (inserir), `⊔ ⊓` (transpor), traço entre dois traços verticais (suprimir), `v.o` e `vale` circulados; `join-space` agora é "Unir" e há `suprimir-espaco`. **R3-09** rótulos circulados `neg`/`bold`, `red`/`nom`, `Cab` novo. **R3-10** `align-left/right` mantidos (não estavam invertidos). **R3-11** 13 sinais novos. **R3-12** `review-legend()` em três blocos; marcadores de cor rotulados como **extensão do pacote**. Conferido em imagem contra a tabela 1 da norma.
- **Não desenhados:** transpor várias palavras (numeração), subscrever, sobrescrever, "colocar no ponto indicado pela seta", variações da barra de atenção, evitar sequência de hífens. Os desenhados são aproximações vetoriais de desenhos à mão. A ligação marcação-no-texto ↔ sinal-na-margem (3.3) não existe.

### Verificação da etapa
- Os 12 `.typ` de `examples/` e o `testeCit.typ` em **0.14.1, 0.13.0 e 0.15.1**: 39 de 39 sem erro e **sem aviso**, `diff` vazio contra a linha de base (mesmas páginas: `tcc` 19, `livro` 25, `periodico` 20, `projeto` 20, `relatorio` 19, `artigo` 6, `poster` 1, `slides` 30 e 24, `citacao-autordata` 2, `citacao-numerica` 3, `formatacao-inline` 1, `testeCit` 4).
- Os 23 `.typ` de `testes-e3/` compilam sem erro e sem aviso nas três versões (`A/bib.typ` com `--input arq=…`).
- Aceitação: `testes-2a/` e `testes-2b/` (cópias em `testes-e3/A/`) com a saída da norma, exceto os limites acima; `so.typ`/`so2.typ` e `ab.typ` 797 de 797.
- **No Typst 0.13.0** o campo `type` de tese é descartado pelo próprio Typst (sai `280 f. Universidade…` sem `Tese (Doutorado…)`; já era assim). **No 0.13** o parser BibLaTeX quebra com `@` dentro de comentário do `.bib` (o cabeçalho do `referencias.bib` diz "tipo inbook" por isso).

## Quebras de API e mudanças de uso da Etapa 3 (para a nota da 0.7.0)
8. **`citar-num-apud(original, consultada)`**: o 1º argumento passa a ser o **texto** da chamada original (`"Freire, 1994"`), não uma chave; a original deixa de entrar na lista numérica.
9. **`abbreviation-dict`** muda de formato; `get-abbreviation` devolve a caixa da norma; `can-abbreviate` conta caracteres.
10. **`format-date-numeric/mixed/short`** dão erro com ano de menos de 4 dígitos; **`format-isbn`** dá erro quando os comprimentos não somam 9; **`validate-isbn`** recusa o que não é 978/979.
11. **`ref-livro`/`ref-artigo`/`ref-online`**: saída e layout mudam (último sobrenome em maiúsculas, sem recuo).
12. **Ordenação:** `sort-key` devolve chave opaca (não imprimir); glossário, siglas, índice e `book-index` passam a ordenar pela NBR 6033.

## Pendências e observações da Etapa 3
- **Para a Etapa 6 (documentação e exemplos):** `docs/manual-implementacao.typ` (449-575 sorting/proofreading; 651-661 e 719 ISBN inválidos e `format-isbn(..., publication-len: 4)`, que agora dá erro; 1484; 1913-1968 dates/abbreviations; changelog 2313/2333), `docs/introducao-abntyp.typ` (~1219 e 1290-1291 `(1; 2)` e `(1 apud 2, p. 25)`; ~1973-2043 `@incollection`, `institution`, `booktitle` sem evento; ISBN em 2340; texto do recuo francês), `README.md`/`README-typst.md` (`hanging-indent`, `@incollection`, `citar-num-apud`), `lib.typ` ("NBR 6023:2018" ≠ versão corrigida 2:2020), `examples/citacao-autordata-exemplo.typ` (mostra `Lima; Serrano`; `pag` já resolve), `examples/citacao-numerica-exemplo.typ` (texto "seção 4.2" nas notas finais), **`examples/tcc-exemplo.typ`: a lista de referências é escrita à mão e sai com recuo francês (a imagem da p. 19 mostra), em desacordo com a DECISOES #4**; `docs/mudancas-pos-auditoria.md:130` (ISBN); rótulos `"Jan"`/`"Mai"` (D50: `projeto-exemplo.typ:271`, manual:1645, `research-project.typ:260`).
- **Decisões suas:** plural 2.1.5 por padrão em `abbreviate-title`; `souza2020` no `.bib` (editora Springer, Cham).
- **Código morto notado, não removido:** `abnt.csl` (ramo `<else-if type="paper-conference article" match="all">` da macro `container-title` nunca roda); `citar-num-linha` idêntica a `citar-num`; `abnt-cite-setup` não faz nada; `extract-number`, `starts-with-number`, `compare-strings` (sorting.typ); `should-suppress` (abbreviations.typ); `replace-text`, `inline-comment`, `margin-note`, `review-note`, `review-mode` sem uso nos templates; `isbn-groups`/`isbn-country` sem uso fora de `identifiers.typ`; os templates imprimem ISBN/ISSN cru (nenhum chama `identifiers.typ`).
- **Exportados por `lib.typ` (via `*`) sem necessidade:** helpers com `_` novos (`_check-year`, `_entry`, `_abbrev-part`, `_is-sigla`, `_traco`, `_poli`, `_sinal`, `_circulo`), como o `_normalizar` que já existia. Sem conflito de nomes (grep).
- `citacao-num-longa`/`bibliografia-numerica` não fixam `top-edge`/`bottom-edge`: fora de `normas-abnt` o "simples" sai um pouco menor que 1,15 × corpo.
- Scripts de apoio no scratchpad (fora do pacote): `matrix.sh`.

---

## Etapa 4 — templates (14/10/2026)

Arquivos alterados: `src/templates/{article,periodical,research-project,book,technical-report,poster}.typ`, `src/core/spacing.typ` (só o `0.65` do `nature-block`, código morto, agora `abnt-leading(1)`), `examples/{artigo,periodico,projeto,livro,relatorio,poster}-exemplo.typ`. Três agentes (A: artigo/periódico/projeto; B: livro; C: relatório/pôster) trabalhando em cópias do pacote no scratchpad (porque `lib.typ` importa todos os templates); eu copiei de volta só esses arquivos, depois de conferir com `diff -rq` que mais nada diferia. Testes novos: `docs/revisao/testes-4/` (nature-block), `testes-4a/` (`art-completo`, `per-completo`, `proj-completo`), `testes-4B-livro/` (29), `testes-4C/` (`c01`–`c08` e cópias da 7c). Nada comitado; `typst.toml` e os PDFs de `examples/` não foram tocados (a matriz compilou para o scratchpad).

### Verificação da etapa (feita por mim no pacote real)
- 12 exemplos + `testeCit.typ` × 0.14.1, 0.13.0 e 0.15.1: **39 de 39 com rc=0 e 0 avisos**, uma única contagem de páginas por arquivo nas três versões. Contra a linha de base: `artigo` 6→5, `livro` 25→28, `periodico` 20→18, `projeto` 20→18, `relatorio` 19→18 (a 19ª era branca); os demais iguais (`tcc` 19, `poster` 1, `slides` 30/24, `autordata` 2, `numerica` 3, `inline` 1, `testeCit` 4).
- Amostragem em imagem por mim: artigo p. 1 (subtítulo com `:` colado, RESUMO centralizado, palavras-chave com `;`, datas), pôster (colunas equilibradas, afiliação), Introdução do relatório numerada 7 (texto do sumário). O resto foi conferido em imagem pelos agentes, conforme os relatórios abaixo; **não reconferi os demais pontos**.
- **`grep -rn "0.65" src/`:** resta só `core/proofreading.typ:95` e `:256`, que são coordenadas de desenho e não entrelinha (falso positivo do teste de aceitação; não alterado). Todos os `0.65` de entrelinha saíram.
- **Não foi feito pela etapa (fora dos arquivos dos agentes):** `elements/index.typ` (R7b-18: `indice(titulo: "")` deixa vão de ~38 pt e termina com `pagebreak()` não fraco; correção: `titulo: none` e `pagebreak(weak: true)`), `elements/toc.typ` (listas vazias R4b-06/R7c-12 no TCC e lista de abreviaturas × siglas R7c-16), `text/figures.typ` (fonte obrigatória, R4a-05), `text/headings.typ:131` (`glossario()` com `pagebreak()` interno e erro em `colunas: 2`), `setup.typ` (título de seção sozinho no pé da página; vira "1 INTRODUÇÃO" no fim da p. 1 do artigo), R4b-14/15 (lombada), R4b-17/18 (índice), R4b-20/21 (moldura e sinais convencionais de `tabela()`).

### Quebras de API e uso da Etapa 4 (para a nota da 0.7.0)
13. **Espaçamento:** `artigo()` e `relatorio()` passam a espaço **simples** por padrão (DECISOES #3); `espacamento: "1,5"` volta ao antigo.
14. **Projeto de pesquisa:** a numeração de página vem do template e conta desde a folha de rosto (Introdução do exemplo: p. 1 → p. 3); quem faz `counter(page).update(1)` à mão deve remover. `periodical-toc()` não usa mais `outline`; em `periodical-cover`/`periodical-title-page` `titulo` passou de `""` a `none`; `periodical()` ganhou `pagina-inicial`.
15. **Livro:** as funções do livro **não terminam mais em `pagebreak()`**; cada uma abre a sua página (`pagebreak(weak: true, to: …)`). Uma `#pagebreak()` solta antes de elemento ímpar em frente-verso deixa branca com cabeçalho e número. Cabeçalho e número só nos elementos textuais; `cabecalho` aceita `(par:, impar:)` e `auto`; epígrafe com a referência em nota de rodapé (`em-nota: false` volta ao antigo); listas vazias não saem.
16. **Relatório:** `report-cover()` não marca mais a folha de rosto (a contagem começa no rosto: Introdução 7, não 8); `report-code()` devolve texto; `relatorio(arquivo-bibliografia:)` com caminho em string aborta cedo; `poster()` e `academic-poster()` abortam com título vazio; nova `referencias-relatorio()` marca a posição das referências.
17. **Pôster:** `poster-a1` passa a 60 × 90 cm (dentro da 15437 5.2); `academic-poster(logo:)` não duplica mais o logo (há `logo-direita`).

### Relatório do agente A (na íntegra)

#### Etapa 4, agente A: artigo, periódico e projeto de pesquisa

Cópia de trabalho: `$SP/A/pkg`. Tudo conferido em Typst 0.14.1, 0.13.0 e 0.15.1 (matriz em `$SP/A/matriz/resumo.txt`).

##### Artigo (`src/templates/article.typ`)

###### R4a-01 · datas, título em inglês, DOI, agradecimentos
- **Onde:** `article.typ` (novos `_data-artigo`, `_cabecalho-artigo`, `agradecimentos-artigo`; `artigo()` com `titulo-en`, `submissao`, `aprovacao`, `doi`, `agradecimentos`).
- **Antes:** nenhum desses elementos existia. **Depois:** `submissao`/`aprovacao` aceitam texto, conteúdo ou `datetime` (vira "12 de março de 2026"); saem depois do abstract como "Data de submissão: …" / "Data de aprovação: …", mais "DOI: …". `titulo-en` sai em itálico sob o título. `agradecimentos-artigo(conteudo)` (nome que não colide com `agradecimentos`, `agradecimentos-relatorio`): título centralizado, sem `pagebreak`. Como a bibliografia automática sai depois do corpo, `artigo(agradecimentos: [...])` imprime o texto DEPOIS das referências (último elemento pós-textual).
- **Verificado:** `testes-4a/art-completo.typ` (imagem das 3 páginas: datas, DOI, título em inglês, REFERÊNCIAS e AGRADECIMENTOS no fim).
- **Parcial:** as datas são opcionais (padrão `none`), não obrigatórias de fato: obrigar quebraria chamadas existentes e o Typst não avisa sem abortar. A docstring diz que a 6022 5.1.4 as exige.

###### R4a-02 · subtítulo
- `TÍTULO:` com os dois-pontos colados, subtítulo na linha seguinte (como o TCC), `hyphenate: false` e `justify: false` no bloco do título (a imagem mostrava "SUPE-RIOR" e linhas esticadas). Conferido em imagem (artigo-exemplo e art-completo com título longo). Em `project-cover`/`project-title-page` o mesmo defeito existia (título justificado e hifenizado: "cognitivo--comportamental"): corrigido, ver R4a-15/16.

###### R4a-03 · RESUMO/ABSTRACT
- RESUMO e ABSTRACT centralizados em negrito, texto sem recuo; palavras-chave em parágrafo próprio: `Palavras-chave: a; b; c.` e `Keywords: a; b; c.` (unificado com o TCC). Vale para `artigo()` e `periodical-article()` (mesmo `_bloco-resumo`). Conferido em imagem.

###### R4a-04 · espaçamento
- `artigo(espacamento: "simples")` (padrão) ou `"1,5"`: `set par(leading/spacing: abnt-leading(k))` depois do `with-abnt-setup`. Medido (`pdftotext -bbox`): 13,8 pt (simples) e 20,7 pt (1,5). Valor inválido dá `assert`. `periodical-article` mantém 1,5: a NBR 6021 não trata de espaçamento (conferido no texto). `artigo-exemplo`: 6 → 5 páginas.

###### R4a-05
- Título 14 pt → 12 pt (feito). Apêndice/anexo/glossário centralizados (vêm do setup): conferido em imagem (`art-completo`).
- **NÃO CORRIGIDO: fonte obrigatória** em ilustração/tabela (6022 6.6/6.7): `container(fonte: none)` está em `src/text/figures.typ`, arquivo de outra etapa.

###### R4a-06
- Cabeçalho do exemplo agora diz que as seções do exemplo são numeradas (`=`, NBR 6024) e que `article-section`/`article-subsection` servem para seções sem número (não alterei essas funções).
- `arquivo-bibliografia: read("referencias.bib")` no exemplo (comentado, como antes): testei descomentando, compila e imprime as referências do `.bib`. A docstring de `artigo()` e o comentário dizem para usar `read(...)`.
- Na lista manual de referências dos 3 exemplos troquei `hanging-indent` (DECISOES #4) por: sem recuo, espaço simples, linha em branco entre elas (mesmo ajuste que `abnt-bibliography`).

##### Periódico (`src/templates/periodical.typ`)

###### R4a-07 · legenda
- **Depois:** o rodapé calcula o intervalo do artigo/seção corrente por marcas (`_per-marca`, metadata `<abnt-per-secao>` emitida por `periodical-article`, `editorial`, `author-guidelines` e `periodical-toc`): do início da seção até a página anterior à da seguinte (a última vai até o fim). Antes: `p. N` da página corrente. Capa, folha de rosto e verso passam a ter `footer: none`; a folha de rosto traz uma só legenda (a do corpo). Página sem seção: `p. N`.
- **Verificado:** `periodico-exemplo` (extraído por página: p. 185-187, 188-191, … e a capa/rosto sem rodapé) e `per-completo`; imagens das páginas 1-6.

###### R4a-08 · sumário por artigos
- `periodical-toc()` lista, a partir das marcas, EDITORIAL, cada artigo (título, autores com "; ", pontilhado, página inicial) e INSTRUÇÕES PARA AUTORES; seções internas não entram. A contagem de seções reinicia a cada artigo e nas instruções (`counter(heading).update(0)` em `_per-marca`). Conferido em imagem. As seções ainda são `heading` (aparecem como marcadores do PDF), só o sumário é próprio.
- Mudança de uso: `periodical-toc()` ignora `outline`; quem usava `#outline()` à mão não muda.

###### R4a-09 · capa
- `periodical-cover(instituicao:, dia:)` (instituição ao pé da capa; com `dia` e um só mês a data sai "16 de setembro de 2014"); `dia` também na folha de rosto e na legenda ("16 set. 2014"). Página inicial: `periodical(pagina-inicial: 1)`, a capa não é numerada e a folha de rosto leva esse número; o exemplo usa 181. Escolha minha: a capa não entra na contagem (6021 5.6.2 diz só que não recebe número).
- Extra: `periodical-title-page(paginas:)` agora é opcional (calculado: da folha de rosto até a última página); a legenda da folha de rosto não tem mais recuo de 1ª linha.

###### R4a-10 · `(c)` → `©` (verso). Conferido em imagem.

###### R4a-11 · parâmetros de `periodical()`
- Usados por estado (como `dados()`): `titulo`, `subtitulo`, `issn`, `volume`, `numero`, `ano`, `mes-*`, `dia`, `local`, `instituicao` valem como padrão de `periodical-cover()` e `periodical-title-page()` (o que for dado a elas prevalece). O exemplo agora chama `#periodical-cover()` e `#periodical-title-page()` sem repetir.
- **NÃO USADOS (documentado na docstring): `editora` e `doi`**: nenhum elemento da 6021 os pede nesses lugares.

###### R4a-12 · conferido, nada alterado
- A legenda usa `abbreviate-title` (Etapa 3, de outro agente). Forma `5(6): 100-122` continua sem função própria.

###### R4a-13 · `periodical-article`
- Mesmos itens do artigo (via `_cabecalho-artigo`): `subtitulo`, `titulo-en`, `submissao`, `aprovacao`, `doi`, resumos centralizados, palavras-chave com "; ", título 12 pt. `agradecimentos-artigo` serve dentro do artigo.
- `0.65` em `periodical.typ:245` → `abnt-leading(1)` (com `top-edge`/`bottom-edge`).

###### Exemplo do periódico
- Removi o `#pagebreak()` extra antes do artigo 1 (o `editorial()` já quebra: havia uma página em branco), "Referências" dos artigos passou a `#heading(numbering: none)` (saía "5 Referências"), datas e DOI nos artigos. 20 → 18 páginas.

##### Projeto (`src/templates/research-project.typ`)

###### R4a-15
- `projeto-pesquisa()` grava `titulo`, `subtitulo`, `autor`, `instituicao`, `local`, `ano`, `tipo-projeto`, `orientador`, `coorientador`, `coordenador`, `volume` num estado; `project-cover()`/`project-title-page()` os usam quando o argumento é `none` (chamada antiga que repete valores continua valendo; `pp.typ` e o `projeto-exemplo` antigo compilam).
- Numeração: `header: abnt-numero-pagina(paginacao: "auto")`, contagem desde a folha de rosto (`marcar-folha-rosto()` em `project-title-page`), número a partir da 1ª seção primária numerada. O `counter(page).update(1)` e o `set page(numbering…)` à mão saíram do exemplo; **efeito visível:** a Introdução passa a ser a p. 3 (antes 1).
- `frente-verso: false` novo: `abnt-margens`, `level-1-pagebreak-impar`, `abnt-frente-verso` (folha de rosto, sumário e listas em página ímpar). Testado com `--input fv=1` (17 páginas; margens espelhadas, número à esquerda nas pares, seções primárias em ímpar; imagem).

###### R4a-16
- Glossário: ordenado (Etapa 3 já faz: `Álgebra, beta, Ícaro, Zeta`), centralizado (setup), `pagebreak(weak: true)`.
- Título/subtítulo 14 → 12 pt, sem justificar nem hifenizar (`_proj-titulo`); natureza 10 → 12 pt e espaço simples (`abnt-leading(1)`); `0.65` removido (`grep` vazio nos 6 arquivos).
- Cronograma: conferido com 3, 12 e 13 períodos (imagem), sem problema.
- Exemplo: removi `= Cronograma` e `= Recursos` duplicados (as funções já criam o título; saía uma página só com "6 CRONOGRAMA" e outra com "7 CRONOGRAMA"). 20 → 18 páginas.
- **R4a-14** (`recursos()`): confere, `rec.typ` compila.

##### Verificação
- Matriz: 39 de 39 com rc=0 e 0 avisos; páginas iguais nas 3 versões. Contra a linha de base só mudam os meus: artigo 6→5, periódico 20→18, projeto 20→18 (os outros 10 arquivos + `testeCit` iguais). Os 3 testes novos compilam sem aviso nos 3 binários (`art-completo` também com `--input esp=1,5` e `col=2`).
- Imagens conferidas: artigo p. 1, 3, 5; `art-completo` p. 1-3 e duas colunas; periódico p. 1-6 e `per-completo`; projeto p. 2, 4, 12, 14 e frente-verso.

##### Arquivos
Alterados (relativos ao pacote): `src/templates/article.typ`, `src/templates/periodical.typ`, `src/templates/research-project.typ`, `examples/artigo-exemplo.typ`, `examples/periodico-exemplo.typ`, `examples/projeto-exemplo.typ`.
Novos: `docs/revisao/testes-4a/art-completo.typ`, `per-completo.typ`, `proj-completo.typ`.
(`src/core/spacing.typ` difere entre minha cópia e o original por mudança de outro agente depois do meu rsync; não toquei nele.)

##### Mudanças de saída visível (nota 0.7.0)
Artigo em espaço simples por padrão; título 12 pt, `TÍTULO:` + subtítulo; RESUMO/ABSTRACT centralizados; palavras-chave com "; "; datas/DOI/título em inglês. Periódico: legenda com intervalo do artigo, sem rodapé na capa/folha de rosto, sumário por artigos, `©`, páginas contadas a partir da folha de rosto, seções reiniciam por artigo. Projeto: título 12 pt, natureza 12 pt, número de página automático contado desde a folha de rosto, glossário sem quebra forçada.

##### Quebras de API / uso
- `periodical-toc()` deixa de usar `outline`. `periodical-cover`/`-title-page`: `titulo` passa de `""` a `none` (vale o do `periodical()`); numeração do periódico agora começa na folha de rosto.
- `project-title-page` agora marca a folha de rosto (contagem); quem fazia `counter(page).update(1)` à mão na Introdução terá número duplicado/diferente: remover.
- `artigo(arquivo-bibliografia:)` continua exigindo `read(...)` (já era).

##### Código morto / defeitos notados (não corrigidos)
- `glossario()` (`src/text/headings.typ:131`) tem `pagebreak()` interno: erro dentro de `colunas: 2` do artigo.
- `1 INTRODUÇÃO` fica sozinha no pé da página (título sem "keep with next"; `setup.typ`).
- Verso do periódico: os créditos do exemplo juntam linhas (texto sem linha em branco/`\`); conteúdo do exemplo.
- Com `arquivo-bibliografia`, apêndices dentro do corpo saem antes das referências (a bibliografia automática vem depois do corpo).
- `article-section`/`article-subsection` seguem sem uso nos exemplos.

##### Pendências
- Etapa 6: manual e introdução (assinaturas de `artigo`, `periodical*`, `projeto-pesquisa`, `agradecimentos-artigo`, `espacamento`, `pagina-inicial`); `docs/` ainda mostram `(c)` e `hanging-indent`.
- Etapa 3/outra: `container(fonte: none)` (R4a-05).

### Relatório do agente B (na íntegra)

#### Etapa 4, agente B — livro (`src/templates/book.typ`, `examples/livro-exemplo.typ`)

Trabalho feito na cópia `$SP/B/pkg`. Matriz final (`$SP/B/matriz/resumo.txt`): 39 de 39 com rc=0, 0 avisos, mesmas páginas nas 3 versões (0.13.0, 0.14.1, 0.15.1); só o `livro-exemplo` mudou em relação à linha de base (25 → 28 páginas, explicado no fim). Testes novos (29 arquivos) também compilam sem aviso e com as mesmas páginas nos 3 binários.

**Nota de nome:** os testes ficam em `docs/revisao/testes-4B-livro/` e não em `testes-4B/`, porque no macOS (sistema de arquivos sem distinção de caixa) `testes-4B` é a MESMA pasta de `testes-4b` (testes originais da Parte 4b). Eu a sobrescrevi por engano no começo e restaurei do pacote original (conferido com `diff -rq`: igual).

##### Mecanismo central (vale para vários achados)

Quebras de página e páginas em branco (R4b-02, R7b-01, R7b-07, R7b-08, R7b-19) passam por `_abre-impar()` e `_livro-abre()` (início de `book.typ`):
- A quebra é nativa: `pagebreak(weak: true, to: "odd" | "even")`. Ela usa a página FÍSICA (testado em `par.typ`: depois de `counter(page).update(1)` na pág. 2, `to: "odd"` ainda trata a pág. 3 como ímpar). Foi a minha primeira tentativa, deixar `here().page()` decidir se insere a branca, que não convergia ("layout did not converge within 5 attempts" com 4 ou mais elementos em sequência, e a dedicatória caía em página par): cada decisão depende das anteriores e o Typst só repete 5 vezes. Por isso a decisão é do `pagebreak(to:)`.
- A branca é reconhecida pelo cabeçalho e pelo rodapé sem depender de paridade: cada `_livro-abre` põe um `metadata` `<abnt-livro-fim>` no fim do conteúdo anterior e `<abnt-livro-ini>` no começo do elemento; a página `p` é branca se `p+1` tem `ini` e `p` não tem `fim` nem `ini` (`_livro-sem-moldura()`). Guardas e quarta capa usam `<abnt-livro-sem-moldura>`.
- Para isso, as funções do livro **não terminam mais com `pagebreak()`**: cada elemento abre a própria página (`_abre-impar()` faz `pagebreak(weak: true)` também sem frente-verso). Isso também resolve R7b-08 (sem branca no fim; colofão e quarta capa abrem página própria).
- **Limitação:** uma `#pagebreak()` solta do usuário antes de um elemento que abre em ímpar, em frente-verso, deixa uma branca COM cabeçalho e número (a marca `fim` cai na página vazia). Use as funções do livro, ou `pagebreak(weak: true)` antes de um título primário (o exemplo faz isso antes das REFERÊNCIAS).

##### P1

###### R4b-01 (parte que faltava) · referência da epígrafe em nota de rodapé
- **Onde:** `book.typ`, `book-epigraph(citacao, autor, em-nota: true)`.
- **Antes:** `(Autor)` ao lado, entre parênteses. **Depois:** `“citação”` com `footnote(autor)`; `autor` recebe a referência (NBR 6023) ou só o nome. `em-nota: false` volta ao `(autor)` ao lado.
- **Verificado:** `ex-fv0/ex-fv1` (imagem da página da epígrafe: texto com nota 1 e a referência abaixo do filete, 2ª linha sob a 1ª letra). O exemplo passa a referência completa (ABELSON; SUSSMAN…).

###### R4b-02 + R7b-14 + R7b-19 (parte do cabeçalho e do número) · cabeçalho só nos textuais
- **Onde:** `livro()` (`header:` e `footer:`), helpers `_livro-primeira-pagina`, `_livro-sem-moldura`.
- **Antes:** cabeçalho em todas as páginas (capa, rosto, brancas, quarta capa); par/ímpar pela contagem lógica e alternando mesmo sem frente-verso; número nas brancas posteriores ao sumário.
- **Depois:** cabeçalho só da página seguinte ao sumário (sem sumário: da 1ª seção numerada) em diante, e nunca em página marcada como sem moldura (brancas, guardas, quarta capa). Paridade pela página física. Frente-verso: par à esquerda, ímpar à direita; sem frente-verso só o texto "ímpar", à direita. `cabecalho` aceita conteúdo único (igual ao antigo) ou `(par: …, impar: …)`; o valor `auto` é o título do capítulo corrente (não se repete na página em que o capítulo abre). O número de página também some nas brancas (`<abnt-livro-fim/ini>`), antes e depois do sumário.
- **Verificado:** `ex-fv1` (36 páginas): todas as 8 brancas (2, 8, 10, 12, 18, 20, 26, 35) com texto extraído vazio (nem cabeçalho nem número); capa e quarta capa sem cabeçalho; imagem. `fim4` (quarta capa no fim, sem frente-verso): pág. 2 só com o ISBN. `fv-sum`: idem. Cabeçalho alterna esquerda/direita (imagem do `ex-fv1`) e sem frente-verso fica sempre à direita (`ex-fv0`).

###### R4b-03 · `©`
- **Onde:** `book-title-page-verso`. **Antes:** `(c) 2026 Autor`. **Depois:** `© 2026 Autor`; com só um dos dois campos sai `© 2026` ou `© Autor` (antes sumia sem aviso; ver R7b-24).
- **Verificado:** `e3` e exemplo (imagem).

###### R7b-01 · sumário abre no anverso
- **Onde:** `book-toc` começa com `_abre-impar()`. **Verificado:** `fv-sum` (só uma lista de siglas antes do sumário): SUMÁRIO na pág. 9 (ímpar), branca na 8, prefácio na 11. `ex-fv1`: sumário na pág. 17. **Aceitação cumprida.**

###### R7b-05 (parte do código) · `book-index` com termo em conteúdo ou vazio
- **Onde:** `book-index`, helper `_livro-texto`. Termos como `$alpha$`, `[*Banco*]` e `""` não dão mais erro (`man2`): letra do cabeçalho e ordem vêm do texto extraído; vazios caem em "#". `book-index(entries: …)` (a forma errada do manual) também passa a valer. Dentro de cada letra agora ordena por `sort-key` (NBR 6033). Aceita dicionário ou lista de pares.
- **Documentação:** Etapa 6.

##### P2

###### R4b-04 · elementos que faltam — **só em parte**
- **Feito:** (1) verso da falsa folha de rosto com a série: `half-title-page(titulo: auto, serie: none)`; (2) errata: `book-errata(referencia:, itens: ((pagina:, linha:, errado:, correto:), …))`, nome sem colisão com `errata` do relatório; tabela "Folha / Linha / Onde se lê / Leia-se", abre em ímpar (a norma não diz isso; escolha minha, igual à dedicatória); (3) folha de guarda: `book-guarda(conteudo: none)`, uma página sem cabeçalho nem número; (4) licença/Creative Commons: parâmetro `licenca:` do verso da folha de rosto, que imprime o conteúdo do usuário (símbolo e texto), sem imagem pronta.
- **NÃO CORRIGIDO:** sobrecapa e orelhas (não couberam sem inventar um modelo gráfico; `book-guarda` aceita conteúdo para quem quiser compor a sobrecapa à mão).
- **Verificado:** exemplo (série na pág. 3 e errata na pág. 6 em imagem), `ex-fv1`.

###### R4b-05 · `:` colado ao título
- **Onde:** `_livro-titulo-sub`, usado na capa e na folha de rosto. Título em negrito com `:` colado (não acrescenta se o título já termina em `: ? ! .`) e o subtítulo na linha de baixo, sem `:`. **Verificado:** imagem (`FUNDAMENTOS DE PROGRAMAÇÃO:` / `Uma Abordagem Prática`).

###### R4b-06 + R7b-16 · listas vazias; quadros
- **Onde:** `_livro-lista`, `book-list-illustrations(tipo: image, titulo: …)`, `book-list-tables()`, novo `book-list-quadros()`. Lista sem itens não sai (inclui `book-list-abbreviations(())` e `book-list-symbols(())`). As listas usam `_abnt-lista-rules` de `toc.typ` (travessão: `Tabela 1 – Título … 14`).
- **Numeração por tipo:** o Typst numera por `kind`; para `Mapa 1`, `Gráfico 1`, `Mapa 2` use `container(tipo: "mapa", suplemento: "Mapa")` e `book-list-illustrations(tipo: "mapa", titulo: "LISTA DE MAPAS")` (`ilus.typ`, imagem: `Mapa 1`, `Mapa 2`, `Gráfico 1`, `Figura 1`, `Quadro 1`, `Tabela 1`, cada um numerado à parte e cada lista só com os seus). Sem tipos próprios a numeração continua única entre suplementos diferentes do mesmo `kind` (limite do Typst, a documentar).

###### R7b-07 · quarta capa
- `book-back-cover` abre página par (`pagebreak(to: "even")` em frente-verso), sem cabeçalho nem número; ISBN impresso só se existir (R7b-11). O exemplo a põe no fim. **Verificado:** `ex-fv1` pág. 36 (par; a 35 branca sem nada), `fim4`.

###### R7b-08 · quebras no fim e no início
- Nenhuma função termina com quebra (ver "Mecanismo central"); colofão e quarta capa abrem página própria. **Verificado:** `fim1`, `fim2`, `fim4`, `fim5` passam de 3 para 2 páginas (sem branca no fim); `fim3` (colofão depois do capítulo) 2 páginas: o colofão vai à última folha.

###### R7b-09 · parâmetros de `livro()` usados
- **Onde:** estado `_livro-dados`, gravado por `livro()`; `book-cover`, `book-back-cover`, `half-title-page`, `book-title-page` e `book-title-page-verso` usam `auto` como padrão (leem o estado) e o valor repetido continua prevalecendo. O exemplo agora não repete nada. O título do PDF leva o subtítulo (`Título: subtítulo`).
- **Efeito:** `ano` (padrão `datetime.today().year()`) passa a sair na capa e na folha de rosto mesmo sem ser repetido nelas.

###### R7b-10 · edição
- `_livro-edicao`: número ≤ 1 ou `none` ou texto vazio não imprime; número > 1 sai `2ª edição`; texto vai como foi dado (`"2ª edição, revista e ampliada"`). **Verificado:** `e1` (`edicao: 1` não imprime), `e3`.

###### R7b-11 · ISBN
- Quarta capa: `ISBN …` só se houver ISBN (`display-isbn` de `core/identifiers.typ`: acrescenta o prefixo, não valida nem dá erro); lista de ISBN: um por linha. Verso da folha de rosto: novo parâmetro `isbn` (padrão: o de `livro()`), impresso depois dos créditos. **Verificado:** `e3`, exemplo. **Não feito:** forma do produto (ISO 2108, 6.4) e ISBN por volume.

###### R7b-12 · autor múltiplo e "(org.)"
- `_livro-nome`: `autor` aceita texto, conteúdo ou lista de nomes (um por linha); no texto, a indicação final entre parênteses não vai para caixa alta (`"Ana Lima (org.)"` → `ANA LIMA (org.)`). **Verificado:** `e2` (lista de dois nomes: não dá mais erro), capa e rosto.

###### R7b-13 · sumário e títulos de elementos
- `_livro-titulo`: SUMÁRIO, LISTA DE …, AGRADECIMENTOS e ERRATA em 14 pt negrito centralizado, com os mesmos vãos dos títulos primários. As entradas do sumário usam `_abnt-outline-rules` de `elements/toc.typ` (importada com esse nome; confirmado por grep que existe): nível 1 em MAIÚSCULAS e negrito, 2 em MAIÚSCULAS, 3 negrito, 4 normal, indicativos alinhados à esquerda, `indent: 0pt`. **Verificado:** imagem do sumário.
- **Também corrigido (não estava na lista):** os títulos de nível 1 do livro sem número (PREFÁCIO, REFERÊNCIAS, GLOSSÁRIO, APÊNDICE, ANEXO, ÍNDICE) saíam à esquerda porque a regra de título do `livro()` sobrepõe a do setup; agora saem centralizados (R1-04) e o título numerado usa `_abnt-titulo` (2ª linha sob a 1ª letra, R1-13). Importa `_abnt-titulo` de `setup.typ`.

###### R7b-15 · equações
- `livro()`: `set math.equation(numbering: "(1)")` (`$ … $` sai numerado sem `book-equation`) e `show ref` que troca `@e1` de equação por `(1)`. **Verificado:** `ref2` ("a equação (1) e a (2)"), imagem do exemplo (números à direita). Equação longa que passa da margem continua sem quebra (limite do Typst).

###### R7b-17 · Fonte nas tabelas do exemplo
- As três tabelas do exemplo passaram a `container(tipo: "tabela", legenda:, fonte:)` (Fonte à esquerda, imagem); a Tabela 3 (ASCII) agora segue o estilo IBGE (filetes, sem grade).

###### R7b-18 · índice remissivo ligado ao `idx()` — **feito, com uma sobra visual**
- `book-index()` sem entradas monta o índice pelos `idx()` do texto (usa `indice()` de `elements/index.typ`, com entrelinha simples); com entradas continua manual. O exemplo usa `#idx(…)` em 5 pontos (não inventa mais páginas).
- **Sobra:** `indice(titulo: "")` imprime um título vazio e o vão antes das entradas fica ~38 pt maior que nos outros elementos; e `indice()` termina com `pagebreak()` (não fraco), então um livro que termine no índice ganha uma página em branco no fim. Correção certa: `indice(titulo: none)` pular o título e usar `pagebreak(weak: true)` (arquivo `elements/index.typ`, não é meu). **NÃO CORRIGIDO** nesses dois pontos.

##### P3

- **R7b-19 (ímpar só onde a norma exige):** ímpar em frente-verso: falsa folha, folha de rosto, errata, dedicatória, agradecimentos, epígrafe, sumário, prefácio/apresentação, posfácio, glossário, capítulos e partes (`parte()`: regra do setup repetida no livro com a branca marcada). Referências, apêndice, anexo e índice só quebram a página (`heading` sem número não chama `_abre-impar`; as funções de prefácio, posfácio e glossário chamam por conta própria). Verificado no `ex-fv1`: referências na pág. 28 (par), glossário na 29. **Não feito:** prefácios seguidos sem branca no meio (4.2.2.1, "sequenciais").
- **R7b-20:** docstrings de `book-appendix`/`book-annex` dizem que `letra: none` dá "APÊNDICE – TÍTULO". Apêndice e anexo passaram a ter `supplement` (`Apêndice A`, `Anexo`) e o parâmetro `rotulo: "ap"` (o `<rótulo>` depois da chamada continua dando `cannot reference sequence`); `@ap` sai "Apêndice A" e é link (`ref2`).
- **R7b-21:** capa e folha de rosto com `justify: false` e `hyphenate: false` (`e1`, imagem: título de 3 linhas centralizado, sem esticar nem hifenizar).
- **R7b-22:** `volume: "Tomo 3"` sai `Tomo 3`; número ou algarismos/romanos sem palavra saem `Volume N` (`e3`).
- **R7b-23:** lista de siglas e de símbolos em duas colunas alinhadas, definição com recuo deslocado (`par(hanging-indent:)` com a largura da maior sigla + 1 em); `book-list-abbreviations(())` aceita vazio (e lista de pares). **Verificado:** `lst` (imagem).
- **R7b-24:** CRB fora da moldura da ficha (abaixo dela, centralizado); aviso de copyright: ver R4b-03 (agora imprime com um campo só) e a docstring. `titulo-original` continua imprimindo sempre "Título original:" (**não mudei**).
- **R7b-25:** o exemplo não usa mais `#set par(hanging-indent: …)` (Decisão #4); as referências ficam alinhadas à esquerda, em espaço simples, isoladas em `#[ … ]`, separadas por linha em branco. O exemplo agora demonstra errata, série, anexo, posfácio, lista de quadros, equações com `@`, `idx()`, rótulo de apêndice; frente-verso fica documentado no cabeçalho do exemplo (basta acrescentar `frente-verso: true`; `testes-4B-livro/ex-fv1.typ` é a versão em frente-verso). **Não demonstra:** `book-presentation`, `book-list-symbols` (testada em `lst`/`man1`), `parte()`.
- **R7b-26 / R7b-27:** só anotados para a Etapa 6 (abaixo).
- **`0.65`:** `grep -n 0.65 src/templates/book.typ examples/livro-exemplo.typ` vazio (o verso usa `set par(leading: abnt-leading(1), spacing: abnt-leading(1))`).

##### Arquivos alterados (relativos ao pacote)
- `src/templates/book.typ` (reescrito em boa parte)
- `examples/livro-exemplo.typ`
- Novos: `docs/revisao/testes-4B-livro/` — `b1→conv-fv.typ`, `conv-fv2.typ`, `e1.typ`, `e2.typ`, `e3.typ`, `eq.typ`, `ex-fv0.typ`, `ex-fv1.typ` (exemplo sem e com frente-verso), `fim1..5.typ`, `fv-sum.typ`, `ilus.typ`, `logo.typ`, `lst.typ`, `man1.typ`, `man2.typ`, `num1.typ`, `par1.typ`, `pg-nenhuma.typ`, `pg-todas.typ`, `ref2.typ`, `verso-long.typ` (os do 7b com caminho `/lib.typ`, mais `conv-fv*`, `ilus` e `ref2` refeitos).
- `src/core/spacing.typ` **não é meu**: no original ele mudou (linha 92, `nature-block`) depois que copiei o pacote; meu `pkg` ainda tem a versão antiga.

##### Mudanças de SAÍDA VISÍVEL (nota da 0.7.0)
- Livro: cabeçalho só nos elementos textuais, alternando par/ímpar pela folha física em frente-verso (sem frente-verso, sempre à direita); sem cabeçalho e número em brancas, guardas e quarta capa.
- Epígrafe: referência em nota de rodapé (antes `(Autor)` ao lado).
- `©` no lugar de `(c)`; subtítulo com `:` colado ao título; título longo da capa/folha de rosto sem justificar nem hifenizar; edição 1 não impressa; `ano` agora sai na capa e na folha de rosto por padrão.
- SUMÁRIO, listas e agradecimentos em 14 pt; entradas do sumário em MAIÚSCULAS/negrito por nível; títulos sem número centralizados; sumário em página ímpar (frente-verso).
- Listas vazias não são impressas; lista de quadros; listas com travessão (`Tabela 1 – …`); siglas e símbolos em colunas.
- Quarta capa vai ao fim (par, em frente-verso); sem branca no fim do documento; colofão em folha própria.
- Seções dentro de apêndice/anexo sem número (já da Etapa 1); `@ap` sai "Apêndice A".
- Equações em bloco numeradas por padrão; `@e1` sai `(1)`.
- Exemplo: 25 → 28 páginas. Contas de elementos: +1 verso da falsa folha (série), +1 errata, +1 lista de quadros, +1 posfácio, +1 anexo, −1 lista de ilustrações vazia (não sai mais), −1 índice e colofão (o índice agora ocupa 1 página e o colofão a seguinte, mas não há mais a página em branco do `pagebreak()` final); o resto (equações, quadro, notas "Fonte" nas tabelas, referências em espaço simples) mexe na quebra dos capítulos e foi conferido só por imagem, sem uma conta página a página. Em frente-verso: 36 páginas (8 brancas, sem cabeçalho nem número).

##### Quebras de API / uso
- Funções do livro não terminam mais em `pagebreak()` (quem contava com isso para separar conteúdo avulso precisa de `pagebreak(weak: true)`).
- `book-epigraph(citacao, autor)`: `autor` vai para nota de rodapé por padrão (`em-nota: false` volta ao antigo).
- `book-index`: `entries` pode ir posicional (como antes) ou nomeado; sem argumento usa `idx()`.
- `book-cover`/`book-title-page`/`half-title-page`/…: parâmetros agora `auto` (herdam de `livro()`); `half-title-page(titulo: "")` antigo continua valendo.
- `book-back-cover`: `isbn` herda de `livro()`; vazio não imprime "ISBN".
- `book-list-illustrations` ganhou `tipo` e `titulo`; `book-list-quadros`, `book-errata`, `book-guarda` são novas (nomes não colidem com `lib.typ`; só os do livro foram verificados em `lib.typ`).
- `cabecalho` aceita dicionário.

##### Código morto notado
- `book-presentation` só repassa a `book-preface`; `book-equation` ficou redundante (mantida); `book-start-numbering` é função vazia (já era). `_frente-verso` e `abre-anverso` (page.typ) são dois estados de frente-verso paralelos (o do livro e o de `normas-abnt`).

##### Pendências
- **Etapa 6 (documentação):** manual 1576 (`entries:`); manual 1475-1485 (`subtitulo`, `editora`, `local`, `ano`, `edicao`, `volume`, `isbn` agora valem em `livro()`); README 178 e manual 2172 (lista de elementos em ímpar: acrescentar sumário, errata, posfácio, glossário e partes; tirar nada); guia rápido 162-165 (no livro o número é centralizado); ISBN e `book-index()`; `book-errata`, `book-guarda`, `book-list-quadros`, `serie`, `licenca`, `rotulo`, `cabecalho` em dicionário, `em-nota`; numeração por tipo de ilustração (R7b-16); limitação da quebra de equação longa (R7b-15); R7b-26 e R7b-27 (livro eletrônico: ISBN da versão digital, localizador, telas distintas) só anotados.
- **Etapa 7:** `indice(titulo: none)` e `pagebreak(weak: true)` em `elements/index.typ` (R7b-18); `book-title-page-verso` ainda imprime "Título original:" sempre (R7b-24); o mecanismo `fim/ini` poderia servir ao TCC/relatório se eles passarem a ter cabeçalho nas brancas.
- **Não corrigido:** sobrecapa e orelhas (R4b-04); prefácios seguidos sem branca (R7b-19); validação do ISBN e forma do produto (R7b-11); quebra de equação longa (limite do Typst).

### Relatório do agente C (na íntegra)

#### Etapa 4 — agente C: relatório técnico (NBR 10719) e pôster (NBR 15437)

Cópia de trabalho: `$SP/C/pkg`. Compilado em Typst 0.14.1, 0.13.0 e 0.15.1. Imagens conferidas com `pdftoppm` + montagem (`$SP/C/out/*.png`). PDFs finais dos dois exemplos: `$SP/C/out/relatorio-exemplo-final.pdf` e `poster-exemplo-final.pdf`.

##### Relatório técnico (`src/templates/technical-report.typ`, `examples/relatorio-exemplo.typ`)

###### R7c-06 = R4b-07 · contagem de páginas a partir da folha de rosto
- **Onde:** `technical-report.typ`, `report-cover` (tirei `marcar-folha-rosto()`) e `report-title-page` (agora chama `marcar-folha-rosto()`).
- **Antes:** capa = folha 1; Introdução do exemplo numerada 8. **Depois:** Introdução numerada **7** (capa p. 1, rosto p. 2 = folha 1, sumário p. 7 do PDF, Introdução p. 8 do PDF).
- **Verificado:** exemplo (imagem do sumário e da p. 8); `c02-semcapa` (sem capa: rosto = 1, Introdução = 3 na 3ª página); `c01-fv` (frente-verso com capa); `c06-erros` (capa + rosto + errata: Introdução = 3).

###### R7c-05 · frente-verso: pré-textuais no anverso, CIP no verso da folha de rosto
- **Onde:** `relatorio()` grava `abnt-frente-verso.update(frente-verso)` (como `normas-abnt` do TCC); `report-title-page`, `errata`, `agradecimentos-relatorio`, `resumo-relatorio` começam com `abre-anverso()`. `report-title-page-verso` não chama (é o verso).
- **Verificado (`c01-fv.typ`, 17 págs., imagem):** capa p. 1, verso em branco p. 2, folha de rosto p. 3, verso (equipe + ficha) p. 4, errata p. 5, agradecimentos p. 7, resumo p. 9, sumário p. 11, Introdução p. 13 (numerada 11, à direita), seções seguintes em página ímpar. Funciona também sem capa (paridade lógica = física, pois o deslocamento é sempre par). `sumario()` já usava `abre-anverso` (Etapa 2).
- **Limite:** a Introdução em página ímpar do PDF sai com número ímpar aqui (11); o efeito de inversão visto no TCC (R1-10) não aparece porque no relatório o verso da folha de rosto continua contado (a 10719 5.2 só manda contar a partir da folha de rosto).

###### R7c-03 · referências na posição certa
- **Onde:** nova `referencias-relatorio()` (marca a posição) + `_relatorio-bib` / `_relatorio-bib-marcada` (estados). `relatorio(arquivo-bibliografia:)` guarda o `.bib`; no fim do corpo, `context if not _relatorio-bib-marcada.final()` imprime as referências só se ninguém usou o marcador.
- **Antes:** referências sempre depois de anexo/índice. **Depois:** com `#referencias-relatorio()` antes do glossário/apêndice a ordem é a da 4.2.3; sem marcador, no fim (como antes).
- **Verificado:** exemplo (sumário e páginas: REFERÊNCIAS p. 15, APÊNDICE p. 16, FORMULÁRIO p. 17; a seção aparece no sumário); `c04-refs-fim` (sem marcador, fim); `c08-semmarcador` (erro claro: "informe arquivo-bibliografia…"). Igual nas 3 versões, sem aviso. Armadilha: `abnt-bibliography` dentro de `context` funciona nas 3 versões (citações `@chave` resolvem e a seção entra no sumário).
- **Caminho em string** (a "dica" antiga do exemplo): `relatorio()` agora aborta cedo com "use arquivo-bibliografia: read("…")" (`r13.typ`).

###### R7c-01 · parâmetros de `relatorio()` agora valem
- **Onde:** `relatorio()` grava no estado `_relatorio-dados` (titulo, subtitulo, numero-relatorio, codigo-relatorio, instituicao, endereco-instituicao, titulo-projeto, autores, classificacao, issn, local, ano, volume, titulo-volume, pagina-inicial); `report-cover` e `report-title-page` os usam como padrão (`_ou(valor, dados, chave)`). O valor da chamada prevalece, então documentos antigos que repetem os dados continuam iguais.
- **Verificado:** o exemplo passa os dados uma vez e chama `#report-cover()` e `#report-title-page()` sem argumentos (imagens das p. 1 e 2).
- **Obs.:** `ano` continua com padrão `datetime.today().year()` (agora a capa/rosto o imprimem se a chamada não der `ano`); `instituicao: ""` e `local: ""` valem "ausente".

###### R7c-02 · "Onde se lê" (acento) — código e docstring.
###### R7c-04 · exemplo com Referências
- `relatorio.with(arquivo-bibliografia: read("referencias.bib"))`, citações `#cite(<silva2023>, form: "prose")` e `<cormen2012>`, `#referencias-relatorio()` antes do apêndice. Verificado (p. 15 do exemplo).

###### DECISOES #3 · `espacamento: "simples"` padrão
- **Onde:** `relatorio()`, depois de `with-abnt-setup`: `set par(leading: abnt-leading(k), spacing: abnt-leading(k))`, `k` = 1 ou 1,5; valor inválido aborta com mensagem.
- **Verificado:** `c03-espaco.typ` com `--input e=simples|1,5`: passo de linha 13,80 pt e 20,70 pt (`pdftotext -bbox-layout`). O resumo herda o espaçamento do documento (tirei o `leading` próprio de `resumo-relatorio`).

###### `0.65` migrados
- `report-title-page-verso` (caixa do CIP: `abnt-leading(1)`) e `resumo-relatorio` (herda). `grep -n 0.65` nos 4 arquivos: vazio.

###### R4b-09 · formulário de identificação (Anexo A) e R7c-15
- **Onde:** `formulario-identificacao`: agora um **quadro** (tabela de 12 colunas, rótulo pequeno sobre valor) na ordem do Anexo A, com os campos que faltavam: `titulo-projeto`, `numero-projeto`, `numero-classificacao`, `tiragem`, `instituicao-executora`, `instituicao-patrocinadora` (cada uma com o endereço no mesmo campo), `subtitulo`. `instituicoes` (lista antiga) vale como executora; `distribuicao` virou campo extra ao lado do distribuidor. Palavras-chave com "; " e ponto final. Verificado em imagem (p. 18 do exemplo).
- Sem nenhum campo, a função não imprime nada (R7c-12).

###### R7c-07 · subtítulo da capa com ":" colado — `report-cover` e `report-title-page` imprimem `TÍTULO: subtítulo` na mesma linha. Verificado (p. 1 e 2).
###### R7c-08 · ISSN — formatado com `format-issn` (`core/identifiers.typ`): `12345679` → `ISSN 1234-5679` (`c06`). **Não validei** (`validate-issn` não é chamada: não há como avisar sem abortar a compilação).
###### R7c-09 · docstrings: verso e formulário dizem que um dos dois (CIP ou formulário) é obrigatório (10719 4.2.1.1.2 b e 4.2.3.6). Sem verificação em código (não dá aviso sem abortar).
###### R7c-10 · volumes: `titulo-volume` (impresso sob "Volume N") e `pagina-inicial` (continua a numeração; `c05-vol2`: rosto 121, sumário 122, Introdução 123). Também aceitos em `relatorio()`.
###### R7c-11 · equações: `set math.equation(numbering: "(1)")` dentro de `relatorio()` (`c05`: "(1)"); para desligar, `#set math.equation(numbering: none)` no documento (documentado na docstring).
###### R7c-12 · páginas em branco e elementos vazios
- Todos os `pagebreak()` finais viraram `pagebreak(weak: true)`; o exemplo perdeu a 19ª página em branco (19 → 18). `errata()` sem itens, `report-title-page-verso()` sem dados e `formulario-identificacao()` vazio não imprimem nada (`c06-erros`: 4 páginas = capa, rosto, errata, Introdução).
- **NÃO CORRIGIDO:** `lista-tabelas()`/`lista-ilustracoes()` sem itens ainda imprimem o título (`src/elements/toc.typ`, funções `lista-*`; mesmo defeito de R4b-06).
###### R7c-13 · chaves e tipos
- `autores` aceita string/dicionário único; `name`/`nome`, `qualification`/`qualificacao`; `volume`, `numero-relatorio`, `ano` em conteúdo; `errata` aceita `pagina` ou `folha` e dá mensagem com o item (`r15.typ`: "errata: falta a chave "pagina" em …"); equipe técnica sem `funcao` imprime só o nome; `resumo-relatorio(palavras-chave:)` aceita string. `c06-erros` compila com `(nome:, qualificacao:)`, `volume: [II]`, `numero-relatorio: [7/2026]`.
###### R7c-14 · `report-code`: devolve texto (não conteúdo), sem separadores soltos quando os campos estão vazios, `sequencia` string ou inteiro (`"7"` → `007`), `sequencia: none` omite. `c07-code`: `report-code()` → `001`; `INPE-RPE-2024-EST-001`; `assunto: ""` → `INPE-RPE-2024-007`. O exemplo usa a função.
###### R7c-15 · verso sem recuo na 1ª linha (`first-line-indent: 0pt`), ficha em caixa com texto à esquerda (antes saía centralizado), sem recuo duplo. Formulário: ver R4b-09.
###### R7c-17 · exemplo
- `apendice("A", …)` (en dash, no sumário "APÊNDICE A – …"); "45 p." trocado por `context counter(page).final().first()` (17) na ficha, na errata e no formulário; errata corrige trechos que **existem** no texto (folha 10 linha 29; folha 11 linha 25; conferidos com Times New Roman — com outra fonte a paginação muda); `nota-tabela` após a tabela; uma figura (`placeholder.svg`) com `fonte`; `report-code` e `referencias-relatorio` demonstrados; lista "Elementos demonstrados" atualizada.
###### Palavras-chave do resumo/formulário: "a; b; c." (`resumo-relatorio`, formulário).

###### NÃO CORRIGIDO no relatório
- **R7c-16** lista de abreviaturas × siglas separadas: `lista-siglas` está em `src/elements/toc.typ` (não é meu).
- **R7c-12 (parte)** `lista-tabelas()` vazia: idem, `toc.typ`.
- **R7c-08 (parte)** não valida o dígito do ISSN (só formata).
- 5.6 (siglas na 1ª menção): sem apoio (P3, fora da lista).

##### Pôster (`src/templates/poster.typ`, `examples/poster-exemplo.typ`)

Refatoração: `poster()` e `academic-poster()` passaram a usar auxiliares comuns (`_poster-base`, `_poster-cabecalho`, `_poster-autores`, `_poster-resumo`, `_poster-colunas`, `_poster-logo`), para os achados valerem nos dois sem duplicar.

###### R7c-19 · colunas equilibradas
- **Onde:** `_poster-colunas`. O Typst (nas 3 versões) não equilibra colunas: enche a 1ª até o fim da página. Agora: `layout` + `measure` do conteúdo à largura de uma coluna; `block(height: H1/n + 4 linhas, breakable: false)` com `columns` dentro; as seções (blocos quebráveis) partem entre colunas. Se o conteúdo não cabe na página, volta ao enchimento normal (2ª página, nada some). Parâmetro novo `equilibrar-colunas: true`; com `false` valem as colunas antigas e `colbreak()` manual.
- **Verificado:** `p01`, `p03`, `p03b` (4 seções curtas: antes todas na 1ª coluna; agora 3 colunas parecidas), `p04b` (4 colunas), `p05` (seção de 2.500 palavras: 2.565 palavras no PDF, 2 páginas), exemplo (1 página, 3 colunas; a 3ª fica um pouco mais curta, pela folga).
- **Limite honesto:** a altura é heurística (folga de 4 linhas). Com itens que não partem (imagem alta) a coluna pode estourar e o excesso sai por baixo do bloco, sobrepondo o que vem depois (testei só com texto: a folga foi suficiente; forcei folga negativa e o excesso aparece sobreposto, sem perda de texto). Nesses casos use `equilibrar-colunas: false` + `colbreak()`.

###### R7c-20 e R7c-29 · afiliação e numeração por instituição
- `_poster-autores` (os dois templates): cada instituição distinta recebe um número na ordem em que aparece; o autor leva o número da sua; a lista das afiliações vem abaixo. Autor sem afiliação fica sem número. Aceita `affiliation` ou `afiliacao`. Verificado em `p01`, `p02`, `p07` (10 autores) e no exemplo ("¹Universidade Federal de Exemplo").

###### R7c-22 · cabeçalho e subtítulo (resolve R4b-12)
- Título e autores centralizados, `justify: false` e `hyphenate: false`; sem a linha em branco/`linebreak()` que abria parágrafo novo. Título leva ":" e o subtítulo vem na linha seguinte, menor (`TÍTULO:` / subtítulo). Vão título–subtítulo normal. Verificado (`p06`, `p07`, exemplo).

###### R4b-10 · `poster-a1`: troquei por **60 × 90 cm** (título 56 pt, corpo 22 pt), dentro da 5.2; docstring explica que o A1 ISO (59,4 × 84,1) fica abaixo. `pdfinfo` de `p11`: 1700,79 × 2551,18 pt = 60 × 90 cm, 1 página. A função mantém o nome (quebra de uso: o tamanho muda).
###### R4b-11 · palavras-chave com ponto final (`Palavras-chave: a; b; c.`). A contagem de 100 palavras só está na docstring (`p14` com 160 palavras compila).
###### R7c-21 · docstring de `poster()`: conteúdo além da altura vira 2ª página, sem aviso.
###### R7c-23 · fundo escuro
- `cor-texto` (padrão preto) em `poster()`/`academic-poster()`; a caixa do resumo e `poster-highlight` (fundo claro) forçam texto preto; o título da seção usa branco ou preto conforme a luminância da cor (`_poster-contraste`: `#ffd400` → preto). Verificado em `p09` (fundo `#1b1b1b`, `cor-texto: white`, destaque amarelo).
###### R7c-24 · pisos de fonte
- Afiliação, departamento, contato, referências e fonte da figura nunca abaixo de **20 pt** (`_poster-piso`). Medido com `pdftotext -bbox` (altura da linha, antes → depois): contato 15,8 → 18,8; referências 18,0 → 18,8; departamento 18,0 → 20,3.
###### R7c-25 · `poster-figure` e tabelas
- `poster-figure` usa `figure(caption:)` com `set figure.caption(position: top, separator: [ – ])`: "Tabela 1 – …" / "Figura 1 – …" em cima (o tipo vem do conteúdo), `origem` ("Fonte: …") embaixo, no piso de 20 pt. O exemplo tem as duas tabelas sem verticais (3 traços horizontais), com título e fonte. `origem` continua opcional (docstring: a norma a exige).
###### R7c-26 · logotipo
- `logo` (esquerda) e novo `logo-direita`; um só logo sai uma vez, com um espaço invisível (`hide`) do outro lado para o título ficar centralizado; tamanho máximo `largura-logo`/`altura-logo` (10 × 6 cm; reduz com `scale`, mantém a proporção); sem logotipo, o cabeçalho é o de `poster()` (sem as 3 linhas de grade e o centímetro extra). Verificado em `p15a` (PNG 600 × 300), `p15b` (3000 × 2000: antes esmagava o título), `p02`, `p03`/`p03b` (sem logo, mesma altura de cabeçalho).
###### R7c-27 · `titulo` vazio aborta com "informe o titulo (NBR 15437 4.1…)" (`p08.typ` é o teste do erro esperado); `autores` e `palavras-chave` aceitam string única (`p12`, `p13`). **Autores continuam opcionais** (R8a-06, `autores: ()` compila): a docstring diz que a norma os exige, mas não aborto.
###### R7c-28 · `cor-destaque` herdada: estado `_poster-cor`; `poster-section`/`poster-highlight` com `cor-destaque: auto` (o exemplo não repete mais a cor). `poster-references` sem justificar, sem hifenizar e **sem recuo francês** (DECISOES #4). Docstring de `academic-poster` escrita; `poster-a0`/`poster-a1` documentam que repassam só os parâmetros listados. **Não feito:** `largura`/`altura`/`fundo` etc. em `poster-a0`/`poster-a1` e versões acadêmicas; campos de cidade/estado/data (seguem em `contato`); aviso de `footnote` no pôster.
###### R7c-30 · o exemplo é um só documento (`academic-poster`): documentei os outros formatos em comentário; só `poster-a1` (60 × 90) foi compilado e medido (`p11`); `poster-a0` não foi testado nesta rodada (a função só passou a herdar as mudanças de `poster()`). Figura de imagem: o exemplo usa tabelas (sem imagem); `p10` testa `poster-figure` com imagem.
###### R7c-18 (já feito, confirmado) e R8a-06 (idem): seção longa continua correndo pelas colunas (`p05`).

##### Aceitação
- `relatorio-exemplo`: 19 → **18 páginas**, Introdução numerada 7, espaço simples; imagens conferidas (capa, folha de rosto, verso, errata, sumário, p. 8, apêndice, formulário). `poster-exemplo`: 1 página, colunas equilibradas, imagem conferida.
- Matriz (`$SP/matrix.sh $PKG $SP/C/matriz`): 39 de 39 com rc=0 e avisos=0; páginas iguais nas 3 versões em todos os arquivos; contra a linha de base só mudou `relatorio-exemplo` (19 → 18, página em branco final removida). Os testes novos (`c01`–`c07`, `p*` exceto `p08` que erra de propósito, `r*` salvo `r13`/`r15` que testam erro) compilam sem aviso nos 3 binários; `c08-semmarcador` e `p08`, `r13`, `r15` erram de propósito (mensagens claras).
- Observação: o `src/core/spacing.typ` do pacote original mudou depois da minha cópia (não é meu; não toquei).

##### Arquivos alterados (relativos ao pacote)
- `src/templates/technical-report.typ`
- `src/templates/poster.typ`
- `examples/relatorio-exemplo.typ`
- `examples/poster-exemplo.typ`

##### Arquivos de teste novos (`docs/revisao/testes-4C/`)
`c01-fv.typ`, `c02-semcapa.typ`, `c03-espaco.typ` (`--input e=simples|1,5`), `c04-refs-fim.typ`, `c05-vol2.typ`, `c06-erros.typ`, `c07-code.typ`, `c08-semmarcador.typ` (erra de propósito), `referencias.bib` (cópia); e as cópias de `testes-7c` com o import `/lib.typ` (`r01`–`r23`, `rc1`–`rc8`, `p01`–`p15b`, `fig.png`, `logo.png`; `r12` ajustado para `read("/examples/referencias.bib")`).

##### Mudanças de SAÍDA VISÍVEL (nota da 0.7.0)
- Relatório: espaçamento **simples** por padrão; numeração conta a partir da folha de rosto (Introdução do exemplo: 8 → 7); sem página em branco final; frente-verso com pré-textuais no anverso e CIP no verso da folha de rosto (mais páginas em branco); errata "Onde se lê"; subtítulo da capa na mesma linha; equações em bloco numeradas `(1)`; formulário em quadro com os campos do Anexo A; ficha (CIP) alinhada à esquerda; ISSN formatado; palavras-chave "a; b." ; referências no ponto de `referencias-relatorio()`.
- Pôster: colunas equilibradas; título/autores centralizados sem justificar; título com ":" e subtítulo na linha de baixo; afiliações numeradas por instituição (e agora aparecem no `academic-poster`); palavras-chave com ponto; textos secundários ≥ 20 pt; legenda de figura/tabela em cima com "Figura/Tabela N –"; referências sem recuo e sem justificar; `poster-a1` passa a 60 × 90 cm; logotipo uma vez e com tamanho máximo.

##### Quebras de API / uso
- `poster-a1`: 59,4 × 84,1 → 60 × 90 cm (e fonte 18 → 22 pt, título 48 → 56 pt).
- `academic-poster(logo:)` não duplica mais o logotipo à direita (usar `logo-direita:`).
- `poster-figure` agora é um `figure` numerado (legenda em cima, em texto normal e não em negrito); a legenda sem `origem` não imprime "Fonte".
- `poster()`/`academic-poster()` abortam com `titulo` vazio.
- `relatorio(arquivo-bibliografia: "caminho.bib")` (string) agora aborta cedo (antes, panic no fim). Resumo e formulário dão `;` + ponto final.
- `report-code()` devolve texto (não conteúdo).
- `errata()`, verso e formulário vazios não imprimem página.
- `report-cover()` não marca mais a folha de rosto; quem montava capa sem `report-title-page()` perde a contagem a partir dela.

##### Código morto / observações
- `formulario-identificacao(distribuicao:)` e `instituicoes:` ficaram só por compatibilidade.
- Nomes `_poster-*`, `_relatorio-*`, `_ou`, `_lista`, `_txt` saem pelo `import *` do `lib.typ` (sem privacidade em Typst); não colidem entre si (poster usa `_poster-lista`/`_poster-nome`).
- `with-abnt-headings`/`abnt-heading-setup` (headings.typ) continuam com a cópia antiga das regras (não meu).

##### Pendências para as Etapas 6 e 7
- Etapa 6 (documentação): README/USER_GUIDE: `referencias-relatorio()`, `espacamento`, `titulo-volume`/`pagina-inicial`, novos campos do formulário, `logo-direita`, `equilibrar-colunas`, `cor-texto`, `poster-a1` 60 × 90, `lista-*` vazias (toc.typ), comentário de `relatorio-exemplo` sobre a folha/linha da errata (Times New Roman).
- Etapa 7: conferir leitura real a 1 m do pôster (piso de 20 pt é critério de trabalho); testar `relatorio` com Arial (a errata do exemplo cita página/linha de Times).
- `src/elements/toc.typ`: `lista-tabelas()`/`lista-ilustracoes()` vazias (R7c-12) e lista de abreviaturas × siglas (R7c-16).

## Etapa 5 — slides (14/10/2026)

Arquivos alterados: `src/templates/slides.typ`, `examples/slides-simples-exemplo.typ`, `examples/slides-defesa-exemplo.typ`. 0 agentes. `touying` fica em 0.7.4 (DECISOES #1); `typst.toml` não tocado. Testes em `docs/revisao/testes-5/` (`t01` data e rodapé, `t02` capas, `t03` todos os auxiliares, `t04` bordas e notas do apresentador). Antes de cada correção reproduzi o defeito (erro com `data:` em texto, "05 de March de 2025", "Ana Souza2 / 3", capa em 2 e 3 páginas, auxiliares sem rodapé).

### Itens corrigidos
| ID | Onde | Antes → depois | Verificação |
|---|---|---|---|
| R7a-01 | `slides.typ` `_data-slide` | `data: "texto"` dava `type string has no method display` → aceita `datetime`, texto ou conteúdo (outro tipo: `assert` em português). O trecho da introdução (`data: "15 de março de 2026"`) passa a compilar. | `t01b-texto.typ` compila |
| R7a-02 | idem | "15 de March de 2025", "05 de …" → "5 de março de 2025", reaproveitando `format-date` de `core/dates.typ` | `pdftotext` de `t01a` e das capas dos dois exemplos |
| R7a-03 | `footer`/`footer-right` de `slides()` e `slides-defesa()` | `Ana Souza2 / 3` → `Ana Souza   2 / 3` (instituição à esquerda; autor e contador à direita, com `h(1em)`) | imagem do slide 2 de `t01a`; texto dos dois exemplos |
| R7a-04 | capas | capa em 2 páginas (3 com subtítulo e orientador; 4 com logo de 3 cm) → 1 página: tamanhos em pt, `par(spacing: 0.4em)` e o novo `_cabe` (bloco `1fr` + `layout`/`measure`/`scale`, só reduz se não couber) | `t02a/b/c`: 2, 3 e 3 páginas (capa + 1 slide [+ final]); imagens conferidas, inclusive logo + título de 2 linhas |
| R7a-07 | `slide-*` | passam pela função `slide` do tema (`_slide-aux`): ganham cabeçalho, rodapé e número; `titulo:` vira `==` de verdade (entra no índice do PDF); com `titulo: ""` vale o `==` anterior (o exemplo "Tipos de Aprendizado" tem título de novo); numeração sem saltos | `t03` antes/depois em imagem; 11 páginas nos dois, sem slide vazio |
| R7a-08 | `slide-*`, `slides()` | cada `slide-*` tinha `cor-primaria: rgb("#003366")` próprio → `cor-primaria: auto` lê `self.colors.primary` do tema; `cor-secundaria` agora chega ao tema (`config-colors(secondary:)`, antes `secondary:` era ignorado em silêncio) | `t03` com `cores-clean`: todos os slides na mesma cor |
| R7a-06 | `slide-citacao`, `slide-figura` | citação de 120 palavras saía cortada fora da página e a atribuição noutra; figura alta em 3 páginas → ambas se reduzem para caber (`_cabe`) | `t04`: 1 página cada, com título e rodapé (figura de 20 cm) |
| R7a-09 | rodapé, notas, `Fonte:`, `cores-*` | `gray` (2,32:1) → `luma(90)` (6,90:1), também no `neutral-light` do tema; 7 secundárias das `cores-*` escurecidas até ≥ 4,5:1 (usp `#996E11`, unesp `#996F09`, ufrj `#C95100`, ufmg e ufpe `#8A7400`, moderno `#D24537`, clean `#2A7BB1`); subtítulo de `slide-secao` na primária (sem `lighten(30%)`) | razões calculadas com a fórmula WCAG em Python (valores na tabela); as outras 6 já passavam |
| R7a-11 | tamanhos | docstring dizia 18–24 pt e o corpo é 25 pt → docstring corrigido; mínimos subidos a 16 pt (capa, banca, rótulos dos números 14→18, referências 14→16, `Fonte:` 12→16, notas 10→16); `slide-metodologia` em 20 pt para caber | imagens; rodapé do tema continua em 15 pt (decorativo) |
| R7a-12 | validação | `autor` aceita lista ("Ana, Bruno e Carla"); `orientador: none` não imprime mais "Orientador(a):" vazio (cada rótulo só se houver nome); `procedimentos/instrumentos: none` aceitos; `itens` do resultado numérico com par inválido → `assert` em português, valor `int` ou conteúdo aceito; `slide-citacao()` vazio → `assert`; docstring de `proporcao` ("L-A", `16-10` também) | `t04` e `t02` |
| R7a-14 | `slides`/`slides-defesa` | sem `..args` → `..config` repassado ao tema; docstring explica `config-common(show-notes-on-second-screen: right)` e que `#speaker-note` sozinha não aparece no PDF | `t04`: notas à direita |
| R7a-16, R5-04 | `slide-citacao`, `slide-figura`, `nota…`, `aviso-citacoes`, `slide-referencias` | `upper(autor)` e rótulos "Formatação conforme NBR 6023/10520" (falsos: o template não formata nada) → usa `citar` do pacote ("(Silva, 2020, p. 12)", inicial maiúscula); rótulo de `slide-referencias` removido; `aviso-citacoes` diz que a aplicação é do autor; docstring de `slide-citacao` diz que o destaque é adaptação para projeção e não o formato de citação longa (10520 7.1.1) | imagens de `t03` |
| R7a-17 | `slide-referencias` | `hanging-indent: 1em` removido (DECISOES #4); negrito das referências preto em vez de cor do tema | imagem |
| R7a-18 | docstrings | `coorientador` e o efeito de `programa` (rodapé "Dissertação/Tese" × "TCC") e do slide final documentados | leitura |
| R7a-20 | exemplos | português acentuado nos dois; `Precisao\@10` em string → `Precisão@10`; `#pause` antes de `==` removidos (subslides idênticos); `==` redundante antes de `slide-comparativo/resultado-numerico` com `titulo:` removidos; lista centralizada em caixa → `set align(left)`; cor do exemplo vinda de `cores-*` em vez de hex repetido; `Precisão` e rótulos "conforme NBR" fora | imagens dos dois |
| R7a-05 | exemplos | 4 páginas em branco e 3 de sobra sem título → nenhuma (simples 24→16 páginas; defesa 30→25; as páginas a mais que os 12/23 slides são os subslides de `#pause`). Docstring de `slides()` avisa que cada slide deve caber na página, inclusive o conteúdo oculto por `#pause` | montagens de todas as páginas; `pdftotext` sem página vazia |
| R7a-21 | `slide-sumario` | `set enum(…)` sem efeito removido (a função foi reescrita); as dez cópias de `touying-slide-wrapper` viraram um auxiliar | leitura |
| R7a-22 | docstring | "N / total" conta slides, não páginas; a capa é o slide 1 | documentado, comportamento não mudou |

### Verificação da etapa
- 12 exemplos + `testeCit.typ` × 0.14.1, 0.13.0 e 0.15.1: **39 de 39 com rc=0 e 0 avisos**; páginas iguais às da linha de base em 10 arquivos; só mudaram `slides-defesa-exemplo` 30→25 e `slides-simples-exemplo` 24→16, iguais nas três versões. O texto extraído difere entre versões só em espaçamento da fórmula e quebra de linha ("IA/ML"), não em conteúdo.
- Amostragem em imagem por mim: capas (3 variantes), os 11 slides auxiliares, bordas (citação longa, figura alta, notas do apresentador), todas as páginas dos dois exemplos regerados.

### O que NÃO foi corrigido (e por quê)
- **PDF/UA-1** (R7a-10, aceitação "se viável"): `--pdf-standard ua-1` continua reprovando os dois exemplos com "the first heading must be of level 1" (o touying usa `==` para slides). Testei emitir o título como `heading(depth: 1)` com `<touying:hidden>`: passa no UA-1, mas o tema mostra o último título de nível 1 no cabeçalho, e o título da apresentação aparece no topo de todos os slides (saída visível muda), e `titulo: ""` dá "heading title is empty". Revertido. Os títulos dos `slide-*` agora são `heading` (entram no índice); `slide-secao` e `slide-citacao` não têm título. `alt` em imagem/logo: só documentado (docstrings de `slides` e `slide-figura`).
- **R7a-13** (fonte Arial sem reserva): acrescentar "Liberation Sans" à pilha geraria 1 aviso novo em todo Mac nos dois exemplos, contra a regra desta etapa; fica documentado no docstring (`fonte: "Liberation Sans"` em Linux sem Arial).
- **R7a-06 (parte)**: `slide-sumario` (> ~6 itens), `slide-referencias` (> ~5), `slide-comparativo` e `slide-metodologia` com texto longo ainda estouram para outra página; não os envolvi em `_cabe` porque `layout` esconde `#pause` e `#only` do touying. Documentado nos docstrings.
- **R7a-15/22 (reexportação)**: `lib.typ` ainda expõe os ~55 nomes do touying; não mexi (arquivo fora da etapa). `slide-pause/only/uncover` continuam como aliases redundantes.
- **R7a-18 (parte)**: "Obrigado!" fixo no masculino e slide final sempre anexado em `slides-defesa`; rótulo "Defesa de TCC/Dissertação/Tese" ainda ligado a `programa`.
- **R7a-19**: documentação em README, introdução, guia rápido e manual (nenhuma função `slide-*` documentada; trecho com `import touying` desnecessário) → Etapa 6.
- **R7a-21 (parte)**: `=` (seção do tema) e `slide-secao` continuam dois estilos de divisor.
- Código morto notado, não apagado: os `import` de `citar-autor`, `citar-multiplos`, `citar-etal`, `citar-entidade`, `citar-titulo` em `slides.typ` só servem de reexportação.

### Mudanças de saída visível para a nota da 0.7.0
- Slides: data da capa em português ("20 de agosto de 2025"); rodapé com o contador separado do autor; capa sempre em 1 página; slides auxiliares com cabeçalho, rodapé, número e título de tamanho único; cor do tema em todos os slides; texto auxiliar mais escuro (contraste ≥ 4,5:1) e ≥ 16 pt; secundárias das `cores-*` mais escuras (7 delas); referências sem recuo francês; `slide-citacao` sem `upper` e sem a frase "segue NBR 10520"; `slide-metodologia` em 20 pt.
- Uso: `data:` aceita texto; `autor:` aceita lista; `slides(..config)` repassa configuração ao touying; `slide-*(cor-primaria:)` passa a ser `auto`; `titulo:` dos `slide-*` vira `==` (um `==` escrito antes com `titulo:` também preenchido mostra os dois).

## Backlog dos slides (anotado em 14/10/2026, depois da Etapa 5)
- **Cosméticos:** "Obrigado!" fixo no masculino; o slide final de `slides-defesa` não pode ser desligado; dois estilos de divisor de seção; item "1." do sumário/roteiro sem o mesmo destaque dos demais; "$15.7 tri" quebra em duas linhas no exemplo `slides-simples`.
- **Código morto, só mencionado:** os `import` de `citar-autor`, `citar-multiplos`, `citar-etal`, `citar-entidade` e `citar-titulo` em `slides.typ`, que servem só de reexportação; reexportação do touying em `lib.typ` (fora da etapa).
- **Não corrigido:** PDF/UA-1 (touying), reserva da fonte Arial (R7a-13) e estouro dos slides auxiliares (documentar na Etapa 6).

---

## Etapa 5b — o que sobrou do núcleo (14/10/2026)

Arquivos alterados: `src/elements/toc.typ`, `src/elements/index.typ`, `src/elements/spine.typ`, `src/core/setup.typ`, `src/text/headings.typ`, `src/text/figures.typ`, `src/text/tables.typ` e uma linha em `src/templates/book.typ` (`:943`, `indice(titulo: none)`). 0 agentes. Testes novos em `docs/revisao/testes-5b/` (15 arquivos; compilar com `typst compile --root <pacote> docs/revisao/testes-5b/<arquivo>.typ`; `h01` e `h02` aceitam `--input`, ver o cabeçalho de cada um). Antes de cada correção reproduzi o defeito. Nada comitado; `typst.toml` não foi tocado (o `git status` já o mostrava modificado antes da etapa, e a `CLAUDE.md`, os `README*` e `docs/introducao-abntyp.typ` também).

### R4b-06 · R7c-12 · listas vazias não saem
- **Onde:** `toc.typ:119` (`lista-ilustracoes`), `:146` (`lista-tabelas`), `:170` (`lista-quadros`), `:199` (`lista-siglas`), `:221` (`lista-simbolos`).
- **Antes:** cada função imprimia o título e uma página vazia (`l01a`: 7 páginas, 5 delas de lista sem item). **Depois:** `context if query(alvo).len() > 0 { … }`; as de dicionário saem com `if itens.len() == 0 { return }`. O `abre-anverso()` e o `pagebreak()` ficam dentro do `if` (nenhuma página em branco no frente-verso). `l01a`: 2 páginas.
- **Verificado:** `l01a` (vazias) e `l01b` (com itens, em imagem: o layout das listas com itens não mudou).
- **Nota:** a consulta é do documento inteiro; uma lista de figuras sai se houver figura **em qualquer lugar**, antes ou depois dela.

### R7c-16 · lista de abreviaturas × lista de siglas
- **Onde:** `toc.typ:194-204`. **Antes:** título fixo "LISTA DE ABREVIATURAS E SIGLAS". **Depois:** `lista-siglas(itens, titulo: …)`, mesmo padrão. Para duas listas (14724 4.2.1.7): `lista-siglas(titulo: "LISTA DE SIGLAS", …)` e `lista-siglas(titulo: "LISTA DE ABREVIATURAS", …)`. **Verificado:** `l01b`, em imagem.
- **Não feito:** 5.6 (sigla por extenso na primeira menção) continua sem apoio; ligar as listas ao glossário de abreviaturas (Etapa 3) é outra tarefa.

### R7b-18 (parte) · `indice()`: título vazio e quebra de página
- **Onde:** `index.typ:106-125` e `:290`; `book.typ:943`.
- **Antes:** `indice(titulo: "")` imprimia um título vazio e o vão (~38 pt a mais); o `pagebreak()` do fim não era fraco: o livro terminava com uma página em branco (`i02`: 3 páginas).
- **Depois:** `titulo: none` (e `""`) não imprime título nem vão; `pagebreak(weak: true)`; `book-index()` chama `indice(titulo: none)`. `i02`: 2 páginas; a primeira entrada ("A") passou de y = 172,4 para 140,6 pt. **Verificado:** `i02` em imagem, `pdftotext -bbox`.

### R4b-17 · R4b-18 (parte) · índice: agrupamento, sub-subtermo e nota
- **Onde:** `index.typ:26-61` (`idx`, `index-entry`: `subsubtermo:`), `:138-205` (agrupamento e ordem), `:204-222` (impressão).
- **Antes:** entradas agrupadas pela grafia exata: `Algoritmo` e `algoritmo`, `Álgebra` e `Algebra` saíam como entradas separadas (a ordem e a letra já vinham do `sort-key`/`sort-initial` da Etapa 3). Sem terceiro nível e sem nota explicativa.
- **Depois:** o agrupamento usa a chave de `sort-key` (sem caixa nem acento; sigla × palavra continuam distintas, como na ordenação); a entrada mostra a primeira grafia registrada. `idx(…, subsubtermo: …)` (recuo de 2em) e `indice(nota: …)` (nota explicativa antes das entradas, 6.3). As remissivas passam a casar pela mesma chave.
- **Verificado:** `i01` (`Álgebra, 1-2`, `algoritmo, 1`, terceiro nível, nota, remissiva), em imagem.
- **Não feito (R4b-18):** letras do canto da página (6.5), "continuação" em página ou coluna nova (6.8), indicativo de volume/parte (6.12 c).

### `glossario()` com `pagebreak()` interno
- **Onde:** `headings.typ:119-134`. **Antes:** `pagebreak()` fixo: dentro de `columns(2)` dava `error: pagebreaks are not allowed inside of containers` (`g01`). **Depois:** `glossario(itens, quebra: true)`; a quebra agora é fraca (não deixa página em branco no fim do documento) e `quebra: false` serve para colunas. O Typst recusa até a quebra fraca dentro de container, então o parâmetro é inevitável. **Verificado:** `g01` (3 páginas, a quebra só onde pedida).

### R8c-08 · título de seção sozinho no pé da página
- **Onde:** `setup.typ:22-26` (auxiliar `_titulo-sticky`) e `:123`, `:130`, `:137`, `:144`, `:151` (os cinco níveis).
- **Causa:** o `heading` nativo é `block(sticky: true)`, mas a regra do pacote o substitui por `v()` + texto, e perde a propriedade.
- **Antes:** `h01` (5 níveis × 26 alturas de enchimento): 107 páginas com título órfão em 402; nos exemplos, 5 (tcc p. 9, 15 e 17; projeto p. 9; artigo p. 2).
- **Depois:** o texto de cada título vai num `block(sticky: true)` com `above`/`below` = `par.spacing` avaliado a 12 pt (o `em` do espaço de parágrafo é o do corpo, não o do nível do título; com o padrão do `block`, 1,2em, os vãos mudavam). `h01`: **0 em 419**; nos exemplos: 0 nas 3 versões.
- **Vãos:** `h02-vaos` (cinco níveis, títulos seguidos, sem número) em espaço 1,5 e simples, antes × depois: **todas as linhas +0,0 pt**; `topo.typ`, `sub.typ` e `passo.typ` da Etapa 0 idênticos. Os `v()` ficam fora do bloco, então o espaço antes do título continua sumindo no topo da página (nível 1, fraco) e fica na página anterior quando o título desce.
- **Efeito na saída:** `tcc-exemplo` **19 → 20 páginas** (igual nas 3 versões): "5.4 TRABALHOS FUTUROS" desce para a p. 19 e "REFERÊNCIAS" abre a p. 20. Conferido em imagem (p. 9-10, antes × depois: "1.3 OBJETIVOS" sai do pé da p. 8 e abre a p. 9 junto de "1.3.1").

### R4b-14 · R4b-15 · lombada
- **Onde:** `spine.typ:29` (`_autores`), `:55` (`lombada`), `:182` (`lombada-preview`), `:268` (`spine-text-descending`), `:315` (`margem-capa`).
- **Antes:** `rotate(-90deg)` (lê de baixo para cima); `margem-capa(volume: 2)` com `- v. 2` virando item de lista (`•`); `spine-text-descending` devolvia texto horizontal; `lombada()` descendente era uma faixa horizontal de 29,7 × 2 cm (o usuário tinha de girar) e terminava com `pagebreak()` (2ª página em branco); sem `fasciculo`; só um autor; o logo caía dentro da caixa de 30 mm.
- **Depois:** `rotate(90deg)` em tudo (do alto para o pé, 4.1.2.2); `margem-capa` com `\- v.`; `spine-text-descending` devolve o texto girado (como a docstring dizia); `lombada()` é uma página **em retrato** (`largura-lombada` × `altura-lombada`; a descendente monta o layout na horizontal e gira 90°, com o autor no alto, o logo acima e os **30 mm em branco no pé**); sem o `pagebreak()` final; `fasciculo:` (sai "fasc. 3") nas quatro funções; `autor:` aceita lista (separada por "; " na descendente, um abaixo do outro na horizontal, 4.1.1).
- **Verificado:** `s01` a `s04` em imagem (`s04`: antes/lombada/depois = 3 páginas, nenhuma em branco).
- **MUDANÇA DE SAÍDA (nota da 0.7.0):** o PDF de `lombada()` passa de faixa horizontal (`altura × largura`) a retrato (`largura × altura`); `lombada(orientacao: "horizontal")` também troca as dimensões da página (antes `set page(width: altura, height: largura)`). Quem imprime a lombada não precisa mais girá-la.
- **Não feito:** `instituicao` continua entre os elementos (a norma lista só volume, fascículo e data; mantive por ser opcional e do usuário); a lombada não está ligada aos templates (C18); o "fasc." segue a abreviatura da NBR 6032 (se a 12225 usar "n.", trocar em `spine.typ`, três ocorrências).

### R4b-20 · `tabela()` com a moldura da IBGE; R4b-19 (resto) · continua/continuação/conclusão
- **Onde:** `tables.typ:15-17` (contador dos marcadores), `:44-113` (`tabela`).
- **Antes:** `tabela()` = `table(stroke: none, …)`: sem traço algum se o usuário não escrevesse `table.hline` (`t01`); sem repetição do cabeçalho; sem "continua".
- **Depois:** `tabela(moldura: true, continuacao: true, …)`. Sem `table.hline` do usuário: traço de topo (1,5 pt), traço abaixo do cabeçalho (0,75 pt) e de fecho (1,5 pt), e a primeira linha (ou o `table.header` que vier) vira cabeçalho repetido. Com `table.hline` do usuário, nada muda (os exemplos e o guia rápido continuam iguais). Tabela de mais de uma página recebe, abaixo do corpo e à direita, "(continua)", "(continuação)" e "(conclusão)"; **o traço de fecho só na última página** (ele é desenhado pelo rodapé repetido, só quando a página é a última). Tabela de uma página fecha normalmente e não recebe palavra.
- **Por que dá certo:** o `context` dentro de um rodapé repetido (`table.footer(repeat: true)`) vale **por página** nas três versões (testado em 0.13.0, 0.14.1 e 0.15.1); o início e o fim da tabela vêm de dois marcadores com um número por chamada.
- **Verificado:** `t01` (curta, com e sem traços escritos) e `t02` (40 linhas em 6 páginas e uma segunda tabela com `table.header` explícito), em imagem.
- **Limites:** o traço final **escrito pelo usuário** sai em todas as páginas (a função não sabe qual `hline` é o último); se o fim da tabela cair exatamente no pé da página, o marcador final pode ir para a página seguinte e a última página mostrar "(continuação)"; os parênteses em "(continua)" são convenção, a IBGE não os exige.

### R4b-21 · sinais convencionais
- **Onde:** `tables.typ:119` (`sinal-convencional`), `:138` (`nota-sinais`). **Antes:** `error: unknown variable` (Parte 9). **Depois:** `sinal-convencional("zero" | "nao-se-aplica" | "nao-disponivel" | "omitido" | "arredondado-positivo" | "arredondado-negativo", casas: 0..2)` devolve `-`, `..`, `...`, `X`, `0`/`0,0`/`0,00`, `-0`/`-0,0`/`-0,00` (IBGE 4.8.1, conferido na imagem da Parte 9); `nota-sinais(…)` monta a nota geral de 4.8.2 para os tipos usados. **Verificado:** `t03`.
- **Não feito:** chamadas numeradas em destaque (4.9), notas específicas na ordem das chamadas (4.12.2), e `quadro` (kind `"quadro"`) com as mesmas regras. As chamadas e as notas específicas ficam com o autor.

### R4a-05 · R1-15 · fonte obrigatória em `container()`
- **Onde:** `figures.typ:27-31` (docstring), `:40` (`fonte: auto`), `:49-54` (`assert`). **Antes:** `container(fonte: none)`, o padrão, era aceito sem aviso. **Depois:** `fonte` tem padrão `auto`; sem `fonte:` nem `origem:` o `container` aborta com `container(): informe a fonte (NBR 14724 5.8: obrigatória, mesmo em produção própria)…`; `fonte: none` dispensa de propósito; `origem:` continua valendo. O alinhamento à esquerda de "Fonte:" e "Nota:" já era da Etapa 2.
- **Verificado:** `f01` (com `fonte`, com `origem`, com `fonte: none` compilam; sem nenhum, o erro). Os 12 exemplos e o `guia-rapido.typ` já passam `fonte:` em todo `container` (só o `livro-exemplo` usa `container`).
- **MUDANÇA DE USO (nota da 0.7.0):** documentos que chamavam `container()` sem fonte passam a dar erro. Dizer na nota da versão.

### Não feito (opcionais do prompt)
- **R7b-11 (validação do ISBN) e sobrecapa/orelhas (6029):** ficaram de fora; mexem em `templates/book.typ`, que não é desta etapa. `validate-isbn` já existe em `core/identifiers.typ`.

### Verificação da etapa
- 12 exemplos + `testeCit.typ` × 0.14.1, 0.13.0 e 0.15.1: **39 de 39 com rc=0 e 0 avisos**; uma só contagem de páginas por arquivo nas três versões. Contra a linha de base desta sessão (matriz de antes da etapa): **só o `tcc-exemplo` mudou, 19 → 20** (R8c-08, ver acima); os outros 12 arquivos iguais (artigo 5, citação autor-data 2, numérica 3, inline 1, livro 28, periódico 18, pôster 1, projeto 18, relatório 18, slides 25 e 16, testeCit 4).
- Os 15 testes de `testes-5b/` compilam sem erro e sem aviso nas três versões, com a mesma contagem de páginas.
- Órfãos (`pdftotext` por página) nos seis exemplos de texto: 0 nas três versões.
- Aceitação da etapa (cada achado com teste em `testes-5b/` e a matriz sem aviso): **passou**.
- Scripts de apoio (scratchpad, fora do pacote): `matrix.sh`, `orfaos.sh`, `orfaos-h01.sh`.

### Quebras de API e mudanças de saída da Etapa 5b (para a nota da 0.7.0)
18. **`container()` exige a fonte** (`fonte:` ou `origem:`; `fonte: none` dispensa).
19. **`lombada()` em retrato** (largura × altura), descendente girada; `fasciculo:` novo; `autor:` aceita lista; `spine-text-descending()` devolve texto girado.
20. **Listas vazias não saem** (`lista-ilustracoes/tabelas/quadros/siglas/simbolos`); `lista-siglas(titulo:)`.
21. **`tabela()`** desenha a moldura IBGE e repete o cabeçalho quando o usuário não escreve `table.hline`; marcas "continua/continuação/conclusão" em tabela de várias páginas.
22. **Títulos de seção não ficam sozinhos no pé da página** (muda a paginação: `tcc-exemplo` 19 → 20).
23. **`indice(titulo: none)`**, `nota:`, `idx(subsubtermo:)`; entradas que diferem só por caixa ou acento viram uma; `glossario(quebra: false)` para colunas.

## Etapa 5c — livro e índice (14/10/2026)

Arquivos alterados: `src/templates/book.typ`, `src/elements/index.typ`, `src/text/tables.typ`. 0 agentes. Testes em `docs/revisao/testes-5c/` (compilar com `typst compile --root <pacote> docs/revisao/testes-5c/<arquivo>.typ`; `ix-canto.typ` aceita `--input canto=letras|entradas --input fv=0|1 --input numero=0|1`). Antes de cada correção reproduzi o defeito. Nada comitado; `typst.toml`, `CLAUDE.md`, `README*` e `docs/introducao-abntyp.typ` já vinham modificados (não são meus).

### R7b-11 · validação do ISBN no livro
- **Onde:** `book.typ:10` (importa `validate-isbn` e `validate-isbn10`), `:125-135` (`_livro-isbn`), `:208` (`livro()` valida na entrada).
- **Antes:** `isbn: "123"` e `"978-65-00000-00-8"` (dígito errado) saíam impressos sem erro (`isbn-curto`, `isbn-ruim`). **Depois:** texto que não é ISBN-13 (978/979, dígito certo) nem ISBN-10 válido aborta com `livro(): ISBN "…" inválido (NBR ISO 2108 …)`; conteúdo (`[em obtenção]`), lista, `none` e vazio continuam como eram. `livro(isbn:)` também valida, mesmo que nenhuma página o imprima (`isbn-livro`).
- **ISBN no verso da folha de rosto:** já estava feito na Etapa 4 (`book-title-page-verso(isbn: auto)`, `book.typ:642`); só ganhou a validação. **Verificado:** `isbn-ok` (ISBN-13, ISBN-10 com o 13 ao lado, lista, conteúdo, `none`), `isbn-ruim`, `isbn-curto`, `isbn-livro`, nas 3 versões.
- **Não feito:** forma do produto (ISO 2108, 6.4) e ISBN por volume. `isbn: [ISBN 978…]` (conteúdo) sai com o prefixo duplicado ("ISBN ISBN …"): comportamento antigo do ramo de conteúdo, não mexi.

### Sobrecapa e orelhas (6029, 4.1.1 e 4.1.5; opcionais)
- **Onde:** `book.typ:413` (`book-orelha`). **Feito:** `book-orelha(biografia:, comentario:, publico:, outros:, largura: 9cm)`, uma página estreita sem cabeçalho nem número, com o que a 4.1.5 recomenda. A sobrecapa é "primeira e quarta capas e orelhas" (4.1.1): não criei função própria, ela se compõe com `book-cover()`, `book-orelha()` e `book-back-cover()` (dito na docstring).
- **Verificado:** `orelha` (páginas de 255 × 842 e 198 × 842 pt, as demais A4; imagem). **Limite:** em frente-verso as orelhas contam como páginas físicas do PDF e deslocam a paridade (a falsa folha de rosto abriu na p. 5 com a p. 4 em branco); quem imprime as orelhas à parte não é afetado.

### Tabela · traço final escrito pelo usuário (IBGE 8.3)
- **Onde:** `tables.typ:29-33` (docstring), `:55-60` (`traco-final`), `:109`, e `:110` (a palavra só ocupa linha se existir).
- **Antes:** o último `table.hline` do usuário saía no pé de **todas** as páginas (`tab-fecho`, 5 páginas: traço grosso embaixo das páginas 1 a 4). **Depois:** o último item, se for `table.hline` e a tabela tiver o rodapé de "continua/conclusão", sai do corpo e é desenhado no rodapé só na última página (com a espessura que o usuário deu). A moldura automática (`fecho`) usa o mesmo caminho.
- **Efeito colateral evitado:** o rodapé acrescentava uma linha vazia de 10 pt abaixo do traço nas tabelas de uma página; agora a linha da palavra só existe quando há "(continua)/(continuação)/(conclusão)". **Verificado:** `tab-fecho` (5 páginas, imagem antes × depois), `tab-fecho-curta` (uma página, com e sem rodapé), `t01`, `t02` e `t03` da 5b iguais.
- **Não corrigido (observado):** com `table.hline` escrito pelo usuário e sem `table.header`, o `hline` inicial reaparece no alto das páginas seguintes, sem o cabeçalho (o cabeçalho só se repete com `table.header` ou com a moldura automática).

### R4b-18 · índice (NBR 6034)
- **6.12 c, volume:** `idx(…, volume:)` e `index-entry(…, volume:)` (`index.typ:36`, `:58`); `format-pages` (`:258`) agrupa por volume: `Idade Média, v. 2, 1-2; v. 3, 3`, `Clorofila, pt. 1, 2`; número vira "v. N", texto vai como foi dado. **Verificado:** `ix-volume`.
- **6.5, canto:** `indice(canto: "letras" | "entradas")` e `book-index(canto:)` (`index.typ:86` `_indice-canto`, `:125`, `:153`; `book.typ:970`). Desenhado com `set page(foreground:)`, que não substitui o cabeçalho nem o número da página; lado externo lido de `page.margin` (direita nas ímpares e à esquerda nas pares com `inside/outside`; sempre à direita sem frente-verso), a 2,4 cm do alto. Abre página nova (é um `set page`) e vale só para as páginas do índice. **Verificado:** `ix-canto` (letras sem frente-verso: "A", "B–E", "F–I"; entradas em frente-verso: p. 12 par à esquerda, p. 13 ímpar à direita, número no cabeçalho preservado), `ix-livro` (livro em frente-verso: layout igual ao índice sem `canto`, só com o canto a mais).
- **6.8, continuação:** o termo com as subentradas fica inteiro na coluna (`block(breakable: false)`); o que é mais alto que uma coluna começa coluna nova e é fatiado em partes do tamanho da coluna, cada uma (menos a 1ª) com o cabeçalho e, se for sub-subentrada, o subcabeçalho repetidos com "*(continuação)*" (`index.typ:301` `linhas-de`, `:340-390`). **Primeira tentativa descartada:** repetir o cabeçalho onde o Typst quebra a coluna (sondas de posição + `query`): cada cabeçalho empurra as quebras seguintes e o layout não converge em 5 passagens (`warning: layout did not converge`), mesmo com um só termo grande. A solução final não consulta posições. **Verificado:** `ix-base` (12 termos médios e 2 gigantes de 68 linhas, 21 páginas, 0 avisos nas 3 versões; imagem: letras junto do 1º termo, "(continuação)" no alto de todas as colunas dos gigantes).
- **Mudanças de aparência do índice:** (1) a letra da seção vai dentro do bloco do 1º termo (antes ficava sozinha no pé da coluna) e a letra da 2ª coluna alinha com a da 1ª (antes o balanceamento as deixava em alturas diferentes; `i01` comparado com o HEAD); (2) termos que cabem numa coluna não se partem mais entre colunas: o pé da coluna pode ficar mais vazio.
- **Limites:** o 1º termo do índice, se for gigante, começa na 1ª coluna da 1ª página, que tem o título acima: a 1ª parte pode passar da coluna e a sobra cai sem cabeçalho. O tamanho da coluna vem da altura da página menos as margens `top` e `bottom` (com margem `auto` usa o espaço que sobra). Termos dados como conteúdo (`idx([*x*])`) são ordenados e agrupados pelo `repr` (antigo; a letra sai "S" para `strong`): não mexi. Subentradas de um termo com `ver também` herdam o mesmo mecanismo.
- **Armadilha:** um `metadata` solto no começo de uma linha, depois de `linebreak()`, é posicionado no fim da linha anterior; só uma `box(width: 0pt)` ancora a sonda no início da linha. (Útil para qualquer outro código que meça posições em texto linha a linha.)

### Verificação da etapa
- 12 exemplos + `testeCit.typ` × 0.14.1, 0.13.0 e 0.15.1: **39 de 39 com rc=0 e 0 avisos**, páginas idênticas às da linha de base (`livro` 28, `tcc` 20, `periodico` 18, `projeto` 18, `relatorio` 18, `artigo` 5, `slides` 25 e 16, autor-data 2, numérica 3, inline 1, pôster 1, `testeCit` 4) e **o texto extraído (`pdftotext -layout`) de cada exemplo igual ao da base**: nenhum exemplo muda de saída.
- Os 13 testes de `testes-5c/` e os `i01`, `i02`, `t01`, `t02`, `t03`, `l01b` da 5b compilam nas 3 versões sem aviso e com a mesma contagem de páginas; os três ISBN inválidos e o `canto: "cima"` dão o erro esperado nas 3.
- Aceitação da etapa (um teste por item em `testes-5c/` e a matriz sem aviso): **passou**.
- Scripts de apoio (scratchpad, fora do pacote): `matrix.sh`, `tests3.sh`, `c.sh`, `mont.sh` (junta PNGs pelo próprio typst; a máquina não tem `montage` nem PIL).

### Quebras de API e mudanças de saída da Etapa 5c (para a nota da 0.7.0)
24. **ISBN inválido dá erro** em `livro()`, `book-title-page-verso()` e `book-back-cover()` quando é texto (ISBN-13 com 978/979 e dígito certo, ou ISBN-10 válido); conteúdo, lista e `none` passam. Quem usava um ISBN de exemplo (`"123"`, dígito errado) precisa trocar.
25. **`tabela()`**: o último `table.hline` escrito pelo usuário sai só na última página.
26. **Índice:** novos `idx(volume:)`, `index-entry(volume:)`, `indice(canto:)` e `book-index(canto:)`; o termo com as subentradas não se parte entre colunas (só os maiores que uma coluna, com "(continuação)"); a letra acompanha o 1º termo.
27. **`book-orelha()`** nova (orelhas, 4.1.5); a sobrecapa é a composição de `book-cover`, `book-orelha` e `book-back-cover`.

### Pendências (não feitas, com o motivo)
- Forma do produto e ISBN por volume (ISO 2108, 6.4); sobrecapa como função única (a norma só a define como a soma das três peças).
- Documentação das funções novas (`book-orelha`, `canto:`, `volume:`): Etapa 6.
- `hline` inicial repetido sem cabeçalho em tabela longa com traços do usuário (ver acima).
