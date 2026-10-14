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

## Quebras de API para a nota da 0.7.0 (resumo; detalhes nos itens indicados)
1. **`#sub[…]` → `#sublinhado[…]`** (R8b-06, Etapa 0): sem a troca o texto sai subscrito, sem erro.
2. **Funções `abnt-*-setup` e de numeração** (R1-02, Etapa 1b): `#abnt-page-setup(...)` e similares deixam de ser chamadas sem efeito e passam a dar erro de compilação; usar `#show: abnt-page-setup.with(...)`.
