% Module 2 Part 2 Group 6 Decision Program
% Mario ---- outputing data to file
% Stephen -- decision tree
% Brett ---- graph labels and format
% Vedant --- graph legend
% Edward --- outputing data to command window
% Hamilton - Basic program layout, final formating

clear                                                                       %clear all variables
clc                                                                         %clear the command window
close all;

load WaterUseData.mat                                                       %load water useage file

ActiveMetaData = ThermoelectricpowerinBgald;                                %set active metadata

y = 1;                                                                      %set y = 1
n = 0;                                                                      %set n = 0

GraphforUser = input('Would you like to display graphs? [y/n]: ');          %ask user if they would like to display graphs
SaveFileUser = input('Would you like to output data to file? [y/n]: ');     %ask user if they would like to output to file

% the following code is based of the first question "at what point should
% investers stop investing in thermoelectirc power based off the given data

% plan: to graph the data points and then generate a line of best fit, find
% out where the derivative of the line becomes negative and report the 
% value of x right before that point

BestFit = polyfit(Year, ActiveMetaData, 2);                                 %Generate line of best fit
BestFitLine = polyval(BestFit, Year);                                       %Clean up best fit line into a usable format
BestFitDer = polyder(BestFit);                                              %Get the derivitive of the best fit line
BestFitDerLine = polyval(BestFitDer, Year);                                 %Put derivitive into usable format

DerivitiveMatrix(:,1) = BestFitDerLine;                                     %Make a matrix and put the bestfit der values in column one
DerivitiveMatrix(:,2) = Year;                                               %Put year in column 2

ZeroValue = min(abs(DerivitiveMatrix(:,1)));                                %Find the closest value to 0                             
MatrixZero = find(abs(DerivitiveMatrix(:,1)-ZeroValue) < 0.1);              %find the index of ZeroValue in the matrix
YearToQuit = DerivitiveMatrix(MatrixZero,2);                                %get the corresponding year value

if GraphforUser == 1                                                        %run if the user wants to display a graph
    hold on;                                                                %keep all open windows and write plots to the current window
    Plot1 = plot(Year, ActiveMetaData, 'ro');                               %plot the metadata
    Plot2 = plot(Year, BestFitLine, 'b');                                   %plot the best fit line
    Plot3 = plot(Year, BestFitDerLine);                                     %plot the derivitive
    %graph lables to be added
    %graph legend to be added
end

%decision tree to be added

if SaveFileUser == 1
    disp("sorry, saving to file hasn't been added yet");
    %data output to file to be added
end

% output data into command window (year to stop investing is stored in
% variable YearToQuit