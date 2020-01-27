%% this function retuns a matlab object that can detect a foreground object in the modelled background. See the function in detail from the help file
function [foregroundDetector1]= calibration(videoreader1)
    foregroundDetector1 = vision.ForegroundDetector('NumGaussians',3,'NumTrainingFrames', 10,'LearningRate',0.0000000005,'MinimumBackgroundRatio', 0.7);
    videoplayer1 = vision.VideoPlayer('Name','Left Camera Calibration','Position',[30 60 640 600]);
    for i=1:10
        frame1 = step(videoreader1);
        foreground1 = step(foregroundDetector1, frame1);
        step(videoplayer1,foreground1);
    end
release(videoplayer1);
end

     