package shisho.decision

# METADATA
# title: "Wrap a resource ID to an internal representation of Shisho Cloud"
# scope: "rule"
# description: |
#   Wraps the given value to an internal resource ID format.
#
#   It's commonly used by `shisho.decision.*.*_header` functions.
#   You don't need to use this constant directly.
as_resource_id(rid) = x {
	x := {"value": rid}
}
