# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.github

import data.shisho

# @title Ensure the deletion of protected branches is limited
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
#   d := shisho.decision.github.branch_deletion_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.branch_deletion_policy_payload({
#       "allowed": false,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_branch_deletion_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_branch_deletion_policy".
branch_deletion_policy(d) = x {
	x := {
		"header": branch_deletion_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": branch_deletion_policy_locator(d),
			"severity": branch_deletion_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

branch_deletion_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

branch_deletion_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

branch_deletion_policy_kind = "github_branch_deletion_policy"

branch_deletion_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": branch_deletion_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.17",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_branch_deletion_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_branch_deletion_policy
#
#   The parameter `data` is an object with the following fields: 
#   - allowed: boolean
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allowed": false,
#     "subject_branch": "example",
#   }
#   ```
branch_deletion_policy_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure code owner’s review is required when a change affects owned code
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
#   d := shisho.decision.github.code_owners_review_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.code_owners_review_policy_payload({
#       "required": false,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_code_owners_review_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_code_owners_review_policy".
code_owners_review_policy(d) = x {
	x := {
		"header": code_owners_review_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": code_owners_review_policy_locator(d),
			"severity": code_owners_review_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

code_owners_review_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

code_owners_review_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

code_owners_review_policy_kind = "github_code_owners_review_policy"

code_owners_review_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": code_owners_review_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.7",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_code_owners_review_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_code_owners_review_policy
#
#   The parameter `data` is an object with the following fields: 
#   - required: boolean
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "required": false,
#     "subject_branch": "example",
#   }
#   ```
code_owners_review_policy_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure verification of signed commits for new changes before merging
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
#   d := shisho.decision.github.commit_signature_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.commit_signature_policy_payload({
#       "required": false,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_commit_signature_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_commit_signature_policy".
commit_signature_policy(d) = x {
	x := {
		"header": commit_signature_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": commit_signature_policy_locator(d),
			"severity": commit_signature_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

commit_signature_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

commit_signature_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

commit_signature_policy_kind = "github_commit_signature_policy"

commit_signature_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": commit_signature_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.12",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_commit_signature_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_commit_signature_policy
#
#   The parameter `data` is an object with the following fields: 
#   - required: boolean
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "required": false,
#     "subject_branch": "example",
#   }
#   ```
commit_signature_policy_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Keep a default branch protected by branch protection rule(s)
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
#   d := shisho.decision.github.default_branch_protection({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.default_branch_protection_payload({
#       "default_branch_name": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_default_branch_protection"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_default_branch_protection".
default_branch_protection(d) = x {
	x := {
		"header": default_branch_protection_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": default_branch_protection_locator(d),
			"severity": default_branch_protection_severity(d),
		}),
		"payload": d.payload,
	}
}

default_branch_protection_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

default_branch_protection_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

default_branch_protection_kind = "github_default_branch_protection"

default_branch_protection_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": default_branch_protection_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.14",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_default_branch_protection"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_default_branch_protection
#
#   The parameter `data` is an object with the following fields: 
#   - default_branch_name: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "default_branch_name": "example",
#   }
#   ```
default_branch_protection_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure force push code to branches is denied
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
#   d := shisho.decision.github.force_push_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.force_push_policy_payload({
#       "allowed": false,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_force_push_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_force_push_policy".
force_push_policy(d) = x {
	x := {
		"header": force_push_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": force_push_policy_locator(d),
			"severity": force_push_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

force_push_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

force_push_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

force_push_policy_kind = "github_force_push_policy"

force_push_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": force_push_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.16",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_force_push_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_force_push_policy
#
#   The parameter `data` is an object with the following fields: 
#   - allowed: boolean
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allowed": false,
#     "subject_branch": "example",
#   }
#   ```
force_push_policy_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure linear history is required
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
#   d := shisho.decision.github.linear_history_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.linear_history_policy_payload({
#       "required": false,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_linear_history_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_linear_history_policy".
linear_history_policy(d) = x {
	x := {
		"header": linear_history_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": linear_history_policy_locator(d),
			"severity": linear_history_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

linear_history_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 0

linear_history_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

linear_history_policy_kind = "github_linear_history_policy"

linear_history_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": linear_history_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.13",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_linear_history_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_linear_history_policy
#
#   The parameter `data` is an object with the following fields: 
#   - required: boolean
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "required": false,
#     "subject_branch": "example",
#   }
#   ```
linear_history_policy_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure any change to code receives the enough number of approvals by authenticated users
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
#   d := shisho.decision.github.minimum_approval_number_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.minimum_approval_number_policy_payload({
#       "required_approval_count": 0,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_minimum_approval_number_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_minimum_approval_number_policy".
minimum_approval_number_policy(d) = x {
	x := {
		"header": minimum_approval_number_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": minimum_approval_number_policy_locator(d),
			"severity": minimum_approval_number_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

minimum_approval_number_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 2

minimum_approval_number_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

minimum_approval_number_policy_kind = "github_minimum_approval_number_policy"

minimum_approval_number_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": minimum_approval_number_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.3",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_minimum_approval_number_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_minimum_approval_number_policy
#
#   The parameter `data` is an object with the following fields: 
#   - required_approval_count: number
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "required_approval_count": 0,
#     "subject_branch": "example",
#   }
#   ```
minimum_approval_number_policy_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure branch protection rules are enforced for administrators
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
#   d := shisho.decision.github.protection_enforcement_for_admins({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.protection_enforcement_for_admins_payload({
#       "allowed": false,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_protection_enforcement_for_admins"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_protection_enforcement_for_admins".
protection_enforcement_for_admins(d) = x {
	x := {
		"header": protection_enforcement_for_admins_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": protection_enforcement_for_admins_locator(d),
			"severity": protection_enforcement_for_admins_severity(d),
		}),
		"payload": d.payload,
	}
}

protection_enforcement_for_admins_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

protection_enforcement_for_admins_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

protection_enforcement_for_admins_kind = "github_protection_enforcement_for_admins"

protection_enforcement_for_admins_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": protection_enforcement_for_admins_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.14",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_protection_enforcement_for_admins"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_protection_enforcement_for_admins
#
#   The parameter `data` is an object with the following fields: 
#   - allowed: boolean
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allowed": false,
#     "subject_branch": "example",
#   }
#   ```
protection_enforcement_for_admins_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure minimum number of administrators are set for the GitHub repository
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
#   d := shisho.decision.github.repo_admins({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.repo_admins_payload({
#       "admins": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_repo_admins"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_repo_admins".
repo_admins(d) = x {
	x := {
		"header": repo_admins_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": repo_admins_locator(d),
			"severity": repo_admins_severity(d),
		}),
		"payload": d.payload,
	}
}

repo_admins_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

repo_admins_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

repo_admins_kind = "github_repo_admins"

repo_admins_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": repo_admins_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "common",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.3.7",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_repo_admins"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_repo_admins
#
#   The parameter `data` is an object with the following fields: 
#   - admins: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "admins": ["example"],
#   }
#   ```
repo_admins_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure deletion of GitHub repositories is restricted
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
#   d := shisho.decision.github.repo_members_permission_on_deleting_repository({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.repo_members_permission_on_deleting_repository_payload({
#       "allowed_users": ["example"],
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_repo_members_permission_on_deleting_repository"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_repo_members_permission_on_deleting_repository".
repo_members_permission_on_deleting_repository(d) = x {
	x := {
		"header": repo_members_permission_on_deleting_repository_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": repo_members_permission_on_deleting_repository_locator(d),
			"severity": repo_members_permission_on_deleting_repository_severity(d),
		}),
		"payload": d.payload,
	}
}

repo_members_permission_on_deleting_repository_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

repo_members_permission_on_deleting_repository_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

repo_members_permission_on_deleting_repository_kind = "github_repo_members_permission_on_deleting_repository"

repo_members_permission_on_deleting_repository_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": repo_members_permission_on_deleting_repository_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.2.3",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_repo_members_permission_on_deleting_repository"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_repo_members_permission_on_deleting_repository
#
#   The parameter `data` is an object with the following fields: 
#   - allowed_users: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allowed_users": ["example"],
#   }
#   ```
repo_members_permission_on_deleting_repository_payload(edata) = x {
	x := json.marshal(edata)
}

# @title Ensure previous approvals are dismissed when updates are introduced to a code change proposal
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
#   d := shisho.decision.github.stale_review_policy({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.github.stale_review_policy_payload({
#       "enforced": false,
#       "subject_branch": "example",
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:github_stale_review_policy"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:github_stale_review_policy".
stale_review_policy(d) = x {
	x := {
		"header": stale_review_policy_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": stale_review_policy_locator(d),
			"severity": stale_review_policy_severity(d),
		}),
		"payload": d.payload,
	}
}

stale_review_policy_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

stale_review_policy_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

stale_review_policy_kind = "github_stale_review_policy"

stale_review_policy_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": stale_review_policy_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.1.4",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:github_stale_review_policy"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:github_stale_review_policy
#
#   The parameter `data` is an object with the following fields: 
#   - enforced: boolean
#   - subject_branch: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "enforced": false,
#     "subject_branch": "example",
#   }
#   ```
stale_review_policy_payload(edata) = x {
	x := json.marshal(edata)
}
