#region INFO
<# 
.SYNOPSIS
    
    PowerShell helpers to check and configure Microsfot Teams Auto Attendant and Call Flow voice policies
 
.DESCRIPTION
    Author: Andrew Morpeth
    
   This script is provided as-is, no warranty is provided or implied. The author is NOT responsible 
   for any damages or data loss that may occur through the use of this script. Always test before 
   using in a production environment. The script remains the intellectual property of the author.

.LINK
    Blog: https://ucgeek.co/ 
#>
#endregion INFO


#SETUP######################################################################################################################
Connect-MicrosoftTeams
$TenantDialPlan = "<TENANT DIAL PLAN>" #Optional - If not set Microsoft will assign a default based on usage location
$VoiceRoutingPolicy = "<VOICE ROUTING POLICY>" #Required to grant outbound PSTN calling permissions to a Auto Attendant or Queue
$ra = "<RESOURCE ACCOUNT UPN>" #Resource Account UPN

#CHECK CURRENT CONFIG#######################################################################################################
Get-CsOnlineUser $ra | select DisplayName, UserPrincipalName, TenantDialPlan, OnlineVoiceRoutingPolicy


#CONFIGURE##################################################################################################################
#Voice Routing Policy - only required if you need to transfer to external numbers
Grant-CsOnlineVoiceRoutingPolicy -Identity $ra -PolicyName $VoiceRoutingPolicy

#Dial Plan - only required if you need to transfer to external numbers
Grant-CsTenantDialPlan -Identity $ra -PolicyName $TenantDialPlan

