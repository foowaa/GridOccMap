%%
%http://xbingoz.com/2012/12/31/Miller-cylindrical/
%https://segmentfault.com/a/1190000000408831
% lon 经度，西经为负数; lat 纬度，南纬是负数
function [x,y] = millerXY (lon, lat)
         L = 6381372 * pi * 2;     % 地球周长
         W = L;     % 平面展开后，x轴等于周长
         H = L / 2;     % y轴约等于周长一半
         mill = 2.3;      % 米勒投影中的一个常数，范围大约在正负2.3之间
         x = lon* pi / 180;
         y = lat* pi / 180;
     % 这里是米勒投影的转换
     y = 1.25 * log( tan( 0.25 * pi + 0.4 * y ) );
     % 这里将弧度转为实际距离
     x = ( W / 2 ) + ( W / (2 * pi) ) * x;
     y = ( H / 2 ) - ( H / ( 2 * mill ) ) * y;
     % 转换结果的单位是公里
     % 可以根据此结果，算出在某个尺寸的画布上，各个点的坐标
end