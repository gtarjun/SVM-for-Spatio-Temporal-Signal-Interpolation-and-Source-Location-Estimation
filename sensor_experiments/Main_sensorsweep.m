close all;clear all;clc 
addpath('L:\Cognitive Radio\SVM formulation\libsvm-3.22\libsvm-3.22\matlab') %add your path to libsvm
%%%%%%%%%%%%%%%%%%%%%%%%%
az_theta=[10 25]*pi/180; %DOA’s of signals in rad.
az_theta_D = az_theta*180/pi;
P=[1 1 1]; %Incoming signal power
N=200; %Number of data points
lambda = 2;%Wavelength
d=0.5*lambda; %Distance between elements in wavelength
noise_var= 0.5; %Variance of noise
m=length(az_theta); %Number of emitter sources
search_angles=(-90:1:90); %Azimuth search vector
deviation= 5; %Deviation coefficient 
sigma = d^2;
iterations = 5;%Number of runs per sweep 
L = 5:6;
squared_error_ss = zeros(1,3*m,iterations,length(L));
noise_vari = 0.5;
 
counter = 1
  for i= 1: length(L)

     for Iter=1:iterations
        
        [positions_x_nu,positions_x_u] = sensor_locations(d,deviation,L(i));
        [X_nu,noise_variance] = signal_gen(positions_x_nu,L(i),lambda,az_theta,N,noise_var,positions_x_u);
       
 
        DOA_svr =  SVR_intp_comp(N,X_nu,positions_x_nu,d,sigma,m,noise_variance);
        DOA_Freidlander = LS_intp(N,lambda,positions_x_nu,d,X_nu,positions_x_u,m,noise_variance,L(i),noise_vari);
        DOA_nu = nonuniform_DOA(X_nu,N,m,d);
        data_matrix_ss = [DOA_svr DOA_Freidlander DOA_nu];
        squared_error_ss(:,:,Iter,i)=(data_matrix_ss - [sort(az_theta_D) sort(az_theta_D) sort(az_theta_D)]).^2;
        
        
     end
   MSE_ss_1 = mean(squared_error_ss,3);
   counter = counter+1
  end
 

%save('MSE_ss_1')