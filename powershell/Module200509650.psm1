# I have created a function which will collect info about IP Configuration.
function Collect-IPconfigurationInfo{
$Collected_Info = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled}
$output = foreach ($info in $Collected_Info ) {
    [PSCustomObject]@{
        "description" = $info.Description
        "index" = $info.Index
        "ip-address" = $info.IPAddress
        "subnet-mask" = $info.IPSubnet
        "DNSdomain name" = $info.DNSDomain
        "DNS server" = $info.DNSServerSearchOrder
       #"DHCP server" = $info.DHCPServer
    }
}
$output | Format-Table -AutoSize

}

#this line will call the function and displays the output.
#Collect-IPconfigurationInfo


#system
# I am developing a function that gathers information 
# gathering the hardware components of the system
function Collect-SystemHardwareInfo{
    $Collected_Info = Get-WmiObject -Class Win32_ComputerSystem
    $totalPhysicalMemory = [double]$Collected_Info.TotalPhysicalMemory / 1GB
    $totalPhysicalMemoryFormatted = "{0:N2}" -f $totalPhysicalMemory
    
    $output = [PSCustomObject]@{
        "manufacturer" = $Collected_Info.Manufacturer
        "model" = $Collected_Info.Model
        "total physical memory" = "$totalPhysicalMemoryFormatted GB"
        "description" =$Collected_Info.Description
        "type" = $Collected_Info.SystemType
    }
    return $output

}

# I am developing a function that gathers information about the operating components of the system
function Collect-OperatingInfo {
    $Collected_Info = Get-WmiObject -Class Win32_OperatingSystem
    $output=[PSCustomObject]@{
        "system name" = $Collected_Info.Caption
        "version number" = $Collected_Info.Version
    }
return $output
}

# gathers information about the system processor component
function Collect-ProcessorInfo {
   $Collected_Info = Get-WmiObject -Class Win32_Processor
    $output = [ordered]@{
        "name" = $Collected_Info.Name
        "number of cores" = $Collected_Info.NumberOfCores
        "speed mhz" = $Collected_Info.MaxClockSpeed
        "l1 cache size" = if ($Collected_Info.L1CacheSize) { ($Collected_Info.L1CacheSize[0] / 1KB).ToString("#.## KB") } else { "N/A" }
        "l2 cache size" = if ($Collected_Info.L2CacheSize) { ($Collected_Info.L2CacheSize[0] / 1KB).ToString("#.## KB") } else { "N/A" }
        "l3 cache size" = if ($Collected_Info.L3CacheSize) { ($Collected_Info.L3CacheSize[0] / 1KB).ToString("#.## KB") } else { "N/A" }
    }
    return $output.GetEnumerator() | Format-Table    
    
}


# gathers information about the system memory component
function Collect-RAMmemoryInfo {
   $Collected_Info = Get-WmiObject -Class Win32_PhysicalMemory
    $totalMemory = 0
    $output = foreach ($Collected_RAM in $Collected_Info) {
        [PSCustomObject]@{
            vendor = $Collected_RAM.Manufacturer
            description = $Collected_RAM.Description
            capacity = "{0:N2} GB" -f ($Collected_RAM.Capacity / 1GB)
            slot = $Collected_RAM.DeviceLocator
            type = $Collected_RAM.MemoryType
            speed = $Collected_RAM.Speed
        }
        $totalMemory += $Collected_RAM.Capacity
    }

    $output | Format-Table -AutoSize
    Write-Output "Total $(('{0:N2}' -f ($totalMemory / 1GB))) GB is available in the system"
  

 }

# gathers information about the system disk component
function Collect-DiskDriveInfo{
  $diskdrives = CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                $space = [math]::Round(($logicaldisk.FreeSpace / $logicaldisk.Size) * 100, 2)
		$output= [PSCustomObject]@{

		  manufacturer=$disk.Manufacturer
          model=$disk.Model     
		  size = "{0:N2} GB" -f ($logicaldisk.Size / 1GB)
          "available-space" = "{0:N2} GB" -f ($logicaldisk.FreeSpace / 1GB)
		 "Free-space" = "$space%"
			                                                     }
		 $output
           }
      }
  }

}
                                                         
# gathers information about the system video component
function Collect-VideoControllerInfo {
    $Collected_Info = Get-WmiObject -Class Win32_VideoController
    $output= foreach ($info in $Collected_Info) {
        [PSCustomObject]@{
            vendor = $info.VideoProcessor
            description = $info.Description
            resolution = "{0}x{1}" -f $info.CurrentHorizontalResolution, $v.CurrentVerticalResolution
        }
    }
    $output | Format-List
}




# calling all the function and display output
Write-Output " 	"
Write-Output "++++++++++++++++++++                               System Information Report                          +++++++++++++++++++++" 

Write-Output "+++	Collected Hardware Info"
Collect-SystemHardwareInfo | Format-List

Write-Output "+++	Collected Oprating System Info"
Collect-OperatingInfo | Format-List

Write-Output "  "
Write-Output "+++	Collected Processor Info"
Collect-ProcessorInfo | Format-List


Write-Output "+++	Collected RAM Memory Info"
Collect-RAMmemoryInfo

Write-Output "  "
Write-Output "  "
Write-Output "+++	Collected Disk Drive Info"
Collect-DiskDriveInfo | Format-Table -AutoSize


Write-Output "+++	Collected IP Configuration Info"
netinfo.ps1

Write-Output "+++	Collected Video Controller Info"
Collect-VideoControllerInfo | Format-List
Write-Output "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

#profile

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

