# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.rds

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that public access is not given to RDS instances
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
#   d := shisho.decision.aws.rds.instance_accessibility({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.rds.instance_accessibility_payload({
#       "is_publicly_accessible": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_rds_instance_accessibility"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_rds_instance_accessibility".
instance_accessibility(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_accessibility_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_accessibility_locator(d),
			"severity": instance_accessibility_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_accessibility_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

instance_accessibility_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_accessibility_kind = "aws_rds_instance_accessibility"

instance_accessibility_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_accessibility_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "2.3.3",
			"decision.api.shisho.dev:aws/fsbp/latest": "RDS.2",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_accessibility_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_accessibility_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_rds_instance_accessibility"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_rds_instance_accessibility
#
#   The parameter `data` is an object with the following fields: 
#   - is_publicly_accessible: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "is_publicly_accessible": false,
#   }
#   ```
instance_accessibility_payload(edata) := x {
	instance_accessibility_payload_assert(edata, "<the argument to instance_accessibility_payload>")
	x := json.marshal(edata)
} else := ""

instance_accessibility_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "is_publicly_accessible", concat("", [hint, ".", "is_publicly_accessible"]))]
	every c in key_checks { c }

	value_checks := [instance_accessibility_payload_assert_is_publicly_accessible(edata, "is_publicly_accessible", concat("", [hint, ".", "is_publicly_accessible"]))]
	every c in value_checks { c }
} else := false

instance_accessibility_payload_assert_is_publicly_accessible(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
