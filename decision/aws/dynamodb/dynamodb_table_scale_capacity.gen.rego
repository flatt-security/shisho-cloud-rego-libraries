# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.dynamodb

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that DynamoDB tables use auto scaling
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
#   d := shisho.decision.aws.dynamodb.table_scale_capacity({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.dynamodb.table_scale_capacity_payload({
#       "autoscaling_enabled": false,
#       "billing_mode": "example",
#       "read_capacity": 0,
#       "write_capacity": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_dynamodb_table_scale_capacity"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_dynamodb_table_scale_capacity".
table_scale_capacity(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": table_scale_capacity_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": table_scale_capacity_locator(d),
			"severity": table_scale_capacity_severity(d),
		}),
		"payload": d.payload,
	}
}

table_scale_capacity_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

table_scale_capacity_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

table_scale_capacity_kind = "aws_dynamodb_table_scale_capacity"

table_scale_capacity_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": table_scale_capacity_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "DynamoDB.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(table_scale_capacity_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
table_scale_capacity_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_dynamodb_table_scale_capacity"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_dynamodb_table_scale_capacity
#
#   The parameter `data` is an object with the following fields:
#   - autoscaling_enabled: boolean
#   - billing_mode: string
#   - read_capacity: number
#   - write_capacity: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "autoscaling_enabled": false,
#     "billing_mode": "example",
#     "read_capacity": 0,
#     "write_capacity": 0,
#   }
#   ```
table_scale_capacity_payload(edata) := x {
	table_scale_capacity_payload_assert(edata, "<the argument to table_scale_capacity_payload>")
	x := json.marshal(edata)
} else := ""

table_scale_capacity_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "autoscaling_enabled", concat("", [hint, ".", "autoscaling_enabled"])),
		assertion.has_key(edata, "billing_mode", concat("", [hint, ".", "billing_mode"])),
		assertion.has_key(edata, "read_capacity", concat("", [hint, ".", "read_capacity"])),
		assertion.has_key(edata, "write_capacity", concat("", [hint, ".", "write_capacity"])),
	]
	every c in key_checks { c }

	value_checks := [
		table_scale_capacity_payload_assert_autoscaling_enabled(edata, "autoscaling_enabled", concat("", [hint, ".", "autoscaling_enabled"])),
		table_scale_capacity_payload_assert_billing_mode(edata, "billing_mode", concat("", [hint, ".", "billing_mode"])),
		table_scale_capacity_payload_assert_read_capacity(edata, "read_capacity", concat("", [hint, ".", "read_capacity"])),
		table_scale_capacity_payload_assert_write_capacity(edata, "write_capacity", concat("", [hint, ".", "write_capacity"])),
	]
	every c in value_checks { c }
} else := false

table_scale_capacity_payload_assert_autoscaling_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

table_scale_capacity_payload_assert_billing_mode(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

table_scale_capacity_payload_assert_read_capacity(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false

table_scale_capacity_payload_assert_write_capacity(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false
