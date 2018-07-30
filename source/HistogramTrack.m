% Create System objects for reading and displaying videoand for drawing a bounding box of the object.
videoFileReader = vision.VideoFileReader('LarvalDOs_highRes_002.avi');
videoPlayer = vision.VideoPlayer();
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[1 0 0]);
%% Read the first video frame, which contains the object.Convert the image to HSV color space. Then define and display theobject region.
objectFrame = step(videoFileReader); 
objectHSV = rgb2hsv(objectFrame);
objectRegion = [140.5 13.5 60 88];  
objectImage = step(shapeInserter, objectFrame, objectRegion);
figure; imshow(objectImage); title('Red box shows object region');
figure; imshow(objectHSV); title('Hue');
%% Set the object, based on the hue channel of the firstvideo frame. 
  tracker = vision.HistogramBasedTracker;
  initializeObject(tracker, objectHSV(:,:,1) , objectRegion);
  %% Track and display the object in each video frame. Thewhile loop reads each image frame, converts the image to HSV colorspace, then tracks the object in the hue channel where it is distinctfrom the background. Finally, the example draws a box around the objectand displays the results.
while ~isDone(videoFileReader)
  frame = step(videoFileReader);          
  hsv = rgb2hsv(frame);                   
  bbox = step(tracker, hsv(:,:,1));       
                                        
  out = step(shapeInserter, frame, bbox); 
  step(videoPlayer, out);                 
end
%% Release the video reader and player.
release(videoPlayer);
release(videoFileReader);

  


