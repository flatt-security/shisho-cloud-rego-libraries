# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.apigateway

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that access logging should be configured for API Gateway V2 Stages
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
#   d := shisho.decision.aws.apigateway.access_logging({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.apigateway.access_logging_payload({
#       "stages": [{"name": "example", "access_log_destination_arn": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_apigateway_access_logging"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_apigateway_access_logging".
access_logging(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": access_logging_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": access_logging_locator(d),
			"severity": access_logging_severity(d),
		}),
		"payload": d.payload,
	}
}

access_logging_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

access_logging_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

access_logging_kind = "aws_apigateway_access_logging"

access_logging_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": access_logging_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "APIGateway.9",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(access_logging_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
access_logging_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_apigateway_access_logging"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_apigateway_access_logging
#
#   The parameter `data` is an object with the following fields:
#   - stages: {"name": string, "access_log_destination_arn": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "stages": [{"name": "example", "access_log_destination_arn": "example"}],
#   }
#   ```
access_logging_payload(edata) := x {
	access_logging_payload_assert(edata, "<the argument to access_logging_payload>")
	x := json.marshal(edata)
} else := ""

access_logging_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "stages", concat("", [hint, ".", "stages"]))]
	every c in key_checks { c }

	value_checks := [access_logging_payload_assert_stages(edata, "stages", concat("", [hint, ".", "stages"]))]
	every c in value_checks { c }
} else := false

access_logging_payload_assert_stages(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [access_logging_payload_assert_stages_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

access_logging_payload_assert_stages_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "name", "string", hint),
		assertion.has_typed_key(x[key], "access_log_destination_arn", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		access_logging_payload_assert_stages_element_name(x[key], "name", concat("", [hint, ".", "name"])),
		access_logging_payload_assert_stages_element_access_log_destination_arn(x[key], "access_log_destination_arn", concat("", [hint, ".", "access_log_destination_arn"])),
	]
	every c in value_checks { c }
} else := false

access_logging_payload_assert_stages_element_access_log_destination_arn(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

access_logging_payload_assert_stages_element_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
