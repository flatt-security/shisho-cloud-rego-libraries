# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.s3

import data.shisho

# @title Ensure S3 buckets enabled block public access feature
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
#   d := shisho.decision.aws.s3.bucket_public_access_block({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.s3.bucket_public_access_block_payload({
#       "enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_s3_bucket_public_access_block"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_s3_bucket_public_access_block".
bucket_public_access_block(d) = x {
	x := {
		"header": bucket_public_access_block_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": bucket_public_access_block_locator(d),
			"severity": bucket_public_access_block_severity(d),
		}),
		"payload": d.payload,
	}
}

bucket_public_access_block_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

bucket_public_access_block_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

bucket_public_access_block_kind = "aws_s3_bucket_public_access_block"

bucket_public_access_block_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": bucket_public_access_block_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "2.1.5",
			"decision.api.shisho.dev:aws/fsbp/latest": "S3.8",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(bucket_public_access_block_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
bucket_public_access_block_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_s3_bucket_public_access_block"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_s3_bucket_public_access_block
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
bucket_public_access_block_payload(edata) = x {
	x := json.marshal(edata)
}
