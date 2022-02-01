function [Output_Modulated_FSK_signal] = BFSK_Function_Generator_Block(Input_Signal,Amp_UNIPOLAR_NRZ,period_noise_effect,Omega1,Omega2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Generating an output vector modulated FSK signal
Output_Modulated_FSK_signal=ones(1,length(Input_Signal))*Amp_UNIPOLAR_NRZ;
%Putting cos(w1) in an intermediate variable for later assignement
Interm1 = Output_Modulated_FSK_signal.*cos(Omega1*period_noise_effect);
Output_Modulated_FSK_signal(Input_Signal==1)=Interm1(Input_Signal==1);
%Putting cos(w2) in an intermediate variable for later assignement
Interm0 = Output_Modulated_FSK_signal.*cos(Omega2*period_noise_effect);
Output_Modulated_FSK_signal(Input_Signal==0)=Interm0(Input_Signal==0);
%Modulating the Output signal to match
% 1 ---> cos(w1)
% 0 ---> cos(w2)
for i = 1:length(Input_Signal)
    if(Input_Signal(i)==1)
        Output_Modulated_FSK_signal(i)=Interm1(i);
    else
        Output_Modulated_FSK_signal(i)=Interm0(i);
    end
end
end

