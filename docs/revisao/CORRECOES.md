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
