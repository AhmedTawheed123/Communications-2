function [] = Plotter(count,seq,input_Signal_1,input_Signal_2,input_Signal_3,input_Signal_4,period_noise_effect,Signal_To_Noise_Ratio)
%PLOTTER Summary of this function goes here
%   Detailed explanation goes here
if (count==1 && seq ==1)
    figure;
    plot(period_noise_effect,input_Signal_1);
    title('BPSK AFTER ADDING NOISE');
    xlabel('Time in seconds');
    ylabel('Voltage levels in Volts');
elseif (count==1 && seq==2)
    figure;
    plot(period_noise_effect,input_Signal_1);
    title('BPSK AFTER PASSING THROUGH MATCHED FILTER BLOCK');
    xlabel('Time in seconds');
    ylabel('Voltage level in Volts');
elseif (count==1 && seq ==3)
    figure;
    plot(period_noise_effect,input_Signal_1);
    title('BFSK AFTER ADDING NOISE');
    xlabel('Time in seconds');
    ylabel('Voltage level in Volts');
elseif (count==1 && seq ==4)
    figure;
    plot(period_noise_effect,input_Signal_1);
    title('BFSK AFTER PASSING THROUGH MATCHED FILTER BLOCK 1');
    xlabel('Time in seconds');
    ylabel('Voltage level in Volts');
    figure;
    plot(period_noise_effect,input_Signal_2);
    title('BFSK AFTER PASSING THROUGH MATCHED FILTER BLOCK 2');
    xlabel('Time in seconds');
    ylabel('Voltage level in Volts');
elseif seq ==5
    figure;
    hold on;
    plot(Signal_To_Noise_Ratio,(input_Signal_1));
    hold on;
    plot(Signal_To_Noise_Ratio,(input_Signal_2));
    hold on;
    plot(Signal_To_Noise_Ratio,(input_Signal_3));
    hold on;
    plot(Signal_To_Noise_Ratio,(input_Signal_4));
    title('Average and Theoretical BER for BPSK and BFSK across SNR range');
    xlabel('Signal to noise ratio in DB');
    ylabel('BER');
    hold off;
    set(gca,'yscale','log')
    grid
    legend('PracBPSK','TheoBPSK','PracBFSK','TheoBFSK');
end
end

