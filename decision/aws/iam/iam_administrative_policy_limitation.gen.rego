# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure IAM policies that allow full administrative privileges are not attached
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
#   d := shisho.decision.aws.iam.administrative_policy_limitation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.administrative_policy_limitation_payload({
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation".
administrative_policy_limitation(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": administrative_policy_limitation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": administrative_policy_limitation_locator(d),
			"severity": administrative_policy_limitation_severity(d),
		}),
		"payload": d.payload,
	}
}

administrative_policy_limitation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 4

administrative_policy_limitation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

administrative_policy_limitation_kind = "aws_iam_administrative_policy_limitation"

administrative_policy_limitation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": administrative_policy_limitation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.16",
			"decision.api.shisho.dev:aws/fsbp/latest": "IAM.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(administrative_policy_limitation_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
administrative_policy_limitation_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation
#
#   The parameter `data` shoud be empty object (`{}`).
administrative_policy_limitation_payload(edata) := x {
	administrative_policy_limitation_payload_assert(edata, "<the argument to administrative_policy_limitation_payload>")
	x := json.marshal(edata)
} else := ""

administrative_policy_limitation_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := []
	every c in key_checks { c }

	value_checks := []
	every c in value_checks { c }
} else := false
