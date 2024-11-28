# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that the log_hostname database flag for Cloud SQL for PostgreSQL instance is set to on
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
#   d := shisho.decision.googlecloud.sql.instance_postgresql_log_hostname({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_postgresql_log_hostname_payload({
#       "log_hostname_state": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_hostname"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_hostname".
instance_postgresql_log_hostname(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_postgresql_log_hostname_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_postgresql_log_hostname_locator(d),
			"severity": instance_postgresql_log_hostname_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_postgresql_log_hostname_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_postgresql_log_hostname_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_postgresql_log_hostname_kind = "googlecloud_sql_instance_postgresql_log_hostname"

instance_postgresql_log_hostname_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_postgresql_log_hostname_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.2.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_postgresql_log_hostname_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_postgresql_log_hostname_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_hostname"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_postgresql_log_hostname
#
#   The parameter `data` is an object with the following fields:
#   - log_hostname_state: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "log_hostname_state": "example",
#   }
#   ```
instance_postgresql_log_hostname_payload(edata) := x {
	instance_postgresql_log_hostname_payload_assert(edata, "<the argument to instance_postgresql_log_hostname_payload>")
	x := json.marshal(edata)
} else := ""

instance_postgresql_log_hostname_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "log_hostname_state", concat("", [hint, ".", "log_hostname_state"]))]
	every c in key_checks { c }

	value_checks := [instance_postgresql_log_hostname_payload_assert_log_hostname_state(edata, "log_hostname_state", concat("", [hint, ".", "log_hostname_state"]))]
	every c in value_checks { c }
} else := false

instance_postgresql_log_hostname_payload_assert_log_hostname_state(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
