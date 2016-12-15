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


% MEDIA CON SIGNIFICACION 
hhh=figure; 
h=errorbar([1:12],_mediaXsujeto, _stdXsujeto,'*c');
set (h, "linewidth", 3);
hh=ylabel("% of cooperation");set(hh, "fontsize", 14);
hh=title("Cooperation Mean");set(hh, "fontsize", 14);
hold on
axis ("tic[yz]", "labely[xyz]");
bar([1:12],_mediaXsujeto);
h2=plot([1:12],_criterio*ones(1,12),'--r');
set (h2, "linewidth", 3);
plot([1:12],.5*ones(1,12),'--k');
legend("SEM","MEAN","half",0);
t=text([1:12]-0.25, .1*ones(1,12), _txtSujetos(:,:),"fontsize",13);
hh=xlabel("Subjects");set(hh, "fontsize", 14);
axis([0 13 0 1.15])
aux22=_mediaXsujeto'+_stdXsujeto'+0.05;
t=text(-0.15+[1:length(aux22)]', aux22, {"* "; "  ";"* ";"  ";"  "; "  ";"* ";"* ";"* ";"* "; "* ";"* "},"fontsize",20);
%t=text([1:(4-1)/(length(_sujetosCooperadores)-1):4], -.08*ones(1,length(_sujetosCooperadores)), _txtSujetos(_sujetosCooperadores,:),"fontsize",14);
hold off
name=strcat("figura_iPD_1_2_9s_13s/fig_finales/cooperation_mean_with_significant",".png");
print(hhh, name);
