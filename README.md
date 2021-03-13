<h1><p align="center">SheHacks_Team-033</p></h1>

<p align="center"><img src="UI images/saheli.png" width="300" height="300"></p>

Women's Safety has been a century-old issue. Even today according to the statistics around 88 rape cases are reported every day and there are many cases that are not even reported. Only about 1.5% of cases are brought to justice while others are still free and a threat to other similar victims. The reason behind this is the lack of witnesses, proofs, corruption, and so on. Women are also motivated to learn self-defense but this is rendered useless in front of more than one abuser and their strength. 

## Implementation: 
If the user feels that they are in danger, they tap the pushbutton on the neckpiece three times. This activates the HC05 Bluetooth module, which sends a character to the app through serial communication. (Note: The app/phone is already connected to the Bluetooth of the neckpiece). This activates the app, which proceeds to send SOS messages to the two emergency contacts which have been previously entered. It also sends the location coordinates. Live location tracking can be carried out through the app itself.
Meanwhile, the three-tap trigger also activates the camera module in the neckpiece. We have used the OV7670 camera module here. We also have an SD Card breakout board that has an SDcard inserted in it. The camera module has been calibrated to generate color images in bitmap(.bmp) format. We have set it such that it generates 8 photos at a gap of two seconds each, for demonstration purposes. This can be adjusted for real-time situations. These photos are stored on the SD card. We can remove the SD card to view the photos on a PC or any other device. 

## Future Aspects

Neckpiece:
The microcontroller can be replaced by a Raspberry Pi, which is a supercomputer. This can enable us to use neural networks to generate better and sharper images or add special python functions to facilitate video streaming from the OV7670. The Raspberry Pi also has its own separate camera module, and the video can be live-streamed to a central police database or to the app, thus ensuring that prompt and appropriate aid is received. Additional functionalities can be added, although the overall price of the device will also go up quite a bit.

Taser:
The current handheld Taser will be upgraded to a ring structure, to allow for discrete defense. The ring will have twin capacitors to charge the ring, along with a capacitor charging apparatus that can be used to charge the ring before exiting the house. A miniature DC boost convertor will be attached to the ring in order to step up the voltage discharged by the capacitor and generate enough voltage to tase an individual. A switch will be provided to ensure that you don’t accidentally tase someone when you shake hands or the likes.

## Hardware: <br>
<table>
  <tr>
    <td> <img src="hardware images/model1.jpeg" width="200" height="200"></td>
    <td> <img src="hardware images/model2.jpeg" width="200" height="200"></td>
     <td> <img src="hardware images/pcb.jpeg" width="200" height="200"></td>
  </tr>
  <tr>
    <td> <img src="hardware images/circuit1.jpeg" width="200" height="200"></td>
    <td> <img src="hardware images/circuit2.jpeg" width="200" height="200"></td>
     <td> <img src="hardware images/circuit3.jpeg" width="200" height="200"></td>

  </tr>
  <tr>
   <td> <img src="hardware images/hardware1.jpeg" width="200" height="200"></td>
    <td> <img src="hardware images/hardware2.jpeg" width="200" height="200"></td>
     <td> <img src="hardware images/hardware3.jpeg" width="200" height="200"></td>
  </tr>
</table>

## User Interface: <br>
<table>
  <tr>
    <td> <img src="UI images/phone.jpeg" width="200" height="400"></td>
    <td> <img src="UI images/otp.jpeg" width="200" height="400"></td>
  </tr>
  <tr>
    <td> <img src="UI images/profile.jpeg" width="200" height="400"></td>
    <td> <img src="UI images/mainpage.jpeg" width="200" height="400"></td>
  </tr>
  <tr>
    <td> <img src="UI images/explicit.jpeg" width="200" height="400"></td>
    <td> <img src="UI images/implicit.jpeg" width="200" height="400"></td>
  </tr>
</table>

## Authors

* [**Aditi Chowdhuri**](https://github.com/Aditi-Chowdhuri)
* [**Shivani Mishal**](https://github.com/shivanimishal5) 
* [**Trisha**](https://github.com/TriAnu1010) 
* [**Sakshi Parikh**](https://github.com/Sakshi725744) 

