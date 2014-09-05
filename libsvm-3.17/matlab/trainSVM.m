%% Gabriele Ermacora  Training SVM

% acquire samples for training
% put a threshold and automatically detect the fall

clc

freq = 256;
tw = 5*freq;
threshold = 12; %g
modacc_l = size(modacc);
stop_acq = 100*freq; % stop time of acq
dt = 5*freq;
n = 1; % number of samples acquired
samples_at = 0 ; % at what index the sample is acquired
samples = zeros(70,dt);
last_i = 0 ;

n_good_samp = 6; 
n_bad_samp = 6;

for i = 1:modacc_l(1) %- 2
    
    if modacc_filt(i) > threshold && (i - last_i) > dt
        
        start = i - dt/2;
        finish = i + dt/2;
        samples(n,:) = modacc_filt(start : finish-1);
        samples_at(n) = i -dt/2;
        n = n + 1;
        last_i = i;
        
    end
end
% 
% ind_good = [1.169*10^5, 1.991*10^5 ];
% samples(7,:) = a_mod(1.169*10^5 : 1.169*10^5+tw-1);
% samples(8,:) = a_mod(1.991*10^5 : 1.991*10^5+tw-1);

% train SVM

good_samp = samples(1:n_good_samp,:);
bad_samp = zeros(n_bad_samp,dt);

%bad samples

ind_bad = [10^3, 10^4, 4.592*10^5, 4.3*10^5, 5*10^5, 8.087*10^5, 1.112*10^6, 1.139*10^6, 1.177*10^6, 1.191*10^6,  1.55*10^6, 1.56*10^6, 1.57*10^6];

for j = 1: n_bad_samp 
    
    bad_samp(j,:) = modacc2(ind_bad(j) : ind_bad(j) +tw -1); 
    
end

instance_mat = [good_samp ; bad_samp];

good_labs = ones(n_good_samp,1);
bad_labs = zeros(n_bad_samp,1);
labels = [good_labs ; bad_labs];

%svm_model = svmtrain(labels,instance_mat); % this work almost fine
svm_model = svmtrain(labels,instance_mat,'c 100 -t 2');