# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho

# @title Ensure multi-factor authentication (MFA) is enabled for all IAM users that have a console password
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
#   d := shisho.decision.aws.iam.user_mfa({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.user_mfa_payload({
#       "has_console_password": false,
#       "mfa_active": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_user_mfa"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_user_mfa".
user_mfa(d) = x {
	x := {
		"header": user_mfa_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": user_mfa_locator(d),
			"severity": user_mfa_severity(d),
		}),
		"payload": d.payload,
	}
}

user_mfa_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

user_mfa_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

user_mfa_kind = "aws_iam_user_mfa"

user_mfa_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": user_mfa_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.10",
			"decision.api.shisho.dev:aws/fsbp/latest": "IAM.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(user_mfa_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
user_mfa_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_user_mfa"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_user_mfa
#
#   The parameter `data` is an object with the following fields: 
#   - has_console_password: boolean
#   - mfa_active: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "has_console_password": false,
#     "mfa_active": false,
#   }
#   ```
user_mfa_payload(edata) = x {
	x := json.marshal(edata)
}