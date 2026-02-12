#!/bin/bash
update() {
  source "$CONFIG_DIR/colors.sh"
  # WIDTH="dynamic"
  BACKGROUND="on"
  BORDER=$HIGH_MED_MOON
  if [ "$SELECTED" = "true" ]; then
    BORDER=$LOVE_MOON
    # WIDTH="0"
    # BACKGROUND="off"
  fi

  sketchybar --animate tanh 20 --set $NAME icon.highlight=$SELECTED background.border_color=$BORDER background.drawing=$BACKGROUND
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
    sketchybar --trigger space_change --trigger windows_on_spaces
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

case "$SENDER" in
"mouse.clicked")
  mouse_clicked
  ;;
*)
  update
  ;;
esac
