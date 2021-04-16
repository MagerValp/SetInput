#!/bin/bash


iss() {
	"/Library/Application Support/SetInput/InputSourceSelector" "$@"
}


# Read layouts.txt into array.
IFS=$'\r\n' GLOBIGNORE='*' command eval 'layouts=($(grep -v "^#" "/Library/Application Support/SetInput/layouts.txt"))'

# Enable layouts in array.
for layout in "${layouts[@]}"; do
	iss enable "$layout"
done

# Select the first layout in the array.
iss select "${layouts[0]}"

# Disable all layouts that aren't in the array.
while read -r enabled; do
	if [[ ! " ${layouts[@]} " =~ " $enabled " ]]; then
		iss disable "$enabled"
	fi
done < <( iss list-enabled | cut -d" " -f1 )


exit 0
