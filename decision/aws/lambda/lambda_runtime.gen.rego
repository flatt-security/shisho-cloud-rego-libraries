# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.lambda

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that Lambda functions use newer runtimes
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
#   d := shisho.decision.aws.lambda.runtime({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.lambda.runtime_payload({
#       "runtime": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_lambda_runtime"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_lambda_runtime".
runtime(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": runtime_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": runtime_locator(d),
			"severity": runtime_severity(d),
		}),
		"payload": d.payload,
	}
}

runtime_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

runtime_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

runtime_kind = "aws_lambda_runtime"

runtime_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": runtime_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "Lambda.2",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(runtime_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
runtime_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_lambda_runtime"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_lambda_runtime
#
#   The parameter `data` is an object with the following fields:
#   - runtime: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "runtime": "example",
#   }
#   ```
runtime_payload(edata) := x {
	runtime_payload_assert(edata, "<the argument to runtime_payload>")
	x := json.marshal(edata)
} else := ""

runtime_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "runtime", concat("", [hint, ".", "runtime"]))]
	every c in key_checks { c }

	value_checks := [runtime_payload_assert_runtime(edata, "runtime", concat("", [hint, ".", "runtime"]))]
	every c in value_checks { c }
} else := false

runtime_payload_assert_runtime(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
