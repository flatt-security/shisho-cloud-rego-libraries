# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.functions

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure secrets are not stored in Cloud Functions environment variables
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
#   d := shisho.decision.googlecloud.functions.environment_variables({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.functions.environment_variables_payload({
#       "build_environment_variable_keys": ["example"],
#       "service_environment_variable_keys": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_functions_environment_variables"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_functions_environment_variables".
environment_variables(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": environment_variables_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": environment_variables_locator(d),
			"severity": environment_variables_severity(d),
		}),
		"payload": d.payload,
	}
}

environment_variables_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

environment_variables_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

environment_variables_kind = "googlecloud_functions_environment_variables"

environment_variables_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": environment_variables_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "1.18",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(environment_variables_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
environment_variables_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_functions_environment_variables"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_functions_environment_variables
#
#   The parameter `data` is an object with the following fields:
#   - build_environment_variable_keys: string
#   - service_environment_variable_keys: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "build_environment_variable_keys": ["example"],
#     "service_environment_variable_keys": ["example"],
#   }
#   ```
environment_variables_payload(edata) := x {
	environment_variables_payload_assert(edata, "<the argument to environment_variables_payload>")
	x := json.marshal(edata)
} else := ""

environment_variables_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "build_environment_variable_keys", concat("", [hint, ".", "build_environment_variable_keys"])),
		assertion.has_key(edata, "service_environment_variable_keys", concat("", [hint, ".", "service_environment_variable_keys"])),
	]
	every c in key_checks { c }

	value_checks := [
		environment_variables_payload_assert_build_environment_variable_keys(edata, "build_environment_variable_keys", concat("", [hint, ".", "build_environment_variable_keys"])),
		environment_variables_payload_assert_service_environment_variable_keys(edata, "service_environment_variable_keys", concat("", [hint, ".", "service_environment_variable_keys"])),
	]
	every c in value_checks { c }
} else := false

environment_variables_payload_assert_build_environment_variable_keys(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [environment_variables_payload_assert_build_environment_variable_keys_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

environment_variables_payload_assert_build_environment_variable_keys_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

environment_variables_payload_assert_service_environment_variable_keys(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [environment_variables_payload_assert_service_environment_variable_keys_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

environment_variables_payload_assert_service_environment_variable_keys_element(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
