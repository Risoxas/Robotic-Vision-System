addpath 'C:\Users\K.P. Maghendhran\Desktop\tt'; %%change the path to where files are saved

%%create a video object for the camera attached
videoReader1 = imaq.VideoDevice('winvideo', 2);
set(videoReader1,'ReturnedColorSpace','rgb');
preview(videoReader1);


%%create a serial port object and mention corresponding COM port.
s = serial('COM33','BaudRate',9600);

%%Open the COM Port
fopen(s);

pause(2);

%% Detection Process starts
%% Create a Background object
[foregroundDetector1] = calibration(videoReader1); %% Go to calibration.m subroutine

[bbox1,frame1] = motion_detection(foregroundDetector1,videoReader1);%%Go to motion_detection.m subroutine
a=size(bbox1);

%%process continues until object is detected
while a(1)~=1
    [bbox1,frame1] = motion_detection(foregroundDetector1,videoReader1);
    a=size(bbox1);
end    

%% Tracking process starts
%% frame1 and bbox1 are given as tempelate to tracking algorithm
[tracker1] = motion_tracking(frame1,bbox1);%% Go to motion_tracking.m subroutine

%%Create a videoplayer
leftVideo = vision.VideoPlayer('Name','Left Camera','Position',[30 60 640 600]);

for i=1:300 %% Run the programe for n frames. here n=300
    scene1=step(videoReader1);
    hsv1 = rgb2hsv(scene1);
    BBox1 = step(tracker1, hsv1(:,:,1)); %% BBox1 gives the postion of object in successive video frames
    result1 = insertShape(scene1, 'Rectangle', BBox1, 'Color', 'green');
    step(leftVideo, result1);
    
    %% finding the center of object 
    xcenter1=abs(BBox1(1)+(BBox1(3))/2);
    ycenter1=abs(BBox1(2)+(BBox1(4))/2);
    
    %%Sending the center values to pantilt subroutine
    [tiltcmd, pancmd]=pantilt(xcenter1,ycenter1); %% Go to pantilt.m subroutine
    
    %%Write the returned values to the serial port
    fwrite(s,pancmd,'char');
    fwrite(s,tiltcmd,'char');
  
end

%%Close all objects
fclose(s);
release(videoReader1);
release(leftVideo);
