% Module 2 Part 2 Group 6 Decision Program
% Mario ---- 
% Stephen -- 
% Brett ---- 
% Vedant --- 
% Edward --- 
% Hamilton - Basic program layout, final formating

clear                                                                       %clear all varables
clc                                                                         %clear the command window

load WaterUseData.mat                                                       %load water useage file

ActiveMetaData = ThermoelectricpowerinBgald;                                %set active metadata

% the following code is based of the first question "at what point should
% investers stop investing in thermoelectirc power based off the given data

% plan: to graph the data points and then generate a line of best fit, find
% out where the derivative of the line becomes negative and report the 
% value of x right before that point