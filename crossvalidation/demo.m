%generate a matrix of  random numbers of dimension msize x msize
rmatrix=rand(msize);

%create an output file name based on msize and write the random matrix to it
[~,hname]=system('hostname');
fname=num2str(msize);
process=num2str(pid);
fname=strcat(hname,'.',process,'.',fname,'.csv');
csvwrite(fname,rmatrix);
quit
