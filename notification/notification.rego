package shisho.notification

# METADATA
# title: "A new notification"
# scope: "rule"
# description: |
#   Emits a new notification with the given message to the given target.
#
#   # Example 1
#   You can send a new notification to a notification group by writing a policy in `jobs[].notify.rego` as follwos:
#
#   ```rego
#   import data.shisho
#  
#   notifications[n] {
#   	target := shisho.notification.to_notification_group("id-of-notification-group")
#   	msg := "test"
#   
#   	n := shisho.notification.new(target, msg)
#   }
#   ```
#
#   # Example 2
#   You can send a new comment to a GitHub issue by writing a policy in `jobs[].notify.rego` as follwos:
#
#   ```rego
#   import data.shisho
#  
#   notifications[n] {
#   	target := shisho.notification.to_github_issue(
#         "octcat",
#         "example",
#         377,
#       )
#   	msg := "test"
#   
#   	n := shisho.notification.new(target, msg)
#   }
#   ```
new(target, message) = x {
	x := {
		"target": target,
		"message": message,
	}
}

# METADATA
# title: "A notification group as a notification target"
# scope: "rule"
# description: |
#   Emits a notification target representing a notification group.
to_notification_group(id) = x {
	x := {"notification_group": {"id": id}}
}

# METADATA
# title: "A new email as a notification target"
# scope: "rule"
# description: |
#   Emits a notification target representing a new email to the given email address
to_email(email) = x {
	x := {"email": {"email": email}}
}

# METADATA
# title: "A new Slack message as a notification target"
# scope: "rule"
# description: |
#   Emits a notification target representing a new message on the given Slack channel
to_slack_channel(workspace_id, channel_id) = x {
	x := {"slack_channel": {
		"slack_workspace_id": {"id": workspace_id},
		"channel_id": {"id": channel_id},
	}}
}

# METADATA
# title: "A new issue comment on GitHub as a notification target"
# scope: "rule"
# description: |
#   Emits a notification target representing a comment of the given GitHub issue
to_github_issue(owner, repo, issue_id) = x {
	x := {"github_issue": {
		"owner": owner,
		"repo": repo,
		"issue_id": issue_id,
	}}
}

# METADATA
# title: "A new pull request comment on GitHub as a notification target"
# scope: "rule"
# description: |
#   Emits a notification target representing the given GitHub pull request
to_github_pull_request(owner, repo, pull_id) = x {
	x := {"github_issue": {
		"owner": owner,
		"repo": repo,
		"issue_id": pull_id,
	}}
}
