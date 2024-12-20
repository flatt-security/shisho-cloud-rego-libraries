# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.autoscaling

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that Auto Scaling groups use multiple instance types in multiple Availability Zones
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
#   d := shisho.decision.aws.autoscaling.group_instance_types({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.autoscaling.group_instance_types_payload({
#       "availability_zones": ["example"],
#       "instance_types": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_autoscaling_group_instance_types"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_autoscaling_group_instance_types".
group_instance_types(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": group_instance_types_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": group_instance_types_locator(d),
			"severity": group_instance_types_severity(d),
		}),
		"payload": d.payload,
	}
}

group_instance_types_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

group_instance_types_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

group_instance_types_kind = "aws_autoscaling_group_instance_types"

group_instance_types_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": group_instance_types_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "AutoScaling.6",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(group_instance_types_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
group_instance_types_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_autoscaling_group_instance_types"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_autoscaling_group_instance_types
#
#   The parameter `data` is an object with the following fields:
#   - availability_zones: string
#   - instance_types: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "availability_zones": ["example"],
#     "instance_types": ["example"],
#   }
#   ```
group_instance_types_payload(edata) := x {
	group_instance_types_payload_assert(edata, "<the argument to group_instance_types_payload>")
	x := json.marshal(edata)
} else := ""

group_instance_types_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "availability_zones", concat("", [hint, ".", "availability_zones"])),
		assertion.has_key(edata, "instance_types", concat("", [hint, ".", "instance_types"])),
	]
	every c in key_checks { c }

	value_checks := [
		group_instance_types_payload_assert_availability_zones(edata, "availability_zones", concat("", [hint, ".", "availability_zones"])),
		group_instance_types_payload_assert_instance_types(edata, "instance_types", concat("", [hint, ".", "instance_types"])),
	]
	every c in value_checks { c }
} else := false

group_instance_types_payload_assert_availability_zones(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [group_instance_types_payload_assert_availability_zones_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

group_instance_types_payload_assert_availability_zones_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

group_instance_types_payload_assert_instance_types(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [group_instance_types_payload_assert_instance_types_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

group_instance_types_payload_assert_instance_types_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
