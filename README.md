# Yelets
Pipeline programming language.

## Extension
`.y`

## Built-in
Collection of core objects implemented internally.

### Operators
* `>` - Transfers struct from instruction output to the left, to the instruction input to the right. If the right target is the function, it immediatelly gets called. By default, the passed struct is digested into args and kwargs: args are appended after existing args of the call, kwargs are appended after existing kwargs of the call. Append position can be modified with `*` and `**` spread operators. To skip the digestion, use `>>`, the struct will be passed as a whole. If the instruction to the right cannot handle all the incoming data, but received enough, redundant fields are discarded. We do not support the opposite `<` for better readability.
* `;` - Ends instruction.
* ``
* `()` - Struct brackets.
* `[]` - Array brackets.
* `{}` - Block brackets.
* `#<target> <args *any> <kwargs **any>` - Directives.
* `//` - Comments.
* `*` - Positional spread.
* `**` - Keyword spread.

### Instructions
* `(...)` - Creates a struct type, can be used inside pipe step.
* `[...]` - Creates an array type, can be used inside pipe step.
* `{...}` - Creates a block type, can be used inside pipe step.
* `def <type_ type> <name str> <obj any>` - Associates a name with a typed object in the local scope.
* `fn::new <args struct> <output struct> <implementation block>` - Creates a function instance.
* `fn::new <args struct> <output struct> <external_name str>` - Creates a function instance with external implementation.

* `is <objects *any>` - Checks if first given object is compatible with the rest.
    * Arrays: item types must be compatible.
    * Functions: signature types must be compatible (recursive `is` is performed per type).
    * Structs: first object must contain all keys of the following objects, for these keys all types must be compatible.
    * Other types: must be directly equal.
* `return <object struct>` - Returns struct instance from the block.

* `add <objects *any>` - Adds all objects in order.
* `sub <objects *any>` - Subtracts all objects in order.
* `mul <objects *any>` - Multiplies all objects in order.
* `div <objects *any>` - Divides all objects in order.
* `mod <objects *any>` - Perform modulus division on all objects in order .

* `eq <objects *any>` - Checks if all objects are equal.
* `ne <objects *any>` - Checks if all objects aren't equal.
* `gt <objects *any>` - Checks if any preceding object is greater than following one.
* `lt <objects *any>` - Checks if any preceding object is less than following one.
* `ge <objects *any>` - Checks if any preceding object is greater than or equal following one.
* `le <objects *any>` - Checks if any preceding object is less than or equal following one.

### Value Types
* `int` - s64.
* `byte` - uint8.
* `float` - float32.
* `str`
* `bool`

### Reference Types
* `null` - Empty value. Can be used instead of any reference type.
* `type` - Describes a reference type.
* `any` - Can point to anything.
* `arr` - Contains objects of the same type.
* `struct` - The main structure passed in pipes. Contains __ordered__ values associated with string keys. Every value has information about it's type.
* `block` - Collection of instructions.
* `fn` - Function - collection of instructions with a local state. Function accepts struct and returns struct.

### Directives
* `#import <path>.y` - Brings a Yelets file into local scope. All file's top-level objects, which name does not start with `_`, become available in the local scope under the file's module name. The file must have directive `#module <name>` at the top of the file, before the first instruction or it won't be considered as a module. If the imported file's module name is the same, as import initiator's file module name, the imported object names can be used without a namespace prefix. Otherwise, all imported objects must be called using `imported_module::desired_object` notation. We don't want to support `#using <namespace>` in the near future. The `#import` must be placed at top of the file, before any non-directive instruction. If imported object names conflicts with the existing ones in the importing scope, an immediate interpreter panic will be raised.
* `#module <name>` - Declares the name of this module. Must be placed, if placed, at the top of the file, before anything else (except comments). Without this directive the file cannot be considered a module, and thus cannot be imported by other Yelets files.

## Standard Library
Collection of objects implemented in Yelets.

### Structs
* `Writer (write (value byte[])(written int, e err))` - Writes bytes to the underlying data stream. Implementations must not retain `value`. Returns number of bytes written.

### Functions
* `print (object any, target Writer)` - Tries to print given object in the best possible way.
