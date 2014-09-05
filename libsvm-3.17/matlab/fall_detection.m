%% Fall detetion algorithm


tw = 5*freq;  %sliding window
step_t = ceil(tw/5); %step time
detection = zeros(modacc_l,1); % what it draws in red on the plot if there s a detection


for i = 6000*freq:step_t :modacc_l - tw % seconds when to start
    clc
    test = modacc(i:i + tw -1 );
    
    
    if( svmpredict(1,test', svm_model) == 1)
    
        % yeao! fall detected!
        detection(i:i+tw,1) = 10;        
        
    end
    
end


plot(modacc,'g')
hold on
plot(detection, 'r');