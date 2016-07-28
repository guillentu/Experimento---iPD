aa=zeros(4,_nSujetos);
frec_teo=zeros(4,1,_nSujetos);
frec_teo= sum(probxExpTotal(:,:,:),2)./2;%     Se suman y div x 2 todos las eleciones luego de T
% componentes de la sumatoria  (Oi-Ei)^2/Ei
aa=(probxExpTotal(:,1,:)-frec_teo).^2./frec_teo;
% sumatoria del Chi 2
chi_2_coop = zeros(4,1);% sum(aa([1 2 4],1,_sujetosCooperadores),3)
chi_2_coop(1) = sum(aa(1,1,_sujetosCooperadores),3);
chi_2_coop(2) = sum(aa(2,1,_sujetosCooperadores),3);
chi_2_coop(3) = sum(aa(3,1,_sujetosCooperadores([2:4 6])),3); % SALVANDO ESTADOS DONDE NUCA SE REALIZARON ELECCIONES
chi_2_coop(4) = sum(aa(4,1,_sujetosCooperadores),3);
chi_2_coop
_sujetosNocooperadores=complemento(_sujetosCooperadores,_nSujetos);
chi_2_nocoop = sum(aa(:,1,_sujetosNocooperadores),3)

pasanCoop=zeros(1,4);
pasanNocoop=zeros(1,4);

for i=1:4
  if (1-chi2cdf(chi_2_coop(i),5))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanCoop(i)=1;
  endif
endfor

for i=1:4
  if (1-chi2cdf(chi_2_nocoop(i),5))<0.05 %Si es menor significa que las muestras no provienen de una población aleatoria
    pasanNocoop(i)=1;
  endif
endfor

% Da casi todo significativo, indicando que las probabilidades de eleción no provienen de problaciones aleatorias.
