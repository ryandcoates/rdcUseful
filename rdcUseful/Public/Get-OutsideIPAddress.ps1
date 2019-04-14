function Get-OutsideIPAddress {
    <#
    .Synopsis
       Function to return your external IP address
    .DESCRIPTION
       Get-OutsideIPAddress hits a web service and returns your outside interface IP address via a single command
    .EXAMPLE
       Get-OutsideIPAddress
    #>
        Process
        {
            $holdIP = Invoke-WebRequest -Uri http://icanhazip.com
            $holdPTR = Invoke-WebRequest -Uri http://icanhazptr.com
    
            [String]$IPAddress = $($holdIP.Content).TrimEnd()
            [String]$PTR = $($holdPTR.Content).TrimEnd()
    
            $OutsideIP = New-Object -TypeName PSObject
            $OutsideIP | Add-Member -Type NoteProperty -Name IPAddress -Value $IPAddress
            $OutsideIP | Add-Member -Type NoteProperty -Name PTR -Value $PTR
        } # process block
    
        End
        {
            Return $OutsideIP
        } # end block
    
    } # function