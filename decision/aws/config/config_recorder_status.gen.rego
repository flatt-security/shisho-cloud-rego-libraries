# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.config

import data.shisho

# @title Ensure AWS Config is enabled in all regions
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
#   d := shisho.decision.aws.config.recorder_status({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.config.recorder_status_payload({
#       "missing_regions": ["example"],
#       "recorders": {"name": "example", "region": "example", "recording_group": {"all_supported": false, "resource_types": ["example"], "include_global_resource_types": false}},
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_config_recorder_status"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_config_recorder_status".
recorder_status(d) = x {
	x := {
		"header": recorder_status_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": recorder_status_locator(d),
			"severity": recorder_status_severity(d),
		}),
		"payload": d.payload,
	}
}

recorder_status_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

recorder_status_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

recorder_status_kind = "aws_config_recorder_status"

recorder_status_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": recorder_status_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "3.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(recorder_status_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
recorder_status_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_config_recorder_status"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_config_recorder_status
#
#   The parameter `data` is an object with the following fields: 
#   - missing_regions: string
#   - recorders: {"name": string, "region": string, "recording_group": {"all_supported": boolean, "resource_types": string, "include_global_resource_types": boolean}}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "missing_regions": ["example"],
#     "recorders": {"name": "example", "region": "example", "recording_group": {"all_supported": false, "resource_types": ["example"], "include_global_resource_types": false}},
#   }
#   ```
recorder_status_payload(edata) = x {
	x := json.marshal(edata)
}
