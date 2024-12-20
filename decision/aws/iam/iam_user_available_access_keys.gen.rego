# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure there is only one active access key available for any single IAM user
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
#   d := shisho.decision.aws.iam.user_available_access_keys({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.user_available_access_keys_payload({
#       "access_key_ids": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_user_available_access_keys"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_user_available_access_keys".
user_available_access_keys(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": user_available_access_keys_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": user_available_access_keys_locator(d),
			"severity": user_available_access_keys_severity(d),
		}),
		"payload": d.payload,
	}
}

user_available_access_keys_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

user_available_access_keys_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

user_available_access_keys_kind = "aws_iam_user_available_access_keys"

user_available_access_keys_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": user_available_access_keys_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.13",
			"decision.api.shisho.dev:aws/cis-benchmark/v3.0.0": "1.13",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(user_available_access_keys_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
user_available_access_keys_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_user_available_access_keys"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_user_available_access_keys
#
#   The parameter `data` is an object with the following fields:
#   - access_key_ids: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "access_key_ids": ["example"],
#   }
#   ```
user_available_access_keys_payload(edata) := x {
	user_available_access_keys_payload_assert(edata, "<the argument to user_available_access_keys_payload>")
	x := json.marshal(edata)
} else := ""

user_available_access_keys_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "access_key_ids", concat("", [hint, ".", "access_key_ids"]))]
	every c in key_checks { c }

	value_checks := [user_available_access_keys_payload_assert_access_key_ids(edata, "access_key_ids", concat("", [hint, ".", "access_key_ids"]))]
	every c in value_checks { c }
} else := false

user_available_access_keys_payload_assert_access_key_ids(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [user_available_access_keys_payload_assert_access_key_ids_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

user_available_access_keys_payload_assert_access_key_ids_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
