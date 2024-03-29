# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.kms

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Cloud KMS encryption keys are rotated within a period of 90 days
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
#   d := shisho.decision.googlecloud.kms.key_rotation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.kms.key_rotation_payload({
#       "last_rotated_at": "example",
#       "rotation_period_expectation_seconds": 0,
#       "rotation_period_seconds": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_kms_key_rotation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_kms_key_rotation".
key_rotation(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": key_rotation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": key_rotation_locator(d),
			"severity": key_rotation_severity(d),
		}),
		"payload": d.payload,
	}
}

key_rotation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

key_rotation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

key_rotation_kind = "googlecloud_kms_key_rotation"

key_rotation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": key_rotation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "1.10",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(key_rotation_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
key_rotation_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_kms_key_rotation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_kms_key_rotation
#
#   The parameter `data` is an object with the following fields:
#   - last_rotated_at: string
#   - rotation_period_expectation_seconds: number
#   - rotation_period_seconds: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "last_rotated_at": "example",
#     "rotation_period_expectation_seconds": 0,
#     "rotation_period_seconds": 0,
#   }
#   ```
key_rotation_payload(edata) := x {
	key_rotation_payload_assert(edata, "<the argument to key_rotation_payload>")
	x := json.marshal(edata)
} else := ""

key_rotation_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "last_rotated_at", concat("", [hint, ".", "last_rotated_at"])),
		assertion.has_key(edata, "rotation_period_expectation_seconds", concat("", [hint, ".", "rotation_period_expectation_seconds"])),
		assertion.has_key(edata, "rotation_period_seconds", concat("", [hint, ".", "rotation_period_seconds"])),
	]
	every c in key_checks { c }

	value_checks := [
		key_rotation_payload_assert_last_rotated_at(edata, "last_rotated_at", concat("", [hint, ".", "last_rotated_at"])),
		key_rotation_payload_assert_rotation_period_expectation_seconds(edata, "rotation_period_expectation_seconds", concat("", [hint, ".", "rotation_period_expectation_seconds"])),
		key_rotation_payload_assert_rotation_period_seconds(edata, "rotation_period_seconds", concat("", [hint, ".", "rotation_period_seconds"])),
	]
	every c in value_checks { c }
} else := false

key_rotation_payload_assert_last_rotated_at(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

key_rotation_payload_assert_rotation_period_expectation_seconds(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false

key_rotation_payload_assert_rotation_period_seconds(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false
