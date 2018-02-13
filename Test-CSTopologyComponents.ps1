<#  
.SYNOPSIS  
	#todo


.DESCRIPTION  
	Created by James Arber. www.skype4badmin.com
	Built with PoshTools www.poshtools.com
    
	
.NOTES  
    Version      	   	: 0.1 (Devel)
	Date			    : 13/02/2017 
	Lync Version		: Tested against Skype4B 2015
    Author    			: James Arber
	Header stolen from  : Greig Sheridan who stole it from Pat Richard's amazing "Get-CsConnections.ps1"
							
	:v0.1:	Internal Build
	
.LINK  
    https://www.skype4badmin.com

.KNOWN ISSUES
   None at this stage, this is however in development code and bugs are expected

.EXAMPLE Starts the tool and loads the default topology
    PS C:\> .\Test-CsTopologyComponents.ps1

.INPUT
Test-CsTopologyComponents Does not accept input from the pipeline.

.Output
Test-CsTopologyComponents Does not output to the pipeline

#>






Function Write-Log {
    PARAM(
         [String]$Message,
         [String]$Path = $LogFileLocation,
         [int]$severity = 1,
         [string]$component = "Default"
         )

         $TimeZoneBias = Get-WmiObject -Query "Select Bias from Win32_TimeZone"
         $Date= Get-Date -Format "HH:mm:ss"
         $Date2= Get-Date -Format "MM-dd-yyyy"

         $MaxLogFileSizeMB = 10
         If(Test-Path $Path)
         {
            if(((gci $Path).length/1MB) -gt $MaxLogFileSizeMB) # Check the size of the log file and archive if over the limit.
            {
                $ArchLogfile = $Path.replace(".log", "_$(Get-Date -Format dd-MM-yyy_hh-mm-ss).lo_")
                ren $Path $ArchLogfile
            }
         }
         
		 "$env:ComputerName date=$([char]34)$date2$([char]34) time=$([char]34)$date$([char]34) component=$([char]34)$component$([char]34) type=$([char]34)$severity$([char]34) Message=$([char]34)$Message$([char]34)"| Out-File -FilePath $Path -Append -NoClobber -Encoding default
         #If the log entry is just informational (less than 2), output it to write verbose
		 if ($severity -le 2) {"Info: $date $Message"| Write-Host -ForegroundColor Green}
		 #If the log entry has a severity of 3 assume its a warning and write it to write-warning
		 if ($severity -eq 3) {"$date $Message"| Write-Warning}
		 #If the log entry has a severity of 4 or higher, assume its an error and display an error message (Note, critical errors are caught by throw statements so may not appear here)
		 if ($severity -ge 4) {"$date $Message"| Write-Error}
} 

Function Read-CsPublishedTopology(){
	Write-Log -component "Read-CsPublishedTopology" -Message "Read-CsPublishedTopology Called" -severity 1
	Write-Log -component "Read-CsPublishedTopology" -Message "Read-CsPublishedTopology Called" -severity 1
	$Script:PublishedTopoloy = Get-CsTopology

}

Fucntion Test-Services{ #todo name
	#Internal Webservices FQDN
		#FQDN to IP
		#Certificate (Throw warning if cert going to expire in < 3 months)
		#Certificate valid
		#Functions
			#Addressbook
				#Addressbook Query
			#AutoDiscover
				#Valid XML
				#Check an endpoint
			#CertProv service
			#Dialin
			#CSCP
			
			#RGS
				#Clients
				#Config

	#OfficeWebApps Server

	}



Fucnction Test-CSInternalAddressBook($PoolWebServices) {
	New-Object 
}
