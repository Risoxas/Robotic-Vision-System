#include <Servo.h>
Servo panservo,tiltservo;
int pan=90;
int tilt=90;
char cmd;
int stepsize=1;
void setup() 
{
  Serial.begin(9600);
  panservo.attach(10);
  tiltservo.attach(9);
  panservo.write(pan);
  tiltservo.write(tilt);
  delay(500);

}

void loop() 
{
  if (Serial.available() >0) {
   cmd=Serial.read();
      switch (cmd) {
        
        case 'b':
                if(tilt > 45) {
                  tilt -= stepsize;} //Update the tilt position variable to lower the tilt servo.
                  break;
        
        case 'u':
                if(tilt < 135) {  
                  tilt += stepsize;} //Update the tilt position variable to raise the tilt servo.
                  break;
        
        case 'l':
                if(pan < 175) {  
                  pan += stepsize;}  //Update the pan position variable to move the servo to the left.
                  break;
        
        case 'r':
                if(pan > 5) {  
                  pan -= stepsize;}  //Update the pan position variable to move the servo to the right.
                  break;
        
}
  
      panservo.write(pan);                   
      tiltservo.write(tilt);      
      delay(10);
  
}                                     
   
}
