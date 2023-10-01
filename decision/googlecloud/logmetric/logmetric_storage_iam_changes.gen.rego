# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.logmetric

import data.shisho

# @title Ensure that the log metric filter and alerts exist for Cloud Storage IAM permission changes
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
#   d := shisho.decision.googlecloud.logmetric.storage_iam_changes({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.logmetric.storage_iam_changes_payload({
#       "cis_notification_implementations": [{"metric_name": "example", "alert_policy_name": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_logmetric_storage_iam_changes"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_logmetric_storage_iam_changes".
storage_iam_changes(d) = x {
	x := {
		"header": storage_iam_changes_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": storage_iam_changes_locator(d),
			"severity": storage_iam_changes_severity(d),
		}),
		"payload": d.payload,
	}
}

storage_iam_changes_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

storage_iam_changes_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

storage_iam_changes_kind = "googlecloud_logmetric_storage_iam_changes"

storage_iam_changes_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": storage_iam_changes_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.10",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(storage_iam_changes_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
storage_iam_changes_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_logmetric_storage_iam_changes"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_logmetric_storage_iam_changes
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
storage_iam_changes_payload(edata) = x {
	x := json.marshal(edata)
}
