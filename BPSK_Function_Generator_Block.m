function [BPSK_Generated_Signal] = BPSK_Function_Generator_Block(Rectangular_Polar_NRZ_Pulse,Amp_POLAR_NRZ,period_noise_effect,carrier_frequency)
%BPSK_FUNCTION_GENERATOR Summary of this function goes here
%   Detailed explanation goes here

%Parameters:
%Rectangular_Polar_NRZ_Pulse:Signal pulse of the POLAR NRZ
%Amp_POLAR_NRZ:Calculated Amplitude at each different SIGNAL TO NOISE RATIO
%period_noise_effect: need to state the time range of the cosine
%carrier_frequency: frequency of the carrier signal 

BPSK_Generated_Signal=(Rectangular_Polar_NRZ_Pulse*Amp_POLAR_NRZ).*cos(carrier_frequency*period_noise_effect);

end

