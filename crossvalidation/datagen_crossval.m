%clear all;clc
%%Data generation for cross validation
%addpath(genpath('addpath(genpath('/users/arjun/wheeler-scratch/Working_Folder/libsvm-3.22/libsvm-3.22/matlab/'))
addpath('/users/ceodspsp/CARC_Work/User_support/Arjun/Working_Folder/')
addpath('/users/ceodspsp/CARC_Work/User_support/Arjun/Working_Folder/libsvm-3.23/matlab/')
%Attributes
rng('default')
%az_theta=[10 25]*pi/180; %DOA’s of signals in rad.
%az_theta_D = az_theta*180/pi;
P=[1 1 1]; %Incoming signal power
N=50; %Number of data points
lambda = 2;%Wavelength
d=0.5*lambda; %Distance between elements in wavelength
noise_var= 0.5; %Variance of noise
m=2;%length(az_theta); %Number of emitter sources
search_angles=(-90:1:90); %Azimuth search vector
deviation= 5;%Deviation coefficient 
%sigma = d^2;
iterations = 1000;%Number of runs per sweep 
L = 8;
squared_error = zeros(1,1*m,iterations);

%Generating random position once for the entire validation
[positions_x_nu,positions_x_u] = sensor_locations(d,deviation,L); %fetching positions

C=params(1);
sigma=params(2);
index=params(3);

for i = 1:iterations

        
az_theta=randi([-30 30],[1,2])*pi/180; %DOA’s of signals in rad.
az_theta_D = az_theta*180/pi;
m=length(az_theta); %Number of emitter sources

[X_nu,noise_variance] = signal_gen(positions_x_nu,L,lambda,az_theta,N,noise_var,positions_x_u);%fetching signal and noise variance
       
 
DOA_svr =  SVR_intp_cval1(N,X_nu,positions_x_nu,d,m,sigma,C);%SVR interpolated 
 
Squared_Error(:,:,i) = (DOA_svr -sort(az_theta_D)).^2;
%Squared_Error = mean(Squared_Error,3);
%Squared_Error = mean(squared_Error,2);
%data_matrix = [C,sigma,Squared_Error,index];
end 

Squared_Error = mean(Squared_Error,3);
Squared_Error = mean(Squared_Error,2);
data_matrix = [C,sigma,Squared_Error,index];

pause('on')
pause(15)
pause('off')
%fname= crossval_data; %strcat('datagen_crossvali-','C=',num2str(C),'Sigma=',num2str(sigma),'Iterations=',num2str(Iter),'.txt');


dlmwrite('crossval_data_L8.csv',data_matrix,'delimiter',',','-append');

