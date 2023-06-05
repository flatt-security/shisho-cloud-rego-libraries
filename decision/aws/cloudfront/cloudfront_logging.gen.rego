# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.cloudfront

import data.shisho

# @title Ensure CloudFront distributions have an active logging bucket
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
#   d := shisho.decision.aws.cloudfront.logging({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.cloudfront.logging_payload({
#       "bucket_id": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_cloudfront_logging"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_cloudfront_logging".
logging(d) = x {
	x := {
		"header": logging_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": logging_locator(d),
			"severity": logging_severity(d),
		}),
		"payload": d.payload,
	}
}

logging_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

logging_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

logging_kind = "aws_cloudfront_logging"

logging_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": logging_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "CloudFront.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(logging_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
logging_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_cloudfront_logging"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_cloudfront_logging
#
#   The parameter `data` is an object with the following fields: 
#   - bucket_id: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "bucket_id": "example",
#   }
#   ```
logging_payload(edata) = x {
	x := json.marshal(edata)
}
