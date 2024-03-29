$env:path += ";$home/documents/github/comp2101/powershell"
New-Alias np notepad.exe

function welcome
{
# Lab 2 COMP2101 welcome script for profile

write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."

}

function get-cpuinfo
{

$Collected_Info = Get-CimInstance CIM_Processor | Select-Object Manufacturer, Name, MaxClockSpeed, CurrentClockSpeed, NumberOfCores 
$Collected_Info | Format-List

}


function get-mydisks
{

$Collected_Info = Get-CimInstance CIM_DiskDrive | Select-Object Manufacturer, Model, SerialNumber, FirmwareRevision, Size 
$Collected_Info | Format-Table -AutoSize

}

