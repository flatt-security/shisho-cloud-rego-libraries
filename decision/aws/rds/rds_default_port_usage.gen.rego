# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.rds

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that RDS instances and clusters do not use a database engine default port
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
#   d := shisho.decision.aws.rds.default_port_usage({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.rds.default_port_usage_payload({
#       "engine": "example",
#       "port": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_rds_default_port_usage"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_rds_default_port_usage".
default_port_usage(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": default_port_usage_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": default_port_usage_locator(d),
			"severity": default_port_usage_severity(d),
		}),
		"payload": d.payload,
	}
}

default_port_usage_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

default_port_usage_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

default_port_usage_kind = "aws_rds_default_port_usage"

default_port_usage_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": default_port_usage_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "RDS.23",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(default_port_usage_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
default_port_usage_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_rds_default_port_usage"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_rds_default_port_usage
#
#   The parameter `data` is an object with the following fields:
#   - engine: string
#   - port: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "engine": "example",
#     "port": 0,
#   }
#   ```
default_port_usage_payload(edata) := x {
	default_port_usage_payload_assert(edata, "<the argument to default_port_usage_payload>")
	x := json.marshal(edata)
} else := ""

default_port_usage_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "engine", concat("", [hint, ".", "engine"])),
		assertion.has_key(edata, "port", concat("", [hint, ".", "port"])),
	]
	every c in key_checks { c }

	value_checks := [
		default_port_usage_payload_assert_engine(edata, "engine", concat("", [hint, ".", "engine"])),
		default_port_usage_payload_assert_port(edata, "port", concat("", [hint, ".", "port"])),
	]
	every c in value_checks { c }
} else := false

default_port_usage_payload_assert_engine(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

default_port_usage_payload_assert_port(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false
