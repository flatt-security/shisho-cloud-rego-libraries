# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.codebuild

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that CodeBuild project environment variables do not contain clear text AWS credentials
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
#   d := shisho.decision.aws.codebuild.project_env_variables({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.codebuild.project_env_variables_payload({
#       "environment_variables": [{"type": "example", "name": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_codebuild_project_env_variables"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_codebuild_project_env_variables".
project_env_variables(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": project_env_variables_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": project_env_variables_locator(d),
			"severity": project_env_variables_severity(d),
		}),
		"payload": d.payload,
	}
}

project_env_variables_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

project_env_variables_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

project_env_variables_kind = "aws_codebuild_project_env_variables"

project_env_variables_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": project_env_variables_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "CodeBuild.2",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(project_env_variables_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
project_env_variables_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_codebuild_project_env_variables"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_codebuild_project_env_variables
#
#   The parameter `data` is an object with the following fields:
#   - environment_variables: {"type": string, "name": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "environment_variables": [{"type": "example", "name": "example"}],
#   }
#   ```
project_env_variables_payload(edata) := x {
	project_env_variables_payload_assert(edata, "<the argument to project_env_variables_payload>")
	x := json.marshal(edata)
} else := ""

project_env_variables_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "environment_variables", concat("", [hint, ".", "environment_variables"]))]
	every c in key_checks { c }

	value_checks := [project_env_variables_payload_assert_environment_variables(edata, "environment_variables", concat("", [hint, ".", "environment_variables"]))]
	every c in value_checks { c }
} else := false

project_env_variables_payload_assert_environment_variables(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [project_env_variables_payload_assert_environment_variables_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

project_env_variables_payload_assert_environment_variables_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "type", "string", hint),
		assertion.has_typed_key(x[key], "name", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		project_env_variables_payload_assert_environment_variables_element_type(x[key], "type", concat("", [hint, ".", "type"])),
		project_env_variables_payload_assert_environment_variables_element_name(x[key], "name", concat("", [hint, ".", "name"])),
	]
	every c in value_checks { c }
} else := false

project_env_variables_payload_assert_environment_variables_element_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

project_env_variables_payload_assert_environment_variables_element_type(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
