<#
    .SYNOPSIS
    Verify connection through a recognized VPN or hosting provider by checking external WAN IP

    .DESCRIPTION
    This script obtains the system's external WAN IP address and organization details using an external API.
    It determines whether the connection is through NordVPN or other recognized hosting providers by inspecting the organization information.
    - If the connection is via one of the recognized organizations, it outputs the external IP and a success message, then returns exit code 0.
    - If the connection is not through one of the recognized organizations, it outputs a warning with the detected organization and returns exit code 1.
    - If the script fails to determine the IP address or the organization details, it outputs an error message and returns exit code 2.

    .NOTES
    Version 1.1
    Date: 2025-01-19
#>

# List of recognized organizations (NordVPN and known hosting providers)
$recognizedOrgs = @(
    "NordVPN",
    "Clouvider",
    "DataCamp",
    "M247",
    "Packet Exchange",
    "Nexeon Technologies",
    "Latitude.sh",
    "Psychz",
    "HostRoyale"
)

try {
    # Query an external service to get IP and organization information
    $response = Invoke-RestMethod -Uri "https://ipinfo.io/json" -ErrorAction Stop
    
    if ($response -and $response.ip -and $response.org) {
        $externalIP = $response.ip
        $org = $response.org
        
        Write-Host "External IP Address: $externalIP"
        Write-Host "Organization Info: $org"
        
        # Check if the organization matches any recognized organizations
        $isRecognized = $false
        foreach ($recognizedOrg in $recognizedOrgs) {
            if ($org -match [regex]::Escape($recognizedOrg)) {
                $isRecognized = $true
                break
            }
        }
        
        if ($isRecognized) {
            Write-Host "Connection is via a recognized provider: $org"
            exit 0
        } else {
            Write-Host "Warning: Unrecognized organization. Detected organization: $org"
            exit 1
        }
    } else {
        Write-Host "Failed to retrieve complete IP or organization information."
        exit 2
    }
} catch {
    Write-Host "Error occurred while fetching IP information: $($_.Exception.Message)"
    exit 2
}