function Test-DownorJustme{
    <#
    .Synopsis
       Short description
    .DESCRIPTION
       Long description
    .EXAMPLE
       Example of how to use this cmdlet
    .EXAMPLE
       Another example of how to use this cmdlet
    #>
    
        [CmdletBinding()]
        [Alias()]
        [OutputType([int])]
        Param
        (
            # Param1 help description
            [Parameter(Mandatory=$true,
                       ValueFromPipelineByPropertyName=$true,
                       Position=0)]
            $URI
    
    
        )
    
        Begin
        {
            $hold = Invoke-WebRequest -Uri http://www.downforeveryoneorjustme.com/$uri
        }
        Process
        {
            If ($hold.content | Select-String "It's just you."){
                Write-Output "It's just down for you"
            } else {
                Write-Output "The site seems to be down"
            }
        }
        End
        {
        }
    }