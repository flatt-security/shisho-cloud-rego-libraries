# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.github

import data.shisho

# @title Enforce two-factor authentication on GitHub organization(s)
# You can emit this decision as follows:
# 
# ```
# import data.shisho
# 
# decisions[d] {
#   # the target of the decision (e.g. a GitHub repository, etc.)
#   subject := "test"
#
#   # whether the target is allowed by this policy or not
#   allowed := true
#
#   # See the following for further information:
#   # ja: https:/shisho.dev/docs/g/api/graphql-schema
#   # en: https:/shisho.dev/docs/ja/g/api/graphql-schema
#   policyReportId := "..."
#
#   # evidence for the decision
#   entries := [
#     shisho.decision.github.org_2fa_status_entry_v2(policyReportId, {
#     }),
#   ]
#
#   d := shisho.decision.github.org_2fa_status({
#     "allowed": allowed,
#     "subject": subject,
#     "entries": entries,
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_2fa_status"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:org_2fa_status".
org_2fa_status(d) = x {
	x := {
		"header": org_2fa_status_header({
			"allowed": d.allowed,
			"subject": d.subject,
		}),
		"entries": d.entries,
	}
}

org_2fa_status_kind = "org_2fa_status"

org_2fa_status_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": org_2fa_status_kind,
		"subject": h.subject,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "common",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.3.5",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_2fa_status"
# scope: "rule"
# description: "Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_2fa_status"
org_2fa_status_entry(report_id) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({}),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_2fa_status"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_2fa_status
#
#   The parameter `data` shoud be empty object (`{}`).
org_2fa_status_entry_v2(report_id, edata) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_2fa_status"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_2fa_status with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_2fa_status_entry_with_severity(report_id, severity) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({}),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_2fa_status"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_2fa_status with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_2fa_status_entry_v2_with_severity(report_id, severity, edata) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# @title Ensure strict base permissions are set for repositories
# You can emit this decision as follows:
# 
# ```
# import data.shisho
# 
# decisions[d] {
#   # the target of the decision (e.g. a GitHub repository, etc.)
#   subject := "test"
#
#   # whether the target is allowed by this policy or not
#   allowed := true
#
#   # See the following for further information:
#   # ja: https:/shisho.dev/docs/g/api/graphql-schema
#   # en: https:/shisho.dev/docs/ja/g/api/graphql-schema
#   policyReportId := "..."
#
#   # evidence for the decision
#   entries := [
#     shisho.decision.github.org_default_repository_permission_entry_v2(policyReportId, {
#       "current": ["example"],
#     }),
#   ]
#
#   d := shisho.decision.github.org_default_repository_permission({
#     "allowed": allowed,
#     "subject": subject,
#     "entries": entries,
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_default_repository_permission"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:org_default_repository_permission".
org_default_repository_permission(d) = x {
	x := {
		"header": org_default_repository_permission_header({
			"allowed": d.allowed,
			"subject": d.subject,
		}),
		"entries": d.entries,
	}
}

org_default_repository_permission_kind = "org_default_repository_permission"

org_default_repository_permission_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": org_default_repository_permission_kind,
		"subject": h.subject,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "common",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.3.8",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_default_repository_permission"
# scope: "rule"
# description: "Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_default_repository_permission"
org_default_repository_permission_entry(report_id, current) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"current": current}),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_default_repository_permission"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_default_repository_permission
#
#   The parameter `data` is an object with the following fields: 
#   - current: string
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "current": ["example"],
#   }
#   ```
org_default_repository_permission_entry_v2(report_id, edata) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_default_repository_permission"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_default_repository_permission with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_default_repository_permission_entry_with_severity(report_id, severity, current) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"current": current}),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_default_repository_permission"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_default_repository_permission with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_default_repository_permission_entry_v2_with_severity(report_id, severity, edata) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# @title Ensure creation of GitHub public pages is restricted
# You can emit this decision as follows:
# 
# ```
# import data.shisho
# 
# decisions[d] {
#   # the target of the decision (e.g. a GitHub repository, etc.)
#   subject := "test"
#
#   # whether the target is allowed by this policy or not
#   allowed := true
#
#   # See the following for further information:
#   # ja: https:/shisho.dev/docs/g/api/graphql-schema
#   # en: https:/shisho.dev/docs/ja/g/api/graphql-schema
#   policyReportId := "..."
#
#   # evidence for the decision
#   entries := [
#     shisho.decision.github.org_members_permission_on_creating_public_pages_entry_v2(policyReportId, {
#       "allowed": false,
#     }),
#   ]
#
#   d := shisho.decision.github.org_members_permission_on_creating_public_pages({
#     "allowed": allowed,
#     "subject": subject,
#     "entries": entries,
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages".
org_members_permission_on_creating_public_pages(d) = x {
	x := {
		"header": org_members_permission_on_creating_public_pages_header({
			"allowed": d.allowed,
			"subject": d.subject,
		}),
		"entries": d.entries,
	}
}

org_members_permission_on_creating_public_pages_kind = "org_members_permission_on_creating_public_pages"

org_members_permission_on_creating_public_pages_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": org_members_permission_on_creating_public_pages_kind,
		"subject": h.subject,
		"labels": {},
		"annotations": {"decision.api.shisho.dev:ssc/category": "common"},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages"
# scope: "rule"
# description: "Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages"
org_members_permission_on_creating_public_pages_entry(report_id, allowed) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"allowed": allowed}),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages
#
#   The parameter `data` is an object with the following fields: 
#   - allowed: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allowed": false,
#   }
#   ```
org_members_permission_on_creating_public_pages_entry_v2(report_id, edata) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_members_permission_on_creating_public_pages_entry_with_severity(report_id, severity, allowed) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"allowed": allowed}),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_pages with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_members_permission_on_creating_public_pages_entry_v2_with_severity(report_id, severity, edata) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# @title Ensure public repository creation is limited to specific members
# You can emit this decision as follows:
# 
# ```
# import data.shisho
# 
# decisions[d] {
#   # the target of the decision (e.g. a GitHub repository, etc.)
#   subject := "test"
#
#   # whether the target is allowed by this policy or not
#   allowed := true
#
#   # See the following for further information:
#   # ja: https:/shisho.dev/docs/g/api/graphql-schema
#   # en: https:/shisho.dev/docs/ja/g/api/graphql-schema
#   policyReportId := "..."
#
#   # evidence for the decision
#   entries := [
#     shisho.decision.github.org_members_permission_on_creating_public_repos_entry_v2(policyReportId, {
#       "allowed": false,
#     }),
#   ]
#
#   d := shisho.decision.github.org_members_permission_on_creating_public_repos({
#     "allowed": allowed,
#     "subject": subject,
#     "entries": entries,
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos".
org_members_permission_on_creating_public_repos(d) = x {
	x := {
		"header": org_members_permission_on_creating_public_repos_header({
			"allowed": d.allowed,
			"subject": d.subject,
		}),
		"entries": d.entries,
	}
}

org_members_permission_on_creating_public_repos_kind = "org_members_permission_on_creating_public_repos"

org_members_permission_on_creating_public_repos_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": org_members_permission_on_creating_public_repos_kind,
		"subject": h.subject,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "source",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.2.2",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos"
# scope: "rule"
# description: "Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos"
org_members_permission_on_creating_public_repos_entry(report_id, allowed) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"allowed": allowed}),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos
#
#   The parameter `data` is an object with the following fields: 
#   - allowed: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allowed": false,
#   }
#   ```
org_members_permission_on_creating_public_repos_entry_v2(report_id, edata) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_members_permission_on_creating_public_repos_entry_with_severity(report_id, severity, allowed) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"allowed": allowed}),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_creating_public_repos with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_members_permission_on_creating_public_repos_entry_v2_with_severity(report_id, severity, edata) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# @title Ensure forking of GitHub repositories is restricted
# You can emit this decision as follows:
# 
# ```
# import data.shisho
# 
# decisions[d] {
#   # the target of the decision (e.g. a GitHub repository, etc.)
#   subject := "test"
#
#   # whether the target is allowed by this policy or not
#   allowed := true
#
#   # See the following for further information:
#   # ja: https:/shisho.dev/docs/g/api/graphql-schema
#   # en: https:/shisho.dev/docs/ja/g/api/graphql-schema
#   policyReportId := "..."
#
#   # evidence for the decision
#   entries := [
#     shisho.decision.github.org_members_permission_on_private_forking_entry_v2(policyReportId, {
#       "allowed": false,
#     }),
#   ]
#
#   d := shisho.decision.github.org_members_permission_on_private_forking({
#     "allowed": allowed,
#     "subject": subject,
#     "entries": entries,
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking".
org_members_permission_on_private_forking(d) = x {
	x := {
		"header": org_members_permission_on_private_forking_header({
			"allowed": d.allowed,
			"subject": d.subject,
		}),
		"entries": d.entries,
	}
}

org_members_permission_on_private_forking_kind = "org_members_permission_on_private_forking"

org_members_permission_on_private_forking_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": org_members_permission_on_private_forking_kind,
		"subject": h.subject,
		"labels": {},
		"annotations": {"decision.api.shisho.dev:ssc/category": "common"},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking"
# scope: "rule"
# description: "Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking"
org_members_permission_on_private_forking_entry(report_id, allowed) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"allowed": allowed}),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking
#
#   The parameter `data` is an object with the following fields: 
#   - allowed: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "allowed": false,
#   }
#   ```
org_members_permission_on_private_forking_entry_v2(report_id, edata) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_members_permission_on_private_forking_entry_with_severity(report_id, severity, allowed) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"allowed": allowed}),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_members_permission_on_private_forking with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_members_permission_on_private_forking_entry_v2_with_severity(report_id, severity, edata) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# @title Ensure minimum number of administrators are set for the organization
# You can emit this decision as follows:
# 
# ```
# import data.shisho
# 
# decisions[d] {
#   # the target of the decision (e.g. a GitHub repository, etc.)
#   subject := "test"
#
#   # whether the target is allowed by this policy or not
#   allowed := true
#
#   # See the following for further information:
#   # ja: https:/shisho.dev/docs/g/api/graphql-schema
#   # en: https:/shisho.dev/docs/ja/g/api/graphql-schema
#   policyReportId := "..."
#
#   # evidence for the decision
#   entries := [
#     shisho.decision.github.org_owners_entry_v2(policyReportId, {
#       "admins": ["example"],
#     }),
#   ]
#
#   d := shisho.decision.github.org_owners({
#     "allowed": allowed,
#     "subject": subject,
#     "entries": entries,
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_owners"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:org_owners".
org_owners(d) = x {
	x := {
		"header": org_owners_header({
			"allowed": d.allowed,
			"subject": d.subject,
		}),
		"entries": d.entries,
	}
}

org_owners_kind = "org_owners"

org_owners_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": org_owners_kind,
		"subject": h.subject,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:ssc/category": "common",
			"decision.api.shisho.dev:ssc/cis-benchmark/v1.0": "1.3.3",
		},
		"type": shisho.decision.as_decision_type(h.allowed),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_owners"
# scope: "rule"
# description: "Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_owners"
org_owners_entry(report_id, admins) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"admins": admins}),
	}
}

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:org_owners"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_owners
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
org_owners_entry_v2(report_id, edata) = x {
	x := {
		"severity": 1,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_owners"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_owners with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_owners_entry_with_severity(report_id, severity, admins) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal({"admins": admins}),
	}
}

# METADATA
# title: "decision.api.shisho.dev/v1beta:org_owners"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:org_owners with a specified severity.
#   Visit decision/decision.rego to see all the severities.
org_owners_entry_v2_with_severity(report_id, severity, edata) = x {
	x := {
		"severity": severity,
		"resource_id": shisho.decision.as_resource_id(report_id),
		"data": json.marshal(edata),
	}
}
