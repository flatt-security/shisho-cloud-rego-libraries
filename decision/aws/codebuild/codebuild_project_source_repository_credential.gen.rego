# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.codebuild

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that CodeBuild Bitbucket source repository URLs do not include credentials
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
#   d := shisho.decision.aws.codebuild.project_source_repository_credential({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.codebuild.project_source_repository_credential_payload({
#       "auth": {"type": "example", "arn": "example"},
#       "source_type": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_codebuild_project_source_repository_credential"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_codebuild_project_source_repository_credential".
project_source_repository_credential(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": project_source_repository_credential_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": project_source_repository_credential_locator(d),
			"severity": project_source_repository_credential_severity(d),
		}),
		"payload": d.payload,
	}
}

project_source_repository_credential_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

project_source_repository_credential_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

project_source_repository_credential_kind = "aws_codebuild_project_source_repository_credential"

project_source_repository_credential_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": project_source_repository_credential_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "CodeBuild.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(project_source_repository_credential_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
project_source_repository_credential_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_codebuild_project_source_repository_credential"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_codebuild_project_source_repository_credential
#
#   The parameter `data` is an object with the following fields:
#   - auth: {"type": string, "arn": string}
#   - source_type: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "auth": {"type": "example", "arn": "example"},
#     "source_type": "example",
#   }
#   ```
project_source_repository_credential_payload(edata) := x {
	project_source_repository_credential_payload_assert(edata, "<the argument to project_source_repository_credential_payload>")
	x := json.marshal(edata)
} else := ""

project_source_repository_credential_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "auth", concat("", [hint, ".", "auth"])),
		assertion.has_key(edata, "source_type", concat("", [hint, ".", "source_type"])),
	]
	every c in key_checks { c }

	value_checks := [
		project_source_repository_credential_payload_assert_auth(edata, "auth", concat("", [hint, ".", "auth"])),
		project_source_repository_credential_payload_assert_source_type(edata, "source_type", concat("", [hint, ".", "source_type"])),
	]
	every c in value_checks { c }
} else := false

project_source_repository_credential_payload_assert_auth(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "type", "string", hint),
		assertion.has_typed_key(x[key], "arn", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		project_source_repository_credential_payload_assert_auth_type(x[key], "type", concat("", [hint, ".", "type"])),
		project_source_repository_credential_payload_assert_auth_arn(x[key], "arn", concat("", [hint, ".", "arn"])),
	]
	every c in value_checks { c }
} else := false

project_source_repository_credential_payload_assert_auth_arn(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

project_source_repository_credential_payload_assert_auth_type(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

project_source_repository_credential_payload_assert_source_type(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false