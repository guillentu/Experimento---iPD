%% Se calcula la Bondad de ajuste respecto de una poblacion aleatoria con 50% de prob de cooperara.
% Se calcula el chi2 para cada frecuencia de cooperacion dado cada estado
% Se utiliza la media en cooperacion dado cada estado a lo largo de los ultimos 10 experiemtnso

frec_teo=100*[.5];
chi_2_xSujetos=zeros(1,_nSujetos);
for i=1:_nSujetos
  chi_2_xSujetos(i)=sum((100.*probEleccion(:,1,i)-frec_teo).^2./frec_teo);
endfor
aux=probEleccion;
aux(:,1,1)=[.5;.55; .5; .5];
aux(:,1,2)=[.5;.5; .55; .5];
aux(:,1,3)=[.5;.5; .5; .55];
aux(:,1,4)=[.55;.5; .5; .5];
aux(:,1,5)=[.55;.55; .55; .55];
aux(:,1,6)=[.55;.55; .5; .5];
aux(:,1,7)=[.5;.5; .55; .55];
aux(:,1,8)=[.55;.55; .5; .5];
aux(:,1,9)=[.5;.55; .55; .55];
aux(:,1,10)=[.55;.55; .55; .5];
aux(:,1,11)=[.55;.55; .55; .5];
aux(:,1,12)=[.60;.55; .55; .60];
for i=1:_nSujetos
  chi_2_xSujetos(i)=sum((100.*aux(:,1,i)-frec_teo).^2./frec_teo);
endfor

pasan=zeros(1,_nSujetos);
pasanBon=zeros(1,_nSujetos);
% Sin correccion de Bonferroni
for i=1:_nSujetos
  freedom=3;% estados -1
  if (1-chi2cdf(chi_2_xSujetos(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasan(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Con Correccion de Bonferroni
for i=1:_nSujetos
  freedom=3;%
  if (1-chi2cdf(chi_2_xSujetos(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor

pasan
pasanBon

%_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop
%chi_2_nocoop = sum(aa(:,1,_sujetosNocooperadores),3);