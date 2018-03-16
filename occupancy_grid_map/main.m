clear all;
close all;

% % capture video
param.captureBool = 0;

%% utilities
load 'ws.mat';

%% Mapping function
myMap = occGridMapping(ranges, scanAngles, pose, height, param);
