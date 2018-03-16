%%write numbers on figure
% author: cltian
% date: 2017/12
function zg = writeText(zg, occCells, height)
  xx = occCells(:,1);
  yy = occCells(:,2);
  xg = 1:50; 
  yg = 1:35;
  %zg = zeros(35, 50);
  for i = 1:length(xx)
      if (xx(i)>50 || xx(i)<1 || yy(i)>50 || yy(i)<1)
          break;
      end
      zg(yy(i), xx(i)) = height(i);
  end
  [xlbl, ylbl] = meshgrid(xg, yg);
  text(xlbl(:), ylbl(:), num2str(zg(:)),'color','g',...
    'HorizontalAlignment','center','VerticalAlignment','middle','FontSize',8);
end