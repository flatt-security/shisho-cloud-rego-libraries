# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.alb

import data.shisho

# @title Ensure Application Load Balancers drop invalid HTTP headers
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
#   d := shisho.decision.aws.alb.invalid_header_handling({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.alb.invalid_header_handling_payload({
#       "invalid_header_mitigation_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_alb_invalid_header_handling"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_alb_invalid_header_handling".
invalid_header_handling(d) = x {
	x := {
		"header": invalid_header_handling_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": invalid_header_handling_locator(d),
			"severity": invalid_header_handling_severity(d),
		}),
		"payload": d.payload,
	}
}

invalid_header_handling_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

invalid_header_handling_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

invalid_header_handling_kind = "aws_alb_invalid_header_handling"

invalid_header_handling_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": invalid_header_handling_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "ELB.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(invalid_header_handling_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
invalid_header_handling_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_alb_invalid_header_handling"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_alb_invalid_header_handling
#
#   The parameter `data` is an object with the following fields: 
#   - invalid_header_mitigation_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "invalid_header_mitigation_enabled": false,
#   }
#   ```
invalid_header_handling_payload(edata) = x {
	x := json.marshal(edata)
}