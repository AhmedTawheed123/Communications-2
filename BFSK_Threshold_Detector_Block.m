function [Ouptut_of_threshold_detector] = BFSK_Threshold_Detector_Block(Input_signal_1,Input_signal_2,Tb)
%BFSK_THRESHOLD_DETECTOR_BLOCK Summary of this function goes here
%   Detailed explanation goes here

%creating a vector to place the output of the decision block
Ouptut_of_threshold_detector=zeros(1,length(Input_signal_1)/Tb);
for i=1:length(Ouptut_of_threshold_detector)
    if( Input_signal_1(i*Tb) - Input_signal_2(i*Tb) > 0)
        Ouptut_of_threshold_detector(i) = 1;
    end
end
end


