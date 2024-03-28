# Declare variables to be used for the Email
$AccountLockOutEvent = Get-EventLog -LogName "Security" -InstanceID 4740 -Newest 1
$LockedAccount = $($AccountLockOutEvent.ReplacementStrings[0])
$MailSubject = "User - $LockedAccount Notice: User Account locked out $LockedAccount"
$MailFrom = "lockout@example.com"
$MailTo = "user1@example.com, user2@example.com"

# Gets the Event Log that contains the most recent lockout event
$Event = Get-EventLog -LogName Security -InstanceId 4740 -Newest 1

# Extracts and formats the 'Event Details' from the event message
$EventDetails = $Event.Message
$EventDetailsFormatted = $EventDetails -replace '(Account Domain:\s*)(\S+)', '$1<span style="font-weight:bold; color:red;">$2</span>' `
                                        -replace '(Caller Computer Name:\s*)(\S+)', '$1<span style="font-weight:bold; color:red;">$2</span>'

# Creates a variable which contains the HTML contents for the email body, including styling for the 'Account' value.
$MailBody = @"
<html>
<head>
<style>
  body {font-family: Arial, sans-serif;}
  table {border-collapse: collapse; width: 100%;}
  th, td {border: 1px solid #dddddd; text-align: left; padding: 8px;}
  th {background-color: #f2f2f2;}
  .styled-value {font-weight: bold; color: red;} /* Class for styling the 'Account' and specified 'Event Details' values */
</style>
</head>
<body>
<h2>Account Lockout Details</h2>
<table>
  <tr>
    <th>Property</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Account</td>
    <td class="styled-value">$LockedAccount</td>
  </tr>
  <tr>
    <td>Time Generated</td>
    <td>$($Event.TimeGenerated)</td>
  </tr>
  <tr>
    <td>Event Details</td>
    <td>$EventDetailsFormatted</td>
  </tr>
</table>
</body>
</html>
"@

# Creates an SMTP Object and assigns an SMTP Address
$SmtpClient = New-Object system.net.mail.smtpClient
$SmtpClient.host = "mail.example.com"

# Creates a new Mail Message Object. This is the object needed for the addressing email, subject, body, etc.
$MailMessage = New-Object system.net.mail.mailmessage
$MailMessage.from = $MailFrom
$MailMessage.To.add($MailTo)
$MailMessage.IsBodyHtml = $true # This needs to be set to $true for HTML content
$MailMessage.Subject = $MailSubject
$MailMessage.Body = $MailBody

# Actually Sends the Message
$SmtpClient.Send($MailMessage)
