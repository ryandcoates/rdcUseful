function Get-Uptime {
    [CmdletBinding()]
    param 
    (
	    [Parameter(Position=0,
                   ValueFromPipeLine=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string[]]$Name
    )


        BEGIN
        {
            $OutputObject = @()
        }

        PROCESS
        {
            If (($Name -eq $Null)){
                Write-Verbose "ComputerName not supplied, setting to `$env:COMPUTERNAME"
	            $Name = $Env:COMPUTERNAME
            }
            
            Write-Verbose "`$Name set as $($_.Name)"


            foreach ($Computer in $Name){
                
	            If (Test-Connection -Quiet -Count 1 -ComputerName $Computer){
                    Write-Verbose "Getting LasTBootUpTime for $Computer"
                    
                    $wmi = Get-WmiObject -ComputerName $Computer -Query "SELECT LastBootUpTime FROM Win32_OperatingSystem" -ErrorAction SilentlyContinue
                    If ($WMI){
                        $now = Get-Date
	                    $boottime = $wmi.ConvertToDateTime($wmi.LastBootUpTime)
                        Write-Verbose "LastBootUpTime for $Computer was $boottime"            
	                    $uptime = $now - $boottime

	                    $d =$uptime.days
	                    $h =$uptime.hours
	                    $m =$uptime.Minutes
	                    $s = $uptime.Seconds
                        $UptimeOutput = "$d Days $h Hours $m Min $s Sec"


                        $ComputerObj = New-Object -TypeName PSObject
                        $ComputerObj | Add-Member -Type NoteProperty -Name 'ComputerName' -Value "$Computer"
                        $ComputerObj | Add-Member -Type NoteProperty -Name 'Uptime' -Value "$UptimeOutput"
                        $ComputerObj | Add-Member -Type NoteProperty -Name 'LastReboot' -Value "$BootTime"

                        $OutputObject += $ComputerObj
                    
                    } else {
                        
                        Write-Warning "WMI connection Failed for $Computer, skipping..."
                        Break
                    }
                
                } 
                else
                {
                    Write-Warning "$Computer unreachable, skipping..."
                    Break
                }
            }
        }
    
        END
        {
            Return $OutputObject
        }

    }