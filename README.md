What is this tool?
This is a tool mainly intended for artists working in 3D or 2D layout. It is basically an upgraded snipping tool which automatically create folder structures for cuts, saves the screenshots to a specify file path, and names and sorts them them according to the episode, cut, and panel number for the scene you need to work on.

Why did I make it?
During my time working in a studio in Japan on a television anime production, I did some work on 3D layouts. In order to closely match the storyboards, I was required to save each storyboard panel as a .png before importing them into blender, and the only way my studio did it was by using snipping tool and manually screenshotting and saving each individual panel to the file path they wanted. It felt like a complete waste of time, and I couldn't find a tool online to speed it up so I decided to make my own in godot.
I hope by sharing it, I can save some time for artists, so they can spend more time creating and less time doing mindless labour.

Requirements:
Windows or mac system, storyboard file saved as pdf or some format you can scroll on WITHOUT needing the tab in focus.

Installation:
Go to releases, download exe file, or the zip file and extract it. When you first launch it you may need to give it access to run. 
For mac users, download the mac build zip and extract. You will need to allow it to run in security settings and then also give it permissions to take screenshots of your screen.

Usage guide:

1. Input path you want to SAVE your screenshots into the first text box.
To get the path, either enter it manually, or in file browser, right click the address bar and press "copy address" and then paste it in the input box.
correct path format should look something like this: C:\document\anime_name\storyboard_cuts\episode1

2. Input episode number into the next box, like 1, or 2, or maybe even 3...

3. You can toggle to use a custom range of cuts you want to screenshot. If it is on, manually input the range you want into the next text box. Please use standard commas and hyphens, if you are on a Japanese keyboard, you may need to toggle half width characters.
   
4. You have not have toggles to specify in what folder format you want the screenshots to be saved. The folders will save into your input path, and then the screenshots you take will be automatically sorted into them if the option is on.
   
5. Press start to start taking screenshots. It will make the relevant folders now

6. Now you can begin to take screenshots. In order to take a screenshot you must have Darucoma's UI IN FOCUS, and be in screenshot mode by pressing "s". If you need to scroll down your storyboard document, un-toggle screenshot mode (s), scroll, and then re-toggle it to take screenshots again.
   Drag and release to take a screenshot, or cancel it by pressing right click.
   The screenshot will save in .png files in the path you inputted, and the cut range folder (if enabled). They will save in the format EpisodeNumber_CutNumber-PanelNumber e.g. ep 5 cut 2 panel 3 is 05_002-3
   if file path set up correctly, screenshots will be saved in folder structure like this in the path you inputted earlier
  
  the panel number will automatically increase when you take a screenshot. When you have finished the cut, press "d" to move onto the next cut.
  Other hotkeys are
  "a" to decrease cut number
  "e" to increase panel number
  "q" to decrease panel number

7. (optional) Screenshot assist can make the process faster. Set a custom aspect ration to lock the screenshot size to that, or set a default size to lock all screenshots to a fixed size. If needed to change it for a pan or zoom, just disable it and then re-enable it when done.
image

Important:
Beta build so still may have issues. Please report them to be via email or github if you find any. 
I would appreciate any feedback whatsoever, so please get intouch if you use this tool.

