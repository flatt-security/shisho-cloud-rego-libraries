package shisho.notification

# METADATA
# title: "A notification group as a notification target"
# scope: "rule"
# description: |
#   Emits a notification representing a notification group.
# 
#   Example:
#
#   ```rego
#   import data.shisho
#  
#   notifications[n] {
#   	n := shisho.notification.to_group(
#         "NG12345678",
#         "Hello!",
#       )
#   }
#   ```
to_group(id, message) = x {
	x := {"message": {"notification_group": {
		"id": id,
		"message": message,
	}}}
}

# METADATA
# title: "A new email as a notification target"
# scope: "rule"
# description: |
#   Emits a notification representing a new email to the given email address
# 
#   Example:
#
#   ```rego
#   import data.shisho
#  
#   notifications[n] {
#   	n := shisho.notification.to_email(
#         "hello@shisho.example",
#         "Hello!",
#       )
#   }
#   ```
to_email(email, message) = x {
	x := {"message": {"email": {
		"address": email,
		"message": message,
	}}}
}

# METADATA
# title: "A new Slack message as a notification target"
# scope: "rule"
# description: |
#   Emits a notification representing a new message on the given Slack channel
# 
#   Example:
#
#   ```rego
#   import data.shisho
#  
#   notifications[n] {
#   	n := shisho.notification.to_slack_channel(
#         "WS123456",
#         "CH123456",
#         "Hello!",
#       )
#   }
#   ```
to_slack_channel(workspace_id, channel_id, message) = x {
	not message.blocks
	x := {"message": {"slack_channel": {
		"workspace_id": workspace_id,
		"channel_id": channel_id,
		"message": message,
	}}}
}

to_slack_channel(workspace_id, channel_id, message) = x {
	message.blocks
	is_array(message.blocks)
	x := {"message": {"slack_channel": {
		"workspace_id": workspace_id,
		"channel_id": channel_id,
		"blocks": message.blocks,
	}}}
}

# METADATA
# title: "A new issue comment on GitHub as a notification target"
# scope: "rule"
# description: |
#   Emits a notification representing a comment of the given GitHub issue
# 
#   Example:
#
#   ```rego
#   import data.shisho
#  
#   notifications[n] {
#   	n := shisho.notification.to_github_issue(
#         "octcat",
#         "example",
#         377,
#         "Hello!",
#       )
#   }
#   ```
to_github_issue(owner, repo, issue_id, message) = x {
	x := {"message": {"github_issue": {
		"owner": owner,
		"repo": repo,
		"issue_id": issue_id,
		"message": message,
	}}}
}

# METADATA
# title: "A new pull request comment on GitHub as a notification target"
# scope: "rule"
# description: |
#   Emits a notification representing the given GitHub pull request
# 
#   Example:
#
#   ```rego
#   import data.shisho
#  
#   notifications[n] {
#   	n := shisho.notification.to_github_pull_request(
#         "octcat",
#         "example",
#         377,
#         "Hello!",
#       )
#   }
#   ```
to_github_pull_request(owner, repo, pull_id, message) = x {
	x := to_github_issue(owner, repo, pull_id, message)
}
