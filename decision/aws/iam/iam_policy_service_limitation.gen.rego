# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that IAM policies that you create do not use wildcard actions
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
#   d := shisho.decision.aws.iam.policy_service_limitation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.policy_service_limitation_payload({
#       "allow_policy_statements": [{"resource": "example", "actions": ["example"]}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_policy_service_limitation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_policy_service_limitation".
policy_service_limitation(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": policy_service_limitation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": policy_service_limitation_locator(d),
			"severity": policy_service_limitation_severity(d),
		}),
		"payload": d.payload,
	}
}

policy_service_limitation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

policy_service_limitation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

policy_service_limitation_kind = "aws_iam_policy_service_limitation"

policy_service_limitation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": policy_service_limitation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "IAM.21",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(policy_service_limitation_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
policy_service_limitation_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_policy_service_limitation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_policy_service_limitation
#
#   The parameter `data` is an object with the following fields:
#   - allow_policy_statements: {"resource": string, "actions": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allow_policy_statements": [{"resource": "example", "actions": ["example"]}],
#   }
#   ```
policy_service_limitation_payload(edata) := x {
	policy_service_limitation_payload_assert(edata, "<the argument to policy_service_limitation_payload>")
	x := json.marshal(edata)
} else := ""

policy_service_limitation_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "allow_policy_statements", concat("", [hint, ".", "allow_policy_statements"]))]
	every c in key_checks { c }

	value_checks := [policy_service_limitation_payload_assert_allow_policy_statements(edata, "allow_policy_statements", concat("", [hint, ".", "allow_policy_statements"]))]
	every c in value_checks { c }
} else := false

policy_service_limitation_payload_assert_allow_policy_statements(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [policy_service_limitation_payload_assert_allow_policy_statements_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

policy_service_limitation_payload_assert_allow_policy_statements_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "resource", "string", hint),
		assertion.has_typed_key(x[key], "actions", "array", hint),
	]
	every c in key_checks { c }
	value_checks := [
		policy_service_limitation_payload_assert_allow_policy_statements_element_resource(x[key], "resource", concat("", [hint, ".", "resource"])),
		policy_service_limitation_payload_assert_allow_policy_statements_element_actions(x[key], "actions", concat("", [hint, ".", "actions"])),
	]
	every c in value_checks { c }
} else := false

policy_service_limitation_payload_assert_allow_policy_statements_element_actions(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [policy_service_limitation_payload_assert_allow_policy_statements_element_actions_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

policy_service_limitation_payload_assert_allow_policy_statements_element_actions_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

policy_service_limitation_payload_assert_allow_policy_statements_element_resource(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
