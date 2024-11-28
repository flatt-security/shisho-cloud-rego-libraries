# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.ec2

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that stopped EC2 instances are removed
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
#   d := shisho.decision.aws.ec2.instance_state({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.ec2.instance_state_payload({
#       "state": "example",
#       "state_transition_time": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_ec2_instance_state"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_ec2_instance_state".
instance_state(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_state_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_state_locator(d),
			"severity": instance_state_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_state_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

instance_state_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_state_kind = "aws_ec2_instance_state"

instance_state_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_state_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "EC2.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_state_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_state_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_ec2_instance_state"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_ec2_instance_state
#
#   The parameter `data` is an object with the following fields:
#   - state: string
#   - state_transition_time: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "state": "example",
#     "state_transition_time": "example",
#   }
#   ```
instance_state_payload(edata) := x {
	instance_state_payload_assert(edata, "<the argument to instance_state_payload>")
	x := json.marshal(edata)
} else := ""

instance_state_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "state", concat("", [hint, ".", "state"])),
		assertion.has_key(edata, "state_transition_time", concat("", [hint, ".", "state_transition_time"])),
	]
	every c in key_checks { c }

	value_checks := [
		instance_state_payload_assert_state(edata, "state", concat("", [hint, ".", "state"])),
		instance_state_payload_assert_state_transition_time(edata, "state_transition_time", concat("", [hint, ".", "state_transition_time"])),
	]
	every c in value_checks { c }
} else := false

instance_state_payload_assert_state(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

instance_state_payload_assert_state_transition_time(x, key, hint) {
	not primitive.has_key(x, key)
} else {
	is_null(x[key])
} else {
	assertion.is_type(x[key], "string", hint)
} else := false
