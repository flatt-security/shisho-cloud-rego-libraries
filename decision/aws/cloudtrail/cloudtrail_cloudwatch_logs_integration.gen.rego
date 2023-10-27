# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.cloudtrail

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure CloudTrail trails are integrated with CloudWatch Logs
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
#   d := shisho.decision.aws.cloudtrail.cloudwatch_logs_integration({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.cloudtrail.cloudwatch_logs_integration_payload({
#       "integrated": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_cloudtrail_cloudwatch_logs_integration"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_cloudtrail_cloudwatch_logs_integration".
cloudwatch_logs_integration(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": cloudwatch_logs_integration_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": cloudwatch_logs_integration_locator(d),
			"severity": cloudwatch_logs_integration_severity(d),
		}),
		"payload": d.payload,
	}
}

cloudwatch_logs_integration_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

cloudwatch_logs_integration_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

cloudwatch_logs_integration_kind = "aws_cloudtrail_cloudwatch_logs_integration"

cloudwatch_logs_integration_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": cloudwatch_logs_integration_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "3.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(cloudwatch_logs_integration_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
cloudwatch_logs_integration_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_cloudtrail_cloudwatch_logs_integration"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_cloudtrail_cloudwatch_logs_integration
#
#   The parameter `data` is an object with the following fields:
#   - integrated: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "integrated": false,
#   }
#   ```
cloudwatch_logs_integration_payload(edata) := x {
	cloudwatch_logs_integration_payload_assert(edata, "<the argument to cloudwatch_logs_integration_payload>")
	x := json.marshal(edata)
} else := ""

cloudwatch_logs_integration_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "integrated", concat("", [hint, ".", "integrated"]))]
	every c in key_checks { c }

	value_checks := [cloudwatch_logs_integration_payload_assert_integrated(edata, "integrated", concat("", [hint, ".", "integrated"]))]
	every c in value_checks { c }
} else := false

cloudwatch_logs_integration_payload_assert_integrated(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
