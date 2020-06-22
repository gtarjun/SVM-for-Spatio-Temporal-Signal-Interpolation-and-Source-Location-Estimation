
%%Plot codes 

 load('MSE_noise_eu2')
MSE_noise_m_eu2=squeeze(MSE_noise_eu2)';
svr_performance = (MSE_noise_m_eu2(:,1) + MSE_noise_m_eu2(:,2))/2;
%svr_performance = smoothdata(svr_performance);
ls_performance = (MSE_noise_m_eu2(:,3) + MSE_noise_m_eu2(:,4))/2;
%ls_performance=smoothdata(ls_performance);
nu_performance = (MSE_noise_m_eu2(:,5) + MSE_noise_m_eu2(:,6))/2;
%nu_performance = smoothdata(nu_performance);
x_axis = 10*log10(1./noise_var);

plot(3)
plot(x_axis,10*log10(svr_performance),'k-','linewidth',2)
hold on
plot(x_axis,10*log10(ls_performance),'k--','linewidth',2)
hold on
plot(x_axis,10*log10(nu_performance),'k:','linewidth',2)


%grid on
set(gca,'FontSize',20)
xlabel('SNR (dB)')
ylabel('MSE (dB)')
legend('SVR Intp','LS Intp','Non-uniform')

hold off