package shisho.resource

# METADATA
# title: "Determine the resource is excepted or not by resource exception filters"
# scope: "rule"
# description: |
#  Determine the resource is excepted or not by resource exception filters.
is_excepted(resource_exceptions, resource_id) {
	filter := resource_exceptions[_]
	filter == "*"
} else {
	filter := resource_exceptions[_]
	filter == resource_id
} else = false {
	true
}
