function Update-MakeMKVFiles {

$origLoc = Get-Location
set-location "C:\Holding\MakeMkv"

    $files = gci -File

    ForEach ($file in $files){

        if ($file.Extension -eq ".mkv"){
    
        $filename = $file.basename
        $fileend = $filename.substring($filename.length -3)
    
        if ($fileend -like "t0*"){
            $c = ($filename.length - 3)
            $newfilename = $filename.substring(0,$c)
            $newfilename = $newfilename +"(2018)"
            $newfilename = ($newfilename -replace "_"," ")
            $newfullname = $newfilename +".mkv"
        
            Rename-Item $file -NewName $newfullname
        
            $newpath = New-Item -ItemType Directory -Name $newfilename
        
            Move-Item $newfullname -Destination $NewPath
            }
        }
    }

Set-Location $origLoc

}