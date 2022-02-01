function [Output_Deceision_Device] = BPSK_Threshold_Detector_Block(Input_signal,Tb)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%{
Parameters:
1-Input_signal: The signal input into the Threshold Detector
This input signal is sampled at every Tb
2-size_of_message_bits: Number of bits sent
%}
%Generate a vector zero with the size of the sent bits
%Output Binary bits in the Diagram
Output_Deceision_Device=zeros(1,length(Input_signal)/Tb);
for i=1:length(Output_Deceision_Device)
    if(Input_signal(i*Tb) > 0)
        Output_Deceision_Device(i) = 1;
    elseif(Input_signal(i*Tb) < 0)
        Output_Deceision_Device(i) = 0;
    end
end
end

