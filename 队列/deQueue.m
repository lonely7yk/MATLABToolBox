function [x,newQueue] = deQueue(oldQueue)
    len = length(oldQueue);
    if len ~= 0
        x = oldQueue(1);
        oldQueue(1) = [];
        newQueue = oldQueue;
    else
    	fprintf('队列已经为空');
    end
end