# TO GET TO THE WINDOW

# WORKING !!! 

$OutPutFile 

<#

You have to Encode your file into Base64 to be able to transfer it via SendKey as it is not able to send 
special characters such as ')' 

However! With base64 encoding we can even tweak it to send over Binaries which is pretty damn cool. 

#>

function EncodeDatFile

{

<#

Inputfilepath the location of the script you wish to Encode into Base64 

OutpitFile the location of where you want the Encoded text file to be Stored. 

#>

$Inputfilepath = "G:\BlueBeast.ps1"
$Script:OutputFile = "G:\Encoded.txt"

[System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes($InputFilePath)) > $OutputFile

<#

Copy this Script to Powershell ISE on the Environment you are Decoding the File

$EncodedFile = C:\LocationOfFile

$data = Get-Content $EncodedFile

[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($data)) > C:\Destination\and\Filename.ps1

Remember to add a "+" to the end of your file on the other end as Sendkey can't add send it over.

#>

}

EncodeDatFile

<#

INSTRUCTIONS 

1). Open up the SDI Environment you want to copy your script onto 

2). Open up note pad on the remote environment 

3). Change $wshell.AppActivate('NAME OF THE WINDOW ON YOUR BROWSER RUNNING THE SDI')

4). Ensure the Variable for the Original File Location and Encoded File Location are Correct

5). Hit Run and Ensure you click your Cursor Inside the Notepad file on the Remote Host

6). Wait... Once the File Finishes Transferring add a + to the end of the File as it does not send this character

7). Copy the Decode Script over to the SDI Environment and run it with the Correct Variables

#>

Sleep 3

# IF $wshell.SendKeys Fails on a Character, Stop. 
$ErrorActionPreference = "Stop"

$wshell = New-Object -ComObject wscript.shell;

# Wshell.AppActivate Type in the Name of the Window you want to .SendKeys Too
$wshell.AppActivate('Untitled - Notepad')

# Obtain Contents of the File you want to send through .SendKey
$derp = [string[]](Get-Content -Path "$OutputFile")

# Format the Content to only Send 1 Character as a time as .Sendkeys is restrictive 
for ($line_index = 0; $line_index -lt $derp.Length; $line_index += 1)

{

    for($char_index = 0; $char_index -lt $derp[$line_index].Length; $char_index += 1)
{

    # The Delay for the Characters
    Start-Sleep -Milliseconds 10
           
        #Placing the final format of the string into a variable
       $stuff = $derp[$line_index][$char_index]

       $wshell.SendKeys("$Stuff") 

    }
}
