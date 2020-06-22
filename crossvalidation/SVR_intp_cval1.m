%addpath('/users/ceodspsp/CARC_Work/User_support/Arjun/Working_Folder/libsvm-3.23/matlab/')
%addpath(genpath('/users/arjun/wheeler-scratch/Working_Folder/libsvm-3.22/libsvm-3.22/matlab/'))
%addpath(genpath('/users/ceodspsp/CARC_Work/User_support/Arjun/Working_Folder/libsvm-3.22/libsvm-3.22/matlab/'))

function [DOA_svr] = SVR_intp_cval1(N,X_nu,positions_x_nu,d,m,sigma,C)
%addpath(genpath('/users/arjun/wheeler-scratch/Working_Folder/libsvm-3.22/libsvm-3.22/matlab/'))

options=sprintf('-s 3 -t 4 -c %f -p 0.1 -q 1',2^C);

sigma=2^sigma;

P=repmat(positions_x_nu,length(positions_x_nu),1);
D=P-P';
K=exp(-D.*D/sigma);
K=[K 0*K;0*K K];
K=K+0.1*eye(size(K));
Pu=repmat(d*[0:length(positions_x_nu)-1],length(positions_x_nu),1);
Du=P-Pu';
Ktest=exp(-Du.*Du/sigma);
Ktest=[Ktest 0*Ktest;0*Ktest Ktest];
N_blocks=size(X_nu,2);
size_K=size(K);
KT=zeros(size_K*N_blocks);
KT_test=zeros(size_K*N_blocks);

for i=1:N_blocks
    i_pos=(i-1)*size_K+1;
    f_pos=(i-1)*size_K+size_K;
    KT(i_pos:f_pos,i_pos:f_pos)=K;
    KT_test(i_pos:f_pos,i_pos:f_pos)=Ktest;
end
Y=[real(X_nu(:));imag(X_nu(:))];

model = svmtrain(Y, [[1:length(Y)]' KT], options);
Y_=svmpredict(zeros(size(Y)), [[1:length(Y)]' KT_test], model, '-q 0');
Z=Y_([1:end/2],:)+1j*Y_([end/2+1:end],:);
Z=reshape(Z,size(X_nu,1),size(X_nu,2));
%X_nu_svr = Z;
% Rxx_svr = Z*Z'/N;
% DOA_svr = sort(rootmusicdoa(Rxx_svr,m));
DOA_svr = sort(2*(180*asin((rootmusic(Z*Z',2))/2/pi/d)/pi))';
end
