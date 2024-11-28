# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.s3

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure CloudTrail trails are logging S3 bucket read events
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
#   d := shisho.decision.aws.s3.bucket_read_trail({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.s3.bucket_read_trail_payload({
#       "enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_s3_bucket_read_trail"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_s3_bucket_read_trail".
bucket_read_trail(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": bucket_read_trail_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": bucket_read_trail_locator(d),
			"severity": bucket_read_trail_severity(d),
		}),
		"payload": d.payload,
	}
}

bucket_read_trail_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

bucket_read_trail_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

bucket_read_trail_kind = "aws_s3_bucket_read_trail"

bucket_read_trail_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": bucket_read_trail_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "3.11",
			"decision.api.shisho.dev:aws/cis-benchmark/v3.0.0": "3.9",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(bucket_read_trail_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
bucket_read_trail_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_s3_bucket_read_trail"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_s3_bucket_read_trail
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
bucket_read_trail_payload(edata) := x {
	bucket_read_trail_payload_assert(edata, "<the argument to bucket_read_trail_payload>")
	x := json.marshal(edata)
} else := ""

bucket_read_trail_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in key_checks { c }

	value_checks := [bucket_read_trail_payload_assert_enabled(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in value_checks { c }
} else := false

bucket_read_trail_payload_assert_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
