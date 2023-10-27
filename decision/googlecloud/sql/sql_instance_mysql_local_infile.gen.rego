# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that the local_infile database flag for a Cloud SQL for MySQL instance is set to off
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
#   d := shisho.decision.googlecloud.sql.instance_mysql_local_infile({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_mysql_local_infile_payload({
#       "local_infile_state": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_local_infile"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_local_infile".
instance_mysql_local_infile(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_mysql_local_infile_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_mysql_local_infile_locator(d),
			"severity": instance_mysql_local_infile_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_mysql_local_infile_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_mysql_local_infile_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_mysql_local_infile_kind = "googlecloud_sql_instance_mysql_local_infile"

instance_mysql_local_infile_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_mysql_local_infile_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.1.3",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_mysql_local_infile_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_mysql_local_infile_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_local_infile"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_mysql_local_infile
#
#   The parameter `data` is an object with the following fields: 
#   - local_infile_state: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "local_infile_state": "example",
#   }
#   ```
instance_mysql_local_infile_payload(edata) := x {
	instance_mysql_local_infile_payload_assert(edata, "<the argument to instance_mysql_local_infile_payload>")
	x := json.marshal(edata)
} else := ""

instance_mysql_local_infile_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "local_infile_state", concat("", [hint, ".", "local_infile_state"]))]
	every c in key_checks { c }

	value_checks := [instance_mysql_local_infile_payload_assert_local_infile_state(edata, "local_infile_state", concat("", [hint, ".", "local_infile_state"]))]
	every c in value_checks { c }
} else := false

instance_mysql_local_infile_payload_assert_local_infile_state(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
