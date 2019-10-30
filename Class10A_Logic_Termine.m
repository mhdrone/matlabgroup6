while 1 == 1
    rightS = input('Enter right sensor reading: ');
    leftS = input('Enter left sensor reading: ');
    
    if (leftS > rightS)
        disp('Turn the right motor on.')
    if (leftS < rightS)
        disp('Turn the left motor on.')
    else
        disp('Turn both motors on.')
    