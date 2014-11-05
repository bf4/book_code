tell application "TextEdit"
  activate
  make new document
end tell

tell application "System Events"
  tell process "TextEdit"
    keystroke "H"
    keystroke "i"
  end tell
end tell

tell application "System Events"
  tell process "TextEdit"
    tell menu bar 1
      tell menu bar item "Edit"
        tell menu "Edit"
          click menu item "Select All"
          click menu item "Copy"
          set rightArrow to 124
          key code rightArrow
          click menu item "Paste"
        end tell
      end tell
    end tell
  end tell
end tell
