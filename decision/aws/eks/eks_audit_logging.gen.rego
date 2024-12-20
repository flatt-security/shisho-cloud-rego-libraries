# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.eks

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that audit logging for EKS clusters is enabled
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
#   d := shisho.decision.aws.eks.audit_logging({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.eks.audit_logging_payload({
#       "enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_eks_audit_logging"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_eks_audit_logging".
audit_logging(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": audit_logging_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": audit_logging_locator(d),
			"severity": audit_logging_severity(d),
		}),
		"payload": d.payload,
	}
}

audit_logging_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

audit_logging_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

audit_logging_kind = "aws_eks_audit_logging"

audit_logging_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": audit_logging_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "EKS.8",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(audit_logging_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
audit_logging_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_eks_audit_logging"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_eks_audit_logging
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
audit_logging_payload(edata) := x {
	audit_logging_payload_assert(edata, "<the argument to audit_logging_payload>")
	x := json.marshal(edata)
} else := ""

audit_logging_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in key_checks { c }

	value_checks := [audit_logging_payload_assert_enabled(edata, "enabled", concat("", [hint, ".", "enabled"]))]
	every c in value_checks { c }
} else := false

audit_logging_payload_assert_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
