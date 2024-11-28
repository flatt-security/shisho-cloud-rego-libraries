# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.dataproc

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that Dataproc cluster is encrypted using customer-managed encryption key
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
#   d := shisho.decision.googlecloud.dataproc.encryption_key({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.dataproc.encryption_key_payload({
#       "has_customer_managed_key": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_dataproc_encryption_key"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_dataproc_encryption_key".
encryption_key(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": encryption_key_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": encryption_key_locator(d),
			"severity": encryption_key_severity(d),
		}),
		"payload": d.payload,
	}
}

encryption_key_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

encryption_key_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

encryption_key_kind = "googlecloud_dataproc_encryption_key"

encryption_key_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": encryption_key_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "1.17",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(encryption_key_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
encryption_key_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_dataproc_encryption_key"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_dataproc_encryption_key
#
#   The parameter `data` is an object with the following fields:
#   - has_customer_managed_key: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "has_customer_managed_key": false,
#   }
#   ```
encryption_key_payload(edata) := x {
	encryption_key_payload_assert(edata, "<the argument to encryption_key_payload>")
	x := json.marshal(edata)
} else := ""

encryption_key_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "has_customer_managed_key", concat("", [hint, ".", "has_customer_managed_key"]))]
	every c in key_checks { c }

	value_checks := [encryption_key_payload_assert_has_customer_managed_key(edata, "has_customer_managed_key", concat("", [hint, ".", "has_customer_managed_key"]))]
	every c in value_checks { c }
} else := false

encryption_key_payload_assert_has_customer_managed_key(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
