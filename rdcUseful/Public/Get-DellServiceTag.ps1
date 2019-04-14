function Get-DellServiceTag {
    param (
    [string]$strDellServer
    )
 Invoke-Command -ComputerName $strDellServer -Command {Get-WMIObject win32_SystemEnclosure | select serialnumber}
} #end function Get-DellServiceTag