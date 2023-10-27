# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.networking

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Cloud DNS Logging is enabled for all VPC networks
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
#   d := shisho.decision.googlecloud.networking.dns_log({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.networking.dns_log_payload({
#       "log_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_networking_dns_log"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_networking_dns_log".
dns_log(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": dns_log_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": dns_log_locator(d),
			"severity": dns_log_severity(d),
		}),
		"payload": d.payload,
	}
}

dns_log_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

dns_log_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

dns_log_kind = "googlecloud_networking_dns_log"

dns_log_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": dns_log_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.12",
			"decision.api.shisho.dev:googlecloud/scc-premium/latest": "FIREWALL_SCANNER.EGRESS_DENY_RULE_NOT_SET",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(dns_log_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
dns_log_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_networking_dns_log"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_networking_dns_log
#
#   The parameter `data` is an object with the following fields: 
#   - log_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "log_enabled": false,
#   }
#   ```
dns_log_payload(edata) := x {
	dns_log_payload_assert(edata, "<the argument to dns_log_payload>")
	x := json.marshal(edata)
} else := ""

dns_log_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "log_enabled", concat("", [hint, ".", "log_enabled"]))]
	every c in key_checks { c }

	value_checks := [dns_log_payload_assert_log_enabled(edata, "log_enabled", concat("", [hint, ".", "log_enabled"]))]
	every c in value_checks { c }
} else := false

dns_log_payload_assert_log_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
