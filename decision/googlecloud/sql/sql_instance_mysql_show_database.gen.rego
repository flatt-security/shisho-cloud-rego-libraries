# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho

# @title Ensure that the skip_show_database database flag for Cloud SQL for MySQL instance is set to on
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
#   d := shisho.decision.googlecloud.sql.instance_mysql_show_database({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_mysql_show_database_payload({
#       "skip_show_database_state": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_show_database"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_show_database".
instance_mysql_show_database(d) = x {
	x := {
		"header": instance_mysql_show_database_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_mysql_show_database_locator(d),
			"severity": instance_mysql_show_database_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_mysql_show_database_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_mysql_show_database_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_mysql_show_database_kind = "googlecloud_sql_instance_mysql_show_database"

instance_mysql_show_database_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_mysql_show_database_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.1.2",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_mysql_show_database_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_mysql_show_database_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_show_database"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_show_database
#
#   The parameter `data` is an object with the following fields: 
#   - skip_show_database_state: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "skip_show_database_state": "example",
#   }
#   ```
instance_mysql_show_database_payload(edata) = x {
	x := json.marshal(edata)
}
