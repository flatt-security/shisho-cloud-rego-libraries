# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure the AWS root user is used only for limited usage
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
#   d := shisho.decision.aws.iam.root_user_usage({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.root_user_usage_payload({
#       "last_used_at": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_root_user_usage"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_root_user_usage".
root_user_usage(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": root_user_usage_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": root_user_usage_locator(d),
			"severity": root_user_usage_severity(d),
		}),
		"payload": d.payload,
	}
}

root_user_usage_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 4

root_user_usage_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

root_user_usage_kind = "aws_iam_root_user_usage"

root_user_usage_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": root_user_usage_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.7",
			"decision.api.shisho.dev:aws/cis-benchmark/v3.0.0": "1.7",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(root_user_usage_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
root_user_usage_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_root_user_usage"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_root_user_usage
#
#   The parameter `data` is an object with the following fields:
#   - last_used_at: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "last_used_at": "example",
#   }
#   ```
root_user_usage_payload(edata) := x {
	root_user_usage_payload_assert(edata, "<the argument to root_user_usage_payload>")
	x := json.marshal(edata)
} else := ""

root_user_usage_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "last_used_at", concat("", [hint, ".", "last_used_at"]))]
	every c in key_checks { c }

	value_checks := [root_user_usage_payload_assert_last_used_at(edata, "last_used_at", concat("", [hint, ".", "last_used_at"]))]
	every c in value_checks { c }
} else := false

root_user_usage_payload_assert_last_used_at(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
