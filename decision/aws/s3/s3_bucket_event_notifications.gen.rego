# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.s3

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that S3 buckets have event notifications enabled
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
#   d := shisho.decision.aws.s3.bucket_event_notifications({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.s3.bucket_event_notifications_payload({
#       "notification_eventbridge_enabled": false,
#       "notification_lambda_function_arns": ["example"],
#       "notification_sns_topic_arns": ["example"],
#       "notification_sqs_queue_arns": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_s3_bucket_event_notifications"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_s3_bucket_event_notifications".
bucket_event_notifications(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": bucket_event_notifications_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": bucket_event_notifications_locator(d),
			"severity": bucket_event_notifications_severity(d),
		}),
		"payload": d.payload,
	}
}

bucket_event_notifications_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

bucket_event_notifications_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

bucket_event_notifications_kind = "aws_s3_bucket_event_notifications"

bucket_event_notifications_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": bucket_event_notifications_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "S3.11",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(bucket_event_notifications_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
bucket_event_notifications_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_s3_bucket_event_notifications"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_s3_bucket_event_notifications
#
#   The parameter `data` is an object with the following fields:
#   - notification_eventbridge_enabled: boolean
#   - notification_lambda_function_arns: string
#   - notification_sns_topic_arns: string
#   - notification_sqs_queue_arns: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "notification_eventbridge_enabled": false,
#     "notification_lambda_function_arns": ["example"],
#     "notification_sns_topic_arns": ["example"],
#     "notification_sqs_queue_arns": ["example"],
#   }
#   ```
bucket_event_notifications_payload(edata) := x {
	bucket_event_notifications_payload_assert(edata, "<the argument to bucket_event_notifications_payload>")
	x := json.marshal(edata)
} else := ""

bucket_event_notifications_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "notification_eventbridge_enabled", concat("", [hint, ".", "notification_eventbridge_enabled"])),
		assertion.has_key(edata, "notification_lambda_function_arns", concat("", [hint, ".", "notification_lambda_function_arns"])),
		assertion.has_key(edata, "notification_sns_topic_arns", concat("", [hint, ".", "notification_sns_topic_arns"])),
		assertion.has_key(edata, "notification_sqs_queue_arns", concat("", [hint, ".", "notification_sqs_queue_arns"])),
	]
	every c in key_checks { c }

	value_checks := [
		bucket_event_notifications_payload_assert_notification_eventbridge_enabled(edata, "notification_eventbridge_enabled", concat("", [hint, ".", "notification_eventbridge_enabled"])),
		bucket_event_notifications_payload_assert_notification_lambda_function_arns(edata, "notification_lambda_function_arns", concat("", [hint, ".", "notification_lambda_function_arns"])),
		bucket_event_notifications_payload_assert_notification_sns_topic_arns(edata, "notification_sns_topic_arns", concat("", [hint, ".", "notification_sns_topic_arns"])),
		bucket_event_notifications_payload_assert_notification_sqs_queue_arns(edata, "notification_sqs_queue_arns", concat("", [hint, ".", "notification_sqs_queue_arns"])),
	]
	every c in value_checks { c }
} else := false

bucket_event_notifications_payload_assert_notification_eventbridge_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

bucket_event_notifications_payload_assert_notification_lambda_function_arns(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [bucket_event_notifications_payload_assert_notification_lambda_function_arns_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

bucket_event_notifications_payload_assert_notification_lambda_function_arns_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

bucket_event_notifications_payload_assert_notification_sns_topic_arns(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [bucket_event_notifications_payload_assert_notification_sns_topic_arns_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

bucket_event_notifications_payload_assert_notification_sns_topic_arns_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

bucket_event_notifications_payload_assert_notification_sqs_queue_arns(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [bucket_event_notifications_payload_assert_notification_sqs_queue_arns_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

bucket_event_notifications_payload_assert_notification_sqs_queue_arns_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
