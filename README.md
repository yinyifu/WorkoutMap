# cse442_watch Beta Release Build Procedure
This project is made for CSE442 in UB

Warning: Running this app on simulator with xcode before 9.1 beta 2 will cause performance drop because of a known bug on iphone simulators. If you want the full speed and full effect of this app you need to run it on real device. Referal: https://stackoverflow.com/questions/46234101/googlemaps-on-simulator-in-xcode-9-uses-over-100-of-cpu-when-moving-the-map
Contains a temporary fix on how torestore the performance.

Below is the procedure of how to run this app on your own mac/iphone

1. download the lastest xcode from https://developer.apple.com/xcode/downloads/
If you do not already have an apple develop account, create one. You may also download from app store but make sure the version is 9.0.1.
Install it on your mac.
![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%208.33.06%20PM.png "")
![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%208.32.57%20PM.png "")

2. Go to xcode, Click clone an existing project 

![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%208.32.07%20PM.png "")

3. Go to this github page above, click green button clone or download, copy the link in the text field.
![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%208.33.50%20PM.png "")

4. Paste that into the field "search github or enter repository URL", click clone and enter the place you want to save on the disk.

5. Close the project, we are going to build the dependency now. This step is nessessary and essential.
We now open the terminal, and also where you saved your project files. type cd in the terminal and drag the project folder to the terminal. this will change corrent directory of terminal to your project folder.

![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%209.20.44%20PM.png "")
![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%209.21.06%20PM.png "")
![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%209.21.21%20PM.png "")

6. If you do not have cocoapod, type "sudo gem install cocoapods" in the terminal.
Cocoapod is needed in order to build this app.

7. If you have cocoapod now, type "pod install" in the terminal. pod install will do all the dirty work. If you see the following message, you are all set.

![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%209.21.41%20PM.png "")
![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%209.21.59%20PM.png "")

8. In order to open the project that is "installed" by cocoapod, you need to double click open the xcworkspace file. Do not open the xcodeproj file.

![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%209.22.47%20PM.png "")

9. Your app should be able to run on your iphone and simulator now, go to your iphone and enable developer mode
https://apple.stackexchange.com/questions/159196/enable-developer-inside-the-settings-app-on-ios
and choose generic ios device on the right of stop button, connect your iphone to your mac. Then click the run button on the left of stop button 
![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%2011.38.24%20PM.png "")
Or running the app on iphone simulators. choose an iphone simulator version at the same place, then click run button.

10. In order to pair watch devices from simulator iphone to simulator watch, you just need to do following.

  10.0 If you don't have simulators, or need to set up, You might not have downloaded the right version of xcode or from the right source. Because simulator come with xcode as part of the integration tool. try to refer to this post https://stackoverflow.com/questions/29058229/download-xcode-simulator-directly And it might solve the problem, or redownload and reinstall the app.
  
  10.1 When simulator opens, click Manage Devices
  
  ![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%2011.02.02%20PM.png "")
  
  10.2 Pick the simulator version that is your selection and currently open, add a paired watch that you want to it. Give it a name if you want as well. Then open your paired watch device
  ![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%2011.02.13%20PM.png "")
  ![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%2011.02.22%20PM.png "")
  ![Alt text](https://github.com/yinyifu/cse442_watch/blob/mapdirect/pictures/Screen%20Shot%202017-10-30%20at%2011.40.25%20PM.png "")
  
  10.3 Sometimes when you mess with the setting when app is running, it messes up the app. Restart the app by clicking the run button again.
  
  10.4 To enable location service on simulator, Select your Simulator, go to debug, Location and choose the location you want to simulate.
  ![Alt text](https://github.com/yinyifu/cse442_watch/blob/develop/pictures/directions.png)
  10.5 If you want to install this software on your real device, choose ios generic device on scheme. And you can use location service button from above the console pane to simulate your virtual location on real phone. The watch app will automatically download to your paired watch.
  ![phone Choose](https://github.com/yinyifu/cse442_watch/blob/develop/pictures/your%20iphone.png)
  ![direction sim](https://github.com/yinyifu/cse442_watch/blob/develop/pictures/Direcio.png)
  ![button to click](https://github.com/yinyifu/cse442_watch/blob/develop/pictures/direc.png)
  
  


