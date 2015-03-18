# SensorsToInternet
A UCR Computer Science 100 project by Michael Uy, Leo Li, Will Lee, Chuanping “Ping” Fan

This hardware hack attempts to provide the user with a simple means of communicating data from an analog sensor to be sent, stored, and tracked on the internet. This opens up the opportunity to automate our world. For this proect specifically, we used an Electric Imp to get readings from a thermistor and a photosensor and upload that information to the internet. Our project goal is to present this data in an organized way so that future readers can recreate this project for themselves and explore the applications.

Welcome to the Inernet of Things!


#Components and where do we get them
Electric Imp Module

Photosensor (5V photocell)

100K OHM NTC THERMISTOR 5MM

iOS 5.1.1 or later device or Android 2.1 or up

Electric Imp API

Breadboard or circuit board

Some resistors(resistance can vary, we used 330 ohm resistors) 

For some circuit enthusiasts, many of the materials may be lying around the house. If not, none of these materials are hard to acquire. Sparkfun and Tayda Electronics are excellent resources for ordering the parts online. 
 
#Procedure and Assembly

Assembly: 

![device](/images/device.JPG?raw=true "device.JPG")

There are many different ways for users to assemble sensors in order to upload data onto the internet through using an electric imp. The electric imp consists of a micro-controller with pins as output and input, allowing the user to connect various sensors to it. In our specific case, we used a photoresistor as a sensor for light input, and a thermistor as a sensor for temperature input. 

The photoresistor we used for light input is connected to pin8 of the electric imp. The photoresistor will take in light input, and along with the voltage provided by the electric imp, and convert the analog input into a digital output, which is in turn displayed onto a graph. One side of the photoresistor is connected to pin8 along with a current limiting resistor, and the other side is connected to ground. The external resistor we attached allows us to calculate the current flowing through the resistors because we know the voltage coming out of the electric imp. Because we already know the current flowing through the photoresistor and the provided voltage of 3.3V coming from the electric imp, we can calculate the resistance given by the photoresistor itself, which in turn give us a digital output of an value based on the amount of light being shown on the photocell.  

The thermistor, on the other hand, is a little more complicated. A thermistor is a temperature dependent resistor, it has a specific resistance at room temperature. The resistance varies in proportion with temperature of the component. In our case, our thermistor is a negative temperature coefficient thermistor, meaning that the resistance will decrease as the temperature increases. By including another external resistor along with the thermistor, we created a resistive divider. The resistive divider allows us to calculate the amout of current that flows through both resistors in series. Given the voltage coming from the electric imp, the external 330k ohm resistor we added, and the current that is flowing through both of them, we can now calculate the resistance of the thermistor. From the resistance of the thermistor, we can determine the temperature. The thermistor is connected to pins 7 and 9 of the electric imp. Pin 9 connected to the thermistor is used as an analog to digital converter. It provides a voltage to the thermistor, thus allowing for it to intake analog input from the surrounding environment. Pin 7 is connected on the other side of the thermistor and acts as digital output. When pin7 is set on high, no current flows through the resistors and therefore there is no reading taken. When pin7 is set low, current flows through thus allowing the thermistor to actually take a measurement. Through implementing pin7, we have control when to take a temperature input from the thermistor. 

Procedure: 

The following procedures only highlight the steps that we have taken in order to assemble our specific sensors. There are many ways one can do this, the way we assembled our units is only one of the many ways one can assemble together working sensors.

First, connect the GND pin of the electrip imp to ground on your given breadboard or circuit board. Connect the 3V3 pin to the power of your breadboard or cicuit board. Also, connect the usb to a working power source(laptop, battery, etc) and connect the other end to your electric imp. 

Photoresistor:
Select a pin of your choice, in our case we have selected pin 8. Connect a resistor of your choice, we used a 330K ohm resistor, and connect that to one end of the photoresistor. Connect the other end of the photoresistor to ground on your board. Depending on the pin you have selected to use, you must write your code accordingly to use this pin or else it will not work. 

Thermistor: 
Select 2 pins on the electric imp, we used pin7 and pin9 for our specific case. Connect a resistor of your choice, we used a 330k ohm resistor, and connect that to one of the pins. Then, connect one end of the thermistor to the resistor, while you connect the other end to the second pin you have selected. There is no need to ground the thermistor as mentioned above because you want to use one of the pins to control when to take input from the thermistor. Depending on the pins you have selected, you must write your code accordingly to these pins or the thermistor will not function correctly. 

#Coding and Squirrel
Electric Imp has its own online IDE that allows you to edit code in order to control the behavior of hardware( referred to as the device code) and how it connects to the internet and sends/receives data(referred to as the agent code). This gives you complete control over how data is managed as it is sent through the Electric Imp module. 

https://ide.electricimp.com/ide
Squirrel is the language used to program the imp. Squirrel is very similar to
 C and C++. The official Electric Imp website has a few resources you can use to get yourself started, or you can just look at provided code. 

https://electricimp.com/docs/gettingstarted/helloworld/

https://electricimp.com/docs/squirrel/squirrelcrib/

You will need to decide on a data service that will store this information for you. Sparkfun has their own data service which is pretty easy to setup and can even print out graphs for you without any extra configuration. We used plot.ly as our data service simply because we wanted to be able to do more with the data we collected, such as embedding it on our own website.

https://data.sparkfun.com/ & http://imp.guru/
![data_sparkfun.png](/images/data_sparkfun.png?raw=true "data_sparkfun.png")
![imp_guru](/images/imp_guru.png?raw=true "imp_guru.png")

https://plot.ly/workshop/

![LightGraph](/images/LightGraph.png?raw=true "LightGraph.png") ![TempGraph](/images/TempGraph.png?raw=true "TempGraph.png")


Once you use the mobile phone Electric Imp app to connect your module to the internet, you can then go onto the Electric Imp IDE 


#Interpreting our code

![SquirrelCode](/images/SquirrelCode.png?raw=true "SquirrelCode.png")

In order to get the electric imp to function the way we want it to, the coding is divided into 2 separate sections. The device.nut, and the agent.nut. ".nut" is the file extension for the squirrel Language.  The device section is where we will write code to actually get analog input from the electric imp, and the agent section is where we write code to upload the input we have onto the internet. 

Specifics to Device: 

The ```getsensor()``` function takes in analog light and converts the light into a digital output using a specific formula given to us. 

The ```getsensortemp()``` function takes in analog temperature input as Kelvins and converts it to Fahrenheit, which we send to a data stream on the internet to be graphed. To increase the accuracy of our readings, we take the average of ten readings .001 seconds apart to allow enough time for the thermistor pin to recharge. For varying thermistors, diffrent constants may need to be used and could be found on the data sheet of your device.

The ```gettime()``` function gets the current month, date, and time of when the actual analog input is received fromt the sensor connected to the electric imp. 

The ```sendDataToAgent()``` function sends the data we have received from the sensors on our electric imp to the agent section of the IDE, where then the agent will continue on to upload all the data we have received. In our code, wee assigned pin9 as ANALOG_IN to read the temp, but we also set pin7 as DIGITAL_OUT. By setting pin7 to high, we are able to deactivate the thermistor and save electricity. In order for us to take readings, we simply write pin7 to 0  and call our read function, writing 1 to pin7 afterwards.

Specifics to Agent:

The ```device.on``` function is a function that passes in a string, and depending on the string, it will upload the information associated with that string onto the internet. Within this function, the ```data``` struct contains the data that you want to upload and the timestamp of the current time when the actual data was loaded. The ```layout``` struct contains the data for what the graph will be called. If the filename is changed, then a new url will be outputted for the output of our data. Next, there is the ```payload``` struct, which sets up the data to be posted online. Afterwards in this struct, the heaaders, url, and body are declared.Finally, the ```httppostwrapper``` function is called, which will request the http website and actually post the information online for others to see.  

Posting to 2 Separate Graphs:

In order to post to 2 separate graphs, we wrote 2 different device.on functions, one for temperature reading and one for light readings. By changing the "filename" variable in these functions, we are able to post data to separate graphs. Each time the filename is changed by the user, a new url will be outputted on the terminal. If we do not change the filename, then the data will continuously be updated on the same graph on plotly. 

#Errors and Issues

The electric imp is going to take some time and patience to configure correctly to your phone. That is because the electric imp needs to read a light pattern emitted from your smart phone. If there are external light and/or other distractions in the room that might obstruct the reading pattern of the electric imp, the imp not configure. We have encountered this error many times in our numerous attempts to configure the imp. The best solution for this issue is to configure your imp in a dark area where no other light except the light on you smart phone can be seen by your electric imp. 

#Applications and Extensions 
- Track when your dog uses the doggy door/ are they inside or outside
- Temperature of your room or office
- How much light is your garden receiving
- Water level of your aquarium
#Last words
#Resources
Sparkfun is an excellent resource for purchasing parts. Their data streaming service is also worth taking a look at.


![webpage.png](/images/webpage.png?raw=true "webpage.png")
