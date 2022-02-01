clear;
clc;
close all;
%%
%Size of the sent message[Number of bits]%
Sent_msg_size=20;
%Number of realizations as stated in the document
N0=2;
N = 40;
Ts = 1;
Tb = Ts*N;
count=0;
%Signal to noise range of values from -4 to 4
Signal_To_Noise_Ratio=-4:1:4;
%Period of time axis of cosine
Period_time_axis=1:1:Tb;
%carrier frequency of cosine
carrier_frequency=(4*2*pi)/Tb;
%To calculate Omega1(W1) and Omega2(W2)
Omega1 = 2*pi*(5)/Tb;
Omega2 = 2*pi*(3)/Tb;
%period of effect of the noise on bits
total_l = Sent_msg_size*Tb;
period_noise_effect=1:total_l;
%vector variables
%Average Bit error rate(Practical)
Practical_Average_Bit_Error_Rate_BPSK=zeros(1,length(Signal_To_Noise_Ratio));
Practical_Average_Bit_Error_Rate_BFSK=zeros(1,length(Signal_To_Noise_Ratio));

%Average Bit error rate(theoretical)
TheoreticaL_Average_Bit_Error_Rate_BPSK=zeros(1,length(Signal_To_Noise_Ratio));
TheoreticaL_Average_Bit_Error_Rate_BFSK=zeros(1,length(Signal_To_Noise_Ratio));

%%
%using random function to generate a random bits
%of 0's and 1's according to the given message size%
Random_bits_bk=randi([0 1],1,Sent_msg_size);
%%
%%
%POLAR NRZ generation bits
bk_POLAR_NRZ_signal=Random_bits_bk';
bk_UniPOLAR_NRZ_signal=Random_bits_bk';
bk_POLAR_NRZ_signal(Random_bits_bk==0)=-1;
%%
%POLAR NRZ rectangular generation 
Rectangular_Polar_NRZ_Pulse=rectpulse(bk_POLAR_NRZ_signal,Tb)';
figure
%%
%preparing the graph plotting
plot(Rectangular_Polar_NRZ_Pulse);
title('Polar-NRZ signal');
xlabel('Time in seconds');
ylabel('Voltage levels in volt');
ylim([-2 2]);
xlim([0 Sent_msg_size*Tb]);
xticks(0:Tb:Sent_msg_size*Tb);
%%
%UniPOLAR NRZ rectangular generation 
Rectangular_UniPolar_NRZ_Pulse=rectpulse(bk_UniPOLAR_NRZ_signal,Tb)';
figure;
%%
%preparing the graph plotting
plot(Rectangular_UniPolar_NRZ_Pulse);
title('Uni=Polar-NRZ signal');
xlabel('Time in seconds');
ylabel('Voltage levels in volt');
ylim([-2 2]);
xlim([0 Sent_msg_size*Tb]);
xticks(0:Tb:Sent_msg_size*Tb);
%%
% Drawing the PSD of the POLAR NRZ
[PSD_SIGNAL_POLAR,FREQUENCY_PSD_SIGNAL_POLAR]=periodogram(Rectangular_Polar_NRZ_Pulse,[],[],1);
figure;
plot(FREQUENCY_PSD_SIGNAL_POLAR,PSD_SIGNAL_POLAR);
title('PSD of the POLAR NRZ');
xlabel('Frequency in Hertz)');
ylabel('Power spectral density in Watt/Hertz');
xlim([0 0.2]);
%%
%%
% Drawing the PSD of the UNIPOLAR NRZ
[PSD_SIGNAL_UNIPOLAR,FREQUENCY_PSD_SIGNAL_UNIPOLAR]=periodogram(Rectangular_UniPolar_NRZ_Pulse,[],[],1);
figure;
plot(FREQUENCY_PSD_SIGNAL_UNIPOLAR,PSD_SIGNAL_UNIPOLAR);
title('PSD of the UNIPOLAR NRZ');
xlabel('Frequency in Hertz)');
ylabel('Power spectral density in Watt/Hertz');
xlim([0 0.2]);
%%
lEN_SNRA=length(Signal_To_Noise_Ratio);
for i=1:lEN_SNRA
    %Amplitude Rule Derived in document
    Amplitude_Before_Modulation=sqrt((10^(Signal_To_Noise_Ratio(i)/10)) * (2*N0/Tb));
    %Modulate the signal for BPSK
    Modulated_BPSK_Signal=BPSK_Function_Generator_Block(Rectangular_Polar_NRZ_Pulse,Amplitude_Before_Modulation,period_noise_effect,carrier_frequency);
    %Modulate the signal for BPSK
    Modulated_BFSK_Signal=BFSK_Function_Generator_Block(Rectangular_UniPolar_NRZ_Pulse,Amplitude_Before_Modulation,period_noise_effect,Omega1,Omega2);
    %%change this value to draw at specific SNR
    if Signal_To_Noise_Ratio(i) == 4
        %BPSK Modulation
        figure;
        plot(period_noise_effect,Modulated_BPSK_Signal);
        ylim([-1 1]);
        title('Modulated Bits BPSK Signal');
        xlabel('Time in seconds');
        ylabel('Voltage levels in Volt');
        
        %BFSK Modulation
        figure;
        plot(period_noise_effect,Modulated_BFSK_Signal);
        ylim([-1 1]);
        title('Modulated Bits BFSK Signal');
        ylabel('Voltage levels in Volt');
        xlabel('Time in seconds');
        %count variable to just make sure to draw the following only once
        count=count+1;
    end
    
    %We will calculate the BER for 20 realizations and put them in a vector
    %Here we kept the same value of SNR, Used in the calculation of the 
    %Average BER Practical
    Realizations_number = 20;
    Bit_error_rate_BPSK=zeros(1,Realizations_number);
    Bit_error_rate_BFSK=zeros(1,Realizations_number);
    for j=1:Realizations_number
        %BPSK
        %Generating noise
        Noise_W=(N0/2)*randn(1, total_l);
        %Adding Noise to the signal
        Output_Summer_V_BPSK=Modulated_BPSK_Signal+Noise_W;
        Plotter(count,1,Output_Summer_V_BPSK,0,0,0,period_noise_effect,0);
        %Passing the Signal+noise through the Matched filter
        Output_Macthed_filter_Vo_BPSK=BPSK_Matched_Filter_Block(Output_Summer_V_BPSK,Amplitude_Before_Modulation,carrier_frequency,Period_time_axis,Tb);
        Plotter(count,2,Output_Macthed_filter_Vo_BPSK,0,0,0,period_noise_effect,0);
        %Passing the Output of the matched filter through the Threshold detector 
        Output_Threshold_detector_binaryData_BPSK = BPSK_Threshold_Detector_Block(Output_Macthed_filter_Vo_BPSK,Tb);
        
        %BFSK
        %Adding Noise to the signal
        Noise_W2=(N0/2)*randn(1, total_l);
        Output_Summer_V_BFSK=Modulated_BFSK_Signal+Noise_W2;
        Plotter(count,3,Output_Summer_V_BFSK,0,0,0,period_noise_effect,0);
        %Passing the Signal+noise through the Matched filter
        [Output_Macthed_filter_Vo_BFSK1,Output_Macthed_filter_Vo_BFSK2]=BFSK_Matched_Filter_Block(Output_Summer_V_BFSK,Amplitude_Before_Modulation,Period_time_axis,Omega1,Omega2,Tb);
        Plotter(count,4,Output_Macthed_filter_Vo_BFSK1,Output_Macthed_filter_Vo_BFSK2,0,0,period_noise_effect,0);
        %Passing the Output of the matched filter through the Threshold detector 
        Output_Threshold_detector_binaryData_BFSK = BFSK_Threshold_Detector_Block(Output_Macthed_filter_Vo_BFSK1,Output_Macthed_filter_Vo_BFSK2,Tb);
        
        
        %Here we check if the output of the threshold detector is not the
        %same as the input binary bits
        %we calculate the total number of error in each realization for
        %both BPSK AND BFSK
        Not_Equal_BPSK_Val = sum(Random_bits_bk~=Output_Threshold_detector_binaryData_BPSK);
        Not_Equal_BFSK_Val = sum(Random_bits_bk~=Output_Threshold_detector_binaryData_BFSK);
        %erroneous bits
        %Rule given on the document in each realization
        Bit_error_rate_BPSK(j) = Not_Equal_BPSK_Val/Sent_msg_size;
        Bit_error_rate_BFSK(j) = Not_Equal_BFSK_Val/Sent_msg_size;
        count=0;
    end
    %Average Bit error rate(Practical)
    %Average Bit error rate
    %BPSK
    Practical_Average_Bit_Error_Rate_BPSK(i) = sum(Bit_error_rate_BPSK)/Realizations_number;
    Practical_Average_Bit_Error_Rate_BFSK(i) = sum(Bit_error_rate_BFSK)/Realizations_number;
    
    %Average Bit error rate(Theoretical)
    %Rule derived in the Report
    TheoreticaL_Average_Bit_Error_Rate_BPSK(i) = (1/2)*erfc(Amplitude_Before_Modulation*sqrt(Tb/(2*N0)));
    TheoreticaL_Average_Bit_Error_Rate_BFSK(i) = (1/2)*erfc((Amplitude_Before_Modulation/2)*sqrt(Tb/N0));  
end
Plotter(0,5,Practical_Average_Bit_Error_Rate_BPSK,TheoreticaL_Average_Bit_Error_Rate_BPSK,Practical_Average_Bit_Error_Rate_BFSK,TheoreticaL_Average_Bit_Error_Rate_BFSK,0,Signal_To_Noise_Ratio);
