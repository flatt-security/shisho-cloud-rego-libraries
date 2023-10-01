# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.kms

import data.shisho

# @title Ensure that Cloud KMS cryptokeys are exposed only to trusted principals
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
#   d := shisho.decision.googlecloud.kms.key_accessibility({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.kms.key_accessibility_payload({
#       "forbidden_bindings": [{"principal": "example", "role": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_kms_key_accessibility"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_kms_key_accessibility".
key_accessibility(d) = x {
	x := {
		"header": key_accessibility_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": key_accessibility_locator(d),
			"severity": key_accessibility_severity(d),
		}),
		"payload": d.payload,
	}
}

key_accessibility_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

key_accessibility_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

key_accessibility_kind = "googlecloud_kms_key_accessibility"

key_accessibility_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": key_accessibility_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "1.9",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(key_accessibility_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
key_accessibility_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_kms_key_accessibility"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_kms_key_accessibility
#
#   The parameter `data` is an object with the following fields: 
#   - forbidden_bindings: {"principal": string, "role": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "forbidden_bindings": [{"principal": "example", "role": "example"}],
#   }
#   ```
key_accessibility_payload(edata) = x {
	x := json.marshal(edata)
}