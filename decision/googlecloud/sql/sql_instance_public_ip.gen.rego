# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.sql

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Cloud SQL instances have public IPs only if they need
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
#   d := shisho.decision.googlecloud.sql.instance_public_ip({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.sql.instance_public_ip_payload({
#       "has_public_ip": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_sql_instance_public_ip"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_sql_instance_public_ip".
instance_public_ip(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_public_ip_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_public_ip_locator(d),
			"severity": instance_public_ip_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_public_ip_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

instance_public_ip_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_public_ip_kind = "googlecloud_sql_instance_public_ip"

instance_public_ip_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_public_ip_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "6.6",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_public_ip_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_public_ip_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_sql_instance_public_ip"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_sql_instance_public_ip
#
#   The parameter `data` is an object with the following fields:
#   - has_public_ip: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "has_public_ip": false,
#   }
#   ```
instance_public_ip_payload(edata) := x {
	instance_public_ip_payload_assert(edata, "<the argument to instance_public_ip_payload>")
	x := json.marshal(edata)
} else := ""

instance_public_ip_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "has_public_ip", concat("", [hint, ".", "has_public_ip"]))]
	every c in key_checks { c }

	value_checks := [instance_public_ip_payload_assert_has_public_ip(edata, "has_public_ip", concat("", [hint, ".", "has_public_ip"]))]
	every c in value_checks { c }
} else := false

instance_public_ip_payload_assert_has_public_ip(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
