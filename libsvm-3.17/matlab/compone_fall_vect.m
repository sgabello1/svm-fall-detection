%%first implementation of a fall detection
clc
% clear

ts = 10^-2 ;                         %sampling time 1/ts [s]
tw    = 10/ts;                      %time window

%training
heights = [5, 7 , 10, 15, 1 , 2];
amaxs = [7, 10, 12, 5, 8, 15];
bad_heights = [5, 7 , 10, 15, 1 , 2];
bad_amaxs = [1, 0.5, 15, 12, 3, 5];
nrows = 6;
ncolumns = tw;

good_examples = zeros([nrows,ncolumns]);

for ii=1:nrows

h = heights(ii);                    %[m] height fall
amax = amaxs(ii);                   %[g] from 5 to 15
fall_synth                % outputs the fall vect 

good_examples(ii,:) = y;        %build examples matrix

%initialize
x = 0;
y = 0;
xbef = 0;
xfree = 0;
xamax = 0;
xc = 0;
xaft = 0;
ybef = 0;
yfree = 0;
yamax = 0;
yc = 0;
yaft = 0; 
end

bad_examples = zeros([nrows,ncolumns]);

for jj=1:nrows

h = bad_heights(jj);                    %[m] height fall
amax = bad_amaxs(jj);                   %[g] from 5 to 15
nofall_synth                % outputs the bad example fall vect 

bad_examples(jj,:) = by;        %build examples matrix

%initialize
bx = 0;
by = 0;
xbef = 0;
xfree = 0;
xamax = 0;
xc = 0;
xaft = 0;
ybef = 0;
yfree = 0;
yamax = 0;
yc = 0;
yaft = 0; 
end

%labels
god_labels = ones(nrows, 1);
bad_labels = zeros(nrows, 1);

labels = [god_labels;bad_labels];
examples = [good_examples ; bad_examples];
