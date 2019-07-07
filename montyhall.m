% ------------------------
% Solution to Question 2
% ------------------------
%
% Student 1: SID = 470345744       
% Student 2: SID = 
%
% ----------------------
% Brief description:
% Given 3 doors, I randomly generated a number from 1-3 using randi(), set it 
% as the number corresponding to the "car door" and the remaining two numbers
% correponding to the "goat doors" using setdiff() function.
% 
% Similarly, another arbitrary number was generated from 1-3 and was set as 
% the number corresponding to the door contestant picks. In order to find
% which door to reveal, I first set the reveal vector as the difference between 
% number vector corresponding to the goat doors and number of the picked door.
% If contestant picks the goat, this vector is the goat we want to reveal; 
% If contestant picks the car, this vector is the goat-door array and we need
% to randomly select one element as new reveal vector.
% 
% Besides that, by using strcmpi() function the input argument was read to
% check if the contestant wants to stay or switch and then update the "pick"
% variable. Error message will be displayed and program will be ceased if
% the input argument is invalid.
%
% Selection process finishes and return the game result(win-1/lost-0) as "result".
% ----------------------

function result = montyhall(switchornot)
    num_doors = 3;
    doors = 1:num_doors;
    
    % randomly set a door to be the "car door"
    car = randi(num_doors);
    % set the two remaining doors to be the "goat doors"
    goats = setdiff(doors, car);

    % contestant randomly pick a door from 3 doors
    pick = randi(num_doors);
    % set the difference as reveal first
    % if contestant picks the goat, this is the goat we want to reveal
    % if contestant picks the car, this is the goat-door array and we need
    % to randomly select one element as the reveal
    reveal = setdiff(goats, pick);
    if length(reveal) == 2
        reveal = reveal(randi(2));
    end 
    
    % the doors that haven't been revealed
    notreveal = setdiff(doors,reveal);
    
    if strcmpi(switchornot,'switch')
        pick = setdiff(notreveal,pick);
    elseif strcmpi(switchornot,'stay')
        pick = pick;
    else
        % display error message and cease the program
        % if the argument is invalid
        disp("Error! Please input swap or stay.");
        return;
    end 
    
    % return the result
    if pick == car
        result = 1;
    else 
        result = 0;
    end 
end 



