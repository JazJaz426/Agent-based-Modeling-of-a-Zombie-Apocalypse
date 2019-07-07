% ------------------------
% Solution to Question 1
% ------------------------
%
% Student 1: SID = 470345744        
% Student 2: SID = 
%
% ----------------------
% Brief description:
%
% To answer the corresponding questions, 4 extra parameters("occupy_prob",
% "healthy_remaining", "zombie_num" and "theo_infected_num") were defined.
%
% The last person was set to be the only zombie while the remaining
% ones are nonzombies. Random coordinates within the grid limit were then
% created for all those people using randi() so that everyone was randomly 
% distributed as specified.
% 
% In order to run the simulation for 1000 times over 100 people, I created
% a double-for loop. For each simulation, every person among 100
% people can choose 1 movement out of 5 choices. By randomly generating a number 
% between 1-5 using randi(), each person's random movement this numebr 
% mapped to can be determined. This movement was also properly handled so 
% the person won't go out of the boundary.
%
% For each simulation, the current numbers of zombies and nonzombies were 
% stored in the corresponding vectors. By checking if zombies and
% nonzombies share the same location using double-for loop, the number of 
% infections can be determined and the number of zombies was then updated.
% 
% Each zombie is possible to be remitted according to the given 
% remission rate. For each zombie, a random probability p between [0,1]
% is generated and compared with the remission rate. If p <= remission rate,
% a zombie is remitted. Hence by this way we makes sure the zombie was 
% remitted by the given remission rate.
% 
% All the previously created parameters/vectors are updated in each
% simulations and cease the program when all nonzombies are infected.
% ----------------------
%% Set parameters

% -parameters given
sidelength = 40;
maxtime = 1000;
npeople = 100;
remission = 0;

% -parameters defined by ourselves
% the probability any given square is occupied by a zombie
occupy_prob = zeros(maxtime);
% total healthy people remaining
healthy_remaining = zeros(maxtime);
% the total number of zombies 
zombie_num = zeros(maxtime);
% the number of zombies increased per day
theo_infected_num = zeros(maxtime);
%% Initialize people
people = struct();

% let the first (npeople-1) people to be non-zombie
for p = 1:npeople-1
    people(p).x = randi(sidelength);
    people(p).y = randi(sidelength);
    people(p).zombie = 0;
end 

% let the last person to be a zombie
people(npeople).x = randi(sidelength);
people(npeople).y = randi(sidelength);
people(npeople).zombie = 1;
%% Run loop
% run #[maxtime] simulations
for t = 1:maxtime
    % create 5 random variables
    % map them to the five movements respectively
    none = 1;
    left = 2;
    right = 3;
    up = 4;
    down = 5;
    
    % FIRST:Movement

    % in each simulation, each person can have 5 "movements"
    % stay still/left/right/up/down
    for p = 1:npeople

        % generate a random movement for each person
        movement = randi(5);

        % 1. stay still
        if movement == none
            continue;
        % 2. left
        elseif movement == left
            % reverse to the right when they try to move out the world
            if people(p).x == 1
                people(p).x = people(p).x + 1;
            else 
                people(p).x = people(p).x - 1;
            end 
        % 3. right
        elseif movement == right
            % reverse to the left when they try to move out the world
            if people(p).x == sidelength
                people(p).x = people(p).x - 1;
            else
                people(p).x = people(p).x + 1;
            end 
        % 4. up
        elseif movement == up
            % reverse to the downside when they try to move out the world
            if people(p).y == sidelength
                people(p).y = people(p).y - 1;
            else
                people(p).y = people(p).y + 1;
            end 
        % 5. down
        elseif movement == down
            % reverse to the upside when they try to move out the world
            if people(p).y == 1
                people(p).y = people(p).y + 1;
            else
                people(p).y = people(p).y - 1;
            end 
        end 
    end  
    
    % SECOND: Count zombies
    % find the indices of zombies and nonzombies
    % the indices for all zombies
    zombies = find([people.zombie]);
    
    % the indices for all nonzombies
    nonzombies = find(~[people.zombie]);
    
    % THIRD: Update zombies
    % for each zombie, check if there is any nonzombie that shares the same position
    for z = zombies
        for nz = nonzombies
            if people(nz).x == people(z).x && people(nz).y == people(z).y
                people(nz).zombie = 1;
            end 
        end 
    end 
    
    % FOURTH: Remission
    % for each zombie, if the remission rate is positive
    for z = zombies
        if remission > 0
            % for some random probability p
            % the probability that p <= remission is the remission rate
            % hence if p <= remission, we remit the zombie
            p = rand;
            if p <= remission
                people(z).zombie = 0;
            end 
        end
    end 
    
    %% Plotting
    % clear the current figure
    clf
    hold on 
    
    % plot the locations of all people
    scatter([people.x], [people.y], 'filled')
    
    % plot the zombies in green
    scatter([people(zombies).x], [people(zombies).y], 'filled', 'g');
    
    % show the current time and the current number of zombies in the title
    title(sprintf('t=%i zombies=%i', t, length(zombies)))
    
    % set the axis limits to include the entire world
    xlim([1,sidelength])
    ylim([1,sidelength])
    
    % pause for a very short time so that the plot will update
    pause(0.01)
    
    % stop when all nonzombies are infected
    if length(zombies) == npeople
        % record the time taken to be time_last
        time_last = t;
        zombie_num(time_last:maxtime) = length(zombies);
        break;
    end 
    
    occupy_prob(t) = length(zombies)/sidelength^2;
    healthy_remaining(t) = length(nonzombies);
    zombie_num(t) = length(zombies);
    % theoretical number of infections per day is the product of the current zombie
    % occupy rate and the number of remaining healthy people 
    theo_infected_num(t) = healthy_remaining(t)*occupy_prob(t);

end
