%%write videos
% author: cltian
% date: 2017/12
function pics = writeVideo(baseDir, n)
fileName = ['record_', datestr(now,'yyyy-mm-dd_HH-MM-SS'), '.mp4'];
videoObj = VideoWriter(fileName,'MPEG-4');
videoObj.Quality=100;
videoObj.FrameRate = 3;
open(videoObj);

pics = cell(n);
for i=1:n*10
    if (mod(i,n) == 0)
        i = 77;
    else
        i = mod(i, n);
    end
  if (i<=10)
      fn = fullfile(baseDir, strcat('000000000', num2str(i-1), '.png'));
  else
      fn = fullfile(baseDir, strcat('00000000', num2str(i-1), '.png'));
  end
%   fn = fullfile(baseDir, strcat(num2str(i), '_cropc', '.png'));
  pics{i+1} = imread(fn);
  writeVideo(videoObj, pics{i+1});
end
close(videoObj);

