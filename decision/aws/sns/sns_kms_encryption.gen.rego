# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.sns

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that SNS topics are encrypted
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
#   d := shisho.decision.aws.sns.kms_encryption({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.sns.kms_encryption_payload({
#       "kms_master_key_id": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_sns_kms_encryption"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_sns_kms_encryption".
kms_encryption(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": kms_encryption_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": kms_encryption_locator(d),
			"severity": kms_encryption_severity(d),
		}),
		"payload": d.payload,
	}
}

kms_encryption_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

kms_encryption_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

kms_encryption_kind = "aws_sns_kms_encryption"

kms_encryption_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": kms_encryption_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "SNS.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(kms_encryption_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
kms_encryption_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_sns_kms_encryption"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_sns_kms_encryption
#
#   The parameter `data` is an object with the following fields:
#   - kms_master_key_id: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "kms_master_key_id": "example",
#   }
#   ```
kms_encryption_payload(edata) := x {
	kms_encryption_payload_assert(edata, "<the argument to kms_encryption_payload>")
	x := json.marshal(edata)
} else := ""

kms_encryption_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "kms_master_key_id", concat("", [hint, ".", "kms_master_key_id"]))]
	every c in key_checks { c }

	value_checks := [kms_encryption_payload_assert_kms_master_key_id(edata, "kms_master_key_id", concat("", [hint, ".", "kms_master_key_id"]))]
	every c in value_checks { c }
} else := false

kms_encryption_payload_assert_kms_master_key_id(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
