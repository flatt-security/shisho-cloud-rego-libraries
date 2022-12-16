package shisho.decision

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
			"labels": {},
			"annotations": {},
			"type": shisho.decision.as_decision_type(d.allowed),
		},
		"entries": d.entries,
	}
}
