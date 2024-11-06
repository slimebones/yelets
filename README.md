# Yelets
Pipeline programming language.

## Extension
`.y`

## Built-in
Collection of core objects implemented internally.

### Operators
Operators are used to perform operations on variables and values.

* `;` - Ends instruction.
* `>` - Transfers pack from instruction output to the left, to the instruction input to the right. We do not support the opposite `<` for better readability.
* `()` - Pack brackets.
* `[]` - Array brackets.
* `{}` - Block brackets.

### Instructions
* `def <namespace>::<name>` - Defines a name in the local scope.
* `fn <input_pack> <output_pack> {<instructions...>}` - Creates a function.
* `extern <input_pack> <output_pack> <external_name>` - Creates a function with external implementation.
* `save`

### Value Types
* `int`
* `float`
* `str`

### Reference Types
* `arr`
* `pack` - The main structure passed in pipes. Contains positional and keyword fields.
* `block` - Collection of instructions.
* `fn` - Function - collection of instructions with a local state. Function accepts pack and returns pack.
