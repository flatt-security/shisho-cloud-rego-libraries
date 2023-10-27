# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that the log_min_error_statement database flag for Cloud SQL for PostgreSQL instance is set to error or stricter
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
#   d := shisho.decision.googlecloud.sql.instance_postgresql_log_min_error_statement({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_postgresql_log_min_error_statement_payload({
#       "log_min_error_statement_state": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_min_error_statement"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_min_error_statement".
instance_postgresql_log_min_error_statement(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_postgresql_log_min_error_statement_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_postgresql_log_min_error_statement_locator(d),
			"severity": instance_postgresql_log_min_error_statement_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_postgresql_log_min_error_statement_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_postgresql_log_min_error_statement_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_postgresql_log_min_error_statement_kind = "googlecloud_sql_instance_postgresql_log_min_error_statement"

instance_postgresql_log_min_error_statement_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_postgresql_log_min_error_statement_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.2.7",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_postgresql_log_min_error_statement_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_postgresql_log_min_error_statement_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_min_error_statement"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_min_error_statement
#
#   The parameter `data` is an object with the following fields: 
#   - log_min_error_statement_state: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "log_min_error_statement_state": "example",
#   }
#   ```
instance_postgresql_log_min_error_statement_payload(edata) := x {
	instance_postgresql_log_min_error_statement_payload_assert(edata, "<the argument to instance_postgresql_log_min_error_statement_payload>")
	x := json.marshal(edata)
} else := ""

instance_postgresql_log_min_error_statement_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "log_min_error_statement_state", concat("", [hint, ".", "log_min_error_statement_state"]))]
	every c in key_checks { c }

	value_checks := [instance_postgresql_log_min_error_statement_payload_assert_log_min_error_statement_state(edata, "log_min_error_statement_state", concat("", [hint, ".", "log_min_error_statement_state"]))]
	every c in value_checks { c }
} else := false

instance_postgresql_log_min_error_statement_payload_assert_log_min_error_statement_state(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
