set tmVol to "/Volumes/tm"
set mountedIcon to "/Users/mhild/Documents/Pictures/icons/tm-mounted.png"
set unmountedIcon to "/Users/mhild/Documents/Pictures/icons/tm-unmounted.png"

try
    do shell script "mount | grep -q " & quoted form of tmVol
    do shell script "diskutil unmount " & quoted form of tmVol
    do shell script "say \"Time Machine ejected\""
    set newText to "⚪️ TM Ejected"
    set newIcon to unmountedIcon
on error
    do shell script "say \"Time Machine is not mounted\""
    set newText to "⚪️ TM Ejected"
    set newIcon to unmountedIcon
end try

tell application "BetterTouchTool"
    update_stream_deck_widget "9F25263F-FDF3-4169-9A35-FA1848CB5065" text "" json "{
     BTTStreamDeckBackgroundColor : '108.194754, 155.000000, 201.000000, 255.000000',
     BTTStreamDeckIconType : 2,
     BTTStreamDeckSFSymbolStyle : 2,
     BTTStreamDeckSFSymbolName : 'exclamationmark.triangle.fill',
     BTTStreamDeckIconColor1 : '255.000000, 224.000002, 97.000002, 255.000000',
     BTTStreamDeckIconColor2 : '100.000000, 45.000001, 33.000002, 255.000000',
     BTTStreamDeckIconColor3 : '100.000000, 45.000001, 33.000002, 255.000000',
  }"
end tell