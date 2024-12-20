# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.firebaseauth

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Firebase Authentication User Activities Are Logged
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
#   d := shisho.decision.googlecloud.firebaseauth.user_activity_logging({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.firebaseauth.user_activity_logging_payload({
#       "enabled": false,
#       "tenant_scopes": [{"tenant_name": "example", "enabled": false}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_user_activity_logging"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_user_activity_logging".
user_activity_logging(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": user_activity_logging_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": user_activity_logging_locator(d),
			"severity": user_activity_logging_severity(d),
		}),
		"payload": d.payload,
	}
}

user_activity_logging_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

user_activity_logging_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

user_activity_logging_kind = "googlecloud_firebaseauth_user_activity_logging"

user_activity_logging_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": user_activity_logging_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(user_activity_logging_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
user_activity_logging_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_user_activity_logging"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_firebaseauth_user_activity_logging
#
#   The parameter `data` is an object with the following fields:
#   - enabled: boolean
#   - tenant_scopes: {"tenant_name": string, "enabled": boolean}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "enabled": false,
#     "tenant_scopes": [{"tenant_name": "example", "enabled": false}],
#   }
#   ```
user_activity_logging_payload(edata) := x {
	user_activity_logging_payload_assert(edata, "<the argument to user_activity_logging_payload>")
	x := json.marshal(edata)
} else := ""

user_activity_logging_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "enabled", concat("", [hint, ".", "enabled"])),
		assertion.has_key(edata, "tenant_scopes", concat("", [hint, ".", "tenant_scopes"])),
	]
	every c in key_checks { c }

	value_checks := [
		user_activity_logging_payload_assert_enabled(edata, "enabled", concat("", [hint, ".", "enabled"])),
		user_activity_logging_payload_assert_tenant_scopes(edata, "tenant_scopes", concat("", [hint, ".", "tenant_scopes"])),
	]
	every c in value_checks { c }
} else := false

user_activity_logging_payload_assert_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

user_activity_logging_payload_assert_tenant_scopes(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [user_activity_logging_payload_assert_tenant_scopes_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

user_activity_logging_payload_assert_tenant_scopes_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "tenant_name", "string", hint),
		assertion.has_typed_key(x[key], "enabled", "boolean", hint),
	]
	every c in key_checks { c }
	value_checks := [
		user_activity_logging_payload_assert_tenant_scopes_element_tenant_name(x[key], "tenant_name", concat("", [hint, ".", "tenant_name"])),
		user_activity_logging_payload_assert_tenant_scopes_element_enabled(x[key], "enabled", concat("", [hint, ".", "enabled"])),
	]
	every c in value_checks { c }
} else := false

user_activity_logging_payload_assert_tenant_scopes_element_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

user_activity_logging_payload_assert_tenant_scopes_element_tenant_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
