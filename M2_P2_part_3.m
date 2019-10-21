%plot the selected meta data

clc
clear

close all;
load WaterUseData.mat;

fprintf("[1] ThermoElectric\n[2] Population in Millions\n[3] Public Supply in billions of gallons\n");
Metadata = input('input selection: ');

if Metadata == 1
    edward
    SelMetaData = ThermoelectricpowerinBgald;
    LegendString = 'Thermoelectric power supply in Billions';
    LineType = 2;
elseif Metadata == 2
    SelMetaData = Populationinmillions;
    LegendString = 'Population in millions';
    LineType = 1;
elseif Metadata == 3
    SelMetaData = PublicsupplyinBgald;
    LegendString = 'Public Supply in Billions';
    LineType = 2;
else
    disp("error no selection");
    return
end

hold on;
grid on;

MetaDataGraph = plot(Year, SelMetaData, 'ro');

title(sprintf('%s vs. Year', LegendString));
xlabel("Year");
ylabel(LegendString);

if LineType == 1
    BestFit = polyfit(Year, SelMetaData, LineType);
    BestFitLine = BestFit(1)*Year+BestFit(2);
else
    BestFit = polyfit(Year, SelMetaData, LineType);
    BestFitLine = polyval(BestFit, Year);
    
    %BestFitLine = (BestFit(1)*(Year.^2))+(BestFit(2)*(Year))+(BestFit(3));
    %ax^2+bx+c
end

%{
if LineType == 1
    BestFit = polyfit(Year, SelMetaData, 1);
    BestFitLine = BestFit(1)*Year+BestFit(2);
else
    BestFit = polyfit(Year, SelMetaData, 2);
    %Pval = polyval(BestFit, Year);
    
    BestFitLine = (BestFit(1)*(Year.^2))+(BestFit(2)*(Year))+(BestFit(3)); %ax^2+bx+c
end
%}

BestFitLineLE = plot(Year, BestFitLine, 'b');
BestFitLineL = 'Line of best fit';

legend([MetaDataGraph; BestFitLineLE], LegendString, BestFitLineL);
