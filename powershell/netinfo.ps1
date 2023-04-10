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
Collect-IPconfigurationInfo