# MD5 checksum calculate and check

Scripts for calculating and checking md5 checksum for specified folder.

**WARNING! Running this file, you accept that you know what you're doing. All actions with this script are at your own
risk.**

## Usage

1. Copy this folder content to your `/opt/scripts` on the Linux system where you need to process md5.
2. Set-up `$SOURCE_PATH` variable in [**calculate_md5.sh**](calculate_md5.sh) and
[**check_md5.sh**](check_md5.sh) scripts.
3. (Optional) Modify your [**check_error_notifications.sh**](check_error_notifications.sh) to send an error message to your
messenger.
4. Run `calculate_md5.sh` to calculate md5 checksums in `$SOURCE_PATH`, then run `check_md5.sh` to check.
