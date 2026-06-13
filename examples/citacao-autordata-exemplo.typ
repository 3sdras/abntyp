// ============================================================================
// EXEMPLO: Sistema autor-data com arquivo .bib (NBR 10520:2023)
// ============================================================================
//
// Este é o caminho RECOMENDADO e mais ergonômico para citar: o sobrenome, o
// ano e o "et al." vêm do arquivo .bib, e a lista de referências é gerada e
// mantida em sincronia automaticamente. Use a sintaxe nativa @chave.
//
// Compile a partir da pasta examples/ (o referencias.bib está aqui ao lado):
//   typst compile citacao-autordata-exemplo.typ
//
// ============================================================================

#import "../lib.typ": *
#show: normas-abnt.with(fonte: "Times New Roman")

= Citações no sistema autor-data

== O básico (basta a chave)

Entre parênteses, o sobrenome e o ano vêm da entrada do `.bib` @silva2023.
Com página, use colchetes logo após a chave @silva2023[p. 45].

Para 4 ou mais autores, o "et al." é inserido automaticamente @cormen2012 ---
nenhuma função é necessária.

Várias obras citadas juntas: basta colocá-las lado a lado
@silva2023@santos2022 (o Typst agrupa e ordena).

== Autor na sentença

Segundo #pag(<silva2023>, 45), o método é adequado. O nome
exibido é lido do `.bib` --- nada é redigitado.

== Citação de citação (apud)

A fonte consultada é uma chave do `.bib` (entra na lista de referências);
a fonte original, não acessada, vai como texto:
#apud("Freire", 1994, <oliveira2021>, 25).

== Citação direta

Citação curta incorporada ao texto, entre aspas
#citacao-curta("Silva", 2023, 45)[a padronização garante consistência],
com grifo do citador #citacao-curta("Silva", 2023, 46, grifo: "nosso")[a
#grifo-nosso[clareza] é essencial].

#postextual()

// A lista de referências é gerada automaticamente a partir das chaves citadas.
// IMPORTANTE: envolva o caminho do .bib em read(...) para que ele seja
// resolvido em relação a ESTE documento (e não ao pacote).
#referencias(read("referencias.bib"))
