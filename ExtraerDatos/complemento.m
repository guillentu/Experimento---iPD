function pp = complemento(_grupo,_tamano)
pp=[];
for i=1:_tamano
  if ~length(find(i==_grupo))
    pp=[pp i];
  endif
endfor

