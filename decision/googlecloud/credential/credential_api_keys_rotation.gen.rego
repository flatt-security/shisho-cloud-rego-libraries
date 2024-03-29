# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.credential

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure API keys are rotated within reasonable days
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
#   d := shisho.decision.googlecloud.credential.api_keys_rotation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.credential.api_keys_rotation_payload({
#       "created_at": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_rotation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_rotation".
api_keys_rotation(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": api_keys_rotation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": api_keys_rotation_locator(d),
			"severity": api_keys_rotation_severity(d),
		}),
		"payload": d.payload,
	}
}

api_keys_rotation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

api_keys_rotation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

api_keys_rotation_kind = "googlecloud_credential_api_keys_rotation"

api_keys_rotation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": api_keys_rotation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "1.15",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(api_keys_rotation_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
api_keys_rotation_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_rotation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_credential_api_keys_rotation
#
#   The parameter `data` is an object with the following fields:
#   - created_at: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "created_at": "example",
#   }
#   ```
api_keys_rotation_payload(edata) := x {
	api_keys_rotation_payload_assert(edata, "<the argument to api_keys_rotation_payload>")
	x := json.marshal(edata)
} else := ""

api_keys_rotation_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "created_at", concat("", [hint, ".", "created_at"]))]
	every c in key_checks { c }

	value_checks := [api_keys_rotation_payload_assert_created_at(edata, "created_at", concat("", [hint, ".", "created_at"]))]
	every c in value_checks { c }
} else := false

api_keys_rotation_payload_assert_created_at(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
