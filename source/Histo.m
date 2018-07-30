clear;
close all;

videoFileReader = vision.VideoFileReader('LarvalDOs_highRes_002.avi');
videoPlayer = vision.VideoPlayer();
% Read a video frame and run the face detector.
bbox=[214.5 348.5 34 38];
x = bbox(1); y = bbox(2); w = bbox(3); h = bbox(4);
bboxPolygon = [x, y, x+w, y, x+w, y+h, x, y+h];

%% Draw the returned bounding box around the detected face.
shapeInserter  = vision.ShapeInserter('Shape', 'Polygons', 'BorderColor','Custom','CustomBorderColor',[255 255 0]);
objectFrame = step(videoFileReader);
objectFrame = step(shapeInserter, objectFrame, bboxPolygon);
objectFrame2 = rgb2gray(objectFrame);
binary = roicolor(objectFrame2,0.3,0.45);
binary=double(binary);
figure; imshow(objectFrame2); title('Red box shows object region');
cropped = imcrop(binary, bbox);
figure; imshow(cropped); title('Cropped');
% figure; imshow(videoFrame); title('Detected larva');
% cropped=imcrop(videoFrame,bbox);
% figure; imshow(cropped); title('Cropped');

%% Crop out the region of the image containing the face, and detect the feature points inside it.
cornerDetector = vision.CornerDetector('Method','Minimum eigenvalue (Shi & Tomasi)');
points = step(cornerDetector, binary);

% The coordinates of the feature points are with respect to the cropped region. They need to be translated back into the original image coordinate system. 
points = double(points);
points(:, 1) = points(:, 1) + double(bbox(1));
points(:, 2) = points(:, 2) + double(bbox(2));

% Display the detected points.
markerInserter = vision.MarkerInserter('Shape', 'Plus','BorderColor', 'White');
binary = step(markerInserter, binary, points);
figure, imshow(binary), title('Detected features');

% %% Initialize a Tracker to Track the Points
% % Create a point tracker and enable the bidirectional error constraint to make it more robust in the presence of noise and clutter.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the initial point locations and the initial video frame.
initialize(pointTracker, double(points), binary);

% Initialize a Video Player to Display the Results Create a video player object for displaying video frames.
videoInfo    = info(videoFileReader);
videoPlayer  = vision.VideoPlayer('Position',[100 100 videoInfo.VideoSize(1:2)+30]);

% %% Initialize a Geometric Transform Estimator
geometricTransformEstimator = vision.GeometricTransformEstimator('PixelDistanceThreshold', 4, 'Transform', 'Nonreflective similarity');
% 
% % Make a copy of the points to be used for computing the geometric
% % transformation between the points in the previous and the current frames
oldPoints = double(points);
% 
%% Track the Points
while ~isDone(videoFileReader)
    % get the next frame
    objectFrame = step(videoFileReader);
    objectFrame2 = rgb2gray(objectFrame);
    binary = roicolor(objectFrame2,0.3,0.45);
    binary=double(binary);
    
    % Track the points. Note that some points may be lost.
    [points, isFound] = step(pointTracker, binary);
    visiblePoints = points(isFound, :);
    oldInliers = oldPoints(isFound, :);
    
    if ~isempty(visiblePoints)
        % Estimate the geometric transformation between the old points and the new points.
        [xform, geometricInlierIdx] = step(geometricTransformEstimator,double(oldInliers), double(visiblePoints));
        
        % Eliminate outliers
        visiblePoints = visiblePoints(geometricInlierIdx, :);
        oldInliers = oldInliers(geometricInlierIdx, :);
        
         % Apply the transformation to the bounding box
        boxPoints = [reshape(bboxPolygon, 2, 4)', ones(4, 1)];
        boxPoints = boxPoints * xform;
        bboxPolygon = reshape(boxPoints', 1, numel(boxPoints));
        
        % Insert a bounding box around the object being tracked
        binary = step(shapeInserter, double(binary), bboxPolygon);
        
        % Display tracked points
        videoFrame = step(markerInserter, videoFrame, visiblePoints);
        
        % Reset the points
        oldPoints = visiblePoints;
        setPoints(pointTracker, oldPoints);        
    end
    
     % Display the annotated video frame using the video player object
      step(videoPlayer, videoFrame);
end