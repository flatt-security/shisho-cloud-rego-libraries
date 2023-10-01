# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.logging

import data.shisho

# @title Ensure that Cloud Storage buckets for storing logs are configured using bucket lock
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
#   d := shisho.decision.googlecloud.logging.bucket_retention_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.logging.bucket_retention_policy_payload({
#       "locked": false,
#       "retention_period": 0,
#       "storage_bucket_name": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_logging_bucket_retention_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_logging_bucket_retention_policy".
bucket_retention_policy(d) = x {
	x := {
		"header": bucket_retention_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": bucket_retention_policy_locator(d),
			"severity": bucket_retention_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

bucket_retention_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

bucket_retention_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

bucket_retention_policy_kind = "googlecloud_logging_bucket_retention_policy"

bucket_retention_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": bucket_retention_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.3",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(bucket_retention_policy_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
bucket_retention_policy_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_logging_bucket_retention_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_logging_bucket_retention_policy
#
#   The parameter `data` is an object with the following fields: 
#   - locked: boolean
#   - retention_period: number
#   - storage_bucket_name: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "locked": false,
#     "retention_period": 0,
#     "storage_bucket_name": "example",
#   }
#   ```
bucket_retention_policy_payload(edata) = x {
	x := json.marshal(edata)
}