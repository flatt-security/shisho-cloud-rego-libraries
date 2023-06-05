# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.compute

import data.shisho

# @title Ensure Compute Engine instances block project-wide SSH keys
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
#   d := shisho.decision.googlecloud.compute.instance_project_wide_key_management({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.compute.instance_project_wide_key_management_payload({
#       "blocked": false,
#       "project_wide_key_available": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_compute_instance_project_wide_key_management"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_compute_instance_project_wide_key_management".
instance_project_wide_key_management(d) = x {
	x := {
		"header": instance_project_wide_key_management_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_project_wide_key_management_locator(d),
			"severity": instance_project_wide_key_management_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_project_wide_key_management_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_project_wide_key_management_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_project_wide_key_management_kind = "googlecloud_compute_instance_project_wide_key_management"

instance_project_wide_key_management_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_project_wide_key_management_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "4.3",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_project_wide_key_management_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_project_wide_key_management_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_compute_instance_project_wide_key_management"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_compute_instance_project_wide_key_management
#
#   The parameter `data` is an object with the following fields: 
#   - blocked: boolean
#   - project_wide_key_available: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "blocked": false,
#     "project_wide_key_available": false,
#   }
#   ```
instance_project_wide_key_management_payload(edata) = x {
	x := json.marshal(edata)
}