clc;
clear;
videoFReader = vision.VideoFileReader('Larvae.avi'); % Handle to read a video frame.
videoFWriter = vision.VideoFileWriter('Larvae_processed.avi'); % Handle to write a video frame.
while ~isDone(videoFReader)
      videoFrame = step(videoFReader); % get the next frame
      videoFrame2 = rgb2gray(videoFrame); 
      videoFrame3 = roicolor(videoFrame2,0.176,0.255);
      step(videoFWriter, videoFrame3);  % Save the video frame in video
end
release(videoFReader);
release(videoFWriter);