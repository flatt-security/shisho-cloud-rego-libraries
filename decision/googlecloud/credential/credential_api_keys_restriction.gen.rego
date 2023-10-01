# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.credential

import data.shisho

# @title Ensure API Keys are restricted to usage by only specified hosts and apps
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
#   d := shisho.decision.googlecloud.credential.api_keys_restriction({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.credential.api_keys_restriction_payload({
#       "permissive_values": ["example"],
#       "restriction_type": RESTRICTION_TYPE_NO_RESTRICTION,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_restriction"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_restriction".
api_keys_restriction(d) = x {
	x := {
		"header": api_keys_restriction_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": api_keys_restriction_locator(d),
			"severity": api_keys_restriction_severity(d),
		}),
		"payload": d.payload,
	}
}

api_keys_restriction_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

api_keys_restriction_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

api_keys_restriction_kind = "googlecloud_credential_api_keys_restriction"

api_keys_restriction_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": api_keys_restriction_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "1.13",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(api_keys_restriction_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
api_keys_restriction_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_restriction"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_restriction
#
#   The parameter `data` is an object with the following fields: 
#   - permissive_values: string
#   - restriction_type: restriction_type
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "permissive_values": ["example"],
#     "restriction_type": RESTRICTION_TYPE_NO_RESTRICTION,
#   }
#   ```
api_keys_restriction_payload(edata) = x {
	x := json.marshal(edata)
}

RESTRICTION_TYPE_NO_RESTRICTION = 0

RESTRICTION_TYPE_IP_ADDRESS_RESTRICTION = 1

RESTRICTION_TYPE_REFERRER_RESTRICTION = 2

RESTRICTION_TYPE_ANDROID_APP_RESTRICTION = 3

RESTRICTION_TYPE_IOS_APP_RESTRICTION = 4
