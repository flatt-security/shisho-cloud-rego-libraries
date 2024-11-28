# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.alb

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Application Load Balancers mitigate HTTP desync attacks
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
#   d := shisho.decision.aws.alb.desync_mitigation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.alb.desync_mitigation_payload({
#       "desync_mitigation_mode": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_alb_desync_mitigation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_alb_desync_mitigation".
desync_mitigation(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": desync_mitigation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": desync_mitigation_locator(d),
			"severity": desync_mitigation_severity(d),
		}),
		"payload": d.payload,
	}
}

desync_mitigation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

desync_mitigation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

desync_mitigation_kind = "aws_alb_desync_mitigation"

desync_mitigation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": desync_mitigation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "ELB.12",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(desync_mitigation_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
desync_mitigation_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_alb_desync_mitigation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_alb_desync_mitigation
#
#   The parameter `data` is an object with the following fields:
#   - desync_mitigation_mode: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "desync_mitigation_mode": "example",
#   }
#   ```
desync_mitigation_payload(edata) := x {
	desync_mitigation_payload_assert(edata, "<the argument to desync_mitigation_payload>")
	x := json.marshal(edata)
} else := ""

desync_mitigation_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "desync_mitigation_mode", concat("", [hint, ".", "desync_mitigation_mode"]))]
	every c in key_checks { c }

	value_checks := [desync_mitigation_payload_assert_desync_mitigation_mode(edata, "desync_mitigation_mode", concat("", [hint, ".", "desync_mitigation_mode"]))]
	every c in value_checks { c }
} else := false

desync_mitigation_payload_assert_desync_mitigation_mode(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
