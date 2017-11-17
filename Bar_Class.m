classdef Bar_Class<handle
    properties
        x %x coordinate
        y %y coordinate
        w %width
        h %height
        bounder %bounder
    end
    methods
        function obj = Bar_Class(x,y,w,h)
            % @fxn constructor(x,y,w,h)
            % @params x position x
            % @params y position y
            % @params w width
            % @params h height
            obj.x = x;
            obj.y = y;
            obj.w = w;
            obj.h = h;
        end
        % Move
        function x = move(obj,dir)
            % @fxn move
            % @params obj, dir
            % @params obj: self
            % @params dir: direction to move ('left','right')
            % @out: x position after moved
            switch dir
                case 'left'
                    if(obj.x>200*0)
                        obj.x = obj.x - obj.w;
                    end
                case 'right'
                    if(obj.x<200*3)
                        obj.x = obj.x + obj.w;
                    end
                otherwise
            end
            x = obj.x;
            getBounder(obj);
        end
        function bounder = getBounder(obj)
            obj.bounder = [];
            % @fxn getBounder: get array of bounders base on x,y location
            for height = 1:obj.h
                bLeft = [obj.x,obj.y+height]; % Left bounders
                obj.bounder = [obj.bounder;bLeft];
            end
            for height = 1:obj.h
                bRight = [obj.x+obj.w,obj.y+height]; % Right bounder
                obj.bounder = [obj.bounder;bRight];
            end
            for width = 1:obj.w
                bTop = [obj.x+width,obj.h]; % Top bounder
                obj.bounder = [obj.bounder;bTop];
            end
            bounder = obj.bounder
        end
    end
end