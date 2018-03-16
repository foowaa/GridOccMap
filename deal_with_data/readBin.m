%%This file read binary point cloud in KITTI dataset
% Author: cltian
% Date: 2017/12
function filecellM = readBin(dir)
  clear all;
  filecell = cell(77,1);
  filecellM = cell(77,1);
  for i=0:76
      if (i<10)
          fn = fullfile(dir, strcat('000000000',num2str(i), '.bin'));
      else
          fn = fullfile(dir, strcat('00000000', num2str(i), '.bin'));
      end
      fp = fopen(fn);
      filecell{i+1} = fread(fp);
      len = length(filecell{i+1});
      m = 4; n = len/m;
      v = filecell{i+1};
      matx = zeros(m,n);
      for j=1:len
          if (mod(j, 4) ~= 0)
              matx(mod(j, 4), floor(j/4)+1) = v(j);
          else
              matx(4, j/4) = v(j);
          end
      end
      filecellM{i+1} = matx;
  end
end
