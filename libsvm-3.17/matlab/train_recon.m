%%implementation of a fall detection usign methods
clc
clear

ts = 10^-2 ;                         %sampling time 1/ts [s]
tw = 2/ts;                      %time window


nrows = 6;
ncolumns = tw;
noise = 1;
dist = 1;

% heights = [5, 7 , 10, 15, 1 , 2];
% amaxs = [7, 10, 12, 5, 8, 15];
% bad_times = [1, 0.5 , 20, 25, 1 , 2];
% bad_amaxs = [7, 10, 12, 5, 8, 15];
%training

%random
heights =  (20).*rand(nrows,1);                   %[m] height fall
amaxs = 5 + (10).*rand(nrows,1);

bad_times = (9).*rand(nrows,1); 
bad_amaxs = 5 + (10).*rand(nrows,1);
good_examples = zeros([nrows,ncolumns]);

for ii=1:nrows

good_examples(ii,:) = fall_synth_func (heights(ii),amaxs(ii),ts,tw,noise,dist);                %build examples matrix

end

bad_examples = zeros([nrows,ncolumns]);

for jj=1:nrows

bad_examples(jj,:) = nofall_synth_func (bad_times(jj),bad_amaxs(jj),ts,tw,noise);        %build bad examples matrix

end

%labels
god_labels = ones(nrows, 1);
bad_labels = zeros(nrows, 1);

labels = [god_labels;bad_labels];
examples = [good_examples ; bad_examples];

svm_model = svmtrain(labels, examples, '-s 0 -t 0 -c 100');