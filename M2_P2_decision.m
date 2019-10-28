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

% ZeroValue = min(abs(DerivitiveMatrix(:,1)));                              %Find the closest value to 0                             
% MatrixZero = find(abs(DerivitiveMatrix(:,1)-ZeroValue) < 0.1);            %find the index of ZeroValue in the matrix
%YearToQuit = DerivitiveMatrix(MatrixZero, 2);                              %get the corresponding year value

if GraphforUser == 1                                                        %run if the user wants to display a graph
    hold on;                                                                %keep all open windows and write plots to the current window
    Plot1 = plot(Year, ActiveMetaData, 'ro');                               %plot the metadata
    Plot2 = plot(Year, BestFitLine, 'b');                                   %plot the best fit line
    Plot3 = plot(Year, BestFitDerLine);                                     %plot the derivitive
    xlabel('Years');%graph lables to be added
    ylabel('Thermoelectric Power in Billions of gallons');%graph legend to be added
    title('Thermoelectric Power Water Usage (1950-2015)');
    %graph lables to be added
    %graph legend to be added
    legend({'ActiveMetaData', 'BestFitLine', 'BestFitDerLine'}, 'Location', 'northwest'); 
end

currentYear = 0;
while currentYear < 2015 || currentYear > 2020  
    currentYear = input('Please input the current year (2015-2020): ');     % Input current year [2015-2020]
end

% Input min and max derivative values for next four years
rateThresholds = [];
for i=1:4
    yearToPromptFor = currentYear + i;
    minRateForYear = input(sprintf("Please input the minimum rate of change for thermoelectric power usage in change in billions of gallons per day for %.0f: ", yearToPromptFor));
    maxRateForYear = input(sprintf("Please input the maximum rate of change for thermoelectric power usage in change in billions of gallons per day for %.0f: ", yearToPromptFor));
    % Min and max rates are stored in a 2x4 matrix - each row corresponds
    % to a year [1,4] and each column (top/bottom) corresponds to a min/max
    % rate
    rateThresholds(1, i) = minRateForYear;
    rateThresholds(2, i) = maxRateForYear;
end

% disp(DerivitiveMatrix(:,1));
% disp(DerivitiveMatrix(:,2));
% disp(rateThresholds);
% disp(currentYear);

YearToQuit = -1;
% Output first year whose data is outside min/max rate of change
for year=currentYear:currentYear+4                     
    currentRate = DerivitiveMatrix((year - 1950) / 5, 1);                   % Data is in 5 year intervals, so divide by 5 to find index
    currentMinRate = rateThresholds(1, year - currentYear + 1);             % Data is NOT in 5 year intervals
    currentMaxRate = rateThresholds(2, year - currentYear + 1);
    
    if currentRate < currentMinRate
        YearToQuit = year;
        fprintf('Rate of change for %.0f is below threshold %.0f.\n', currentYear, currentMinRate);
        break;
    elseif currentRate > currentMaxRate
        YearToQuit = year;
        fprintf('Rate of change for %.0f is below threshold %.0f.\n', currentYear, currentMaxRate);
        break;
    end
end

if YearToQuit ~= 1
    fprintf('We recommend that investments in hydroelectric power be discontinued in %.0f.\n', YearToQuit);
end


if SaveFileUser == 1
    disp("sorry, saving to file hasn't been added yet");
    %data output to file to be added
end

% disp('Year to stop investing: ')
% disp(YearToQuit)
% output data into command window (year to stop investing is stored in
% variable YearToQuit
