#!/bin/bash
SCRIPT_SPACES="export PATH=$PATH; $RELPATH/plugins/spaces/script.sh"

SCRIPT_SPACE_WINDOWS="export PATH=$PATH; $RELPATH/plugins/spaces/script-windows.sh"

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i + 1))

  space=(
    associated_space=$sid
    icon=${SPACE_ICONS[i]}
    icon.padding_left=8
    icon.padding_right=8
    icon.color=$GOLD_MOON
    icon.font="$FONT:Medium:14.0"
    padding_left=2
    padding_right=2
    # background.color=$HIGH_MED_MOON
    background.height=$(($BAR_HEIGHT - 10))
    # background.corner_radius=7
    # background.drawing=off
    background.border_width=1
    background.border_color=$HIGH_MED_MOON
    background.color=$OVERLAY_MOON
    background.corner_radius=8

    icon.highlight_color=$LOVE_MOON
    label.padding_right=16
    label.padding_left=-4
    label.font="sketchybar-app-font:Regular:14.0"
    label.background.height=$(($BAR_HEIGHT - 10))
    # label.background.drawing=on
    # label.background.color=$HIGH_HIGH_MOON
    # label.background.corner_radius=7
    label.y_offset=-1
    label.drawing=off
    script="$SCRIPT_SPACES"
  )

  sketchybar --add space space.$sid left \
    --set space.$sid "${space[@]}" \
    --subscribe space.$sid mouse.clicked
done

separator=(
  icon=􀆊
  label.drawing=off
  icon.font="$FONT:Semibold:14.0"
  associated_display=active
  click_script="export PATH=$PATH; yabai -m space --create && sketchybar --trigger space_change"
  icon.color=$SUBTLE_MOON
  script="$SCRIPT_SPACE_WINDOWS"
)

spaces_container=(
  background.height=$(($BAR_HEIGHT - 8))
  blur_radius=24
)

sketchybar --add bracket spaces '/space\..*/' \
  --set spaces "${spaces_container[@]}" \
  --add item separator left \
  --set separator "${separator[@]}" \
  --subscribe separator space_windows_change
