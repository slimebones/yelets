# Yelets
Pipeline programming language.

## Extension
`.y`

## Built-in
Collection of core objects implemented internally.

### Operators
* `>` - Transfers struct from instruction output to the left, to the instruction input to the right. If the right target is the function, it immediatelly gets called. By default, the passed struct is digested into args and kwargs: args are appended after existing args of the call, kwargs are appended after existing kwargs of the call. Append position can be modified with `*` and `**` spread operators. To skip the digestion, use `>>`, the struct will be passed as a whole. If the instruction to the right cannot handle all the incoming data, but received enough, redundant fields are discarded. We do not support the opposite `<` for better readability.
* `;` - Ends instruction.
* `()` - Struct brackets.
* `[]` - Array brackets.
* `{}` - Block brackets.
* `#<target> <args *any> <kwargs **any>` - Directives.
* `//` - Comments.
* `*` - Positional spread.
* `**` - Keyword spread.

### Instructions
* `(...)` - Shortcut to `struct::new_type <raw str>`.
* `<type>[...]` - Shortcut to `arr::new_type item_1 item_2 ... item_n`.
* `{...}` - Shortcut to `block::new_type <raw str>`
* `def <metatype_ metatype> <name str> <args *any> <kwargs **any>` - Creates a new type, internally using `metatype::new_type *args **kwargs` and associating the created type with a name.
* `def fn <name str> <args struct> <output struct> <implementation block>` - Creates a function instance.
* `def extern <name str> <args struct> <output struct> <external_name str>` - Creates a function instance with external implementation.
* `impl <struct_type type> <name str> <args struct> <output struct> <implementation block>` - Creates a new function type, and assigns it to a struct using `struct::append_field`.
* `impl_extern <struct_type type> <name str> <args struct> <output struct> <implementation block>` - Creates a new function type with external implementation, and assigns it to a struct using `struct::append_field`.

* `is <objects *any>` - Checks if first given object is compatible with the rest.
    * Arrays: item types must be compatible.
    * Functions: signature types must be compatible (recursive `is` is performed per type).
    * Structs: first object must contain all keys of the following objects, for these keys all types must be compatible.
    * Other types: must be directly equal.
* `return <object struct>` - Returns struct instance from the block.

* `add <objects *any>` - Adds alel objects in order. Types of all objects must be compatible.
* `sub <objects *any>` - Subtracts all objects in order. Types of all objects must be compatible.
* `mul <objects *any>` - Multiplies all objects in order. Types of all objects must be compatible.
* `div <objects *any>` - Divides all objects in order. Types of all objects must be compatible.
* `mod <objects *any>` - Perform modulus division on all objects in order. Types of all objects must be compatible.

* `eq <objects *any>` - Checks if all objects are equal. Types of all objects must be compatible.
* `ne <objects *any>` - Checks if all objects aren't equal. Types of all objects must be compatible.
* `gt <objects *any>` - Checks if any preceding object is greater than following one. Types of all objects must be compatible.
* `lt <objects *any>` - Checks if any preceding object is less than following one. Types of all objects must be compatible.
* `ge <objects *any>` - Checks if any preceding object is greater than or equal following one. Types of all objects must be compatible.
* `le <objects *any>` - Checks if any preceding object is less than or equal following one. Types of all objects must be compatible.

### Value Types
* `int` - s64.
* `byte` - uint8.
* `float` - float32.
* `str`
* `bool`

### Reference Types
* `null` - Empty value. Can be used instead of any reference type.
* `type` - Describes a reference type.
* `metatype` - Special type which can create child types. Every metatype has `new_type` function which is responsible for creating new types. This function is internally used by instruction `def`, which propagate it's given args and kwargs to this function.
* `any` - Can point to anything.
* `arr` - Contains objects of compatible type. It's a `metatype`.
* `struct` - The main structure passed in pipes. Contains __ordered__ values associated with string keys. Every value has information about it's type. It's a `metatype`.
* `block` - Collection of instructions. It's a `metatype`.
* `fn` - Function - collection of instructions with a local state. Function accepts struct and returns struct. It's a `metatype`. Could have external implementation, if created using `extern` instruction.

### Directives
Directives are special calls available using `#` prefix. They must be written *without* ending semicolon `;`.

* `#import path_without_extension` - Brings a Yelets file into local scope. All file's top-level objects, which name does not start with `_`, become available in the local scope under the imported file's name (without extension). All imported objects must be called using `imported_name::desired_object` notation. We don't want to support `#using <namespace>` in the near future. If imported object names conflicts with the existing ones in the importing scope, an immediate interpreter panic will be raised. Import path is always relative. Alternatively, you can use `#import <dependency_path_without_extension>` (`<>` arrows intended), to import relative to `./.yelets/deps` directory.

## Common Concepts
### Struct Functions
Any function being attached to a field of struct, can make use of `self` input
field name. When such name is used as a first argument of such function, it will
be populated with an actual reference to the hosting struct. If such name is not on the first position, an interpreter panic is thrown. Functions defining `self` as the first argument are considered as a struct's `methods`, and can be referenced from the point of an instance: `rect.calculate_area ...`. Functions without `self` are considered as `statics`. They are references only by struct's type: `Rect::calculate_area`

## Yelets Project
Directory containing `./.yelets` subdirectory is considered a Yelets project. Such project can access installed dependencies located at `./.yelets/deps`.

## FFI
TODO

## Standard Library
Collection of objects implemented in Yelets.

### Structs
* `Writer (write (value byte[])(written int, e err))` - Writes bytes to the underlying data stream. Implementations must not retain `value`. Returns number of bytes written.

### Functions
* `print (object any, target Writer)` - Tries to print given object in the best possible way.
