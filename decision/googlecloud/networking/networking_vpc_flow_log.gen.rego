# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.networking

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure VPC Flow Logs feature is enabled for critical VPC networks and subnets
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
#   d := shisho.decision.googlecloud.networking.vpc_flow_log({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.networking.vpc_flow_log_payload({
#       "flow_log_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_networking_vpc_flow_log"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_networking_vpc_flow_log".
vpc_flow_log(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": vpc_flow_log_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": vpc_flow_log_locator(d),
			"severity": vpc_flow_log_severity(d),
		}),
		"payload": d.payload,
	}
}

vpc_flow_log_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

vpc_flow_log_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

vpc_flow_log_kind = "googlecloud_networking_vpc_flow_log"

vpc_flow_log_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": vpc_flow_log_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "3.8",
			"decision.api.shisho.dev:googlecloud/scc-premium/latest": "SUBNETWORK_SCANNER.FLOW_LOGS_DISABLED",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(vpc_flow_log_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
vpc_flow_log_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_networking_vpc_flow_log"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_networking_vpc_flow_log
#
#   The parameter `data` is an object with the following fields:
#   - flow_log_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "flow_log_enabled": false,
#   }
#   ```
vpc_flow_log_payload(edata) := x {
	vpc_flow_log_payload_assert(edata, "<the argument to vpc_flow_log_payload>")
	x := json.marshal(edata)
} else := ""

vpc_flow_log_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "flow_log_enabled", concat("", [hint, ".", "flow_log_enabled"]))]
	every c in key_checks { c }

	value_checks := [vpc_flow_log_payload_assert_flow_log_enabled(edata, "flow_log_enabled", concat("", [hint, ".", "flow_log_enabled"]))]
	every c in value_checks { c }
} else := false

vpc_flow_log_payload_assert_flow_log_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
