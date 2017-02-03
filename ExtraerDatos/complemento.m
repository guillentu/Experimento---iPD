function pp = complemento(_grupo,_tamano)
pp=[];
for i=_tamano
  if ~length(find(i==_grupo))
    pp=[pp i];
  endif
endfor

