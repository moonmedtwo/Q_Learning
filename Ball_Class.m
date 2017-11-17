classdef Ball_Class<handle
    properties
        x %x coordinate
        y %y coordinate
        r %radius
        v %velocity
    end
    methods
        function obj = Ball_Class(x,y,r,v)
            % @fxn constructor(x,y,r,v)
            % @params x position x
            % @params y position y
            % @params r radius
            % @params v moving speed in y direction
            obj.x = x;
            obj.y = y;
            obj.r = r;
            obj.v = v;
        end
        function y = move(obj,dir)
            % @fxn move
            % @params obj, dir
            % @params obj: self
            % @params dir: direction to move ('up','down')
            % @out: y position after moved
            switch dir
                case 'up'
                    obj.y = obj.y + obj.v;
                case 'down'
                    obj.y = obj.y - obj.v;
                otherwise
            end
            y = obj.y;
        end
    end
end