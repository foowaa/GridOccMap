% Occupancy Grid Mapping function
function myMap = occGridMapping(ranges, scanAngles, pose, height, param)

% Parameters 
% 
% the number of grids for 1 meter.
 myResol = param.resol;
% the initial map size in pixels
 myMap = zeros(param.size);
% the origin of the map in pixels
 myOrigin = param.origin; 
 
% Log-odd parameters 
lo_occ = param.lo_occ;
lo_free = param.lo_free; 
lo_max = param.lo_max;
lo_min = param.lo_min;

N = size(pose,2);

%Create figure window
figure('units','pixels','position',get(groot,'ScreenSize'),'Name','Grid Map','NumberTitle','off');

%Preallocation of all Poses
allPoses = [];

%Video capturing check
if (param.captureBool)
    fileName = ['record_', datestr(now,'yyyy-mm-dd_HH-MM-SS'), '.mp4'];
    videoObj = VideoWriter(fileName,'MPEG-4');
    videoObj.Quality=100;
    videoObj.FrameRate = 3;
    open(videoObj);
end

zg = zeros(35, 50);
for j = 1:N 
    %position of pose on grid
    gridPose = ceil(myResol*[pose(1,j);pose(2,j)]) + myOrigin;
    %Find occupied-measurement cells from LIDAR readings
    occCells = grids(ranges(:,j),scanAngles,pose(:,j),myOrigin,myResol);

    % Find free-measurement cells
    for i = 1 : length(occCells)
       % [freex, freey] = bresenham(gridPose(1),gridPose(2),occCells(i,1),occCells(i,2)); 
       [freex, freey] = bresenham1(gridPose(1),gridPose(2),occCells(i,1),occCells(i,2));
        free = sub2ind(size(myMap),freey,freex);
        % Update the log-odds
        myMap(occCells(i,2),occCells(i,1)) = myMap(occCells(i,2),occCells(i,1)) + lo_occ;
        myMap(free) = myMap(free) - lo_free;
    end

    % Saturate the log-odd values
    myMap(myMap>lo_max)= lo_max;
    myMap(myMap<lo_min)= lo_min;
    
    
    % Visualize the map as needed
    allPoses = [allPoses gridPose]; %current + previous poses
  
    %occupancy grid
    colormap gray;
    CX = max(myMap(:))-myMap+min(myMap(:));
    imagesc(CX);
    hold on;
    
    %plot point
    plot(allPoses(1,:),allPoses(2,:),'r.-','LineWidth',2.5); %Plot the poses up till this point
    
    %write numbers
    zg = writeText(zg, occCells, height(:,j));
    hold off;
    pause(0.1);

    %Capture Video
    if (param.captureBool)
        writeVideo(videoObj, getframe(gcf));
    end
    
end

if (param.captureBool)
    close(videoObj);
end

end

