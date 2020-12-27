# esx_adminzone
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/nick-perry14/esx_adminzone)](#)
[![Maintenance](https://img.shields.io/maintenance/yes/2020)](#)
[![GitHub all releases](https://img.shields.io/github/downloads/nick-perry14/esx_adminzone/total)](https://github.com/nick-perry14/esx_adminmode/releases)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/nick-perry14/esx_adminzone)](https://github.com/nick-perry14/esx_adminmode/releases/latest)
[![GitHub issues](https://img.shields.io/github/issues/nick-perry14/esx_adminzone)](https://github.com/nick-perry14/esx_adminmode/issues)

## About
### Admin Zones
This is a simple admin project that allows users of a specific group to set an "Admin Zone".  These zones automatically:
- Disable Firing
- Disable Meele
- Notifies player upon entering/leaving zone
- Draws a notification on the screen
- Adds a ***TEMPORARY*** blip that shows on users map.  (Additional info below)
- Warns players who are speeeding to slow down.

Upon removing the zones, the resource:
- Ungods the player
- Returns their ESX Job back to where it was before
- Removes the admin vehicle (unreliable at the current point)
- Resets the player's ped to the ESX skin (looking to change to last ped to work with EUP)

## Commands
- /setzone - Enables the admin zone around the admin
- /clearzone - Clears the admin zone of the admin.
