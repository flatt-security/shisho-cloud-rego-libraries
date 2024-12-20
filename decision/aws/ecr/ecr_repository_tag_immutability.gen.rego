# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.ecr

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that ECR private repositories have tag immutability configured
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
#   d := shisho.decision.aws.ecr.repository_tag_immutability({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.ecr.repository_tag_immutability_payload({
#       "tag_immutability_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_ecr_repository_tag_immutability"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_ecr_repository_tag_immutability".
repository_tag_immutability(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": repository_tag_immutability_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": repository_tag_immutability_locator(d),
			"severity": repository_tag_immutability_severity(d),
		}),
		"payload": d.payload,
	}
}

repository_tag_immutability_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

repository_tag_immutability_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

repository_tag_immutability_kind = "aws_ecr_repository_tag_immutability"

repository_tag_immutability_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": repository_tag_immutability_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "ECR.2",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(repository_tag_immutability_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
repository_tag_immutability_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_ecr_repository_tag_immutability"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_ecr_repository_tag_immutability
#
#   The parameter `data` is an object with the following fields:
#   - tag_immutability_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "tag_immutability_enabled": false,
#   }
#   ```
repository_tag_immutability_payload(edata) := x {
	repository_tag_immutability_payload_assert(edata, "<the argument to repository_tag_immutability_payload>")
	x := json.marshal(edata)
} else := ""

repository_tag_immutability_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "tag_immutability_enabled", concat("", [hint, ".", "tag_immutability_enabled"]))]
	every c in key_checks { c }

	value_checks := [repository_tag_immutability_payload_assert_tag_immutability_enabled(edata, "tag_immutability_enabled", concat("", [hint, ".", "tag_immutability_enabled"]))]
	every c in value_checks { c }
} else := false

repository_tag_immutability_payload_assert_tag_immutability_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
