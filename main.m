clear; clc;
gamma = 0.8;
score = 1;
iter = 10000;
cnt = 1;
Q = zeros(4000,3);
R = zeros(4000,3); % 3 columns're equivalent to 3 actions: left, right, stand still

% Initialize position of the ball along horizontal axis
for i = 1:100
    ball_pos(1,i) = (i-1)*8;
end

% Initialize vertical position of the ball
for i = 1:10
    ball_height(1,i) = (i-1)*40;
end
wedge_pos = [0 200 400 600];

for i = 1:length(wedge_pos)
    for j = 1:length(ball_height)
        for k = 1:length(ball_pos)
            state_vector(cnt,1) = wedge_pos(i);
            state_vector(cnt,2) = ball_height(j);
            state_vector(cnt,3) = ball_pos(k);
            if (ball_pos(k) > wedge_pos(i)+200)
                if (wedge_pos(i)+200 < 800)  R(cnt,:) = [0 1 0];
                else R(cnt,:) = [0 0 1];
                end
            elseif (ball_pos(k) < wedge_pos(i))
                if (wedge_pos(i) > 0)  R(cnt,:) = [1 0 0];
                else R(cnt,:) = [0 0 1];
                end
            else R(cnt,:) = [0 0 1];
            end
            cnt = cnt + 1;
        end
    end
end

wedge_current_pos = wedge_pos(randi([1,4],1)); % generate random wedge's position
for i = 1:iter
    ball_current_pos = ball_pos(randi([1,100],1)); % random ball's position
    height = 360; % ball begins to fall at max height
    [state ~] = find(state_vector(:,1)==wedge_current_pos & state_vector(:,2)==height & state_vector(:,3)==ball_current_pos,1);
    % find at which state the system is
    
    %% Q-learning process
    while (height >= 40)
        action = randi([1 3],1);        
        height = height - 40;
        [~,col] = max(Q(state,:)); % maximum index of actions
        if ((Q(state,1) == Q(state,2) && Q(state,2) == Q(state,3)) || (col == 3)) % action = stand still
        elseif (col == 1) % action = left
            wedge_current_pos = wedge_current_pos - 200;
        elseif (col == 2) % action = right
            wedge_current_pos = wedge_current_pos + 200;
        end
        [nstate,~] = find(state_vector(:,1)==wedge_current_pos & state_vector(:,2)==height & state_vector(:,3)==ball_current_pos,1);
        % next state
        state = nstate;
        Q(state,action) = R(state,action) + gamma*max(Q(nstate,:));
    end
end
Q