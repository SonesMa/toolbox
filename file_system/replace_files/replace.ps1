<#
.SYNOPSIS
This script will search files in source directory, and then replace given files in dstination directory.
.DESCRIPTION
Fist, set the file name matcher. And then this script will search related files in source directory. Last, files in source directory will be copyed to directory under destination where contains related files.
.PARAMETER fileinfo
description to this parameter.
.PARAMETER sourcePath
description to this parameter.
.PARAMETER destinationPath
description to this parameter.
.Example
.\replace -fileinfo *.txt -sourcePath ./new -destinationPath ./old
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, HelpMessage="Enter file matcher to be replaced")]
    [Alias('matcher')]
    [string]
    $fileinfo = "*.txt",

    [Parameter(Mandatory=$true, HelpMessage="Enter source directory to be searched")]
    [Alias('source')]
    [string]
    $sourcePath = ".\new",

    [Parameter(Mandatory=$true, HelpMessage="Enter destination directory to be copyed")]
    [Alias('destination')]
    [string]
    $destinationPath = ".\old"
)

# This is a single line comment.
$files = Get-ChildItem -Path $sourcePath -Filter $fileinfo
ForEach ($file in $files) {
    $targetFile = Get-ChildItem -Path $destinationPath -Recurse -Filter $file.Name
    if ($null -ne $targetFile) {
        Copy-Item -Path $file.PSPath -Destination $targetFile.Directory
        Write-Verbose "Copy $file to $($targetFile.Directory)" 
    }
    else {
        Write-Warning "Could not find $file in $destinationPath" -WarningAction Continue
    }
}