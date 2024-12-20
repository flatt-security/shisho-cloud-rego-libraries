# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.networking

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that Stateless Network Firewall rule group is not empty
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
#   d := shisho.decision.aws.networking.frg_rules({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.networking.frg_rules_payload({
#       "number_of_rules": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_networking_frg_rules"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_networking_frg_rules".
frg_rules(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": frg_rules_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": frg_rules_locator(d),
			"severity": frg_rules_severity(d),
		}),
		"payload": d.payload,
	}
}

frg_rules_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

frg_rules_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

frg_rules_kind = "aws_networking_frg_rules"

frg_rules_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": frg_rules_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/fsbp/latest": "NetworkFirewall.6",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(frg_rules_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
frg_rules_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_networking_frg_rules"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_networking_frg_rules
#
#   The parameter `data` is an object with the following fields:
#   - number_of_rules: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "number_of_rules": 0,
#   }
#   ```
frg_rules_payload(edata) := x {
	frg_rules_payload_assert(edata, "<the argument to frg_rules_payload>")
	x := json.marshal(edata)
} else := ""

frg_rules_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "number_of_rules", concat("", [hint, ".", "number_of_rules"]))]
	every c in key_checks { c }

	value_checks := [frg_rules_payload_assert_number_of_rules(edata, "number_of_rules", concat("", [hint, ".", "number_of_rules"]))]
	every c in value_checks { c }
} else := false

frg_rules_payload_assert_number_of_rules(x, key, hint) {
	assertion.is_type(x[key], "number", hint)
} else := false
