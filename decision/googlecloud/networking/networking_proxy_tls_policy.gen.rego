# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.networking

import data.shisho

# @title Ensure that Cloud Load Balancing uses TLS policies with strong cipher suites
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
#   d := shisho.decision.googlecloud.networking.proxy_tls_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.networking.proxy_tls_policy_payload({
#       "tls_policy_attached": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_networking_proxy_tls_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_networking_proxy_tls_policy".
proxy_tls_policy(d) = x {
	x := {
		"header": proxy_tls_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": proxy_tls_policy_locator(d),
			"severity": proxy_tls_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

proxy_tls_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

proxy_tls_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

proxy_tls_policy_kind = "googlecloud_networking_proxy_tls_policy"

proxy_tls_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": proxy_tls_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "3.9",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(proxy_tls_policy_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
proxy_tls_policy_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_networking_proxy_tls_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_networking_proxy_tls_policy
#
#   The parameter `data` is an object with the following fields: 
#   - tls_policy_attached: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "tls_policy_attached": false,
#   }
#   ```
proxy_tls_policy_payload(edata) = x {
	x := json.marshal(edata)
}