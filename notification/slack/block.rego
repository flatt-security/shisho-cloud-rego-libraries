package shisho.notification.slack

text_section(text, opts) = x {
	not opts.fields
	x := {"section": {"text": {"type": "mrkdwn", "text": text}}}
}

text_section(text, opts) = x {
	opts.fields
	x := {"section": {
		"text": {"type": "mrkdwn", "text": text},
		"fields": opts.fields,
	}}
}

divider_block = x {
	x := {"divider": {}}
}

context_block(elements) = x {
	x := {"context": {"elements": elements}}
}
