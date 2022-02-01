function [Output_Matched_Filter1,Output_Matched_Filter2] = BFSK_Matched_Filter_Block(Input_signal,Amp_UNIPOLAR_NRZ,Period_time_axis,Omega1,Omega2,Tb)
%BFSK_MATCHED_FILTER_BLOCK Summary of this function goes here
%   Detailed explanation goes here

%Matched Filters Transfer functions
TF1(Period_time_axis)=Amp_UNIPOLAR_NRZ*cos(Omega1*(Tb-Period_time_axis));
TF2(Period_time_axis)=Amp_UNIPOLAR_NRZ*cos(Omega2*(Tb-Period_time_axis));
%Setting the output of Matched Filters Transfer functions
Output_Matched_Filter1 = conv(Input_signal,TF1);
Output_Matched_Filter2 = conv(Input_signal,TF2);
Output_Matched_Filter1 = Output_Matched_Filter1(1:length(Input_signal));
Output_Matched_Filter2 = Output_Matched_Filter2(1:length(Input_signal));

end

