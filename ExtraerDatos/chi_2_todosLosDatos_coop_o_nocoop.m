_stdSujetosCoop2=zeros(4,1);
_todoJuntoCoop=[];
_todoJuntoNocoop=[];
_todosFallas=[];_todosFallasNocoop=[];
for i=_sujetosCooperadores
  ultimo=expXsuj(i);
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    aux22=(probxExp.(indiceSujeto(i,:)).(indice(j+1,:))./sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2))(:,1);
    _todoJuntoCoop=[_todoJuntoCoop aux22];
    if sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)))!=0
      _todosFallas=[_todosFallas 1];
    else
      _todosFallas=[_todosFallas 0];
    endif
  endfor
endfor
for i=_sujetosNocooperadores
  ultimo=expXsuj(i);
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    aux23=(probxExp.(indiceSujeto(i,:)).(indice(j+1,:))./sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2))(:,1);
    _todoJuntoNocoop=[_todoJuntoNocoop aux23];
    if sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)))!=0
      _todosFallasNocoop=[_todosFallasNocoop 1];
    else
      _todosFallasNocoop=[_todosFallasNocoop 0];
    endif
  endfor
endfor
_stdSujetosCoop2=std(_todoJuntoCoop,0,2);
_stdSujetosNocoop2=std(_todoJuntoNocoop,0,2);
_rango=1;

frec_teo=[_rango*.5];%     Se suman y div x 2 todos las eleciones luego de T

% componentes de la sumatoria  (Oi-Ei)^2/Ei
aaT=(_rango*_todoJuntoCoop(1,find(~isnan(_todoJuntoCoop(1,:))))-frec_teo).^2./frec_teo;
aaR=(_rango*_todoJuntoCoop(2,find(~isnan(_todoJuntoCoop(2,:))))-frec_teo).^2./frec_teo;
aaP=(_rango*_todoJuntoCoop(3,find(~isnan(_todoJuntoCoop(3,:))))-frec_teo).^2./frec_teo;
aaS=(_rango*_todoJuntoCoop(4,find(~isnan(_todoJuntoCoop(4,:))))-frec_teo).^2./frec_teo;
aaTnocoop=(_rango*_todoJuntoNocoop(1,find(~isnan(_todoJuntoNocoop(1,:))))-frec_teo).^2./frec_teo;
aaRnocoop=(_rango*_todoJuntoNocoop(2,find(~isnan(_todoJuntoNocoop(2,:))))-frec_teo).^2./frec_teo;
aaPnocoop=(_rango*_todoJuntoNocoop(3,find(~isnan(_todoJuntoNocoop(3,:))))-frec_teo).^2./frec_teo;
aaSnocoop=(_rango*_todoJuntoNocoop(4,find(~isnan(_todoJuntoNocoop(4,:))))-frec_teo).^2./frec_teo;

% sumatoria del Chi 2
chi_2_coop = zeros(4,1);% sum(aa([1 2 4],1,_sujetosCooperadores),3)
chi_2_nocoop = zeros(4,1);
for i=1:4
  aux24=(_rango*_todoJuntoCoop(i,find(~isnan(_todoJuntoCoop(i,:))))-frec_teo).^2./frec_teo;;
  aux25=(_rango*_todoJuntoNocoop(i,find(~isnan(_todoJuntoNocoop(i,:))))-frec_teo).^2./frec_teo;
  chi_2_coop(i) = sum(aux24);
  chi_2_nocoop(i) = sum(aux25);
endfor

%%%%%%%%%%%%%%%%%%%%%%%%
%% G-test G=2*sum(Oi*ln(Oi/Ei))
%chi_2_coop2 = zeros(4,1);% sum(aa([1 2 4],1,_sujetosCooperadores),3)
%chi_2_nocoop2 = zeros(4,1);
%for i=1:4
%  Oi=_rango*_todoJuntoCoop(i,find(~isnan(_todoJuntoCoop(i,:))));
%  Ei=frec_teo;
%  chi_2_coop2(i) = 2*sum(Oi.*log(Oi./Ei));
%  Oi=_rango*_todoJuntoNocoop(i,find(~isnan(_todoJuntoNocoop(i,:))));
%  chi_2_nocoop2(i) = 2*sum(Oi.*log(Oi./Ei));
%endfor
%%%%%%%%%%%%%%%%%%%%%%%%
pasanCoop=zeros(1,4);
pasanNocoop=zeros(1,4);
pasanCoopBon=zeros(1,4);
pasanNocoopBon=zeros(1,4);
% Sin correccion de Bonferroni
for i=1:4
  freedom=length(find(~isnan(_todoJuntoCoop(i,:))))-1;
  if (1-chi2cdf(chi_2_coop(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Con Correccion de Bonferroni
for i=1:4
  freedom=length(find(~isnan(_todoJuntoCoop(i,:))))-1;
  if (1-chi2cdf(chi_2_coop(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Sin correccion de Bonferroni
for i=1:4
  freedom=length(find(~isnan(_todoJuntoNocoop(i,:))))-1;
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoop(i)=1;% Se rechaza la HIP NULA
  endif
endfor
% Con Correccion de Bonferroni
for i=1:4
  freedom=length(find(~isnan(_todoJuntoNocoop(i,:))))-1;
  if (1-chi2cdf(chi_2_nocoop(i),freedom))<(0.05/(freedom+1)) %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoopBon(i)=1;% Se rechaza la HIP NULA
  endif
endfor



%_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos); % Obtiene los indices de los no coop
%chi_2_nocoop = sum(aa(:,1,_sujetosNocooperadores),3);