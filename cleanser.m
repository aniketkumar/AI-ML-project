% Post process video/audio samples for learning

clc
clear
close all

% check we can load data samples
videodirpath = fullfile('rawTrain','video');
%audiopath = fullfile('rawTrain','audio',); 
      
% Count other files in folder to determine index
D = dir(videodirpath);
sampleCounter = 0; 


% go thru each char folder
for charIndex=3:length(D)
    
    videopath = strcat(videodirpath, '\', D(charIndex).name);
    subD = dir(videopath);
    
    % go thru each char sample 
    for sampleIndex=3:length(subD)
    
        sampleCounter = sampleCounter + 1; 
        videofile = strcat(videopath, '\', subD(sampleIndex).name)
        load(videofile); 

        if(exist('videodata')) 
            figure(sampleCounter);
            imaqmontage(videodata);
        end

        %load(audio); 
        %if(exist('audiodata')) 
        %    figure(2);
        %    plot(audiodata);
        %end
        
        % clean the video frames 
        % grayscale
        [~,~,~,n] = size(videodata);
        for i = 1:n
            vdata(:,:,i)=rgb2gray(im2double(videodata(:,:,:,i))); 
            procdata(:,:,i) = vdata(121:end, 81:240, i);
            data(:,:,i) = procdata(66:95, 51:110, i); 
            %figure(i)
            %imshow(data(:,:,i)); 
        end
        
        % dump the data
        data_compressed(:,sampleCounter) = data(:);
        temp(sampleCounter) = uint8(D(charIndex).name) - 96;
        temp2 = zeros(26,1);
        temp2(temp(sampleCounter))=1;
        label(:,sampleCounter)=temp2;
        
    end
    
end

