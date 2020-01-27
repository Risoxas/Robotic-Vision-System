%%this function returns the direction the pan/tilt mechanism has to turn
%%for tracking

function [c,d]=pantilt(valx,valy)
midscreenX=360;
midscreenY=240;
midscreenwindow=60;
d=' ';
c=' ';
   %%Find out if the Y component of the face is below the middle of the screen.
    if(valy > (midscreenY - midscreenwindow))
          c='b';
      
    
    %%Find out if the Y component of the face is above the middle of the screen.
    elseif(valy < (midscreenY + midscreenwindow))
     
          c='u';
     
    end  
       
    %%Find out if the X component of the face is to the left of the middle of the screen.
    if(valx < (midscreenX - midscreenwindow))
        d='l';
      
   %%Find out if the X component of the face is to the right of the middle of the screen.
    elseif(valx > midscreenX + midscreenwindow)
          d='r';
    end  