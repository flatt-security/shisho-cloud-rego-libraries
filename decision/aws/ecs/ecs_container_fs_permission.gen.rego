# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.ecs

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure root filesystem operation by ECS containers is limited to read-only access
# You can emit this decision as follows:
# 
# ```
# import data.shisho
# 
# decisions[d] {
#   # the resource ID to review (e.g. a GitHub repository, etc.)
#   subject := "test"
#
#   # whether the target is allowed by this policy or not
#   allowed := true
#
#   d := shisho.decision.aws.ecs.container_fs_permission({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.ecs.container_fs_permission_payload({
#       "containers": [{"container_name": "example", "is_root_fs_readonly": false}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_ecs_container_fs_permission"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_ecs_container_fs_permission".
container_fs_permission(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": container_fs_permission_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": container_fs_permission_locator(d),
			"severity": container_fs_permission_severity(d),
		}),
		"payload": d.payload,
	}
}

container_fs_permission_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

container_fs_permission_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

container_fs_permission_kind = "aws_ecs_container_fs_permission"

container_fs_permission_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": container_fs_permission_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "ECS.5",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(container_fs_permission_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
container_fs_permission_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_ecs_container_fs_permission"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_ecs_container_fs_permission
#
#   The parameter `data` is an object with the following fields: 
#   - containers: {"container_name": string, "is_root_fs_readonly": boolean}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "containers": [{"container_name": "example", "is_root_fs_readonly": false}],
#   }
#   ```
container_fs_permission_payload(edata) := x {
	container_fs_permission_payload_assert(edata, "<the argument to container_fs_permission_payload>")
	x := json.marshal(edata)
} else := ""

container_fs_permission_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "containers", concat("", [hint, ".", "containers"]))]
	every c in key_checks { c }

	value_checks := [container_fs_permission_payload_assert_containers(edata, "containers", concat("", [hint, ".", "containers"]))]
	every c in value_checks { c }
} else := false

container_fs_permission_payload_assert_containers(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [container_fs_permission_payload_assert_containers_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

container_fs_permission_payload_assert_containers_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "container_name", "string", hint),
		assertion.has_typed_key(x[key], "is_root_fs_readonly", "boolean", hint),
	]
	every c in key_checks { c }
	value_checks := [
		container_fs_permission_payload_assert_containers_element_container_name(x[key], "container_name", concat("", [hint, ".", "container_name"])),
		container_fs_permission_payload_assert_containers_element_is_root_fs_readonly(x[key], "is_root_fs_readonly", concat("", [hint, ".", "is_root_fs_readonly"])),
	]
	every c in value_checks { c }
} else := false

container_fs_permission_payload_assert_containers_element_container_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

container_fs_permission_payload_assert_containers_element_is_root_fs_readonly(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
