# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho

# @title Ensure Hardware MFA is enabled for the root user account
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
#   d := shisho.decision.aws.iam.root_user_hardware_mfa({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.root_user_hardware_mfa_payload({
#       "hardware_mfa_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa".
root_user_hardware_mfa(d) = x {
	x := {
		"header": root_user_hardware_mfa_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": root_user_hardware_mfa_locator(d),
			"severity": root_user_hardware_mfa_severity(d),
		}),
		"payload": d.payload,
	}
}

root_user_hardware_mfa_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

root_user_hardware_mfa_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

root_user_hardware_mfa_kind = "aws_iam_root_user_hardware_mfa"

root_user_hardware_mfa_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": root_user_hardware_mfa_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.6",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(root_user_hardware_mfa_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
root_user_hardware_mfa_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa
#
#   The parameter `data` is an object with the following fields: 
#   - hardware_mfa_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "hardware_mfa_enabled": false,
#   }
#   ```
root_user_hardware_mfa_payload(edata) = x {
	x := json.marshal(edata)
}
