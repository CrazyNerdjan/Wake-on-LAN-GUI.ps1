# Wake-on-LAN-GUI.ps1
`Wake-on-LAN-GUI.ps1` is a GUI PowerShellscript for sending Wake-on-LAN magic packets to given machine's hardware MAC address

The "WOL" part of the script is taken and modified from https://github.com/jpluimers/Wake-on-LAN.ps1

My goal was to build a graphical user interface for WOL script.


The following text is copied from https://github.com/jpluimers/Wake-on-LAN.ps1

wakeonlan supports these formats or "notational conventions":

    xx:xx:xx:xx:xx:xx (canonical)
    xx-xx-xx-xx-xx-xx (Windows)
    xxxxxx-xxxxxx (Hewlett-Packard switches)
    xxxxxxxxxxxx (Intel Landesk)
