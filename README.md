# Legislative Openness Data Explorer

## Requirements
- PHP >=5.4
- Smarty 3
- Python 3 (optional, for updating only)
- Python 3 packages: csv, io, json, os, requests, gitpython  (optional, for updating only)
- git version >=2.3 (optional, for updating only)
- `system` allowed for PHP (optional, for updating only)
- `mbstring` installed for PHP

## Instructions

### General
- copy `www/settings-example.json` into `www/settings.json` and set it correctly, this file needs to be readable by www server
- set `smarty/templates_c` writable and readable by www server
- create `www/cache` and set it writable and readable by www server
- set all `.json` files in `inc/` files writable and readable by www server

#### Fonts
The application uses http://fontawesome.io/, which needs to be downloaded into `www/fonts/` directory.

### Updating
Go to `http(s)://<example.com>/update.php`

Note: If the changes are not reflected on the website, go to the source Google Sheet and `Stop publishing` it (`File`->`Publish to the web...`->`Stop publishing`) and `Start publishing` it again (explanation: it seems that Google Sheets sometimes do not reflect the changes made online into its downloadable versions)

Note: `www/inc/*.py` files are rather tightly connected to the current dataset. They allow to add more chambers in the dataset, but not to change questions (structure of columns)

### Clear cache
Go to `http(s)://<example.com>/clear-cache.php`

Note: The cache is also cleared during data update and regularly based on value in `www/settings.json`

## Data Settings
Correct dataset needs to be set in `www/inc/*.py` files, as well as in `www/settings.json`
