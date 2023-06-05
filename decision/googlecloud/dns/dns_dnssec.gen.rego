# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.dns

import data.shisho

# @title Ensure DNSSEC is enabled for Cloud DNS zones
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
#   d := shisho.decision.googlecloud.dns.dnssec({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.dns.dnssec_payload({
#       "dnssec_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_dns_dnssec"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_dns_dnssec".
dnssec(d) = x {
	x := {
		"header": dnssec_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": dnssec_locator(d),
			"severity": dnssec_severity(d),
		}),
		"payload": d.payload,
	}
}

dnssec_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

dnssec_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

dnssec_kind = "googlecloud_dns_dnssec"

dnssec_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": dnssec_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "3.3",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(dnssec_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
dnssec_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_dns_dnssec"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_dns_dnssec
#
#   The parameter `data` is an object with the following fields: 
#   - dnssec_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "dnssec_enabled": false,
#   }
#   ```
dnssec_payload(edata) = x {
	x := json.marshal(edata)
}