# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.rds

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that RDS clusters use a custom administrator username
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
#   d := shisho.decision.aws.rds.cluster_administrator_username({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.rds.cluster_administrator_username_payload({
#       "admin_username": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_rds_cluster_administrator_username"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_rds_cluster_administrator_username".
cluster_administrator_username(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": cluster_administrator_username_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": cluster_administrator_username_locator(d),
			"severity": cluster_administrator_username_severity(d),
		}),
		"payload": d.payload,
	}
}

cluster_administrator_username_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

cluster_administrator_username_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

cluster_administrator_username_kind = "aws_rds_cluster_administrator_username"

cluster_administrator_username_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": cluster_administrator_username_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "RDS.24",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(cluster_administrator_username_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
cluster_administrator_username_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_rds_cluster_administrator_username"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_rds_cluster_administrator_username
#
#   The parameter `data` is an object with the following fields:
#   - admin_username: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "admin_username": "example",
#   }
#   ```
cluster_administrator_username_payload(edata) := x {
	cluster_administrator_username_payload_assert(edata, "<the argument to cluster_administrator_username_payload>")
	x := json.marshal(edata)
} else := ""

cluster_administrator_username_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "admin_username", concat("", [hint, ".", "admin_username"]))]
	every c in key_checks { c }

	value_checks := [cluster_administrator_username_payload_assert_admin_username(edata, "admin_username", concat("", [hint, ".", "admin_username"]))]
	every c in value_checks { c }
} else := false

cluster_administrator_username_payload_assert_admin_username(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false