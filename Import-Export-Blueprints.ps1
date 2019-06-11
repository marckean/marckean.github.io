<#
Original Author: Dean Cefola
Modified by: Marc Kean
Creation Date: 05-20-2019
Usage      : AZURE Blueprint - Export and Import as Code 

******************************************************************************
 Date                         Version      Changes
------------------------------------------------------------------------------
 05/20/2019                       1.0       Intial Version

******************************************************************************
 https://github.com/DeanCefola/Azure-Blueprints

#####################################################################################

Recommend to update to version 2.2.0 of the Az PowerShell Module

The Az PowerShell Module is available from here https://github.com/Azure/azure-powershell/releases/tag/v1.4.0-February2019
... or run: Install-Module -Name Az -RequiredVersion 2.2.0 -AllowClobber

Run Get-InstalledModule to check installed modules

Migration instructions Azure.RM to Az - https://azure.microsoft.com/en-au/blog/how-to-migrate-from-azurerm-to-az-in-azure-powershell/
More information on Installing PowerShell Core 6 https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6
#>

##########################################################
#    Get PowerShell Script to manage Azure Blueprints    #
##########################################################
Install-Script -Name Manage-AzureRMBlueprint `
    -AllowPrerelease `
    -AcceptLicense `
    -Repository PSGallery `
    -MinimumVersion 2.3 `
    -Force `
    -Verbose 

##############################
#    Get Subscription Info   #
##############################
Connect-AzAccount
$SubName = 'Microsoft Azure Internal Consumption'
$Subscription = (Get-AzSubscription `
    -SubscriptionName $SubName).id


##########################
#    Export Blueprint    #
##########################
Manage-AzureRMBlueprint.ps1 `
    -Mode Export `
    -BlueprintName Governance `
    -ExportDir c:\temp\Blueprint `
    -SubscriptionId $Subscription `
    -ModuleMode Az `
    -Verbose


##########################
#    Import Blueprint    #
##########################
Manage-AzureRMBlueprint.ps1 `
    -Mode Import `
    -NewBlueprintName Governance `
    -ManagementGroupID AA-Root `
    -SubscriptionId $Subscription `
    -ModuleMode Az `
    -ImportDir 'c:\temp\Blueprint' `
    -Force
