function [detection,n_fall, fall_detected_at] = fall_detector (freq, tw,modacc,svm_model, st_time)

modacc_l = size(modacc);
fall_detected_at = 0 ;
n_fall = 0;
tw = 5*freq;  %sliding window
step_t = ceil(tw/5); %step time
detection = zeros(modacc_l,1); % what it draws in red on the plot if there s a detection


for i = st_time*freq:step_t :modacc_l - tw % seconds when to start
    clc
    test = modacc(i:i + tw -1 );
    
    
    if( svmpredict(1,test', svm_model) == 1)
    
        % yeao! fall detected!
        detection(i:i+tw,1) = 10;  
        n_fall = n_fall +1;
        fall_detected_at(n_fall) = i;
    end
    
end


plot(modacc,'g')
hold on
plot(detection, 'r');


end
