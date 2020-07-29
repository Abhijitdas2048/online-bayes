function [NormalizedVector] = Normalize(InputVector) 

InputVector = InputVector - min(InputVector) + 0.001;   %One extra is 
%added so that one element of posterior dont become 0.
InputVector = InputVector/sum(InputVector);

NormalizedVector = InputVector;

return;