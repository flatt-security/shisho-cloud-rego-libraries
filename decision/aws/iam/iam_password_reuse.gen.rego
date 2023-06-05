# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho

# @title Ensure IAM password policy prevents password reuse
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
#   d := shisho.decision.aws.iam.password_reuse({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.password_reuse_payload({
#       "current_reuse_prevention": 0,
#       "reuse_prevention_policy_recommendation": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_password_reuse"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_password_reuse".
password_reuse(d) = x {
	x := {
		"header": password_reuse_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": password_reuse_locator(d),
			"severity": password_reuse_severity(d),
		}),
		"payload": d.payload,
	}
}

password_reuse_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

password_reuse_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

password_reuse_kind = "aws_iam_password_reuse"

password_reuse_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": password_reuse_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.9",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(password_reuse_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
password_reuse_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_password_reuse"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_password_reuse
#
#   The parameter `data` is an object with the following fields: 
#   - current_reuse_prevention: number
#   - reuse_prevention_policy_recommendation: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "current_reuse_prevention": 0,
#     "reuse_prevention_policy_recommendation": 0,
#   }
#   ```
password_reuse_payload(edata) = x {
	x := json.marshal(edata)
}