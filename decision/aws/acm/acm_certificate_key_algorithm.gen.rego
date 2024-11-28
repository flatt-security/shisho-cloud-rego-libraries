# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.acm

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that ACM RSA certificates use allowed key algorithms
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
#   d := shisho.decision.aws.acm.certificate_key_algorithm({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.acm.certificate_key_algorithm_payload({
#       "key_algorithm": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_acm_certificate_key_algorithm"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_acm_certificate_key_algorithm".
certificate_key_algorithm(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": certificate_key_algorithm_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": certificate_key_algorithm_locator(d),
			"severity": certificate_key_algorithm_severity(d),
		}),
		"payload": d.payload,
	}
}

certificate_key_algorithm_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

certificate_key_algorithm_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

certificate_key_algorithm_kind = "aws_acm_certificate_key_algorithm"

certificate_key_algorithm_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": certificate_key_algorithm_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "ACM.2",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(certificate_key_algorithm_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
certificate_key_algorithm_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_acm_certificate_key_algorithm"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_acm_certificate_key_algorithm
#
#   The parameter `data` is an object with the following fields:
#   - key_algorithm: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "key_algorithm": "example",
#   }
#   ```
certificate_key_algorithm_payload(edata) := x {
	certificate_key_algorithm_payload_assert(edata, "<the argument to certificate_key_algorithm_payload>")
	x := json.marshal(edata)
} else := ""

certificate_key_algorithm_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "key_algorithm", concat("", [hint, ".", "key_algorithm"]))]
	every c in key_checks { c }

	value_checks := [certificate_key_algorithm_payload_assert_key_algorithm(edata, "key_algorithm", concat("", [hint, ".", "key_algorithm"]))]
	every c in value_checks { c }
} else := false

certificate_key_algorithm_payload_assert_key_algorithm(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
