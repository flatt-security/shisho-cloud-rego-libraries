# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.aws.iam

import data.shisho

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
			"decision.api.shisho.dev:aws/fsbp/latest": "IAM.22",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(credentials_inventory_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
credentials_inventory_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

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
