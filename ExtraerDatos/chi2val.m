function [_chi2value]=chi2val(alpha,df)
%------------------------------------------------------------------------------
% --- Esta funcion calcula el valor CHI2 en base a la probabilidad y Grado de
% Libertad
%----------BUSCANDO el valor de chi2 en base al alpha y al DF
_chi2value=0;
while (1-chi2cdf(_chi2value,df)>alpha)
  
  _chi2value+=0.1;
endwhile
_chi2value=_chi2value-0.5;
while (1-chi2cdf(_chi2value,df)>alpha)
  
  _chi2value+=0.001;
endwhile