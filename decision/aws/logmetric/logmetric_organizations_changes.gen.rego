# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.logmetric

import data.shisho

# @title Ensure a log metric filter and alarm exist for AWS Organizations changes
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
#   d := shisho.decision.aws.logmetric.organizations_changes({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.logmetric.organizations_changes_payload({
#       "cis_notification_implementations": [{"trail_name": "example", "metric_name": "example", "alarm_name": "example", "sns_topic_arn": "example"}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_logmetric_organizations_changes"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_logmetric_organizations_changes".
organizations_changes(d) = x {
	x := {
		"header": organizations_changes_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": organizations_changes_locator(d),
			"severity": organizations_changes_severity(d),
		}),
		"payload": d.payload,
	}
}

organizations_changes_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

organizations_changes_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

organizations_changes_kind = "aws_logmetric_organizations_changes"

organizations_changes_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": organizations_changes_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "4.15",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(organizations_changes_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
organizations_changes_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_logmetric_organizations_changes"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_logmetric_organizations_changes
#
#   The parameter `data` is an object with the following fields: 
#   - cis_notification_implementations: {"trail_name": string, "metric_name": string, "alarm_name": string, "sns_topic_arn": string}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "cis_notification_implementations": [{"trail_name": "example", "metric_name": "example", "alarm_name": "example", "sns_topic_arn": "example"}],
#   }
#   ```
organizations_changes_payload(edata) = x {
	x := json.marshal(edata)
}
