# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.efs

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that EFS access points enforce a user identity
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
#   d := shisho.decision.aws.efs.access_point_user_identity({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.efs.access_point_user_identity_payload({
#       "access_points": [{"id": "example", "user_id_enforced": false}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_efs_access_point_user_identity"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_efs_access_point_user_identity".
access_point_user_identity(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": access_point_user_identity_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": access_point_user_identity_locator(d),
			"severity": access_point_user_identity_severity(d),
		}),
		"payload": d.payload,
	}
}

access_point_user_identity_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

access_point_user_identity_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

access_point_user_identity_kind = "aws_efs_access_point_user_identity"

access_point_user_identity_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": access_point_user_identity_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "EFS.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(access_point_user_identity_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
access_point_user_identity_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_efs_access_point_user_identity"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_efs_access_point_user_identity
#
#   The parameter `data` is an object with the following fields:
#   - access_points: {"id": string, "user_id_enforced": boolean}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "access_points": [{"id": "example", "user_id_enforced": false}],
#   }
#   ```
access_point_user_identity_payload(edata) := x {
	access_point_user_identity_payload_assert(edata, "<the argument to access_point_user_identity_payload>")
	x := json.marshal(edata)
} else := ""

access_point_user_identity_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "access_points", concat("", [hint, ".", "access_points"]))]
	every c in key_checks { c }

	value_checks := [access_point_user_identity_payload_assert_access_points(edata, "access_points", concat("", [hint, ".", "access_points"]))]
	every c in value_checks { c }
} else := false

access_point_user_identity_payload_assert_access_points(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [access_point_user_identity_payload_assert_access_points_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

access_point_user_identity_payload_assert_access_points_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "id", "string", hint),
		assertion.has_typed_key(x[key], "user_id_enforced", "boolean", hint),
	]
	every c in key_checks { c }
	value_checks := [
		access_point_user_identity_payload_assert_access_points_element_id(x[key], "id", concat("", [hint, ".", "id"])),
		access_point_user_identity_payload_assert_access_points_element_user_id_enforced(x[key], "user_id_enforced", concat("", [hint, ".", "user_id_enforced"])),
	]
	every c in value_checks { c }
} else := false

access_point_user_identity_payload_assert_access_points_element_id(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

access_point_user_identity_payload_assert_access_points_element_user_id_enforced(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
