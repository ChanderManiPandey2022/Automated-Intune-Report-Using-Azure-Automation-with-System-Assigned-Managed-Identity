﻿ 
#NOTES
#Onjuective:      Script to used to generate AutoPilot Deployment Report
#Version:         1.0
#Author:          Chander Mani Pandey
#Creation Date:   3 Dec 2023
#Find Author on 
#Youtube:-        https://www.youtube.com/@chandermanipandey8763
#Twitter:-        https://twitter.com/Mani_CMPandey
#LinkedIn:-       https://www.linkedin.com/in/chandermanipandey


# Connect to Microsoft Graph within Azure Automation 
Connect-AzAccount -Identity  ##Az.Accounts
$token = Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com"

#Connect-MgGraph #Microsoft.Graph.Authentication
Connect-MgGraph -Identity  

$graphUri = "https://graph.microsoft.com/beta/deviceManagement/AutopilotEvents"
$Method = "GET"
# Send the request and retrieve the devices
$response = Invoke-MgGraphRequest -Method $Method -uri $graphUri 

# Create a report variable
$report = @()

# Build the report
foreach ($device in $response.Value) {
    $deviceName = $device.managedDeviceName
    $serialNumber = $device.deviceSerialNumber
    $osVersion = $device.osVersion
    $enrollmentType = $device.enrollmentType
    $deploymentState = $device.deploymentState
    $deviceSetupStatus = $device.deviceSetupStatus
    $accountSetupStatus = $device.accountSetupStatus
    $deploymentDuration = $device.deploymentDuration
    $deploymentTotalDuration = $device.deploymentTotalDuration
    $devicePreparationDuration = $device.devicePreparationDuration
    $deviceSetupDuration = $device.deviceSetupDuration
    $accountSetupDuration = $device.accountSetupDuration

    $deviceInfo = [PSCustomObject]@{
        DeviceName = $deviceName
        SerialNumber = $serialNumber
        OSVersion = $osVersion
        EnrollmentType = $enrollmentType
        DeploymentState = $deploymentState
        #DeviceSetupStatus = $deviceSetupStatus
        #AccountSetupStatus = $accountSetupStatus
        #DeploymentDuration = $deploymentDuration
        #DeploymentTotalDuration = $deploymentTotalDuration
        #DevicePreparationDuration = $devicePreparationDuration
        #DeviceSetupDuration = $deviceSetupDuration
        #AccountSetupDuration = $accountSetupDuration
    }

    $report += $deviceInfo
}

# Report Output
$report | Format-Table
