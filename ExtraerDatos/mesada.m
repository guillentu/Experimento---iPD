
% HACER:   struct de T R P S para cada sujeto por sesion
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX;
  figure()
  plot([primero:ultimo],T(i,primero:ultimo),'--ob',[primero:ultimo],C(i,primero:ultimo),'--or',[primero:ultimo],P(i,primero:ultimo),'-->k',[primero:ultimo],S(i,primero:ultimo),'--.m');
  xlabel("n de sesiones");
  ylabel("% Tasa de comportamientos");
  title(strcat("Estrategias probabilistica en iPD: ",_txtSujetos(i,:)));
  legend("T=D-C","C=C-C","P=D-D","S=C-D");
  grid on;
endfor
