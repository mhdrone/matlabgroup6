% Module 2 Part 2 Group 6 Decision Program
% Mario ---- outputing data to file
% Stephen -- decision tree
% Brett ---- graph labels and format
% Vedant --- graph legend
% Edward --- outputing data to command window
% Hamilton - Basic program layout, final formating

clear                                                                       % Clear all variables
clc                                                                         % Clear the command window
close all;                                                                  % Close all open graphs

load WaterUseData.mat                                                       % Load water useage file

ActiveMetaData = ThermoelectricpowerinBgald;                                % Set active metadata

y = 1;                                                                      % Set y = 1
n = 0;                                                                      % Set n = 0

GraphforUser = input('Would you like to display graphs? [y/n]: ');          % Ask user if they would like to display
                                                                            % graphs
SaveFileUser = input('Would you like to output data to file? [y/n]: ');     % Ask user if they want to output to file

% The following code is based of the first question "at what point should
% investers stop investing in thermoelectirc power based off the given data

% Plan: to graph the data points and then generate a line of best fit, find
% out where the derivative of the line becomes negative and report the
% value of x right before that point

BestFit = polyfit(Year, ActiveMetaData, 2);                                 % Generate line of best fit
BestFitLine = polyval(BestFit, Year);                                       % Clean up best fit line into a usable format
BestFitDer = polyder(BestFit);                                              % Get the derivitive of the best fit line
BestFitDerLine = polyval(BestFitDer, Year);                                 % Put derivitive into usable format

DerivitiveMatrix(:,1) = BestFitDerLine;                                     % Make a matrix and put the bestfit der values
                                                                            % in column one
DerivitiveMatrix(:,2) = Year;                                               % Put year in column 2

% ZeroValue = min(abs(DerivitiveMatrix(:,1)));                              % Find the closest value to 0                            
% MatrixZero = find(abs(DerivitiveMatrix(:,1)-ZeroValue) < 0.1);            % Find the index of ZeroValue in the matrix
% YearToQuit = DerivitiveMatrix(MatrixZero, 2);                             % Get the corresponding year value

if GraphforUser == 1                                                        % Run if the user wants to display a graph
    hold on;                                                                % Keep all open windows and write plots to
                                                                            % window
    Plot1 = plot(Year, ActiveMetaData, 'ro');                               % Plot the metadata
    Plot2 = plot(Year, BestFitLine, 'b');                                   % Plot the best fit line
    Plot3 = plot(Year, BestFitDerLine);                                     % Plot the derivitive
    xlabel('Years');                                                        % Label the x axis "years"
    ylabel('Thermoelectric Power in Billions of gallons');                  % Label the y axis thermoelectic power
    title('Thermoelectric Power Water Usage (1950-2015)');                  % Title the graph
    legend({'ActiveMetaData', 'BestFitLine', 'BestFitDerLine'},...
        'Location', 'northwest');                                           % Add a legend for each line
end

CurrentYear = 0;
while CurrentYear < 2015 || CurrentYear > 2020  
    CurrentYear = input('Please input the current year (2015-2020): ');     % Input current year [2015-2020]
end

                                                                            % Input min and max derivative values for next
                                                                            % four years
RateThresholds = [];
for i=1:4
    YearToPromptFor = CurrentYear + i;
    MinRateForYear = input(sprintf(['Please input the minimum rate of ' ...
    'change for thermoelectric power usage in change in billions of ' ...
    'gallons per day for %.0f: '], YearToPromptFor));

    MaxRateForYear = input(sprintf(['Please input the maximum rate of ' ...
    'change for thermoelectric power usage in change in billions of ' ...
    'gallons per day for %.0f: '], YearToPromptFor));

                                                                            % Min and max rates are stored in a 2x4 matrix
                                                                            % Each row corresponds to a year [1,4] and
                                                                            % each column (top/bottom) corresponds to a
                                                                            % min/max rate
    RateThresholds(1, i) = MinRateForYear;
    RateThresholds(2, i) = MaxRateForYear;
end

% disp(DerivitiveMatrix(:,1));
% disp(DerivitiveMatrix(:,2));
% disp(RateThresholds);
% disp(CurrentYear);

YearToQuit = -1;
                                                                            % Output first year whose data is outside
                                                                            % min/max rate of change
for year=CurrentYear:CurrentYear+4                    
    CurrentRate = polyval(BestFitDer, (year - 1950) / 5);                   % Data is in 5 year intervals, so divide
                                                                            % by 5 to find index
    CurrentMinRate = RateThresholds(1, year - CurrentYear + 1);             % Data is NOT in 5 year intervals
    CurrentMaxRate = RateThresholds(2, year - CurrentYear + 1);
   
    if CurrentRate < CurrentMinRate
        YearToQuit = year;
        fprintf('Rate of change for %.0f is below threshold %.0f.\n',...
            CurrentYear, CurrentMinRate);
        break;
    elseif CurrentRate > CurrentMaxRate
        YearToQuit = year;
        fprintf('Rate of change for %.0f is below threshold %.0f.\n',...
            CurrentYear, CurrentMaxRate);
        break;
    end
end

if YearToQuit ~= 1
    fprintf(['We recommend that investments in hydroelectric power ' ...
        'be discontinued in %.0f.\n'], YearToQuit);
end


if SaveFileUser == 1
    fid = fopen( 'results.txt', 'wt' );                                     % Creates a new text file and opens it
    fprintf(fid, 'Rate Thresholds: %g, %g, %g, %g, %g, %g, %g, %g\n',...    % Writes the Threshold array to the file
        RateThresholds);
    fprintf(fid, 'Year to quit: %d\n', YearToQuit);                         % Writes the year to quit
    fprintf(fid, 'Current Year: %d\n', CurrentYear);                        % Writes the current year
    fclose(fid);
   
    dlmwrite('matrix.txt', DerivitiveMatrix);                               % Writes the matrix to 'matrix.txt'
   
    disp("results.txt file has been saved.");                               % Confirms to user that the files
    disp("matrix.txt file has been saved.");                                % have been saved
end