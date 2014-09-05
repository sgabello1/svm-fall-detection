
close all;
%clear all;
clc;

g=9.80665; %m/s^2

% test file
%FileName='AD020001.TXT';
%FileName='AD010001a.TXT';
%FileName='Caduta10kg13fc16g13b110Hz1.TXT';
FileName='DATA0006_Klog.TXT';
%FileName='G0700023.TXT';
%FileName='Caduta10kg13fc16g13b100Hz1.TXT';


%for training
%FileName='AD010002.TXT';

a=importdata(FileName,',');

g_scale=16; %g
bit=13;         %full scale = 13bit
freq=128*2; %Hz

%-------------------------------------------------------------------------

lunghezza=size(a.data);

 coef_g=(2*g_scale)/2^bit;
% a=a*coef_g;

coef_time=1/freq;
x_vet=1:lunghezza(1);
x_vet=x_vet*coef_time;

m= 64; % 20 kg
FArope=12; %kN
lrope=4.5; %m
hfall=6.1; %m
fc=hfall/lrope;

a.data=a.data.*coef_g;

fileLength=size(a.data);

modacc3=sqrt( a.data(:,1).^2 + a.data(:,2).^2 + a.data(:,3).^2);   


n_filtro=2;
a_filtro=zeros(n_filtro,1);
a_filtro(1)=n_filtro;
b_filtro=ones(n_filtro,1);
modacc3_filt=filtfilt(b_filtro,a_filtro,modacc3);

plot(x_vet,modacc3)
hold on
plot(x_vet,modacc3_filt,'r')

% % for bad examples
% 
% FileName2='Log_AT_20131124.TXT';
% 
% b=importdata(FileName2,',');
% 
% lunghezza2=size(b.data);
% 
% coef_time=1/freq;
% x_vet2=1:lunghezza2(1);
% x_vet2=x_vet2*coef_time;
% 
% 
% b=importdata(FileName2,',');
% 
% b.data=b.data.*coef_g;
% 
% 
% modacc2=sqrt( b.data(:,1).^2 + b.data(:,2).^2 + b.data(:,3).^2);   
% 
% figure
% 
% plot(x_vet2,modacc2)
% 
