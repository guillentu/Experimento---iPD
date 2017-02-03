function dif = friedmanGuille(vals,alpha,bonferroni)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rangos=ranks(vals,1)';
rangos_mean=sum(rangos);
[k N] = size(vals); % N numero de sujetos
k%=4% k numero de clases (estados)
chi_2 = 12/(N*k*(k+1)).*sum(rangos_mean.^2)-3*N*(k+1)

%----------BUSCANDO el valor de chi2 en base al alpha y al DF
if bonferroni==1
  alpha=alpha/N
endif

_chi2value=0;
while (1-chi2cdf(_chi2value,N-1)>alpha)
  _chi2value+=0.01;
endwhile
%----------
% chi_2 es evaluado respecto a la distribución estandar chi2 con k-1 grado de libertad
#classifiers 2 3 4 5 6 7 8 9 10
_vQAlpha= [1.960 2.343 2.569 2.728 2.850 2.949 3.031 3.102 3.164];
if chi_2 > _chi2value % si chi_2 > chi2_tabla(alpha=0.005 -> 14.860) (alpha=0.05 -> 9.488)
                  % De una tabla corregida para N=6 CHI2_0.005_3 = 11.400 y CHI2_0.05_3=7.6
  %se rechaza Ho (hipotesis nula)
  disp("Se rechaza la hipotesis nula: Los estados no son igualmente prob");
  disp("Comparacion por Two Tails Nemenyi");
  
  % Comparaciñon por Two Tails Nemenyi
  q_alpha=_vQAlpha(size(vals,1)-1);%2,569; % alpha=0.05 -> 2,569  bonferroni correction alpha=0.05/N -> 2,394 
                 % Bonferroni's adjustment: Lower the 0.05 to 0.0083333 ->  3.9608 http://www.quantitativeskills.com/sisa/calculations/bonfer.htm
                 % table of bonferroni correction
  %%q_alpha=3.9608;
  
  CD=q_alpha*sqrt((k*(k+1))/(6*N));
  dif=[];
  for i=1:k
    dif(i).diff=find(abs(rangos_mean-rangos_mean(i))>CD);
  end
  %fprintf(': %i\n',)

else
  disp("La hipotesis nula es CORRECTA: Todos los estados son igualmente probables.");
endif

endfunction