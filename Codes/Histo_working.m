videoFileReader = vision.VideoFileReader('LarvalDOs_highRes_002.avi');
videoPlayer = vision.VideoPlayer();
shapeInserter = vision.ShapeInserter('Shape','Rectangles');
%% Read the first video frame, which contains the object.Convert the image to HSV color space. Then define and display theobject region.
objectFrame = step(videoFileReader); 
objectFrame2=rgb2gray(objectFrame);
binary=roicolor(objectFrame2,0.3,0.45);
bbox=[214.5 348.5 34 38];
bbox=uint32(bbox);
shapeInserter  = vision.ShapeInserter('Shape', 'Rectangles', 'BorderColor','Custom','CustomBorderColor',120);
objectImage = step(shapeInserter, binary, bbox);
binary=double(binary);
figure; imshow(objectImage); title('Red box shows object region');
%% Set the object, based on the hue channel of the firstvideo frame. 
  bbox=double(bbox);
  tracker = vision.HistogramBasedTracker;
  initializeObject(tracker, binary, bbox);
%% Track and display the object in each video frame. The while loop reads each image frame, converts the image to HSV colorspace, then tracks the object in the hue channel where it is distinctfrom the background. Finally, the example draws a box around the objectand displays the results.
while ~isDone(videoFileReader)
 frame = step(videoFileReader);       
 frame2=rgb2gray(frame);
 binaryloop=roicolor(frame2,0.3,0.45);
 binaryloop=double(binaryloop);
 %imshow(binaryloop);
 bbox = step(tracker, binaryloop);
 display(bbox);
 release(shapeInserter);
 out = step(shapeInserter, binaryloop, bbox); 
 step(videoPlayer, out);
end
  %% Release the video reader and player.
release(videoPlayer);
release(videoFileReader);