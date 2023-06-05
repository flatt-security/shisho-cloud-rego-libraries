# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho

# @title Ensure Cloud SQL instances are exposed only to specific IP addresses
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
#   d := shisho.decision.googlecloud.sql.instance_accessibility({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_accessibility_payload({
#       "ip_allowlist": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_accessibility"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_accessibility".
instance_accessibility(d) = x {
	x := {
		"header": instance_accessibility_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_accessibility_locator(d),
			"severity": instance_accessibility_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_accessibility_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 4

instance_accessibility_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_accessibility_kind = "googlecloud_sql_instance_accessibility"

instance_accessibility_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_accessibility_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_accessibility_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_accessibility_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_accessibility"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_accessibility
#
#   The parameter `data` is an object with the following fields: 
#   - ip_allowlist: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "ip_allowlist": ["example"],
#   }
#   ```
instance_accessibility_payload(edata) = x {
	x := json.marshal(edata)
}
