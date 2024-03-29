# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.cloudfront

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure CloudFront distributions have a default root object
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
#   d := shisho.decision.aws.cloudfront.default_root_object({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.cloudfront.default_root_object_payload({
#       "default_root_object": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_cloudfront_default_root_object"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_cloudfront_default_root_object".
default_root_object(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": default_root_object_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": default_root_object_locator(d),
			"severity": default_root_object_severity(d),
		}),
		"payload": d.payload,
	}
}

default_root_object_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 4

default_root_object_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

default_root_object_kind = "aws_cloudfront_default_root_object"

default_root_object_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": default_root_object_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "CloudFront.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(default_root_object_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
default_root_object_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_cloudfront_default_root_object"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_cloudfront_default_root_object
#
#   The parameter `data` is an object with the following fields:
#   - default_root_object: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "default_root_object": "example",
#   }
#   ```
default_root_object_payload(edata) := x {
	default_root_object_payload_assert(edata, "<the argument to default_root_object_payload>")
	x := json.marshal(edata)
} else := ""

default_root_object_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "default_root_object", concat("", [hint, ".", "default_root_object"]))]
	every c in key_checks { c }

	value_checks := [default_root_object_payload_assert_default_root_object(edata, "default_root_object", concat("", [hint, ".", "default_root_object"]))]
	every c in value_checks { c }
} else := false

default_root_object_payload_assert_default_root_object(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
