# External WAN IP Check for NordVPN/Providers

This PowerShell script verifies whether the system's external WAN IP address is associated with NordVPN or a list of recognized hosting providers. It uses the [ipinfo.io](https://ipinfo.io/) API to retrieve IP and organization details and returns specific exit codes based on the connection status.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Configuration](#configuration)
- [Exit Codes](#exit-codes)
- [License](#license)
- [Contributing](#contributing)

## Overview

The script checks if your machine is connected through NordVPN or another trusted provider. It:

- Retrieves the external IP and organization information.
- Compares the organization against a predefined list of recognized providers.
- Returns a success code if the connection is valid or error codes otherwise.

## Features

- **External IP Check**: Queries ipinfo.io to obtain current WAN IP and organization.
- **Provider Verification**: Validates connection against NordVPN and other trusted providers.
- **Customizable Recognized Organizations**: Easily modify which organizations are considered valid.
- **Exit Codes**: 
  - `0` if connected via a recognized provider.
  - `1` if the organization is unrecognized.
  - `2` if unable to determine IP/organization or an error occurs.

## Prerequisites

- PowerShell 5.0 or later.
- Internet access to call the ipinfo.io API.
- No additional modules or dependencies are required.

## Usage

1. **Download the Script**  
   Save the script as `Check-WAN-IP.ps1` on your system.

2. **Run the Script**  
   Open PowerShell and navigate to the directory containing the script. Execute:
   ```powershell
   .\Check-WAN-IP.ps1
   ```

3. **Interpret the Output**  
   - If connected through a recognized provider, you'll see a success message with the IP and organization details.
   - If not, you'll see a warning message indicating an unrecognized organization.
   - In case of errors determining the IP or organization, an error message is displayed.

4. **Use Exit Codes in Automation**  
   After running the script, check `$LASTEXITCODE` to determine the result:
   - `0` – Valid connection.
   - `1` – Unrecognized organization.
   - `2` – Error occurred or details could not be determined.

## Configuration

The list of recognized organizations is defined in the script. By default, it includes NordVPN and several known hosting providers. If you use a different VPN provider or know of another organization associated with NordVPN or trusted services that isn’t listed, you can modify this list.

1. Open the `Check-WAN-IP.ps1` script in a text editor.
2. Locate the `$recognizedOrgs` array near the top of the script.
3. Add, remove, or modify organization names as needed. For example:

   ```powershell
   $recognizedOrgs = @(
       "NordVPN",
       "Clouvider",
       "DataCamp",
       "M247",
       "Packet Exchange",
       "Nexeon Technologies",
       "Latitude.sh",
       "Psychz",
       "HostRoyale",
       "YourCustomVPNProvider"  # Add any additional providers here
   )
   ```

Adjusting this array allows the script to recognize additional trusted VPNs or hosting services as valid connections.

## Exit Codes

- **0**: Connection is via a recognized provider (success).
- **1**: Connection is not through a recognized provider (warning).
- **2**: Failed to determine IP or organization, or an error occurred (failure).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](../../issues) if you want to contribute.