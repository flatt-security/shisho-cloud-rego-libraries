# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.networking

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that unused Network Access Control Lists are removed
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
#   d := shisho.decision.aws.networking.acl_assosiations({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.networking.acl_assosiations_payload({
#       "acls": [{"id": "example", "number_of_associations": 0}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_networking_acl_assosiations"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_networking_acl_assosiations".
acl_assosiations(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": acl_assosiations_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": acl_assosiations_locator(d),
			"severity": acl_assosiations_severity(d),
		}),
		"payload": d.payload,
	}
}

acl_assosiations_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

acl_assosiations_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

acl_assosiations_kind = "aws_networking_acl_assosiations"

acl_assosiations_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": acl_assosiations_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "EC2.16",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(acl_assosiations_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
acl_assosiations_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_networking_acl_assosiations"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_networking_acl_assosiations
#
#   The parameter `data` is an object with the following fields:
#   - acls: {"id": string, "number_of_associations": number}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "acls": [{"id": "example", "number_of_associations": 0}],
#   }
#   ```
acl_assosiations_payload(edata) := x {
	acl_assosiations_payload_assert(edata, "<the argument to acl_assosiations_payload>")
	x := json.marshal(edata)
} else := ""

acl_assosiations_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "acls", concat("", [hint, ".", "acls"]))]
	every c in key_checks { c }

	value_checks := [acl_assosiations_payload_assert_acls(edata, "acls", concat("", [hint, ".", "acls"]))]
	every c in value_checks { c }
} else := false

acl_assosiations_payload_assert_acls(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [acl_assosiations_payload_assert_acls_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

acl_assosiations_payload_assert_acls_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "id", "string", hint),
		assertion.has_typed_key(x[key], "number_of_associations", "number", hint),
	]
	every c in key_checks { c }
	value_checks := [
		acl_assosiations_payload_assert_acls_element_id(x[key], "id", concat("", [hint, ".", "id"])),
		acl_assosiations_payload_assert_acls_element_number_of_associations(x[key], "number_of_associations", concat("", [hint, ".", "number_of_associations"])),
	]
	every c in value_checks { c }
} else := false

acl_assosiations_payload_assert_acls_element_id(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

acl_assosiations_payload_assert_acls_element_number_of_associations(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false