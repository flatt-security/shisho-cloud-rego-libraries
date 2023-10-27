# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Cloud SQL instances require TLS for all incoming connections
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
#   d := shisho.decision.googlecloud.sql.instance_connection({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_connection_payload({
#       "tls_required": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_connection"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_connection".
instance_connection(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_connection_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_connection_locator(d),
			"severity": instance_connection_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_connection_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

instance_connection_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_connection_kind = "googlecloud_sql_instance_connection"

instance_connection_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_connection_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_connection_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_connection_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_connection"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_connection
#
#   The parameter `data` is an object with the following fields: 
#   - tls_required: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "tls_required": false,
#   }
#   ```
instance_connection_payload(edata) := x {
	instance_connection_payload_assert(edata, "<the argument to instance_connection_payload>")
	x := json.marshal(edata)
} else := ""

instance_connection_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "tls_required", concat("", [hint, ".", "tls_required"]))]
	every c in key_checks { c }

	value_checks := [instance_connection_payload_assert_tls_required(edata, "tls_required", concat("", [hint, ".", "tls_required"]))]
	every c in value_checks { c }
} else := false

instance_connection_payload_assert_tls_required(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
