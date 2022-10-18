package shisho.decision

# METADATA
# title: "A type of decision (allowed)"
# scope: "rule"
# description: |
#   Represents that a policy decided to allow the input.
#
#   It's commonly used by `as_decision_type` function.
#   You don't need to use this constant directly.
type_allow = 1

# METADATA
# title: "A type of decision (denied)"
# scope: "rule"
# description: |
#   Represents that a policy decided to deny the input
#
#   It's commonly used by `as_decision_type` function.
#   You don't need to use this constant directly.
type_deny = 2

# METADATA
# title: "Convert a boolean value to a decision type"
# scope: "rule"
# description: |
#   Converts the given boolean value to a decision type (type_allow or type_deny).
# 
#   It's commonly used by `shisho.decision.*.*_header` functions.
#   You don't need to use this constant directly.
as_decision_type(t) := type_allow {
	t == true
} else := type_deny {
	true
}

# METADATA
# title: "Determines whether a decision allows input"
# scope: "rule"
# description: |
#   Determines whether a decision allows input.
is_allowed(d) {
	d.header.type == type_allow
} else = false {
	true
}
