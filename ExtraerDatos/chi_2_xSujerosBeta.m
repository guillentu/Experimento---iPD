%% Se calcula la Bondad de ajuste respecto de una poblacion aleatoria con 50% de prob de cooperara.
% Se calcula el chi2 para cada frecuencia de cooperacion dado cada estado
% Se utiliza la media en cooperacion dado cada estado a lo largo de los ultimos 10 experiemtnso
%for ee=[30 35 40 45 50 55 60 65 70 75 80 85 90 95]
  frec_teo=100*[.45];
  chi_2_xSujetos=zeros(1,_nSujetos);
%  for i=1:_nSujetos
%    chi_2_xSujetos(i)=sum((100.*probEleccion(:,1,i)-frec_teo).^2./frec_teo);
%  endfor
%  aux=probEleccion;
  aux(:,1,1)=[.5;.5];
  aux(:,1,2)=[.5;.55];
  aux(:,1,3)=[.5;.6];
  aux(:,1,4)=[.5;.65];
  aux(:,1,5)=[.6;.65];
  aux(:,1,6)=[.65;.65];
  aux(:,1,7)=[.7;.7];
  aux(:,1,8)=[.5;.45];
  aux(:,1,9)=[.5;.4];
  aux(:,1,10)=[.5;.35];
  aux(:,1,11)=[.5;.30];
  aux(:,1,12)=[.4;.4];
  for i=1:_nSujetos
    chi_2_xSujetos(i)=sum((100.*aux(:,1,i)-frec_teo).^2./frec_teo);
    aux(:,1,i);
  endfor
  frec_teo=sum(sum(QQTot))(:)/4;

  
  
  %  frec_teo=100*[.5];
%  for i=1:_nSujetos
%    chi_2_xSujetos(i)=sum((100*QQTotmarkov(:,1,i)-frec_teo).^2./frec_teo);
%  endfor
  
  pasan=zeros(1,_nSujetos);
  pasanBon=zeros(1,_nSujetos);
  % Sin correccion de Bonferroni
  for i=1:_nSujetos
    freedom=1;% estados -1
    if (1-chi2cdf(chi_2_xSujetos(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
      pasan(i)=1;% Se rechaza la HIP NULA
    endif
  endfor
  % Con Correccion de Bonferroni
  for i=1:_nSujetos
    freedom=1;%
    if (1-chi2cdf(chi_2_xSujetos(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
      pasanBon(i)=1;% Se rechaza la HIP NULA
    endif
  endfor

  pasan
  pasanBon
  aa=[1:_nSujetos];
  aa(pasan==1)
%endfor