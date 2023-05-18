# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.logging

import data.shisho

# @title Ensure Cloud Audit Logging is configured to record API operations
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
#   d := shisho.decision.googlecloud.logging.api_audit({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.logging.api_audit_payload({
#       "audit_configs": [{"service": "example", "audit_log_configs": [{"audit_log_config_log_type": AUDIT_LOG_CONFIG_LOG_TYPE_LOG_TYPE_UNSPECIFIED, "exempted_members": ["example"]}]}],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_logging_api_audit"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_logging_api_audit".
api_audit(d) = x {
	x := {
		"header": api_audit_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": api_audit_locator(d),
			"severity": api_audit_severity(d),
		}),
		"payload": d.payload,
	}
}

api_audit_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

api_audit_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

api_audit_kind = "googlecloud_logging_api_audit"

api_audit_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": api_audit_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.1",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(api_audit_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
api_audit_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_logging_api_audit"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_logging_api_audit
#
#   The parameter `data` is an object with the following fields: 
#   - audit_configs: {"service": string, "audit_log_configs": {"audit_log_config_log_type": audit_log_config_log_type, "exempted_members": string}}
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "audit_configs": [{"service": "example", "audit_log_configs": [{"audit_log_config_log_type": AUDIT_LOG_CONFIG_LOG_TYPE_LOG_TYPE_UNSPECIFIED, "exempted_members": ["example"]}]}],
#   }
#   ```
api_audit_payload(edata) = x {
	x := json.marshal(edata)
}

AUDIT_LOG_CONFIG_LOG_TYPE_LOG_TYPE_UNSPECIFIED = 0

AUDIT_LOG_CONFIG_LOG_TYPE_ADMIN_READ = 1

AUDIT_LOG_CONFIG_LOG_TYPE_DATA_READ = 2

AUDIT_LOG_CONFIG_LOG_TYPE_DATA_WRITE = 3
