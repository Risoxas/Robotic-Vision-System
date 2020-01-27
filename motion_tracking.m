%% This function returns the tracker object which holds information for tracking the object from tempelate(bbox and frame)
function [tracker1]=motion_tracking(frame1,bbox1)
objectHSV1 = rgb2hsv(frame1);
tracker1 = vision.HistogramBasedTracker;
bbox1=double(bbox1);
initializeObject(tracker1, objectHSV1(:,:,1), bbox1);

end