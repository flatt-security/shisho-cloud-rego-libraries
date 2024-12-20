# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.alb

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Application Load Balancers redirect all HTTP requests to HTTPS
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
#   d := shisho.decision.aws.alb.https_redirection({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.alb.https_redirection_payload({
#       "https_redirection_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_alb_https_redirection"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_alb_https_redirection".
https_redirection(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": https_redirection_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": https_redirection_locator(d),
			"severity": https_redirection_severity(d),
		}),
		"payload": d.payload,
	}
}

https_redirection_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

https_redirection_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

https_redirection_kind = "aws_alb_https_redirection"

https_redirection_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": https_redirection_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "ELB.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(https_redirection_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
https_redirection_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_alb_https_redirection"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_alb_https_redirection
#
#   The parameter `data` is an object with the following fields:
#   - https_redirection_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "https_redirection_enabled": false,
#   }
#   ```
https_redirection_payload(edata) := x {
	https_redirection_payload_assert(edata, "<the argument to https_redirection_payload>")
	x := json.marshal(edata)
} else := ""

https_redirection_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "https_redirection_enabled", concat("", [hint, ".", "https_redirection_enabled"]))]
	every c in key_checks { c }

	value_checks := [https_redirection_payload_assert_https_redirection_enabled(edata, "https_redirection_enabled", concat("", [hint, ".", "https_redirection_enabled"]))]
	every c in value_checks { c }
} else := false

https_redirection_payload_assert_https_redirection_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
