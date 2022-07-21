# xakra_utils
## Requirements
- vorp_core
- vorp_inventory
- vorp_character

## Description
This script has three functions (Each function can be disabled):

- /ped: The peds function allows users to apply a ped appearance with the '/ped' command, players can roleplay with RDR2 peds. It can only be converted if it is indicated in the config file and in the character identified with the charidentifier, otherwise it will not be possible. 
- Multijob: The jobs function allows users who are listed in the config file to change jobs, like point 1, they will be identified by the charidentifier and will only be able to change jobs that have been assigned. Points for changing jobs and the menu can be set.
- Pipepeace: For the peace pipe function, you will need to read the 'pipepeace' object and the character will start smoking the peace pipe just like a normal pipe. They can use the folder icon 'Icon'. This function used the code from the wcrp_interaction pipe.

## Instructions to incorporate script
- Copy the script into a folder (to choose) from the 'resources' folder.
- Add 'ensure xakra_utils' in the 'Resources.cfg' document
- Create the item 'pipepeace' in the items table of the database (limit 1).
- You will need to add an image called 'item_name.png' (with png format) in the 'vorp_inventory/html/items' folder. You can use the one in the 'icon' folder.
- Correctly configure the options of the config file, you will be able to disable or enable any of the 3 functions.

Video: https://youtu.be/AX5hQqU9ze4



