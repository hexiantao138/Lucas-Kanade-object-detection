function test_motion(path_to_images, numimages)

%%%    To Do    %%%%%
% try different sigmas
sigma = 6;
%%%%%%%%%%%%%%%%%%%%%
path_to_images='/Users/hexiantao/Desktop/CUHK/Computer vision/CarSequence';
fname = sprintf('%s//car_template.jpg',path_to_images);
numimages=101;
img1_rgb = imread(fname);
img1_gray = rgb2gray(img1_rgb);
window = [0,9,0,9]; %x1 y1 x2 y2, the coordinates of top-left and bottom-right corners
W = zeros(numimages,4);
for frame = 1:numimages
        % Reads next image in sequence
        fname = sprintf('%s//frame00%d.jpg',path_to_images,frame+302);
        img2_rgb = imread(fname);
        img2_gray = rgb2gray(img2_rgb);
        
        %%%%%%%%%%%%%%%%%%%%%% To Do %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        new_window = trackTemplate(img1_gray,img2_gray,window,sigma);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        current_frame = img2_rgb;
        imshow(current_frame);
%         [row2, col2] = size(img2_gray);
         rectangle('Position',[new_window(3),new_window(1),88,49],'edgecolor','r');
        % img2 is a rgb image, you should edit this image to point out the template you track with a box
%         if (new_window(1)>0 && new_window(1)<=new_window(2) && new_window(2)<=row2 && new_window(3)>0 && new_window(3)<=new_window(4) && new_window(4)<=col2)
%             for row = new_window(1):new_window(2)
%                 current_frame(row,new_window(3),1) = 255;    %  red box
%                 current_frame(row,new_window(4),1) = 255;    %  red box
%             end
%             for col = new_window(3):new_window(4)
%                 current_frame(new_window(1),col,1) = 255;    %  red box
%                 current_frame(new_window(2),col,1) = 255;    %  red box
%             end
%         else
%             fprintf('lost tracking at frame %d \n',frame);
%             break;
%         end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        % Prepare for processing next pair
%         imshow(current_frame);
        pause(0.1);
        W(frame,:) = new_window;
        window = new_window;
end
    save 'track_coordinates' W;
end
