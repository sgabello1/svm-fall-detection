%SVM pattern recognition 

% clc
% clear
% 
% %create matrix examples and labels
% recon_fall

% better if make it manually
% remember to create matrix examples and labels
% svm_model = svmtrain(labels, examples, '-s 0 -t 0 -c 1');

n_good_ex = 100;
n_bad_ex  = 100;
noise_test = 2;
dist = 1;

test = zeros((n_good_ex + n_bad_ex),tw);
label_test = zeros((n_good_ex + n_bad_ex ),1);

% h_test = [5, 7 , 10, 15, 1 , 2];                    %[m] height fall
% amax_test = [7, 10, 12, 5, 8, 15];

%random
h_test =  (20).*rand(n_good_ex,1);                   %[m] height fall
amax_test = 5 + (10).*rand(n_good_ex,1);

bad_t_test = (9).*rand(n_bad_ex,1); 
bad_amax = 5 + (10).*rand(n_bad_ex,1);

% bad_t_test = [0.1,0.2,0.5,8,20,3];
% bad_amax = [1, -1,10,6,7,14];
% ts = 10^-2   
% tw    = 10/ts;

for a=1:n_good_ex
    test(a,:)=fall_synth_func(h_test(a),amax_test(a),ts,tw,noise_test,dist);
    label_test(a,:) = 1;
end

for b=(n_good_ex + 1):(n_bad_ex + n_good_ex )
    test(b,:)=nofall_synth_func(bad_t_test(b-n_good_ex),bad_amax(b-n_good_ex),ts,tw,noise_test);
end


[predict] = svmpredict(label_test,test, svm_model);