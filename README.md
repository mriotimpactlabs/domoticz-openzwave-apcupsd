1.) Navigate to directory with Dockerfile and build the image.
    
    $ docker build -t <ImageName> .

2.) Make sure the ZWAVE & APC-UPS USB devices are plugged into the computer and run the container.
    
    $ docker run -it -p 8080:8080 --device=/dev/ttyACM0:/dev/ttyACM0 --device=/dev/usb:/dev/usb <ImageID>
    
3.) Navigate to http://localhost:8080 to open the Domoticz dashboard and click the "please setup your Hardware" link.  

4.) Make sure the "Enabled" checkbox is checked.

5.) In the "Name" textfield, type something like "APC-UPS", "APC Universal Power Supply" or something that references the UPS.

6.) In the "Type" dropdown list, make sure to choose the "Dummy" option.

7.) In the "Data Timeout" dropdown list, make sure to choose the "Disabled" option.

8.) Click the "Add" button.

9.) Click the newly created "Create Virtual Sensors" button for the hardware profile which was created.

10.) Type in the "Name" field something like "Power" Or "Line Voltage" and for the "Sensor Type" input field, choose "Switch".

11.) Click the "Setup" -> "Devices" tab to see the "Idx" number assigned to this sensor.

12.) Make sure that number is identical to the "Idx" number located in the "read-apc-ups.sh" script within the "if else" statement. This file is located in this repository.

13.) Click the "Switches" tab and then click the "Notifications" button under the APC-UPS device box.

14.) In my case I used the "Pushbullet" app to recieve notifications and you can retrieve an "Access Token" from your Pushbullet account on a non-mobile computer.  

15.) Changes can be made to the "read-apc-ups.sh" script to suite your domoticz instance.
