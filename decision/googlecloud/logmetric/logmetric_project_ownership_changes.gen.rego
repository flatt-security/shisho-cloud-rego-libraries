# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.logmetric

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure that the log metric filter and alerts exist for project ownership assignments/changes
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
#   d := shisho.decision.googlecloud.logmetric.project_ownership_changes({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.logmetric.project_ownership_changes_payload({
#       "cis_notification_implementations": [{"metric_name": "example", "alert_policy_name": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_logmetric_project_ownership_changes"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_logmetric_project_ownership_changes".
project_ownership_changes(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": project_ownership_changes_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": project_ownership_changes_locator(d),
			"severity": project_ownership_changes_severity(d),
		}),
		"payload": d.payload,
	}
}

project_ownership_changes_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

project_ownership_changes_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

project_ownership_changes_kind = "googlecloud_logmetric_project_ownership_changes"

project_ownership_changes_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": project_ownership_changes_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(project_ownership_changes_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
project_ownership_changes_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_logmetric_project_ownership_changes"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_logmetric_project_ownership_changes
#
#   The parameter `data` is an object with the following fields:
#   - cis_notification_implementations: {"metric_name": string, "alert_policy_name": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "cis_notification_implementations": [{"metric_name": "example", "alert_policy_name": "example"}],
#   }
#   ```
project_ownership_changes_payload(edata) := x {
	project_ownership_changes_payload_assert(edata, "<the argument to project_ownership_changes_payload>")
	x := json.marshal(edata)
} else := ""

project_ownership_changes_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [assertion.has_key(edata, "cis_notification_implementations", concat("", [hint, ".", "cis_notification_implementations"]))]
	every c in key_checks { c }

	value_checks := [project_ownership_changes_payload_assert_cis_notification_implementations(edata, "cis_notification_implementations", concat("", [hint, ".", "cis_notification_implementations"]))]
	every c in value_checks { c }
} else := false

project_ownership_changes_payload_assert_cis_notification_implementations(x, key, hint) {
	assertion.is_set_or_array(x[key], hint)
	checks := [project_ownership_changes_payload_assert_cis_notification_implementations_element(x[key], i, concat("", [
		hint,
		"[",
		format_int(i, 10),
		"]",
	])) |
		_ := x[key][i]
	]
	every c in checks { c }
} else := false

project_ownership_changes_payload_assert_cis_notification_implementations_element(x, key, hint) {
	assertion.is_type(x[key], "object", hint)
	key_checks := [
		assertion.has_typed_key(x[key], "metric_name", "string", hint),
		assertion.has_typed_key(x[key], "alert_policy_name", "string", hint),
	]
	every c in key_checks { c }
	value_checks := [
		project_ownership_changes_payload_assert_cis_notification_implementations_element_metric_name(x[key], "metric_name", concat("", [hint, ".", "metric_name"])),
		project_ownership_changes_payload_assert_cis_notification_implementations_element_alert_policy_name(x[key], "alert_policy_name", concat("", [hint, ".", "alert_policy_name"])),
	]
	every c in value_checks { c }
} else := false

project_ownership_changes_payload_assert_cis_notification_implementations_element_alert_policy_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false

project_ownership_changes_payload_assert_cis_notification_implementations_element_metric_name(x, key, hint) {
	assertion.is_type(x[key], "string", hint)
} else := false
