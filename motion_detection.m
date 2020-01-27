%%this function returns the boundary box value (bbox) and image frame when
%%object was detected. (Further understanding of the below function read
%%the help file titled "Gaussian Mixture Model")
function [bbox1,frame1]=motion_detection(foregroundDetector1,videoReader1)
    blobAnalysis1 = vision.BlobAnalysis('BoundingBoxOutputPort', true,'AreaOutputPort', false, 'CentroidOutputPort', false,'MinimumBlobArea', 450);
    se = strel('square', 3);
    s1=0;
    while (s1<3000)       
        frame1 = step(videoReader1); % read the next video frame
        foreground1 = step(foregroundDetector1, frame1);
        filteredForeground1 = imopen(foreground1, se);
        s1=sum(sum(filteredForeground1));
        
    end
    for i =1:10
        frame1 = step(videoReader1); % read the next video frame
        foreground1 = step(foregroundDetector1, frame1);
        filteredForeground1 = imopen(foreground1, se);
        bbox1 = step(blobAnalysis1, filteredForeground1);
    end
    
end