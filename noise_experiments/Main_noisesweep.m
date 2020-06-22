close all;clear all;clc
%% Runing script SVR vs LS interpolation

az_theta=[10 30]*pi/180; %DOA’s of signals in rad.
az_theta_D = az_theta*180/pi;
P=[1 1 1]; %Incoming signal power
N= 200; %Number of data points
lambda = 2;%Wavelength
d= 0.5*lambda; %Distance between elements in wavelength
noise_var= 10.^(linspace(-10,5,20)/10); %Variance of noise
m=length(az_theta); %Number of emitter sources
search_angles=(-90:1:90); %Azimuth search vector
deviation= 5;%Deviation coefficient 
sigma = d^2;
iterations = 100;%Number of runs per sweep 
L = 10;%number of sensors
squared_error_ss_test1 = zeros(1,3*m,iterations,length(noise_var));
 
  for i= 1: length(noise_var)

     for Iter=1:iterations
        
        [positions_x_nu,positions_x_u] = sensor_locations(d,deviation,L); %fetching positions 
        [X_nu,noise_variance] = signal_gen(positions_x_nu,L,lambda,az_theta,N,noise_var(i),positions_x_u);%fetching signal and noise variance
       
 
        DOA_svr =  SVR_intp_comp(N,X_nu,positions_x_nu,d,sigma,m);%SVR interpolated 
        DOA_Freidlander = LS_intp(N,lambda,positions_x_nu,d,X_nu,positions_x_u,m,noise_variance,L);%LS interpolated 
        DOA_nu = nonuniform_DOA(X_nu,N,m,d); %non uniform DOA
        data_matrix_ss_test1 = [DOA_svr DOA_Freidlander DOA_nu];%data matrix
        squared_error_ss_test1(:,:,Iter,i)=(data_matrix_ss_test1 - [sort(az_theta_D) sort(az_theta_D) sort(az_theta_D)]).^2; %squared error
        MSE_noise_ex7 = mean(squared_error_ss_test1,3);%MSE
        %Plotcodes_noisesweep
        %drawnow
        
     end
     
  end
 

%save('MSE_noise_ex7')