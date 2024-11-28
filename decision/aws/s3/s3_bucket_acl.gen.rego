# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.s3

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that S3 access control lists (ACLs) are not used
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
#   d := shisho.decision.aws.s3.bucket_acl({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.s3.bucket_acl_payload({
#       "bucket_acl_used": false,
#       "ownership_controls": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_s3_bucket_acl"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_s3_bucket_acl".
bucket_acl(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": bucket_acl_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": bucket_acl_locator(d),
			"severity": bucket_acl_severity(d),
		}),
		"payload": d.payload,
	}
}

bucket_acl_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

bucket_acl_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

bucket_acl_kind = "aws_s3_bucket_acl"

bucket_acl_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": bucket_acl_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "S3.12",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(bucket_acl_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
bucket_acl_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_s3_bucket_acl"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_s3_bucket_acl
#
#   The parameter `data` is an object with the following fields:
#   - bucket_acl_used: boolean
#   - ownership_controls: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "bucket_acl_used": false,
#     "ownership_controls": ["example"],
#   }
#   ```
bucket_acl_payload(edata) := x {
	bucket_acl_payload_assert(edata, "<the argument to bucket_acl_payload>")
	x := json.marshal(edata)
} else := ""

bucket_acl_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "bucket_acl_used", concat("", [hint, ".", "bucket_acl_used"])),
		assertion.has_key(edata, "ownership_controls", concat("", [hint, ".", "ownership_controls"])),
	]
	every c in key_checks { c }

	value_checks := [
		bucket_acl_payload_assert_bucket_acl_used(edata, "bucket_acl_used", concat("", [hint, ".", "bucket_acl_used"])),
		bucket_acl_payload_assert_ownership_controls(edata, "ownership_controls", concat("", [hint, ".", "ownership_controls"])),
	]
	every c in value_checks { c }
} else := false

bucket_acl_payload_assert_bucket_acl_used(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

bucket_acl_payload_assert_ownership_controls(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [bucket_acl_payload_assert_ownership_controls_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

bucket_acl_payload_assert_ownership_controls_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false