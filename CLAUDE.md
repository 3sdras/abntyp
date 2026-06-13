# CLAUDE.md — ABNTyp

Instruções específicas deste repositório. Complementam o CLAUDE.md do diretório pai.

## ⚠️ Checklist ANTES de publicar no Typst Universe (ler sempre antes do push/PR)

O ponto que SEMPRE dá problema é o **README**. Não esquecer:

1. **README publicado = `README-typst.md` (versão enxuta, só uso) copiado COMO `README.md`** dentro de `packages/preview/abntyp/<versão>/`.
   - O `README.md` da raiz é o COMPLETO (para o GitHub) e tem "Estrutura de Arquivos" e "Contribuindo" → essas seções são info de dev e o mantenedor do Universe (@elegaanz) já pediu para NÃO publicá-las.
   - O `README-typst.md` precisa ter: 1 frase em **inglês** no topo (contexto p/ a comunidade Typst) + seções só de uso.
2. **Links de docs/exemplos no README devem ser versionados pela tag**: `https://github.com/3sdras/abntyp/blob/v<versão>/...`.
   - Criar e dar `git push` na tag `v<versão>` no repo abntyp ANTES (senão os links dão 404).
   - Conferir que os caminhos existem de verdade (ex.: o manual é `docs/manual-implementacao.typ`, NÃO `docs/manual.typ`).
3. **Bumpar as referências de versão** em README (raiz e -typst) e nos snippets: `@preview/abntyp:<versão>` e dependências (`@preview/touying:<última>`). O bot do typst.app acusa "older version of the package" para imports desatualizados E para dependências que não estejam na última versão.
4. **`typst.toml` NUNCA pode ter `[dependencies]`** (não é suportado pelo manifest do Universe; resolve pelos `#import "@preview/..."`).
5. **Arquivos do pacote**: `lib.typ`, `typst.toml`, `README.md`, `LICENSE`, `src/`. NÃO incluir `docs/`, `examples/`, `*.pdf`, `CREDITS.md`, `README-typst.md` (fonte), `testeCit.typ`, `_bncc.bib`, `.claude/`, `CLAUDE.md`.
6. **Validar a compilação a partir da pasta publicada** (instalar num namespace local e compilar um exemplo real, incl. um de slides) ANTES de abrir/atualizar o PR.
7. Mensagem do commit do PR: `abntyp:<versão>`. Base: `typst/packages` main atual. Fork: `3sdras/typst-packages`.

## Publicar SEM clonar o repo gigante (typst/packages)

- Sincronizar o fork: `gh api -X POST repos/3sdras/typst-packages/merge-upstream -f branch=main`.
- Criar blobs/tree/commit/ref via Git Data API (`base_tree` = tree do upstream main; `parent` = commit do upstream main); depois `gh pr create`.

## Instalação local para teste

- Symlink: `~/Library/Application Support/typst/packages/local/abntyp/<versão>` → este repo.
- typst.app: zip com a pasta `abntyp/` (= `lib.typ` + `src/`).
