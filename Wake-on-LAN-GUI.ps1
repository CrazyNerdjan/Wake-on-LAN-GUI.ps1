#functions
#The function send-packet is partially taken from https://github.com/jpluimers/Wake-on-LAN.ps1
function Send-Packet() { 
    param($MacAddress)

            $Broadcast = ([System.Net.IPAddress]::Broadcast)
     
            ## Create UDP client instance
            $UdpClient = New-Object Net.Sockets.UdpClient
     
            ## Create IP endpoints for each port
            $IPEndPoint = New-Object Net.IPEndPoint $Broadcast, 9
    
            $BareMacAddressString = $MacAddress.ToUpper() -split "[:\.-]" -join "" # \ because it is a regular expression
     
            ## Construct physical address instance for the hardware MAC address of the machine (string to byte array)
            $MAC = [Net.NetworkInformation.PhysicalAddress]::Parse($BareMacAddressString)
     
            ## Construct the Magic Packet frame
            $Packet = [Byte[]](, 0xFF * 6) + ($MAC.GetAddressBytes() * 16)
     
            ## Broadcast UDP packets to the IP endpoint of the machine
            $UdpClient.Send($Packet, $Packet.Length, $IPEndPoint) | Out-Null
            $UdpClient.Close()
        
        
    
    }

###Button click function
Function Button_Click()
{
    $mac = $textBox.Text
    Send-Packet -MacAddress $mac
    
}

#Hides the console when GUI starts
function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}


#############GUI####################
#Import forms
Add-Type -Assembly System.Windows.Forms 

# .Net methods for hiding/showing the console in the background
Add-Type -Name Window -Namespace Console -MemberDefinition ' 
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
' 
#Hide-console function
Hide-Console

#basic window
$form = New-Object Windows.Forms.Form 
$form.FormBorderStyle ="FixedToolWindow"
$form.Text ="Wake on LAN"
$form.StartPosition = "CenterScreen"
$form.Topmost = $true 

$form.Width = 600
$form.Height= 300

#titel
$titel = New-Object system.Windows.Forms.Label 
$titel.text ="Wake on LAN"
$titel.AutoSize = $true 
$titel.location = New-Object System.Drawing.Point(20,20) 
$titel.Font = "Microsoft Sans Serif,14" 

#description
$description = New-Object system.Windows.Forms.Label
$description.text = "Please enter the mac address of the PC you want to wake up: "
$description.AutoSize = $true
$description.location = New-Object System.Drawing.Point(20,60)
$description.Font = "Microsoft Sans Serif,12"

#button "wake up"
$wolButton = New-Object System.Windows.Forms.Button 
$wolButton.BackColor = "#D8D8D8"
$wolButton.text ="Wake up"
$wolButton.Width = 90
$wolButton.Height= 30
$wolButton.location = New-Object System.Drawing.Point(490,230)
$wolButton.Font = "Microsoft Sans Serif,10"
$wolButton.Add_Click({Button_Click})

#close button
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.BackColor = "#D8D8D8"
$closeButton.text ="Cancel"
$closeButton.Width = 90
$closeButton.Height= 30
$closeButton.location = New-Object System.Drawing.Point(390,230)
$closeButton.Font = "Microsoft Sans Serif,10"
$closeButton.DialogResult = [System.Windows.Forms.DialogResult]::ok

#input Text
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(25,100)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$textBox.BackColor = "#FFFFFF"



#add to form
$form.controls.AddRange(@($titel,$description,$wolButton, $closeButton ,$textBox))



#start window
$form.Activate() #activate form
$form.ShowDialog()