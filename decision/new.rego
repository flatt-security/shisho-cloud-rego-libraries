package shisho.decision

import data.shisho

# METADATA
# title: "Emits a decision to Shisho Cloud"
# scope: "rule"
# description: |
#   Emits a decision to Shisho Cloud.
new(d) = x {
	x := {
		"header": {
			"api_version": d.api_version,
			"kind": d.kind,
			"subject": d.subject,
			"severity": d.severity,
			"locator": d.locator,
			"labels": {},
			"annotations": {},
			"type": shisho.decision.as_decision_type(d.allowed),
		},
		"payload": d.payload,
	}
}
