%% Se calcula la Bondad de ajuste de prob de cooperara dado cada estado respecto a una 
% poblacion aleatoria con 50% .
% Se utiliza la media en cooperacion dado cada estado a lo largo de las ultimas 10 
% sesiones
% CORRER ...matrizDeMarkov.m
  frec_teo=100*[.5];
  chi_2_xSujetos_probCdadoX=zeros(1,_nSujetos);
  
  for i=1:_nSujetos                           %   | cuatro componentes
    chi_2_xSujetos_probCdadoX(i)=sum((100*probEleccionC(:,i)-frec_teo).^2./frec_teo); % cuatro
  endfor
  
  pasan=zeros(1,_nSujetos);
  pasanBon=zeros(1,_nSujetos);
  freedom=length(probEleccionC(:,1))-1;
  % Sin correccion de Bonferroni
  for i=1:_nSujetos
    (1-chi2cdf(chi_2_xSujetos_probCdadoX(i),freedom))
    if (1-chi2cdf(chi_2_xSujetos_probCdadoX(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
      pasan(i)=1;% Se rechaza la HIP NULA
    endif
  endfor
  % Con Correccion de Bonferroni
  for i=1:_nSujetos
    if (1-chi2cdf(chi_2_xSujetos_probCdadoX(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
      pasanBon(i)=1;% Se rechaza la HIP NULA
    endif
  endfor

  pasan
  pasanBon
  aa=[1:_nSujetos];
  aa(pasan==1)
%endfor