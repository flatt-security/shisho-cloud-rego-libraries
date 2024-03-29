# - This code was generated by Shisho Cloud's internal system (protoc-gen-regolib).
# - When you find something to improve, you can create an GitHub issue, instead of creating pull requests.

package shisho.decision.googlecloud.compute

import data.shisho
import data.shisho.assertion
import data.shisho.primitive

import future.keywords.every

# @title Ensure Compute Engine instances enable Shielded VM features
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
#   d := shisho.decision.googlecloud.compute.instance_shielded_vm({
#     "allowed": allowed,
#     "subject": subject,
#     "payload": shisho.decision.googlecloud.compute.instance_shielded_vm_payload({
#       "integrity_monitoring_enabled": false,
#       "secure_boot_enabled": false,
#       "vtpm_enabled": false,
#     }),
#   })
# }
# ```

# METADATA
# title: "decision.api.shisho.dev/v1beta:googlecloud_compute_instance_shielded_vm"
# scope: "rule"
# description: |
#   Emits a decision whose type is decision.api.shisho.dev/v1beta:googlecloud_compute_instance_shielded_vm".
instance_shielded_vm(d) = x {
	shisho.decision.has_required_fields(d)
	x := {
		"header": instance_shielded_vm_header({
			"allowed": d.allowed,
			"subject": d.subject,
			"locator": instance_shielded_vm_locator(d),
			"severity": instance_shielded_vm_severity(d),
		}),
		"payload": d.payload,
	}
}

instance_shielded_vm_severity(d) := shisho.decision.severity_info {
	d.allowed == true
} else := d.severity {
	not is_null(d.severity)
} else := 1

instance_shielded_vm_locator(d) := d.locator {
	not is_null(d.locator)
} else := ""

instance_shielded_vm_kind = "googlecloud_compute_instance_shielded_vm"

instance_shielded_vm_header(h) = x {
	x := {
		"api_version": "decision.api.shisho.dev/v1beta",
		"kind": instance_shielded_vm_kind,
		"subject": h.subject,
		"locator": h.locator,
		"severity": h.severity,
		"labels": {},
		"annotations": {
			"decision.api.shisho.dev:googlecloud/cis-benchmark/v1.3.0": "4.8",
			"decision.api.shisho.dev:needs-manual-review": "false",
			"decision.api.shisho.dev:ssc/category": "infrastructure",
		},
		"type": shisho.decision.as_decision_type(instance_shielded_vm_allowed(h)),
	}
}

# Force to allow the given decision following resource exception policy
instance_shielded_vm_allowed(h) {
	data.params != null
	data.params.resource_exceptions != null
	shisho.resource.is_excepted(data.params.resource_exceptions, h.subject)
} else := h.allowed

# METADATA
# title: "Entry of decision.api.shisho.dev/v1beta:googlecloud_compute_instance_shielded_vm"
# scope: "rule"
# description: |
#   Emits a decision entry describing the detail of a decision decision.api.shisho.dev/v1beta:googlecloud_compute_instance_shielded_vm
#
#   The parameter `data` is an object with the following fields:
#   - integrity_monitoring_enabled: boolean
#   - secure_boot_enabled: boolean
#   - vtpm_enabled: boolean
#
#   For instance, `data` can take the following value:
#   ```rego
#   {
#     "integrity_monitoring_enabled": false,
#     "secure_boot_enabled": false,
#     "vtpm_enabled": false,
#   }
#   ```
instance_shielded_vm_payload(edata) := x {
	instance_shielded_vm_payload_assert(edata, "<the argument to instance_shielded_vm_payload>")
	x := json.marshal(edata)
} else := ""

instance_shielded_vm_payload_assert(edata, hint) {
	assertion.is_type(edata, "object", hint)

	key_checks := [
		assertion.has_key(edata, "integrity_monitoring_enabled", concat("", [hint, ".", "integrity_monitoring_enabled"])),
		assertion.has_key(edata, "secure_boot_enabled", concat("", [hint, ".", "secure_boot_enabled"])),
		assertion.has_key(edata, "vtpm_enabled", concat("", [hint, ".", "vtpm_enabled"])),
	]
	every c in key_checks { c }

	value_checks := [
		instance_shielded_vm_payload_assert_integrity_monitoring_enabled(edata, "integrity_monitoring_enabled", concat("", [hint, ".", "integrity_monitoring_enabled"])),
		instance_shielded_vm_payload_assert_secure_boot_enabled(edata, "secure_boot_enabled", concat("", [hint, ".", "secure_boot_enabled"])),
		instance_shielded_vm_payload_assert_vtpm_enabled(edata, "vtpm_enabled", concat("", [hint, ".", "vtpm_enabled"])),
	]
	every c in value_checks { c }
} else := false

instance_shielded_vm_payload_assert_integrity_monitoring_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

instance_shielded_vm_payload_assert_secure_boot_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false

instance_shielded_vm_payload_assert_vtpm_enabled(x, key, hint) {
	assertion.is_type(x[key], "boolean", hint)
} else := false
