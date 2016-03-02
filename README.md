# Legislative Openness Data Explorer

## Requirements
- PHP >=5.3
- Smarty 3
- Python 3 (optional, for updating only)
- `system` allowed for PHP (optional, for updating only)

## Instructions

### General
- copy `www/settings-example.json` into `www/settings.json` and set it correctly, this file needs to be readable by www server
- set `smarty/templates_c` writable and readable by www server
- set `www/cache` writable and readable by www server

### Updating
Go to `http(s)://<example.com>/update.php`

Note: `www/inc/*.py` files are rather tightly connected to the current dataset. They allow to add more chambers in the dataset, but not to change questions (structure of columns)

### Clear cache
Go to `http(s)://<example.com>/clear-cache.php`

Note: The cache is also cleared during data update.

## Data Settings
Correct dataset needs to be set in `www/inc/*.py` files, as well as in `www/settings.json`
