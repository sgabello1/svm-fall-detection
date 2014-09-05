% bad example of afall synthtizer
% clc
% clear
function [by] = nofall_synth_f(dt,amax,ts,tw,nz)
g = 9.81;                  %[m/s^2]

%noise
dd =  nz + (-2*nz).*rand(1,tw)*sin(2*pi*rand(1,1));
% Fall parameters
tfree = 0   ;         %free fall [ms]
tarr = dt/ts;     %bump time [ms]

tfree_rnd = uint64(tfree);

tfa   = uint64(tfree + tarr);               %time free and after
td    = uint64((tw - tfa)/2);                   %delta time
tbef  = td;                                 %[ms]   before fall
taft = uint64(tw - tbef - tfa );               %[ms]   after fall



                         %[ms]
% A
% |        <-tarr->
% |        amax,tb
% |          /\
% |tbef(1)  /  \   (2)
% |--------/    \---------------------
% |    ta           tc           taft
% |----------------------------------->
%           tfree                               
% Fill 

ybef= ones([1,tbef]);

ta = tbef + tfree;
tb = ta + tarr/2;
tc = ta + tarr;

yfree = zeros([1,tfree_rnd]);


for i=1:tarr/2
   yamax(i) = (2*(amax-1)/tarr)*i + 1; 
end

for i=1: tarr/2
    yc(i) = (-2*(amax-1)/tarr)*i + amax;
end
 if tarr/2 <= 1
     yamax  = 1;
     yc = 1;
 end
[xxx aft] = size([ybef yfree yamax yc]);
diff = tw - aft;
if diff >= tw
    diff = tw
end
yaft = ones([1,diff]);

by = [ybef yfree yamax yc yaft];
by = by(:,1:tw);
by = by + dd;
%size(y)
% figure
% plot(by)
end