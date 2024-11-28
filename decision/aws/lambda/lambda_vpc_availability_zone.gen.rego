# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.lambda

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that VPC Lambda functions operate in more than one Availability Zone
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
#   d := shisho.decision.aws.lambda.vpc_availability_zone({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.lambda.vpc_availability_zone_payload({
#       "subnet_ids": ["example"],
#       "vpc_id": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_lambda_vpc_availability_zone"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_lambda_vpc_availability_zone".
vpc_availability_zone(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": vpc_availability_zone_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": vpc_availability_zone_locator(d),
			"severity": vpc_availability_zone_severity(d),
		}),
		"payload": d.payload,
	}
}

vpc_availability_zone_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

vpc_availability_zone_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

vpc_availability_zone_kind = "aws_lambda_vpc_availability_zone"

vpc_availability_zone_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": vpc_availability_zone_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "Lambda.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(vpc_availability_zone_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
vpc_availability_zone_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_lambda_vpc_availability_zone"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_lambda_vpc_availability_zone
#
#   The parameter `data` is an object with the following fields:
#   - subnet_ids: string
#   - vpc_id: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "subnet_ids": ["example"],
#     "vpc_id": "example",
#   }
#   ```
vpc_availability_zone_payload(edata) := x {
	vpc_availability_zone_payload_assert(edata, "<the argument to vpc_availability_zone_payload>")
	x := json.marshal(edata)
} else := ""

vpc_availability_zone_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "subnet_ids", concat("", [hint, ".", "subnet_ids"])),
		assertion.has_key(edata, "vpc_id", concat("", [hint, ".", "vpc_id"])),
	]
	every c in key_checks { c }

	value_checks := [
		vpc_availability_zone_payload_assert_subnet_ids(edata, "subnet_ids", concat("", [hint, ".", "subnet_ids"])),
		vpc_availability_zone_payload_assert_vpc_id(edata, "vpc_id", concat("", [hint, ".", "vpc_id"])),
	]
	every c in value_checks { c }
} else := false

vpc_availability_zone_payload_assert_subnet_ids(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [vpc_availability_zone_payload_assert_subnet_ids_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

vpc_availability_zone_payload_assert_subnet_ids_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

vpc_availability_zone_payload_assert_vpc_id(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
