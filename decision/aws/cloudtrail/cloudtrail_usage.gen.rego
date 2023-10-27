# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.cloudtrail

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure CloudTrail is enabled in all regions
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
#   d := shisho.decision.aws.cloudtrail.usage({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.cloudtrail.usage_payload({
#       "trail_arns": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_cloudtrail_usage"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_cloudtrail_usage".
usage(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": usage_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": usage_locator(d),
			"severity": usage_severity(d),
		}),
		"payload": d.payload,
	}
}

usage_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

usage_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

usage_kind = "aws_cloudtrail_usage"

usage_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": usage_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "3.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(usage_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
usage_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_cloudtrail_usage"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_cloudtrail_usage
#
#   The parameter `data` is an object with the following fields: 
#   - trail_arns: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "trail_arns": ["example"],
#   }
#   ```
usage_payload(edata) := x {
	usage_payload_assert(edata, "<the argument to usage_payload>")
	x := json.marshal(edata)
} else := ""

usage_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "trail_arns", concat("", [hint, ".", "trail_arns"]))]
	every c in key_checks { c }

	value_checks := [usage_payload_assert_trail_arns(edata, "trail_arns", concat("", [hint, ".", "trail_arns"]))]
	every c in value_checks { c }
} else := false

usage_payload_assert_trail_arns(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [usage_payload_assert_trail_arns_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

usage_payload_assert_trail_arns_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
