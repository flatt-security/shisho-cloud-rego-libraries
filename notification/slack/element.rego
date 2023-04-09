package shisho.notification.slack

text_element(text) = x {
	x := {"type": "mrkdwn", "text": text}
}

image_element(url) = x {
	x := {"type": "image", "image_url": url, "alt_text": ""}
}
