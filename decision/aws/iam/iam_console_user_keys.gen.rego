# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure access keys during initial user setup for all IAM users with a console password
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
#   d := shisho.decision.aws.iam.console_user_keys({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.console_user_keys_payload({
#       "has_access_key": false,
#       "has_console_password": false,
#       "has_unused_access_key": false,
#       "has_unused_console_password": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_console_user_keys"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_console_user_keys".
console_user_keys(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": console_user_keys_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": console_user_keys_locator(d),
			"severity": console_user_keys_severity(d),
		}),
		"payload": d.payload,
	}
}

console_user_keys_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

console_user_keys_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

console_user_keys_kind = "aws_iam_console_user_keys"

console_user_keys_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": console_user_keys_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.11",
			"decision.api.shisho.dev:aws/cis-benchmark/v3.0.0": "1.11",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(console_user_keys_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
console_user_keys_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_console_user_keys"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_console_user_keys
#
#   The parameter `data` is an object with the following fields:
#   - has_access_key: boolean
#   - has_console_password: boolean
#   - has_unused_access_key: boolean
#   - has_unused_console_password: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "has_access_key": false,
#     "has_console_password": false,
#     "has_unused_access_key": false,
#     "has_unused_console_password": false,
#   }
#   ```
console_user_keys_payload(edata) := x {
	console_user_keys_payload_assert(edata, "<the argument to console_user_keys_payload>")
	x := json.marshal(edata)
} else := ""

console_user_keys_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "has_access_key", concat("", [hint, ".", "has_access_key"])),
		assertion.has_key(edata, "has_console_password", concat("", [hint, ".", "has_console_password"])),
		assertion.has_key(edata, "has_unused_access_key", concat("", [hint, ".", "has_unused_access_key"])),
		assertion.has_key(edata, "has_unused_console_password", concat("", [hint, ".", "has_unused_console_password"])),
	]
	every c in key_checks { c }

	value_checks := [
		console_user_keys_payload_assert_has_access_key(edata, "has_access_key", concat("", [hint, ".", "has_access_key"])),
		console_user_keys_payload_assert_has_console_password(edata, "has_console_password", concat("", [hint, ".", "has_console_password"])),
		console_user_keys_payload_assert_has_unused_access_key(edata, "has_unused_access_key", concat("", [hint, ".", "has_unused_access_key"])),
		console_user_keys_payload_assert_has_unused_console_password(edata, "has_unused_console_password", concat("", [hint, ".", "has_unused_console_password"])),
	]
	every c in value_checks { c }
} else := false

console_user_keys_payload_assert_has_access_key(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

console_user_keys_payload_assert_has_console_password(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

console_user_keys_payload_assert_has_unused_access_key(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

console_user_keys_payload_assert_has_unused_console_password(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
