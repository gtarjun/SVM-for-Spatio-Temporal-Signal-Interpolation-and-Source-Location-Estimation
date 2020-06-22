
%%Plot codes 

load('MSE_ss_1')
MSE_ss_m_1 =squeeze(MSE_ss_1)';
svr_performance = (MSE_ss_m_1(:,1) + MSE_ss_m_1(:,2))/2;
ls_performance = (MSE_ss_m_1(:,3) + MSE_ss_m_1(:,4))/2;
nu_performance = (MSE_ss_m_1(:,5) + MSE_ss_m_1(:,6))/2;
x_axis = L;


plot(x_axis,10*log10(svr_performance),'k--')
hold on
plot(x_axis,10*log10(ls_performance),'b--')
hold on
plot(x_axis,10*log10(nu_performance),'r--')

hold off

xlabel('Number of elements')
ylabel('MSE (dB)')
legend('SVR Intp','LS Intp','Non-uniform')