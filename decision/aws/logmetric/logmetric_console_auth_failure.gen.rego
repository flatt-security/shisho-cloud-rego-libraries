# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.logmetric

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure a log metric filter and alarm exist for AWS Management Console authentication failures
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
#   d := shisho.decision.aws.logmetric.console_auth_failure({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.logmetric.console_auth_failure_payload({
#       "cis_notification_implementations": [{"trail_name": "example", "metric_name": "example", "alarm_name": "example", "sns_topic_arn": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_logmetric_console_auth_failure"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_logmetric_console_auth_failure".
console_auth_failure(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": console_auth_failure_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": console_auth_failure_locator(d),
			"severity": console_auth_failure_severity(d),
		}),
		"payload": d.payload,
	}
}

console_auth_failure_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

console_auth_failure_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

console_auth_failure_kind = "aws_logmetric_console_auth_failure"

console_auth_failure_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": console_auth_failure_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "4.6",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(console_auth_failure_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
console_auth_failure_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_logmetric_console_auth_failure"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_logmetric_console_auth_failure
#
#   The parameter `data` is an object with the following fields: 
#   - cis_notification_implementations: {"trail_name": string, "metric_name": string, "alarm_name": string, "sns_topic_arn": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "cis_notification_implementations": [{"trail_name": "example", "metric_name": "example", "alarm_name": "example", "sns_topic_arn": "example"}],
#   }
#   ```
console_auth_failure_payload(edata) := x {
	console_auth_failure_payload_assert(edata, "<the argument to console_auth_failure_payload>")
	x := json.marshal(edata)
} else := ""

console_auth_failure_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "cis_notification_implementations", concat("", [hint, ".", "cis_notification_implementations"]))]
	every c in key_checks { c }

	value_checks := [console_auth_failure_payload_assert_cis_notification_implementations(edata, "cis_notification_implementations", concat("", [hint, ".", "cis_notification_implementations"]))]
	every c in value_checks { c }
} else := false

console_auth_failure_payload_assert_cis_notification_implementations(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [console_auth_failure_payload_assert_cis_notification_implementations_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

console_auth_failure_payload_assert_cis_notification_implementations_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "trail_name", "string", hint),
		assertion.has_typed_key(x[key], "metric_name", "string", hint),
		assertion.has_typed_key(x[key], "sns_topic_arn", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		console_auth_failure_payload_assert_cis_notification_implementations_element_trail_name(x[key], "trail_name", concat("", [hint, ".", "trail_name"])),
		console_auth_failure_payload_assert_cis_notification_implementations_element_metric_name(x[key], "metric_name", concat("", [hint, ".", "metric_name"])),
		console_auth_failure_payload_assert_cis_notification_implementations_element_alarm_name(x[key], "alarm_name", concat("", [hint, ".", "alarm_name"])),
		console_auth_failure_payload_assert_cis_notification_implementations_element_sns_topic_arn(x[key], "sns_topic_arn", concat("", [hint, ".", "sns_topic_arn"])),
	]
	every c in value_checks { c }
} else := false

console_auth_failure_payload_assert_cis_notification_implementations_element_alarm_name(x, key, hint) {
	not primitive.has_key(x, key)
} else {
	assertion.is_type(x[key], "string", hint)
} else := false

console_auth_failure_payload_assert_cis_notification_implementations_element_metric_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

console_auth_failure_payload_assert_cis_notification_implementations_element_sns_topic_arn(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

console_auth_failure_payload_assert_cis_notification_implementations_element_trail_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
