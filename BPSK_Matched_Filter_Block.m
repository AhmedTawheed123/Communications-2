function [Output_of_matched_filter] = BPSK_Matched_Filter_Block(Input_Signal,Amp_POLAR_NRZ,carrier_frequency,Period_time_axis,Tb)
%BPSK_MATCHED_FILTER_BLOCK Summary of this function goes here
%   Detailed explanation goes here
%Parameters:
%Input_Signal:Input of the signal to matched filter after noise is added,
%Input_Signal is V(t) in the project document
%Amp_POLAR_NRZ:Calculated Amplitude at each different SIGNAL TO NOISE RATIO
%carrier_frequency: frequency of the carrier signal 

%h(Period_time_axis) is the transfer function of the matched filter block
TF(Period_time_axis)= Amp_POLAR_NRZ*cos(carrier_frequency*(Tb-Period_time_axis));

%integration part of matched filter in analysis where we apply convolution
Output_of_matched_filter = conv(Input_Signal,TF);

%output of the matched filter in analysis
%output of the matched filter is Vo(t) in the project document 
Output_of_matched_filter = Output_of_matched_filter(1:length(Input_Signal));
end

