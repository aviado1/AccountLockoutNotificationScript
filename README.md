# Account Lockout Notification Script

This PowerShell script is designed to automate the process of notifying system administrators about account lockouts. By monitoring the Security event logs for lockout events (Event ID 4740), it generates a detailed email notification containing information about the locked account, including the account name, the time of lockout, and other pertinent event details.

## Features

- **Automated Detection**: Automatically detects the most recent account lockout event from the Security event log.
- **Email Notifications**: Sends an email notification with detailed information about the account lockout, including a styled HTML body for easy reading.
- **Customizable**: Easily customizable for different email servers, recipients, and domains.

## Prerequisites

To use this script, ensure you have the following:

- PowerShell 5.1 or higher
- Access to the Security event log on the machine where account lockouts are to be monitored
- SMTP server access for sending email notifications

## Usage

1. **Configuration**: Modify the script variables `$MailFrom`, `$MailTo`, and `$SmtpClient.host` to match your email sending and receiving configuration.
2. **Execution**: Run the script in PowerShell with administrative privileges to ensure it has access to the Security event log.
3. **Scheduling**: (Optional) Schedule the script to run at specific intervals using Task Scheduler for continuous monitoring.

## Script Configuration

Below are the key variables you should configure before running the script:

- `$MailFrom`: The email address used to send lockout notifications.
- `$MailTo`: The recipient email addresses, separated by commas for multiple recipients.
- `$SmtpClient.host`: The SMTP server address used to send the email.

## Author

This script was authored by [aviado1](https://github.com/aviado1).

## Contributing

Your contributions are welcome! If you have suggestions for improving this script, please open an issue or submit a pull request.

## Acknowledgments

Special thanks to everyone who tests, contributes to, or uses this script. Your feedback and contributions help improve it for everyone.
