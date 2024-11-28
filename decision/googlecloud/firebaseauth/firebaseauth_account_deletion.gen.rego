# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.firebaseauth

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Firebase Authentication Self-Account Deletion Permission Is Intentional and Not a Mistake
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
#   d := shisho.decision.googlecloud.firebaseauth.account_deletion({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.firebaseauth.account_deletion_payload({
#       "can_be_deleted": false,
#       "tenant_scopes": [{"tenant_name": "example", "can_be_deleted": false}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_account_deletion"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_account_deletion".
account_deletion(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": account_deletion_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": account_deletion_locator(d),
			"severity": account_deletion_severity(d),
		}),
		"payload": d.payload,
	}
}

account_deletion_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

account_deletion_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

account_deletion_kind = "googlecloud_firebaseauth_account_deletion"

account_deletion_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": account_deletion_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(account_deletion_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
account_deletion_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_account_deletion"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_account_deletion
#
#   The parameter `data` is an object with the following fields:
#   - can_be_deleted: boolean
#   - tenant_scopes: {"tenant_name": string, "can_be_deleted": boolean}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "can_be_deleted": false,
#     "tenant_scopes": [{"tenant_name": "example", "can_be_deleted": false}],
#   }
#   ```
account_deletion_payload(edata) := x {
	account_deletion_payload_assert(edata, "<the argument to account_deletion_payload>")
	x := json.marshal(edata)
} else := ""

account_deletion_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "can_be_deleted", concat("", [hint, ".", "can_be_deleted"])),
		assertion.has_key(edata, "tenant_scopes", concat("", [hint, ".", "tenant_scopes"])),
	]
	every c in key_checks { c }

	value_checks := [
		account_deletion_payload_assert_can_be_deleted(edata, "can_be_deleted", concat("", [hint, ".", "can_be_deleted"])),
		account_deletion_payload_assert_tenant_scopes(edata, "tenant_scopes", concat("", [hint, ".", "tenant_scopes"])),
	]
	every c in value_checks { c }
} else := false

account_deletion_payload_assert_can_be_deleted(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

account_deletion_payload_assert_tenant_scopes(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [account_deletion_payload_assert_tenant_scopes_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

account_deletion_payload_assert_tenant_scopes_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "tenant_name", "string", hint),
		assertion.has_typed_key(x[key], "can_be_deleted", "boolean", hint),
	]
	every c in key_checks { c }
	value_checks := [
		account_deletion_payload_assert_tenant_scopes_element_tenant_name(x[key], "tenant_name", concat("", [hint, ".", "tenant_name"])),
		account_deletion_payload_assert_tenant_scopes_element_can_be_deleted(x[key], "can_be_deleted", concat("", [hint, ".", "can_be_deleted"])),
	]
	every c in value_checks { c }
} else := false

account_deletion_payload_assert_tenant_scopes_element_can_be_deleted(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

account_deletion_payload_assert_tenant_scopes_element_tenant_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
