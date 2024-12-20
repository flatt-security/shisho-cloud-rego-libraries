# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.rds

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure encryption is enabled for RDS instances
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
#   d := shisho.decision.aws.rds.instance_encryption({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.rds.instance_encryption_payload({
#       "enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_rds_instance_encryption"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_rds_instance_encryption".
instance_encryption(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_encryption_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_encryption_locator(d),
			"severity": instance_encryption_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_encryption_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

instance_encryption_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_encryption_kind = "aws_rds_instance_encryption"

instance_encryption_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_encryption_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "2.3.1",
			"decision.api.shisho.dev:aws/cis-benchmark/v3.0.0": "2.3.1",
			"decision.api.shisho.dev:aws/fsbp/latest": "RDS.3",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_encryption_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_encryption_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_rds_instance_encryption"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_rds_instance_encryption
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
instance_encryption_payload(edata) := x {
	instance_encryption_payload_assert(edata, "<the argument to instance_encryption_payload>")
	x := json.marshal(edata)
} else := ""

instance_encryption_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in key_checks { c }

	value_checks := [instance_encryption_payload_assert_enabled(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in value_checks { c }
} else := false

instance_encryption_payload_assert_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
