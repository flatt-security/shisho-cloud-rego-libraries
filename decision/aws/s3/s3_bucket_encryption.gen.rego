# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.s3

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure all S3 buckets are encrypted
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
#   d := shisho.decision.aws.s3.bucket_encryption({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.s3.bucket_encryption_payload({
#       "algorithms": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_s3_bucket_encryption"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_s3_bucket_encryption".
bucket_encryption(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": bucket_encryption_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": bucket_encryption_locator(d),
			"severity": bucket_encryption_severity(d),
		}),
		"payload": d.payload,
	}
}

bucket_encryption_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

bucket_encryption_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

bucket_encryption_kind = "aws_s3_bucket_encryption"

bucket_encryption_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": bucket_encryption_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "2.1.1",
			"decision.api.shisho.dev:aws/fsbp/latest": "S3.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(bucket_encryption_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
bucket_encryption_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_s3_bucket_encryption"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_s3_bucket_encryption
#
#   The parameter `data` is an object with the following fields: 
#   - algorithms: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "algorithms": ["example"],
#   }
#   ```
bucket_encryption_payload(edata) := x {
	bucket_encryption_payload_assert(edata, "<the argument to bucket_encryption_payload>")
	x := json.marshal(edata)
} else := ""

bucket_encryption_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "algorithms", concat("", [hint, ".", "algorithms"]))]
	every c in key_checks { c }

	value_checks := [bucket_encryption_payload_assert_algorithms(edata, "algorithms", concat("", [hint, ".", "algorithms"]))]
	every c in value_checks { c }
} else := false

bucket_encryption_payload_assert_algorithms(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [bucket_encryption_payload_assert_algorithms_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

bucket_encryption_payload_assert_algorithms_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
