% fall synthtizer
% clc
% clear

%h hegiht
%a acceleration
%ts sample time
%tw window time
%nz noise
%dist_on distortion ON/OFF if it s 0 no distortion if it s 1 random(0,tw)

function [y] = fall_synth_f(h,amax,ts,tw,nz,dist_on)
g = 9.81;                  %[m/s^2]
%h = 10;                    %[m] height fall
%amax = 12;                  %[g] from 5 to 15

%noise
% dd =  nz + (-2*nz).*rand(1,tw)*sin(2*pi*rand(1,1));
dd =  nz + (-2*nz).*rand(1,tw);

%divide the interval in 2 if dist_on ON or in []
lt = tw*ts;
div = 1 + dist_on*(lt/2-1).*rand(1,1);

% Fall parameters
%ts = 10^-2                          %sampling time 1/ts [s]
tfree = sqrt((2*h)/g)/ts   ;         %free fall [ms]
tarr = 2*sqrt((2*h)/amax)/ts;     %bump time [ms]

tfree_rnd = uint64(tfree);

tfa   = uint64(tfree + tarr);               %time free and after
%tw    = 10/ts;                      %time window
td    = uint64((tw - tfa)/div);                   %delta time
tbef  = td;               %[ms]   before fall
taft = uint64(tw - tbef - tfa );               %[ms]   after fall



                         %[ms]
% A
% |                <-tarr->
% |                amax,tb
% |                   /\
% |     tbef    (1)  /  \   (2)
% |-----|           /    \  |------------------
% |     |       ta /      \ |tc           taft
% |-----|---------/--------\|------------------>
%           tfree                               
% Fill 

ybef= ones([1,tbef]);

ta = tbef + tfree;
tb = ta + tarr/2;
tc = ta + tarr;

yfree = zeros([1,tfree_rnd]);


for i=1:tarr/2
   yamax(i) = (2*amax/tarr)*i; 
end

for i=1: tarr/2
    yc(i) = (-2*amax/tarr)*i + amax;
end
 
[xxx aft] = size([ybef yfree yamax yc]);
diff = tw - aft;
yaft = ones([1,diff]);

y = [ybef yfree yamax yc yaft] + dd;
%size(y)
% figure
% plot(y)
end