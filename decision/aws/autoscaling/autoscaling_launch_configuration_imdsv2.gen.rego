# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.autoscaling

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that Auto Scaling groups require IMDSv2
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
#   d := shisho.decision.aws.autoscaling.launch_configuration_imdsv2({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.autoscaling.launch_configuration_imdsv2_payload({
#       "imdsv2_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_autoscaling_launch_configuration_imdsv2"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_autoscaling_launch_configuration_imdsv2".
launch_configuration_imdsv2(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": launch_configuration_imdsv2_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": launch_configuration_imdsv2_locator(d),
			"severity": launch_configuration_imdsv2_severity(d),
		}),
		"payload": d.payload,
	}
}

launch_configuration_imdsv2_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

launch_configuration_imdsv2_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

launch_configuration_imdsv2_kind = "aws_autoscaling_launch_configuration_imdsv2"

launch_configuration_imdsv2_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": launch_configuration_imdsv2_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "AutoScaling.3",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(launch_configuration_imdsv2_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
launch_configuration_imdsv2_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_autoscaling_launch_configuration_imdsv2"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_autoscaling_launch_configuration_imdsv2
#
#   The parameter `data` is an object with the following fields:
#   - imdsv2_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "imdsv2_enabled": false,
#   }
#   ```
launch_configuration_imdsv2_payload(edata) := x {
	launch_configuration_imdsv2_payload_assert(edata, "<the argument to launch_configuration_imdsv2_payload>")
	x := json.marshal(edata)
} else := ""

launch_configuration_imdsv2_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "imdsv2_enabled", concat("", [hint, ".", "imdsv2_enabled"]))]
	every c in key_checks { c }

	value_checks := [launch_configuration_imdsv2_payload_assert_imdsv2_enabled(edata, "imdsv2_enabled", concat("", [hint, ".", "imdsv2_enabled"]))]
	every c in value_checks { c }
} else := false

launch_configuration_imdsv2_payload_assert_imdsv2_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
