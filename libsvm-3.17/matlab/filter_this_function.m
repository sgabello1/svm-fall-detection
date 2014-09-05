function [modacc_filt] = filter_this_function (modacc)

n_filtro=10;
a_filtro=zeros(n_filtro,1);
a_filtro(1)=n_filtro;
b_filtro=ones(n_filtro,1);
modacc_filt=filtfilt(b_filtro,a_filtro,modacc);

plot(modacc)
hold on
plot(modacc_filt,'r')

end
