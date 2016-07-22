% 
% Brief: Calcula las probabilidades condicionales de cooperar respecto a los 
%        estados T R P S
%        Acumula las veces que aparece 2 (coop) luego de un determinado estados
%        durante los 30 trials de cada experimento
T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));

probxExp=[];
probAux=[];
fallasxExp=[];
for i=1:_nSujetos
  probTotal.(indiceSujeto(i,:)) = zeros(4,2); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
  probAux.(indiceSujeto(i,:)) = zeros(4,2);
endfor

controlFallas=zeros(1,_nSujetos);
auxFallas=1;
_ultimosX=10;
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    for k=_trialIni:_trialFin  % nºtrials x Exp. 
      if ((todo.(indice(j+1,:))(i)._respuestasEXP(k)==0)||(todo.(indice(j+1,:))(i)._respuestasOPO(k)==0))
        if (k==1)
          ++controlFallas(i);%%%
        elseif (k==2) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)% k=1 y K=2 son ceros no se cuenta una falla auxiluar
            auxFallas+=1;  
          endif
          ++controlFallas(i);%%%
        elseif (k==3)
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
            % nada
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
            auxFallas+=1;
          else
            a="MIERDA!!!"
          endif
          ++controlFallas(i);%%%
        else
          auxFallas+=1;
          ++controlFallas(i);
        endif
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2) %COOPERAR DADO:
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++probTotal.(indiceSujeto(i,:))(1,1);
            ++probAux.(indiceSujeto(i,:))(1,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++probTotal.(indiceSujeto(i,:))(2,1);
            ++probAux.(indiceSujeto(i,:))(2,1); 
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
            ++probTotal.(indiceSujeto(i,:))(3,1);
            ++probAux.(indiceSujeto(i,:))(3,1);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++probTotal.(indiceSujeto(i,:))(4,1);
            ++probAux.(indiceSujeto(i,:))(4,1);
          else
            a="COOP ????" 
            i
            j
            k
          endif  
        endif
        auxFallas=1;
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==1)% NO COOPERAR DADO:
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++probTotal.(indiceSujeto(i,:))(1,2); 
            ++probAux.(indiceSujeto(i,:))(1,2);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++probTotal.(indiceSujeto(i,:))(2,2);
            ++probAux.(indiceSujeto(i,:))(2,2);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
            ++probTotal.(indiceSujeto(i,:))(3,2);
            ++probAux.(indiceSujeto(i,:))(3,2);
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++probTotal.(indiceSujeto(i,:))(4,2);
            ++probAux.(indiceSujeto(i,:))(4,2); 
          else
            a="NO coop ????"
            i
            j
            k
          endif
        endif
        auxFallas=1;
      endif
    endfor
    auxFallas=1;
    probxExp.(indiceSujeto(i,:)).(indice(j+1,:))=probAux.(indiceSujeto(i,:));
    fallasxExp.(indiceSujeto(i,:)).(indice(j+1,:))=controlFallas(i);
  endfor
  for i=1:_nSujetos
    probAux.(indiceSujeto(i,:)) = zeros(4,2);
  endfor
endfor

% Transformando probabilidades de eleccion al intervalo [0,1] 
% promediando las ultimas 10 sesiones por sujetos
probxExpTotalN=zeros(4,2,_nSujetos);

for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))=probxExp.(indiceSujeto(i,:)).(indice(j+1,:))/sum(sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:))));
    probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)+probxExpN.(indiceSujeto(i,:)).(indice(j+1,:));
  endfor
endfor

for i=1:_nSujetos
  probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)./length(primero:ultimo);
endfor

% transformar frecuencias de elecion total del exp 
probTotalN=zeros(4,2,_nSujetos);
for i=1:_nSujetos
  probTotalN(:,:,i)=probTotal.(indiceSujeto(i,:))/sum(sum(probTotal.(indiceSujeto(i,:))));
endfor
