%% create a mixed filed with fall and noisy data

clc
clear mixto

ind_nois= [ 1.139*10^6,1.267*10^5, 4.374*10^5, 4.532*10^5, 5.848*10^5, 2.603*10^5,1.053*10^6, 1.531*10^6, 1.614*10^6];
tot = 6;
mixto = 0;

for i=1:tot
    
 %   mixto = [mixto , samples(40-i,:),1 ];
    mixto = [mixto , samples(40-i,:), modacc2(ind_nois(i):ind_nois(i) + 10*tw ,1)',1 ];
    
end

plot(mixto)

