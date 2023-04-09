# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho

# @title Ensure IAM policies that allow full administrative privileges are not attached
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
#   d := shisho.decision.aws.iam.administrative_policy_limitation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.administrative_policy_limitation_payload({
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation".
administrative_policy_limitation(d) = x {
	x := {
		"header": administrative_policy_limitation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": administrative_policy_limitation_locator(d),
			"severity": administrative_policy_limitation_severity(d),
		}),
		"payload": d.payload,
	}
}

administrative_policy_limitation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 4

administrative_policy_limitation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

administrative_policy_limitation_kind = "aws_iam_administrative_policy_limitation"

administrative_policy_limitation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": administrative_policy_limitation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.16",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_administrative_policy_limitation
#
#   The parameter `data` shoud be empty object (`{}`).
administrative_policy_limitation_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure credentials unused for specific days are disabled
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
#   d := shisho.decision.aws.iam.credentials_inventory({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.credentials_inventory_payload({
#       "last_used_at": "example",
#       "recommended_grace_period_days": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_credentials_inventory"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_credentials_inventory".
credentials_inventory(d) = x {
	x := {
		"header": credentials_inventory_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": credentials_inventory_locator(d),
			"severity": credentials_inventory_severity(d),
		}),
		"payload": d.payload,
	}
}

credentials_inventory_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

credentials_inventory_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

credentials_inventory_kind = "aws_iam_credentials_inventory"

credentials_inventory_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": credentials_inventory_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.12",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_credentials_inventory"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_credentials_inventory
#
#   The parameter `data` is an object with the following fields: 
#   - last_used_at: string
#   - recommended_grace_period_days: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "last_used_at": "example",
#     "recommended_grace_period_days": 0,
#   }
#   ```
credentials_inventory_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure AWS IAM access keys are rotated per pre-defined time window
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
#   d := shisho.decision.aws.iam.key_rotation({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.key_rotation_payload({
#       "keys_requiring_rotation": [{"id": "example", "created_at": "example"}],
#       "recommended_rotation_window_days": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_key_rotation"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_key_rotation".
key_rotation(d) = x {
	x := {
		"header": key_rotation_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": key_rotation_locator(d),
			"severity": key_rotation_severity(d),
		}),
		"payload": d.payload,
	}
}

key_rotation_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

key_rotation_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

key_rotation_kind = "aws_iam_key_rotation"

key_rotation_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": key_rotation_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.14",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_key_rotation"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_key_rotation
#
#   The parameter `data` is an object with the following fields: 
#   - keys_requiring_rotation: {"id": string, "created_at": string}
#   - recommended_rotation_window_days: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "keys_requiring_rotation": [{"id": "example", "created_at": "example"}],
#     "recommended_rotation_window_days": 0,
#   }
#   ```
key_rotation_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure IAM password policy requires enough minimum length
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
#   d := shisho.decision.aws.iam.password_length({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.password_length_payload({
#       "current_minimum_length": 0,
#       "minimum_length_policy_recommendation": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_password_length"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_password_length".
password_length(d) = x {
	x := {
		"header": password_length_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": password_length_locator(d),
			"severity": password_length_severity(d),
		}),
		"payload": d.payload,
	}
}

password_length_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

password_length_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

password_length_kind = "aws_iam_password_length"

password_length_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": password_length_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.8",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_password_length"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_password_length
#
#   The parameter `data` is an object with the following fields: 
#   - current_minimum_length: number
#   - minimum_length_policy_recommendation: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "current_minimum_length": 0,
#     "minimum_length_policy_recommendation": 0,
#   }
#   ```
password_length_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure IAM password policy prevents password reuse
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
#   d := shisho.decision.aws.iam.password_reuse({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.password_reuse_payload({
#       "current_reuse_prevention": 0,
#       "reuse_prevention_policy_recommendation": 0,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_password_reuse"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_password_reuse".
password_reuse(d) = x {
	x := {
		"header": password_reuse_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": password_reuse_locator(d),
			"severity": password_reuse_severity(d),
		}),
		"payload": d.payload,
	}
}

password_reuse_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

password_reuse_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

password_reuse_kind = "aws_iam_password_reuse"

password_reuse_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": password_reuse_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.9",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_password_reuse"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_password_reuse
#
#   The parameter `data` is an object with the following fields: 
#   - current_reuse_prevention: number
#   - reuse_prevention_policy_recommendation: number
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "current_reuse_prevention": 0,
#     "reuse_prevention_policy_recommendation": 0,
#   }
#   ```
password_reuse_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure Hardware MFA is enabled for the root user account
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
#   d := shisho.decision.aws.iam.root_user_hardware_mfa({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.root_user_hardware_mfa_payload({
#       "hardware_mfa_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa".
root_user_hardware_mfa(d) = x {
	x := {
		"header": root_user_hardware_mfa_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": root_user_hardware_mfa_locator(d),
			"severity": root_user_hardware_mfa_severity(d),
		}),
		"payload": d.payload,
	}
}

root_user_hardware_mfa_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

root_user_hardware_mfa_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

root_user_hardware_mfa_kind = "aws_iam_root_user_hardware_mfa"

root_user_hardware_mfa_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": root_user_hardware_mfa_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.6",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_root_user_hardware_mfa
#
#   The parameter `data` is an object with the following fields: 
#   - hardware_mfa_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "hardware_mfa_enabled": false,
#   }
#   ```
root_user_hardware_mfa_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure the AWS root user does not have access keys
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
#   d := shisho.decision.aws.iam.root_user_key({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.root_user_key_payload({
#       "root_has_access_keys": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_root_user_key"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_root_user_key".
root_user_key(d) = x {
	x := {
		"header": root_user_key_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": root_user_key_locator(d),
			"severity": root_user_key_severity(d),
		}),
		"payload": d.payload,
	}
}

root_user_key_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 3

root_user_key_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

root_user_key_kind = "aws_iam_root_user_key"

root_user_key_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": root_user_key_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.4",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_root_user_key"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_root_user_key
#
#   The parameter `data` is an object with the following fields: 
#   - root_has_access_keys: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "root_has_access_keys": false,
#   }
#   ```
root_user_key_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure MFA is enabled for the root user account
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
#   d := shisho.decision.aws.iam.root_user_mfa({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.root_user_mfa_payload({
#       "mfa_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_root_user_mfa"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_root_user_mfa".
root_user_mfa(d) = x {
	x := {
		"header": root_user_mfa_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": root_user_mfa_locator(d),
			"severity": root_user_mfa_severity(d),
		}),
		"payload": d.payload,
	}
}

root_user_mfa_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 4

root_user_mfa_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

root_user_mfa_kind = "aws_iam_root_user_mfa"

root_user_mfa_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": root_user_mfa_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.5",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_root_user_mfa"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_root_user_mfa
#
#   The parameter `data` is an object with the following fields: 
#   - mfa_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "mfa_enabled": false,
#   }
#   ```
root_user_mfa_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure the AWS root user is used only for limited usage
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
#   d := shisho.decision.aws.iam.root_user_usage({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.aws.iam.root_user_usage_payload({
#       "last_used_at": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:aws_iam_root_user_usage"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:aws_iam_root_user_usage".
root_user_usage(d) = x {
	x := {
		"header": root_user_usage_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": root_user_usage_locator(d),
			"severity": root_user_usage_severity(d),
		}),
		"payload": d.payload,
	}
}

root_user_usage_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 4

root_user_usage_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

root_user_usage_kind = "aws_iam_root_user_usage"

root_user_usage_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": root_user_usage_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:aws/cis-benchmark/v1.5.0": "1.7",
			"decision.api.shisho.dev:needs-manual-review": "true",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:aws_iam_root_user_usage"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:aws_iam_root_user_usage
#
#   The parameter `data` is an object with the following fields: 
#   - last_used_at: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "last_used_at": "example",
#   }
#   ```
root_user_usage_payload(edata) = x {
	x := json.marshal(edata)
}
