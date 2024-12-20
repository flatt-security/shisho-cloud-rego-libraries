# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.logmetric

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure a log metric filter and alarm exist for unauthorized API calls
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
#   d := shisho.decision.aws.logmetric.unauthorized_api_calls({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.logmetric.unauthorized_api_calls_payload({
#       "cis_notification_implementations": [{"trail_name": "example", "metric_name": "example", "alarm_name": "example", "sns_topic_arn": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_logmetric_unauthorized_api_calls"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_logmetric_unauthorized_api_calls".
unauthorized_api_calls(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": unauthorized_api_calls_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": unauthorized_api_calls_locator(d),
			"severity": unauthorized_api_calls_severity(d),
		}),
		"payload": d.payload,
	}
}

unauthorized_api_calls_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

unauthorized_api_calls_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

unauthorized_api_calls_kind = "aws_logmetric_unauthorized_api_calls"

unauthorized_api_calls_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": unauthorized_api_calls_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "4.1",
			"decision.api.shisho.dev:aws/cis-benchmark/v3.0.0": "4.1",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(unauthorized_api_calls_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
unauthorized_api_calls_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_logmetric_unauthorized_api_calls"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_logmetric_unauthorized_api_calls
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
unauthorized_api_calls_payload(edata) := x {
	unauthorized_api_calls_payload_assert(edata, "<the argument to unauthorized_api_calls_payload>")
	x := json.marshal(edata)
} else := ""

unauthorized_api_calls_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "cis_notification_implementations", concat("", [hint, ".", "cis_notification_implementations"]))]
	every c in key_checks { c }

	value_checks := [unauthorized_api_calls_payload_assert_cis_notification_implementations(edata, "cis_notification_implementations", concat("", [hint, ".", "cis_notification_implementations"]))]
	every c in value_checks { c }
} else := false

unauthorized_api_calls_payload_assert_cis_notification_implementations(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [unauthorized_api_calls_payload_assert_cis_notification_implementations_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

unauthorized_api_calls_payload_assert_cis_notification_implementations_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "trail_name", "string", hint),
		assertion.has_typed_key(x[key], "metric_name", "string", hint),
		assertion.has_typed_key(x[key], "sns_topic_arn", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		unauthorized_api_calls_payload_assert_cis_notification_implementations_element_trail_name(x[key], "trail_name", concat("", [hint, ".", "trail_name"])),
		unauthorized_api_calls_payload_assert_cis_notification_implementations_element_metric_name(x[key], "metric_name", concat("", [hint, ".", "metric_name"])),
		unauthorized_api_calls_payload_assert_cis_notification_implementations_element_alarm_name(x[key], "alarm_name", concat("", [hint, ".", "alarm_name"])),
		unauthorized_api_calls_payload_assert_cis_notification_implementations_element_sns_topic_arn(x[key], "sns_topic_arn", concat("", [hint, ".", "sns_topic_arn"])),
	]
	every c in value_checks { c }
} else := false

unauthorized_api_calls_payload_assert_cis_notification_implementations_element_alarm_name(x, key, hint) {
	not primitive.has_key(x, key)
} else {
	is_null(x[key])
} else {
	assertion.is_type(x[key], "string", hint)
} else := false

unauthorized_api_calls_payload_assert_cis_notification_implementations_element_metric_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

unauthorized_api_calls_payload_assert_cis_notification_implementations_element_sns_topic_arn(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

unauthorized_api_calls_payload_assert_cis_notification_implementations_element_trail_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
