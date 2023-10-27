# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure user_options_configured database flag for a Cloud SQL for SQL Server instance is not configured
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
#   d := shisho.decision.googlecloud.sql.instance_sqlserver_user_options({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_sqlserver_user_options_payload({
#       "user_options_configured": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_user_options"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_user_options".
instance_sqlserver_user_options(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_sqlserver_user_options_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_sqlserver_user_options_locator(d),
			"severity": instance_sqlserver_user_options_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_sqlserver_user_options_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_sqlserver_user_options_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_sqlserver_user_options_kind = "googlecloud_sql_instance_sqlserver_user_options"

instance_sqlserver_user_options_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_sqlserver_user_options_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.3.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_sqlserver_user_options_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_sqlserver_user_options_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_user_options"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_sqlserver_user_options
#
#   The parameter `data` is an object with the following fields:
#   - user_options_configured: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "user_options_configured": false,
#   }
#   ```
instance_sqlserver_user_options_payload(edata) := x {
	instance_sqlserver_user_options_payload_assert(edata, "<the argument to instance_sqlserver_user_options_payload>")
	x := json.marshal(edata)
} else := ""

instance_sqlserver_user_options_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "user_options_configured", concat("", [hint, ".", "user_options_configured"]))]
	every c in key_checks { c }

	value_checks := [instance_sqlserver_user_options_payload_assert_user_options_configured(edata, "user_options_configured", concat("", [hint, ".", "user_options_configured"]))]
	every c in value_checks { c }
} else := false

instance_sqlserver_user_options_payload_assert_user_options_configured(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
