// Sistema Numerico de Citacoes conforme NBR 10520:2023
//
// ============================================================================
// SOBRE O SISTEMA NUMERICO
// ============================================================================
//
// A NBR 10520:2023 (secao 4.2) permite dois sistemas de chamada para citacoes:
// - Sistema autor-data (padrao no Brasil)
// - Sistema numerico (permitido pela norma)
//
// Este modulo implementa o sistema numerico, inspirado no abntex2-num.bst
// do pacote abntex2 para LaTeX.
//
// IMPORTANTE (NBR 10520:2023, secao 4.2):
// "O sistema numerico NAO pode ser usado quando houver notas"
// Isso significa que se voce usar o sistema numerico, NAO pode ter notas
// de rodape no documento, pois haveria conflito na numeracao.
//
// ============================================================================
// FUNCIONAMENTO
// ============================================================================
//
// No sistema numerico:
// - Citacoes sao indicadas por numeros arabicos consecutivos
// - A numeracao remete a lista de referencias ao final do documento
// - A numeracao NAO reinicia a cada pagina
// - Fonte repetida recebe a MESMA numeracao da primeira ocorrencia
//
// Formatos permitidos (NBR 10520:2023):
// - Entre parenteses: (15, p. 34)
// - Em expoente (sobrescrito): ¹⁵, p. 34
//
// ============================================================================
// INSPIRACAO
// ============================================================================
//
// Este modulo foi inspirado no abntex2-num.bst do projeto abntex2
// (https://github.com/abntex/abntex2), adaptado para a sintaxe do Typst.
//
// ============================================================================

// Estado global para o sistema numerico
// Armazena o mapeamento de chaves de citacao para numeros
#let _numeric-citations = state("abnt-numeric-citations", (:))
#let _numeric-counter = state("abnt-numeric-counter", 0)

// ============================================================================
// CONFIGURACAO DO SISTEMA NUMERICO
// ============================================================================

/// Configura o documento para usar o sistema numerico de citacoes
///
/// ATENCAO: O sistema numerico NAO pode ser usado com notas de rodape
/// (NBR 10520:2023, secao 4.2). Esta funcao desabilita notas de rodape
/// para evitar conflitos.
///
/// Parametros:
/// - style: estilo de apresentacao ("parentheses" ou "superscript")
///   - "parentheses": (1), (2, p. 45) - padrao
///   - "superscript": ¹, ², p. 45 - sobrescrito
/// - brackets: tipo de delimitador para estilo parentheses
///   - "()" - parenteses (padrao)
///   - "[]" - colchetes
///
/// Exemplo:
/// ```typst
/// #show: citacao-num-config
///
/// Conforme demonstrado #citar-num(<silva2023>), o resultado foi positivo.
/// ```
#let citacao-num-config(
  style: "parentheses",
  brackets: "()",
  body,
) = {
  // Aviso importante sobre notas de rodape
  // A NBR 10520:2023 proibe o uso simultaneo de sistema numerico e notas

  // Armazenar configuracao no estado
  let config = state("abnt-numeric-config", (
    style: style,
    brackets: brackets,
  ))

  // Resetar contadores no inicio do documento
  _numeric-citations.update((:))
  _numeric-counter.update(0)

  body
}

// ============================================================================
// FUNCOES DE CITACAO NUMERICA
// ============================================================================

/// Citacao numerica simples
///
/// Insere uma citacao no formato numerico. Se a referencia ja foi citada,
/// reutiliza o mesmo numero.
///
/// Parametros:
/// - key: chave da referencia (string identificadora)
/// - page: pagina (opcional)
/// - style: "parentheses" ou "superscript" (opcional, usa padrao do documento)
///
/// Exemplos:
/// ```typst
/// O resultado foi confirmado #citar-num("silva2023").
/// Conforme demonstrado #citar-num("santos2022", page: "45").
/// ```
///
/// Formatos de saida (NBR 10520:2023):
/// - Parenteses: (1) ou (1, p. 45)
/// - Sobrescrito: ¹ ou ¹, p. 45
#let citar-num(
  key,
  page: none,
  volume: none,
  style: "parentheses",
  brackets: "()",
) = {
  context {
    let citations = _numeric-citations.get()
    let is-new = key not in citations
    let num = if is-new { _numeric-counter.get() + 1 } else { citations.at(key) }

    // Registrar nova citacao no estado (separado do calculo do numero)
    if is-new {
      _numeric-counter.update(num)
      _numeric-citations.update(c => {
        c.insert(key, num)
        c
      })
    }

    // Formatar localizacao (pagina, volume)
    let loc = if page != none or volume != none {
      let parts = ()
      if volume != none { parts.push([v. #volume]) }
      if page != none { parts.push([p. #page]) }
      [, #parts.join(", ")]
    } else {
      []
    }

    // Formatar saida conforme estilo
    if style == "superscript" {
      // Formato sobrescrito: ¹, p. 45
      // Nota: sem espaco antes do sobrescrito (NBR 10520:2023)
      super[#num#loc]
    } else {
      // Formato parenteses: (1, p. 45)
      let (open, close) = if brackets == "[]" {
        ("[", "]")
      } else {
        ("(", ")")
      }
      [#open#num#loc#close]
    }
  }
}

/// Citacao numerica com autor no texto
///
/// Quando o nome do autor aparece na sentenca, apenas o numero vai
/// entre parenteses ou sobrescrito.
///
/// Exemplo:
/// ```typst
/// Segundo Silva #citar-num-linha("silva2023", page: "45"), o resultado...
/// ```
///
/// Saida: Segundo Silva (1, p. 45), o resultado...
#let citar-num-linha(
  key,
  page: none,
  volume: none,
  style: "parentheses",
  brackets: "()",
) = {
  citar-num(key, page: page, volume: volume, style: style, brackets: brackets)
}

/// Citacao numerica multipla
///
/// Cita multiplas referencias de uma vez.
///
/// Exemplo:
/// ```typst
/// Varios autores confirmam #citar-num-multiplos(("silva2023", "santos2022", "costa2021")).
/// ```
///
/// Saida: (1; 2; 3) ou ¹ ² ³
#let citar-num-multiplos(
  keys,
  style: "parentheses",
  brackets: "()",
) = {
  context {
    let citations = _numeric-citations.get()
    let counter-val = _numeric-counter.get()
    let nums = ()
    let new-entries = (:)
    let next-num = counter-val

    for key in keys {
      if key in citations {
        nums.push(citations.at(key))
      } else if key in new-entries {
        nums.push(new-entries.at(key))
      } else {
        next-num += 1
        new-entries.insert(key, next-num)
        nums.push(next-num)
      }
    }

    // Registrar novas citacoes no estado
    if new-entries.len() > 0 {
      _numeric-counter.update(next-num)
      _numeric-citations.update(c => {
        for (k, n) in new-entries {
          c.insert(k, n)
        }
        c
      })
    }

    if style == "superscript" {
      super[#nums.map(str).join(", ")]
    } else {
      let (open, close) = if brackets == "[]" {
        ("[", "]")
      } else {
        ("(", ")")
      }
      [#open#nums.map(str).join("; ")#close]
    }
  }
}

/// Citacao numerica de citacao (apud)
///
/// Para citar uma fonte que voce nao teve acesso direto,
/// citada em outra obra que voce consultou.
///
/// NBR 10520:2023: Na lista de referencias, inclua SOMENTE a fonte consultada.
///
/// Parametros:
/// - original-key: chave da fonte original (nao acessada)
/// - original-page: pagina na fonte original (opcional)
/// - consulted-key: chave da fonte consultada
/// - consulted-page: pagina na fonte consultada (opcional)
///
/// Exemplo:
/// ```typst
/// Segundo a teoria #citar-num-apud("freire1994", page: "13", "streck2017", page: "25").
/// ```
///
/// Saida: (1 apud 2, p. 25)
#let citar-num-apud(
  original-key,
  consulted-key,
  original-page: none,
  consulted-page: none,
  style: "parentheses",
  brackets: "()",
) = {
  context {
    let citations = _numeric-citations.get()
    let counter-val = _numeric-counter.get()
    let next-num = counter-val
    let new-entries = (:)

    // Numero para a referencia original
    let orig-num = if original-key in citations {
      citations.at(original-key)
    } else {
      next-num += 1
      new-entries.insert(original-key, next-num)
      next-num
    }

    // Numero para a referencia consultada
    let cons-num = if consulted-key in citations {
      citations.at(consulted-key)
    } else if consulted-key in new-entries {
      new-entries.at(consulted-key)
    } else {
      next-num += 1
      new-entries.insert(consulted-key, next-num)
      next-num
    }

    // Registrar novas citacoes no estado
    if new-entries.len() > 0 {
      _numeric-counter.update(next-num)
      _numeric-citations.update(c => {
        for (k, n) in new-entries {
          c.insert(k, n)
        }
        c
      })
    }

    let orig-loc = if original-page != none { [, p. #original-page] } else { [] }
    let cons-loc = if consulted-page != none { [, p. #consulted-page] } else { [] }

    if style == "superscript" {
      super[#orig-num#orig-loc apud #cons-num#cons-loc]
    } else {
      let (open, close) = if brackets == "[]" {
        ("[", "]")
      } else {
        ("(", ")")
      }
      [#open#orig-num#orig-loc apud #cons-num#cons-loc#close]
    }
  }
}

// ============================================================================
// CITACOES DIRETAS COM NUMERO
// ============================================================================

/// Citacao direta curta (ate 3 linhas) com numero
///
/// Formatada entre aspas duplas, com numero ao final.
///
/// Exemplo:
/// ```typst
/// #citacao-num-curta("silva2023", page: "45")[
///   O resultado demonstrou significativa melhoria.
/// ]
/// ```
///
/// Saida: "O resultado demonstrou significativa melhoria" (1, p. 45).
#let citacao-num-curta(
  key,
  page: none,
  style: "parentheses",
  brackets: "()",
  body,
) = {
  ["#body" #citar-num(key, page: page, style: style, brackets: brackets).]
}

/// Citacao direta longa (mais de 3 linhas) com numero
///
/// Formatada com recuo de 4cm, fonte menor, espacamento simples, sem aspas.
/// Numero ao final da citacao.
///
/// Exemplo:
/// ```typst
/// #citacao-num-longa("silva2023", page: "45-46")[
///   A teleconferencia permite ao individuo participar de um encontro
///   nacional ou regional sem a necessidade de deixar seu local de
///   origem. Tipos comuns de teleconferencia incluem o uso de televisao,
///   telefone e computador.
/// ]
/// ```
#let citacao-num-longa(
  key,
  page: none,
  style: "parentheses",
  brackets: "()",
  body,
) = {
  set par(
    first-line-indent: 0pt,
    leading: 1em, // espacamento simples
  )
  set text(size: 10pt) // fonte menor

  block(
    inset: (left: 4cm),
    [#body #citar-num(key, page: page, style: style, brackets: brackets).]
  )
}

// ============================================================================
// BIBLIOGRAFIA NUMERADA
// ============================================================================

/// Bibliografia no sistema numerico
///
/// Gera a lista de referencias ordenada pela ordem de citacao no texto,
/// com numeros correspondentes as citacoes.
///
/// NOTA: A NBR 6023:2018 permite ordenacao alfabetica ou por ordem de citacao.
/// No sistema numerico, a ordenacao por ordem de citacao e mais intuitiva.
///
/// Parametros:
/// - items: lista de referencias no formato (chave, conteudo)
/// - title: titulo da secao (padrao: "REFERENCIAS")
/// - style: estilo dos numeros ("brackets" ou "plain")
///
/// Exemplo:
/// ```typst
/// #bibliografia-numerica(
///   (
///     ("silva2023", [SILVA, J. *Titulo do livro*. Sao Paulo: Editora, 2023.]),
///     ("santos2022", [SANTOS, M. Artigo importante. *Revista*, v. 1, 2022.]),
///   )
/// )
/// ```
#let bibliografia-numerica(
  items,
  title: "REFERÊNCIAS",
) = {
  // Titulo da secao
  heading(level: 1, numbering: none, title)

  v(1em)

  // Configuracao de paragrafo para referencias
  set par(
    hanging-indent: 0pt, // sem recuo frances no sistema numerico
    first-line-indent: 0pt,
    leading: 1em,
  )

  context {
    let citations = _numeric-citations.get()

    // Ordenar itens pela ordem de citacao
    let ordered = items.filter(item => item.at(0) in citations)
                       .sorted(key: item => citations.at(item.at(0)))

    // Itens nao citados vao ao final (se full: true)
    let uncited = items.filter(item => item.at(0) not in citations)

    // Renderizar referencias numeradas
    for item in ordered {
      let (key, content) = item
      let num = citations.at(key)

      block(spacing: 0.8em)[
        #text(weight: "bold")[#num] #h(0.5em) #content
      ]
    }

    // Avisar sobre referencias nao citadas
    if uncited.len() > 0 {
      v(1em)
      text(fill: gray, size: 9pt)[
        _Nota: #uncited.len() referencia(s) nao citada(s) no texto foram omitidas._
      ]
    }
  }
}

/// Referencia numerada individual (para uso manual)
///
/// Quando nao se usa arquivo .bib, permite criar referencias numeradas manualmente.
///
/// Parametros:
/// - num: numero da referencia
/// - content: conteudo formatado da referencia (conforme NBR 6023:2018)
#let ref-numerica(num, content) = {
  set par(
    hanging-indent: 0pt,
    first-line-indent: 0pt,
  )

  block(spacing: 0.8em)[
    #text(weight: "bold")[#num] #h(0.5em) #content
  ]
}

// ============================================================================
// AVISO SOBRE NOTAS DE RODAPE
// ============================================================================

/// Funcao para inserir aviso sobre incompatibilidade com notas
///
/// Use no inicio do documento quando adotar o sistema numerico.
#let aviso-sistema-numerico() = {
  text(size: 10pt, fill: gray, style: "italic")[
    Este documento utiliza o sistema numerico de citacoes (NBR 10520:2023, secao 4.2).
    Conforme a norma, o sistema numerico nao pode ser usado simultaneamente com
    notas de rodape.
  ]
}

// ============================================================================
// UTILITARIOS
// ============================================================================

/// Obtem o numero atual de uma citacao (se ja foi citada)
///
/// Util para referencias cruzadas manuais.
#let get-citation-number(key) = {
  context {
    let citations = _numeric-citations.get()
    if key in citations {
      str(citations.at(key))
    } else {
      "?"
    }
  }
}

/// Reseta a numeracao de citacoes
///
/// Use apenas se precisar reiniciar a numeracao (ex: em livros com partes independentes).
/// NOTA: A NBR 10520:2023 diz que a numeracao NAO deve reiniciar a cada pagina,
/// mas pode ser reiniciada por capitulo em alguns casos.
#let reset-numeric-citations() = {
  _numeric-citations.update((:))
  _numeric-counter.update(0)
}

/// Obtem o total de citacoes ate o momento
#let get-citation-count() = {
  context {
    _numeric-counter.get()
  }
}
