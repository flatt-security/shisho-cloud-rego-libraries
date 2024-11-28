# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.rds

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that RDS instances have automatic backups enabled
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
#   d := shisho.decision.aws.rds.instance_automatic_backup({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.rds.instance_automatic_backup_payload({
#       "backup_retention_period": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_rds_instance_automatic_backup"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_rds_instance_automatic_backup".
instance_automatic_backup(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_automatic_backup_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_automatic_backup_locator(d),
			"severity": instance_automatic_backup_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_automatic_backup_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_automatic_backup_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_automatic_backup_kind = "aws_rds_instance_automatic_backup"

instance_automatic_backup_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_automatic_backup_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "RDS.11",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_automatic_backup_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_automatic_backup_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_rds_instance_automatic_backup"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_rds_instance_automatic_backup
#
#   The parameter `data` is an object with the following fields:
#   - backup_retention_period: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "backup_retention_period": 0,
#   }
#   ```
instance_automatic_backup_payload(edata) := x {
	instance_automatic_backup_payload_assert(edata, "<the argument to instance_automatic_backup_payload>")
	x := json.marshal(edata)
} else := ""

instance_automatic_backup_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "backup_retention_period", concat("", [hint, ".", "backup_retention_period"]))]
	every c in key_checks { c }

	value_checks := [instance_automatic_backup_payload_assert_backup_retention_period(edata, "backup_retention_period", concat("", [hint, ".", "backup_retention_period"]))]
	every c in value_checks { c }
} else := false

instance_automatic_backup_payload_assert_backup_retention_period(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false