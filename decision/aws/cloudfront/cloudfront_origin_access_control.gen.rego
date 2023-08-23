# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.cloudfront

import data.shisho

# @title Ensure CloudFront distributions with S3 backends use origin access control enabled
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
#   d := shisho.decision.aws.cloudfront.origin_access_control({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.cloudfront.origin_access_control_payload({
#       "origins": [{"id": "example", "domain_id": "example", "origin_access_control_configured": "example", "origin_access_identity_configured": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_cloudfront_origin_access_control"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_cloudfront_origin_access_control".
origin_access_control(d) = x {
	x := {
		"header": origin_access_control_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": origin_access_control_locator(d),
			"severity": origin_access_control_severity(d),
		}),
		"payload": d.payload,
	}
}

origin_access_control_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

origin_access_control_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

origin_access_control_kind = "aws_cloudfront_origin_access_control"

origin_access_control_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": origin_access_control_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "CloudFront.13",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(origin_access_control_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
origin_access_control_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_cloudfront_origin_access_control"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_cloudfront_origin_access_control
#
#   The parameter `data` is an object with the following fields: 
#   - origins: {"id": string, "domain_id": string, "origin_access_control_configured": string, "origin_access_identity_configured": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "origins": [{"id": "example", "domain_id": "example", "origin_access_control_configured": "example", "origin_access_identity_configured": "example"}],
#   }
#   ```
origin_access_control_payload(edata) = x {
	x := json.marshal(edata)
}
