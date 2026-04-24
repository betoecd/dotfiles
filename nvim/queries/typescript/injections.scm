; extends

((call_expression
  function: (identifier) @_name
  arguments: (template_string) @injection.content)
 (#eq? @_name "sql")
 (#set! injection.language "sql"))

((call_expression
  function: (member_expression
    property: (property_identifier) @_name)
  arguments: (template_string) @injection.content)
 (#eq? @_name "sql")
 (#set! injection.language "sql"))
