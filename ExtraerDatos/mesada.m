pasan=zeros(1,4);
frec_obs=zeros(4,2,_nSujetos);
for j=1:4 %Estados
  for i=1:_nSujetos
    if sum(probTotalN(j,:,i))!=0
      frec_obs(j,:,i)=probTotalN(j,:,i)./sum(probTotalN(j,:,i));
    endif
  endfor
endfor
_porX=100;
frec_teo= _porX*0.5
% P(c|T) prob
aa=zeros(1,_nSujetos);
for i=_sujetosCooperadores
  aa(i)=(_porX*frec_obs(1,1,i)-frec_teo).^2./frec_teo;
endfor
chi_2_coop = sum(aa(_sujetosCooperadores),3); 
% El chi2cdf(11.0705,5)=0.95 La funcion da P(X2 < x) inverso a la tabla
if (1-chi2cdf(chi_2_coop,5))<0.05 % Con correccion de Bonferroni 0.05/5
  pasan(1)=1;
endif
