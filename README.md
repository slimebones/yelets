# Yelets
Pipeline programming language.

## Extension
`.y`

## Built-in
Collection of core objects implemented internally.

### Operators
Operators are used to perform operations on variables and values.

* `;` - Ends instruction.
* `>` - Transfers map from instruction output to the left, to the instruction input to the right. We do not support the opposite `<` for better readability.
* `()` - Map brackets.
* `[]` - Array brackets.
* `{}` - Block brackets.

### Instructions
* `def <namespace str>::<name str> <type_ type> <obj any>` - Defines a name and according object in the local scope.
* `struct  `
* `fn <input map> <output map> <implementation block>` - Creates a function.
* `extern <input map> <output map> <external_name str>` - Creates a function with external implementation.

### Value Types
* `int`
* `float`
* `str`

### Reference Types
* `type` - Describes a reference type.
* `any` - Can point to anything.
* `arr<T>` - Contains objects of the same type T.
* `map` - The main structure passed in pipes. Contains __ordered__ values associated with string keys. Every value has information about it's type.
* `block` - Collection of instructions.
* `fn` - Function - collection of instructions with a local state. Function accepts pack and returns pack.
