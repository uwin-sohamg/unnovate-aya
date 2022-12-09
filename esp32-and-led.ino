#include <WiFi.h>
#include <WiFiClientSecure.h>
#include <ESP32Servo.h>
#include <HTTPClient.h>
#define LED 5 
#define SERVO

Servo myservo; //create servo object to control servo
int pos = 0; //variable to store server position
static const int servoPin = 18;

static const String lightStateApi= "https://aya-uwindsor-test-shalinshah777-dev.apps.sandbox.x8i5.p1.openshiftapps.com/lightstatus/currentLightStatus";
HTTPClient client1;
static const String doorlockStateApi = "https://aya-uwindsor-test-shalinshah777-dev.apps.sandbox.x8i5.p1.openshiftapps.com/dooraccess/doorstatus";
HTTPClient client2;


void setup() {
    Serial.begin(115200);  // Initialize serial
    while (!Serial) {
      ; // wait for serial port to connect. Needed for native USB port only
    }
    Serial.print("Connecting to WiFi");
    WiFi.begin("Wokwi-GUEST", "", 6);
    while (WiFi.status() != WL_CONNECTED) {
    delay(100);
    Serial.print(".");
    }
    Serial.println(" Connected!");
    WiFi.mode(WIFI_STA); 
    // ThingSpeak.begin(client);  // Initialize ThingSpeak

    myservo.setPeriodHertz(50); //standard 50hz servo
    myservo.attach(servoPin, 10, 2800); // attaches the servo on pin 18 to the servo object
    myservo.write(90); // By default, lock the door 
    pinMode(LED,OUTPUT);
     
    client1.begin(lightStateApi);
    client2.begin(doorlockStateApi);

}

void loop() {  
  // For light control  
    Serial.println("Light Control logs (0: On , 1: Off):");
    // HTTPClient client1;
    // client1.begin(lightStateApi);
    int responseCode1 = client1.GET();
    Serial.print("    Response Code:"); 
    Serial.println(responseCode1);
    if(responseCode1 > 0){
      int currentLightState = client1.getString().toInt();
       Serial.print("    Light State:");
       Serial.println(currentLightState);
        if(currentLightState == 0) {
          digitalWrite(LED, HIGH); 
        }
       else if(currentLightState == 1) {
          digitalWrite(LED, LOW);
        }
      
    }
    else {
      Serial.println("    Failed to get the state of light, turning ligh off");
      // Turning lights off
         digitalWrite(LED, LOW);
  
      }
    Serial.println("..............................................");
    

  // For Door control  
    Serial.println("Door Control logs (0: Close , 1: Open):");
    int responseCode2 = client2.GET();
    Serial.print("    Response Code:"); 
    Serial.println(responseCode2);
    if(responseCode2 ==  200){
      int currentDoorlockState = client2.getString().toInt();
       Serial.print("    Lock State:");
       Serial.println(currentDoorlockState);
       if(currentDoorlockState == 0) {
         // close the door
       if(pos==0) {pos=90;}
       myservo.write(pos);  // pos:0 -> open, pos:180 -> closed
      }
      else if(currentDoorlockState == 1) {
          // open the door
       if(pos==90){ pos=0;}
       myservo.write(pos);    // pos:0 -> open, pos:180 -> closed
    }
    }
    else {
      Serial.println("    Failed to get the state of door lock, Closing the door");
      // Closing the door
         if(pos==0) {pos=90;}
          myservo.write(pos); 
  
      }
    Serial.println("..............................................");
    
}

