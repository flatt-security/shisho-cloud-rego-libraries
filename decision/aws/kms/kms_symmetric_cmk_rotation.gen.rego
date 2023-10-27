# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.kms

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure rotation for customer created symmetric CMKs is enabled
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
#   d := shisho.decision.aws.kms.symmetric_cmk_rotation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.kms.symmetric_cmk_rotation_payload({
#       "enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_kms_symmetric_cmk_rotation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_kms_symmetric_cmk_rotation".
symmetric_cmk_rotation(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": symmetric_cmk_rotation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": symmetric_cmk_rotation_locator(d),
			"severity": symmetric_cmk_rotation_severity(d),
		}),
		"payload": d.payload,
	}
}

symmetric_cmk_rotation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

symmetric_cmk_rotation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

symmetric_cmk_rotation_kind = "aws_kms_symmetric_cmk_rotation"

symmetric_cmk_rotation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": symmetric_cmk_rotation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "3.8",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(symmetric_cmk_rotation_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
symmetric_cmk_rotation_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_kms_symmetric_cmk_rotation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_kms_symmetric_cmk_rotation
#
#   The parameter `data` is an object with the following fields: 
#   - enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "enabled": false,
#   }
#   ```
symmetric_cmk_rotation_payload(edata) := x {
	symmetric_cmk_rotation_payload_assert(edata, "<the argument to symmetric_cmk_rotation_payload>")
	x := json.marshal(edata)
} else := ""

symmetric_cmk_rotation_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in key_checks { c }

	value_checks := [symmetric_cmk_rotation_payload_assert_enabled(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in value_checks { c }
} else := false

symmetric_cmk_rotation_payload_assert_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
