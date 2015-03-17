# SensorsToInternet
A UCR Computer Science 100 project by Michael Uy, Leo Li, Will Lee, Chuanping “Ping” Fan


Welcome to the Inernet of Things!


This hardware hack attempts to provide the user with a simple means of communicating data from an analog sensor to be sent, stored, and tracked on the internet. This opens up the opportunity to automate your world.

This tutorial  
We’ll be using the Electric Imp module as our means to connect to the internet. 


(idk if we are keeping this)//This project features a EC sensor based on the octiva.net's EC/TDS/PPM Meter. 

# Components and where do we get them
//12V PSU

Electric Imp Module
Photosensor (5V photocell)
100K OHM NTC THERMISTOR 5MM
iOS 5.1.1 or later device or Android 2.1 or up
Electric Imp API
Breadboard or circuit board

For some circuit enthusiasts, many of the materials may be lying around the house. If not, none of these materials are hard to acquire. Sparkfun and Tayda Electronics are excellent resources for ordering the parts online. 
 
#Procedure and Assembly


#Coding and squirrel
Electric Imp has its own online IDE that allows you to edit both the code for the agent and the device. This gives you complete control over how data is managed as its getting sent through the Electric Imp module. 

https://ide.electricimp.com/ide
Squirrel is the language used to program the imp. Squirrel is very similar to
 C and C++, so there shouldn’t be any real difficulty getting used to the language. The official Electric Imp website has a few resources you can use to get yourself started, or you can just look at our code. 

https://electricimp.com/docs/gettingstarted/helloworld/
https://electricimp.com/docs/squirrel/squirrelcrib/

You will need to decide on a data service that will store this information for you. Sparkfun has their own data service which is pretty easy to setup and can even print out graphs for you without any extra configuration. We used plot.ly as our data service simply because we wanted to be able to do more with the data we collected, such as embedding it on our own website.

https://data.sparkfun.com/ & http://imp.guru/ 
https://plot.ly/workshop/


Once you use the mobile phone Electric Imp app to connect your module to the internet, you can then go onto the Electric Imp IDE 


#Interpreting our code
In order to get the electric imp to function the way we want it to, the coding is divided into 2 separate sections. The device section, and the agent section. The device section is where we will write code to actually get analog input from the electric imp, and the agent section is where we write code to upload the input we have onto the internet. 

Specifics to Device: 

The ```getsensor()``` function takes in analog light and converts the light into a digital output using a specific formula given to us. 

The ```getsensortemp()``` function takes in analog temperature input and then converts it using a specific formula as well into a digital output, in which we can graph again after. 

The ```gettime()``` function gets the current month, date, and time of when the actual analog input is received fromt the sensor connected to the electric imp. 

The ```sendDataToAgent()``` function sends the data we have received from the sensors on our electric imp to the agent section of the IDE, where then the agent will continue on to upload all the data we have received. 
Specifics to Agent: 

The ```device.on``` function is a function that passes in a string, and depending on the string, it will upload the information associated with that string onto the internet. Within this function, the ```data``` struct contains the data that you want to upload and the timestamp of the current time when the actual data was loaded. The ```layout``` struct contains the data for what the graph will be called. If the filename is changed, then a new url will be outputted for the output of our data. Next, there is the ```payload``` struct, which sets up the data to be posted online. Afterwards in this struct, the heaaders, url, and body are declared.Finally, the ```httppostwrapper``` function is called, which will request the http website and actualy post the information online for others to see.  

#Errors and Issues


#Applications and Extensions 
- Track when your dog uses the doggy door/ are they inside or outside
- Temperature of your room or office
- How much light is your garden receiving
- Water level of your aquarium
#Last words
#Resources
Sparkfun is an excellent resource for purchasing parts. Their data streaming service is also worth taking a look at.

