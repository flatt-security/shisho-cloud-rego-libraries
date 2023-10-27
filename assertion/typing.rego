package shisho.assertion

import data.shisho.primitive

is_type(x, ty, val_name) := false {
	not primitive.is_type(x, ty)
	print(concat("", ["validation error: type mismatch: ", val_name, " (expected ", ty, ", got ", type_name(x), ")"]))
} else := true

is_set_or_array(x, val_name) := false {
	not primitive.is_set_or_array(x)
	print(concat("", ["validation error: type mismatch: ", val_name, " (expected set or array, got ", type_name(x), ")"]))
} else := true

is_set_or_object(x, val_name) := false {
	not primitive.is_set_or_object(x)
	print(concat("", ["validation error: type mismatch: ", val_name, " (expected set or object, got ", type_name(x), ")"]))
} else := true

has_key(x, key, val_name) := false {
	not primitive.has_key(x, key)
	print(concat("", ["validation error: ", val_name, " is missing key: ", key]))
} else := true

has_typed_key(x, key, ty, val_name) := false {
	not has_key(x, key, val_name)
} else := is_set_or_array(x[key], concat("", [val_name, "[", key, "]"])) {
	ty == "array"
} else := is_type(x[key], ty, concat("", [val_name, "[", key, "]"]))
