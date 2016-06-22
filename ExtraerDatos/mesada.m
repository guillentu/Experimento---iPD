for i=1:12
for j=1:23
  if find(todo.(indice(j+1,:))(i)._respuestasEXP==0)
    j
    i
    find(todo.(indice(j+1,:))(i)._respuestasEXP==0)
  endif
endfor
endfor
