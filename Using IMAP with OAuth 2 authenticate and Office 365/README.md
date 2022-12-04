# Using IMAP with OAuth 2 authenticate and Office 365
This document summarizes some tips to correctly configure Azure AD, consent and so on, for **background applications** like services or daemons..
It also provides two working examples getting a token, connecting to an outlook account using IMAP and OAuth 2, and listing mailbox folders.
- DELPHI example
- [JAVA example](https://github.com/victorgv/dev-notes/tree/main/Using%20IMAP%20with%20OAuth%202%20authenticate%20and%20Office%20365/JAVA_example)

# Using the examples
You need an application registered on Azure AD and this values: 
- Tenant ID
- Client ID
- Secret Value
- Mail address

Replace into Main class in JAVA project or into xxx.pas in DELPHI project.


# Setting up Azure AD
On [how-to-authenticate-an-imap-pop-smtp-app](https://learn.microsoft.com/en-us/exchange/client-developer/legacy-protocols/how-to-authenticate-an-imap-pop-smtp-application-by-using-oauth) ([spanish version](https://learn.microsoft.com/es-es/exchange/client-developer/legacy-protocols/how-to-authenticate-an-imap-pop-smtp-application-by-using-oauth)) page it is explained in detail, you have to pay attention because there are several steps and it is easy to make a mistake.



# Thanks
Projects helps to understand and make correct configurations
- https://github.com/geoffsmith82/GmailAuthSMTP
- https://github.com/alkampfergit/DotNetCoreOauth2 ([video](https://www.youtube.com/watch?v=Q660AYVZM0Y))

