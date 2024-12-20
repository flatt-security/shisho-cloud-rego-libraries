# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.ecs

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that ECS task definitions do not share the host's process namespace
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
#   d := shisho.decision.aws.ecs.task_process_namespace({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.ecs.task_process_namespace_payload({
#       "not_shared_namespace": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_ecs_task_process_namespace"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_ecs_task_process_namespace".
task_process_namespace(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": task_process_namespace_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": task_process_namespace_locator(d),
			"severity": task_process_namespace_severity(d),
		}),
		"payload": d.payload,
	}
}

task_process_namespace_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

task_process_namespace_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

task_process_namespace_kind = "aws_ecs_task_process_namespace"

task_process_namespace_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": task_process_namespace_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "ECS.3",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(task_process_namespace_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
task_process_namespace_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_ecs_task_process_namespace"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_ecs_task_process_namespace
#
#   The parameter `data` is an object with the following fields:
#   - not_shared_namespace: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "not_shared_namespace": false,
#   }
#   ```
task_process_namespace_payload(edata) := x {
	task_process_namespace_payload_assert(edata, "<the argument to task_process_namespace_payload>")
	x := json.marshal(edata)
} else := ""

task_process_namespace_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "not_shared_namespace", concat("", [hint, ".", "not_shared_namespace"]))]
	every c in key_checks { c }

	value_checks := [task_process_namespace_payload_assert_not_shared_namespace(edata, "not_shared_namespace", concat("", [hint, ".", "not_shared_namespace"]))]
	every c in value_checks { c }
} else := false

task_process_namespace_payload_assert_not_shared_namespace(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
