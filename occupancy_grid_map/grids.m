%Function to take input the LIDAR readings and output coordinates of grid location
function gridCord = grids(range,scanAngle,pose,origin,resolution)

%Real Location
x_occ = range.*cos(scanAngle+repmat(pose(3),size(scanAngle))) + repmat(pose(1),size(scanAngle));
y_occ = -range.*sin(scanAngle+repmat(pose(3),size(scanAngle))) + repmat(pose(2),size(scanAngle));

%Grid Index

gridCord = ceil(resolution*[x_occ,y_occ]) + repmat(origin',[size(scanAngle),1]);


end
