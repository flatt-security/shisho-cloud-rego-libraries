# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.networking

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure no security groups allow ingress from ::/0 to remote server administration ports
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
#   d := shisho.decision.aws.networking.sg_ingress_v6({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.networking.sg_ingress_v6_payload({
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_networking_sg_ingress_v6"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_networking_sg_ingress_v6".
sg_ingress_v6(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": sg_ingress_v6_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": sg_ingress_v6_locator(d),
			"severity": sg_ingress_v6_severity(d),
		}),
		"payload": d.payload,
	}
}

sg_ingress_v6_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

sg_ingress_v6_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

sg_ingress_v6_kind = "aws_networking_sg_ingress_v6"

sg_ingress_v6_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": sg_ingress_v6_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "5.3",
			"decision.api.shisho.dev:aws/cis-benchmark/v3.0.0": "5.3",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(sg_ingress_v6_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
sg_ingress_v6_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_networking_sg_ingress_v6"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_networking_sg_ingress_v6
#
#   The parameter `data` shoud be empty object (`{}`).
sg_ingress_v6_payload(edata) := x {
	sg_ingress_v6_payload_assert(edata, "<the argument to sg_ingress_v6_payload>")
	x := json.marshal(edata)
} else := ""

sg_ingress_v6_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := []
	every c in key_checks { c }

	value_checks := []
	every c in value_checks { c }
} else := false
