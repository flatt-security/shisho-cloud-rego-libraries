# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.iam

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Google Cloud service accounts have admin privileges only when truly required
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
#   d := shisho.decision.googlecloud.iam.service_account_project_admin_role({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.iam.service_account_project_admin_role_payload({
#       "suspicious_bindings": [{"service_account_email": "example", "role": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_iam_service_account_project_admin_role"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_iam_service_account_project_admin_role".
service_account_project_admin_role(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": service_account_project_admin_role_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": service_account_project_admin_role_locator(d),
			"severity": service_account_project_admin_role_severity(d),
		}),
		"payload": d.payload,
	}
}

service_account_project_admin_role_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

service_account_project_admin_role_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

service_account_project_admin_role_kind = "googlecloud_iam_service_account_project_admin_role"

service_account_project_admin_role_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": service_account_project_admin_role_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "1.5",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(service_account_project_admin_role_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
service_account_project_admin_role_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_iam_service_account_project_admin_role"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_iam_service_account_project_admin_role
#
#   The parameter `data` is an object with the following fields:
#   - suspicious_bindings: {"service_account_email": string, "role": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "suspicious_bindings": [{"service_account_email": "example", "role": "example"}],
#   }
#   ```
service_account_project_admin_role_payload(edata) := x {
	service_account_project_admin_role_payload_assert(edata, "<the argument to service_account_project_admin_role_payload>")
	x := json.marshal(edata)
} else := ""

service_account_project_admin_role_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "suspicious_bindings", concat("", [hint, ".", "suspicious_bindings"]))]
	every c in key_checks { c }

	value_checks := [service_account_project_admin_role_payload_assert_suspicious_bindings(edata, "suspicious_bindings", concat("", [hint, ".", "suspicious_bindings"]))]
	every c in value_checks { c }
} else := false

service_account_project_admin_role_payload_assert_suspicious_bindings(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [service_account_project_admin_role_payload_assert_suspicious_bindings_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

service_account_project_admin_role_payload_assert_suspicious_bindings_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "service_account_email", "string", hint),
		assertion.has_typed_key(x[key], "role", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		service_account_project_admin_role_payload_assert_suspicious_bindings_element_service_account_email(x[key], "service_account_email", concat("", [hint, ".", "service_account_email"])),
		service_account_project_admin_role_payload_assert_suspicious_bindings_element_role(x[key], "role", concat("", [hint, ".", "role"])),
	]
	every c in value_checks { c }
} else := false

service_account_project_admin_role_payload_assert_suspicious_bindings_element_role(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

service_account_project_admin_role_payload_assert_suspicious_bindings_element_service_account_email(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
