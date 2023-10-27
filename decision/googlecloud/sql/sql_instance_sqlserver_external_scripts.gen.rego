# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure cross_db_ownership_chaining_state database flag for a Cloud SQL for SQL Server instance is set to off
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
#   d := shisho.decision.googlecloud.sql.instance_sqlserver_external_scripts({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_sqlserver_external_scripts_payload({
#       "external_scripts_state": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_external_scripts"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_external_scripts".
instance_sqlserver_external_scripts(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_sqlserver_external_scripts_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_sqlserver_external_scripts_locator(d),
			"severity": instance_sqlserver_external_scripts_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_sqlserver_external_scripts_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_sqlserver_external_scripts_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_sqlserver_external_scripts_kind = "googlecloud_sql_instance_sqlserver_external_scripts"

instance_sqlserver_external_scripts_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_sqlserver_external_scripts_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.3.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_sqlserver_external_scripts_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_sqlserver_external_scripts_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_external_scripts"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_external_scripts
#
#   The parameter `data` is an object with the following fields: 
#   - external_scripts_state: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "external_scripts_state": "example",
#   }
#   ```
instance_sqlserver_external_scripts_payload(edata) := x {
	instance_sqlserver_external_scripts_payload_assert(edata, "<the argument to instance_sqlserver_external_scripts_payload>")
	x := json.marshal(edata)
} else := ""

instance_sqlserver_external_scripts_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "external_scripts_state", concat("", [hint, ".", "external_scripts_state"]))]
	every c in key_checks { c }

	value_checks := [instance_sqlserver_external_scripts_payload_assert_external_scripts_state(edata, "external_scripts_state", concat("", [hint, ".", "external_scripts_state"]))]
	every c in value_checks { c }
} else := false

instance_sqlserver_external_scripts_payload_assert_external_scripts_state(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
