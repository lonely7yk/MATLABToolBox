function newQueue =  enQueue(oldQueue, x)
    len = length(oldQueue);
    oldQueue(len + 1) = x;
    newQueue = oldQueue;
end