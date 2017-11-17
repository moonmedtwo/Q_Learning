function test
%% DEFINES
load('defines.mat');
ball = Ball_Class(8*ceil(100*rand(1)),TOP,BALL_RADIUS,BALL_SPEED);
bar = Bar_Class(LEFT,BOTTOM,BAR_WIDTH,BAR_HEIGHT);
set(gcf,'CurrentCharacter','@')
running = true;
score = 0;
while(running)
    %% Clear graph and set axes limits
    clf;
    xlim([LEFT RIGHT])
    ylim([BOTTOM TOP])
    %% Rendering;
    render_ball(ball);
    render_bar(bar);
    render_score(750,400,score);
    %% Controllinga
    waitforbuttonpress;
    k=get(gcf,'CurrentCharacter');
    if k~='@' % has it changed from the dummy character?
        set(gcf,'CurrentCharacter','@'); % reset the character
        % now process the key as required
        if k=='q'
            running = false; 
        end
    end
    switch k
        case 'j'
            bar.move('left');
        case 'l'
            bar.move('right');
        otherwise
    end
    ball.move('down');
    %% Check
    if(is_touched(ball,bar))
        score = score + 1;
        ball = Ball_Class(8*ceil(100*rand(1)),TOP,BALL_RADIUS,BALL_SPEED);
    end
    if(is_down(ball))
        score = score - 1;
        ball = Ball_Class(8*ceil(100*rand(1)),TOP,BALL_RADIUS,BALL_SPEED);
    end
end
end

%% UTIL FUNCTION
function h = circle2(x,y,r)
d = r*2;
px = x-r;
py = y-r;
h = rectangle('Position',[px py d d],'Curvature',[1,1]);
daspect([1,1,1])
end
function render_ball(ball)
   circle2(ball.x,ball.y,ball.r); 
end
function render_bar(bar)
    rectangle('Position',[bar.x,bar.y,bar.w,bar.h],'Curvature',[0 0]);
end
function render_score(x,y,score)
    s = sprintf('Score:%d',score);
    text(x,y,s);
end
function bool = is_touched(ball,bar)
    % @fxn is_touched: check if ball touches bar
    % @params ball: ball
    % @params bar: bar
    % @out: istouched
    bool = false;
    BALL_RADIUS = 40;
    for idx = 1:length(bar.bounder)
        p1 = bar.bounder(idx,:);
        p2 = [ball.x,ball.y];
        if(calc_dist(p1,p2)<= BALL_RADIUS)
            bool = true;
            break;
        end   
    end
end
function bool = is_down(obj)
    % @fxn is_down: check if ball touchs ground
    % @params ball: ball
    % @out: isdown
    bool = false;
    BALL_RADIUS = 40;
    if(obj.y <= -BALL_RADIUS/2)
        bool = true;
    end
end
function dist = calc_dist(p1,p2)
    % @fxn calc_dist: calculate Euclidian distance between 2 points
    % @params p1: point 1
    % @params p2: point 2
    % @out: distance
    dist = sqrt((p1(1)-p2(1))^2+(p1(2)-p2(2))^2);
end
