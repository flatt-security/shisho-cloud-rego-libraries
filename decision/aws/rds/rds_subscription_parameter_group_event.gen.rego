# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.rds

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that an RDS event notifications subscription is configured for critical database parameter group events
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
#   d := shisho.decision.aws.rds.subscription_parameter_group_event({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.rds.subscription_parameter_group_event_payload({
#       "parameter_group_event_subscriptions": [{"id": "example", "event_categories": ["example"]}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_rds_subscription_parameter_group_event"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_rds_subscription_parameter_group_event".
subscription_parameter_group_event(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": subscription_parameter_group_event_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": subscription_parameter_group_event_locator(d),
			"severity": subscription_parameter_group_event_severity(d),
		}),
		"payload": d.payload,
	}
}

subscription_parameter_group_event_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

subscription_parameter_group_event_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

subscription_parameter_group_event_kind = "aws_rds_subscription_parameter_group_event"

subscription_parameter_group_event_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": subscription_parameter_group_event_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "RDS.21",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(subscription_parameter_group_event_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
subscription_parameter_group_event_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_rds_subscription_parameter_group_event"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_rds_subscription_parameter_group_event
#
#   The parameter `data` is an object with the following fields:
#   - parameter_group_event_subscriptions: {"id": string, "event_categories": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "parameter_group_event_subscriptions": [{"id": "example", "event_categories": ["example"]}],
#   }
#   ```
subscription_parameter_group_event_payload(edata) := x {
	subscription_parameter_group_event_payload_assert(edata, "<the argument to subscription_parameter_group_event_payload>")
	x := json.marshal(edata)
} else := ""

subscription_parameter_group_event_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "parameter_group_event_subscriptions", concat("", [hint, ".", "parameter_group_event_subscriptions"]))]
	every c in key_checks { c }

	value_checks := [subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions(edata, "parameter_group_event_subscriptions", concat("", [hint, ".", "parameter_group_event_subscriptions"]))]
	every c in value_checks { c }
} else := false

subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "id", "string", hint),
		assertion.has_typed_key(x[key], "event_categories", "array", hint),
	]
	every c in key_checks { c }
	value_checks := [
		subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element_id(x[key], "id", concat("", [hint, ".", "id"])),
		subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element_event_categories(x[key], "event_categories", concat("", [hint, ".", "event_categories"])),
	]
	every c in value_checks { c }
} else := false

subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element_event_categories(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element_event_categories_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element_event_categories_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

subscription_parameter_group_event_payload_assert_parameter_group_event_subscriptions_element_id(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
