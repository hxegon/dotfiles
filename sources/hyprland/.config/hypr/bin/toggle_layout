#!/usr/bin/env sh
# vi: ft=sh

# Toggle hyprland kb_variant between qwerty and dvorak
# Optional first arg is the path to hyprland.conf
# defaults to ~/.config/hypr/hyprland.conf
#
# Put this in something like ~/.config/hypr/bin/toggle_layout,
# chmod +x it, and add some binding like this:
# bind = $mainMod SHIFT, T, exec, /home/<your_username>/.config/hypr/bin/toggle_layout
#
# WARNING: THIS WILL NOT WORK IF YOU HAVE MORE THAN 1 'kb_variant'
# LINE IN YOUR CONFIG
#
# It's a good idea to move this into a separate config file
# and source it.
# - If there's a bug here it could mangle your config
# - If you have your config in source control, this will
# you can add your default layout in a separate file,
# commit then ignore it, and when you run this you won't
# have a messy diffs or statuses after you run this

MSG="Changing layout..."
echo "$MSG"
notify-send "$MSG"

# find config file
if [ $# -eq 0 ]; then
	# Default hyprland conf file
	echo 'choosing default hyprland config'
	HYPR_CONFIG="$HOME/.config/hypr/hyprland.conf"
else
	echo "hypr config location $1"
	HYPR_CONFIG="$1"
fi

# Ensure config file exists
if [ ! -f "$HYPR_CONFIG" ]; then
  echo "ERROR: Config not found at $1."
  exit 1
fi

KB_VARIANT_LINE="$(grep 'kb_variant =' "$HYPR_CONFIG")"

# Ensure there's only 1 kb_variant line
N_OF_KB_VARIANT="$(echo $KB_VARIANT_LINE | wc -l)"

if [ "N_OF_KB_VARIANT" -eq 0 ]; then
	# There needs to a kb_variant line, even if it's empty.
	MSG='ERROR: no kb variant setting found'
	notify-send "$MSG"
	echo "$MSG"
	exit 1
elif [ $N_OF_KB_VARIANT -gt 1 ]; then
  MSG='ERROR: More than 1 kb_variant line found.'
	notify-send "$MSG"
	echo "$MSG"
fi

# Determine what you're switching from/to
CURRENT_SETTING="$(echo "$KB_VARIANT_LINE" | sed -E 's/\s*kb_variant\s*=\s*//')"
if [ "$CURRENT_SETTING" = "dvorak" ]; then
  NEW_VARIANT=''
  NEW_VARIANT_NAME='qwerty'
else # assume layout is qwerty
  NEW_VARIANT='dvorak'
  NEW_VARIANT_NAME='dvorak'
fi

## APPLY THE NEW SETTING
sed -iE --follow-symlinks "s/kb_variant\s*=.*/kb_variant = $NEW_VARIANT/" "$HYPR_CONFIG"

# For me, hyprland won't apply the new variant if the variant is set to dvorak.
# touching it forces the a full reload and it applies then.
touch "$HYPR_CONFIG"

# it takes a sec for it to be applied
sleep 2

MSG="Changed layout to $NEW_VARIANT_NAME"

echo "$MSG"
notify-send "$MSG"

exit 0
