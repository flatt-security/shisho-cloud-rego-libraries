# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.s3

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that S3 buckets are encrypted at rest with AWS KMS keys
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
#   d := shisho.decision.aws.s3.bucket_kms_encryption({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.s3.bucket_kms_encryption_payload({
#       "encryption_rules": [{"algorithm": "example", "kms_key_id": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_s3_bucket_kms_encryption"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_s3_bucket_kms_encryption".
bucket_kms_encryption(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": bucket_kms_encryption_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": bucket_kms_encryption_locator(d),
			"severity": bucket_kms_encryption_severity(d),
		}),
		"payload": d.payload,
	}
}

bucket_kms_encryption_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

bucket_kms_encryption_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

bucket_kms_encryption_kind = "aws_s3_bucket_kms_encryption"

bucket_kms_encryption_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": bucket_kms_encryption_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "S3.17",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(bucket_kms_encryption_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
bucket_kms_encryption_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_s3_bucket_kms_encryption"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_s3_bucket_kms_encryption
#
#   The parameter `data` is an object with the following fields:
#   - encryption_rules: {"algorithm": string, "kms_key_id": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "encryption_rules": [{"algorithm": "example", "kms_key_id": "example"}],
#   }
#   ```
bucket_kms_encryption_payload(edata) := x {
	bucket_kms_encryption_payload_assert(edata, "<the argument to bucket_kms_encryption_payload>")
	x := json.marshal(edata)
} else := ""

bucket_kms_encryption_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "encryption_rules", concat("", [hint, ".", "encryption_rules"]))]
	every c in key_checks { c }

	value_checks := [bucket_kms_encryption_payload_assert_encryption_rules(edata, "encryption_rules", concat("", [hint, ".", "encryption_rules"]))]
	every c in value_checks { c }
} else := false

bucket_kms_encryption_payload_assert_encryption_rules(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [bucket_kms_encryption_payload_assert_encryption_rules_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

bucket_kms_encryption_payload_assert_encryption_rules_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "algorithm", "string", hint),
		assertion.has_typed_key(x[key], "kms_key_id", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		bucket_kms_encryption_payload_assert_encryption_rules_element_algorithm(x[key], "algorithm", concat("", [hint, ".", "algorithm"])),
		bucket_kms_encryption_payload_assert_encryption_rules_element_kms_key_id(x[key], "kms_key_id", concat("", [hint, ".", "kms_key_id"])),
	]
	every c in value_checks { c }
} else := false

bucket_kms_encryption_payload_assert_encryption_rules_element_algorithm(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

bucket_kms_encryption_payload_assert_encryption_rules_element_kms_key_id(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false