# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.monitoring

import data.shisho

# @title Ensure a Google Cloud project is monitoring audit configuration assignments/changes
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
#   d := shisho.decision.googlecloud.monitoring.audit_configuration({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.audit_configuration_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_audit_configuration"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_audit_configuration".
audit_configuration(d) = x {
	x := {
		"header": audit_configuration_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": audit_configuration_locator(d),
			"severity": audit_configuration_severity(d),
		}),
		"payload": d.payload,
	}
}

audit_configuration_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

audit_configuration_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

audit_configuration_kind = "googlecloud_monitoring_audit_configuration"

audit_configuration_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": audit_configuration_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(audit_configuration_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
audit_configuration_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_audit_configuration"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_audit_configuration
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
audit_configuration_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure a Google Cloud project is monitoring custom role changes
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
#   d := shisho.decision.googlecloud.monitoring.custom_role({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.custom_role_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_custom_role"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_custom_role".
custom_role(d) = x {
	x := {
		"header": custom_role_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": custom_role_locator(d),
			"severity": custom_role_severity(d),
		}),
		"payload": d.payload,
	}
}

custom_role_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

custom_role_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

custom_role_kind = "googlecloud_monitoring_custom_role"

custom_role_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": custom_role_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.6",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(custom_role_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
custom_role_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_custom_role"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_custom_role
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
custom_role_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure a Google Cloud project is monitoring firewall rule changes
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
#   d := shisho.decision.googlecloud.monitoring.firewall_rule({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.firewall_rule_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_firewall_rule"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_firewall_rule".
firewall_rule(d) = x {
	x := {
		"header": firewall_rule_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": firewall_rule_locator(d),
			"severity": firewall_rule_severity(d),
		}),
		"payload": d.payload,
	}
}

firewall_rule_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

firewall_rule_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

firewall_rule_kind = "googlecloud_monitoring_firewall_rule"

firewall_rule_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": firewall_rule_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.7",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(firewall_rule_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
firewall_rule_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_firewall_rule"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_firewall_rule
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
firewall_rule_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure a Google Cloud project is monitoring network changes
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
#   d := shisho.decision.googlecloud.monitoring.network({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.network_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_network"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_network".
network(d) = x {
	x := {
		"header": network_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": network_locator(d),
			"severity": network_severity(d),
		}),
		"payload": d.payload,
	}
}

network_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

network_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

network_kind = "googlecloud_monitoring_network"

network_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": network_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.9",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(network_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
network_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_network"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_network
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
network_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure a Google Cloud project is monitoring network route changes
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
#   d := shisho.decision.googlecloud.monitoring.network_route({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.network_route_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_network_route"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_network_route".
network_route(d) = x {
	x := {
		"header": network_route_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": network_route_locator(d),
			"severity": network_route_severity(d),
		}),
		"payload": d.payload,
	}
}

network_route_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

network_route_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

network_route_kind = "googlecloud_monitoring_network_route"

network_route_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": network_route_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.8",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(network_route_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
network_route_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_network_route"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_network_route
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
network_route_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure a Google Cloud project is monitoring project ownership assignments/changes
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
#   d := shisho.decision.googlecloud.monitoring.project_ownership({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.project_ownership_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_project_ownership"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_project_ownership".
project_ownership(d) = x {
	x := {
		"header": project_ownership_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": project_ownership_locator(d),
			"severity": project_ownership_severity(d),
		}),
		"payload": d.payload,
	}
}

project_ownership_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

project_ownership_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

project_ownership_kind = "googlecloud_monitoring_project_ownership"

project_ownership_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": project_ownership_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.4",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(project_ownership_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
project_ownership_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_project_ownership"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_project_ownership
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
project_ownership_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure a Google Cloud project is monitoring Cloud SQL configuration changes
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
#   d := shisho.decision.googlecloud.monitoring.sql_instance_configuration({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.sql_instance_configuration_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_sql_instance_configuration"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_sql_instance_configuration".
sql_instance_configuration(d) = x {
	x := {
		"header": sql_instance_configuration_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": sql_instance_configuration_locator(d),
			"severity": sql_instance_configuration_severity(d),
		}),
		"payload": d.payload,
	}
}

sql_instance_configuration_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

sql_instance_configuration_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

sql_instance_configuration_kind = "googlecloud_monitoring_sql_instance_configuration"

sql_instance_configuration_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": sql_instance_configuration_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.11",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(sql_instance_configuration_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
sql_instance_configuration_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_sql_instance_configuration"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_sql_instance_configuration
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
sql_instance_configuration_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure a Google Cloud project is monitoring Cloud Storage IAM changes
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
#   d := shisho.decision.googlecloud.monitoring.storage_iam({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.monitoring.storage_iam_payload({
#       "monitored": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_monitoring_storage_iam"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_monitoring_storage_iam".
storage_iam(d) = x {
	x := {
		"header": storage_iam_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": storage_iam_locator(d),
			"severity": storage_iam_severity(d),
		}),
		"payload": d.payload,
	}
}

storage_iam_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

storage_iam_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

storage_iam_kind = "googlecloud_monitoring_storage_iam"

storage_iam_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": storage_iam_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "2.10",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(storage_iam_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
storage_iam_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_monitoring_storage_iam"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_monitoring_storage_iam
#
#   The parameter `data` is an object with the following fields: 
#   - monitored: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "monitored": false,
#   }
#   ```
storage_iam_payload(edata) = x {
	x := json.marshal(edata)
}
