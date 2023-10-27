package shisho.decision

import data.shisho.assertion
import future.keywords.every

has_required_fields(d) {
	checks := [
		assertion.has_typed_key(d, "allowed", "boolean", concat("", ["d.allowed"])),
		assertion.has_typed_key(d, "subject", "string", concat("", ["d.subject"])),
		has_serialized_payload(d),
	]
	every c in checks { c }
}

has_serialized_payload(d) := false {
	not is_string(d.payload)
	print(concat("", ["validation error: type mismatch: d.payload (expected string, got ", type_name(d.payload), ")"]))
} else := false {
	d.payload == ""
	print("validation error: payload must not be empty")
} else := true
