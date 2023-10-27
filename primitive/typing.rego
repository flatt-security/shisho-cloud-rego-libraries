package shisho.primitive

is_type(x, ty) := is_array(x) {
	ty == "array"
} else := is_boolean(x) {
	ty == "boolean"
} else := is_null(x) {
	ty == "null"
} else := is_object(x) {
	ty == "object"
} else := is_set(x) {
	ty == "set"
} else := is_string(x) {
	ty == "string"
} else := is_number(x) {
	ty == "number"
} else := false

is_set_or_array(x) {
	is_set(x)
} else {
	is_array(x)
} else := false

is_set_or_object(x) {
	is_set(x)
} else {
	is_object(x)
} else := false

has_key(x, k) {
	_ = x[k]
} else := false
