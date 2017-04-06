% 
% Brief: Calcula las probabilidades condicionales de cooperar respecto a los 
%        estados T R P S
%        Acumula las veces que aparece 2 (coop) luego de un determinado estados
%        durante los 30 trials de cada experimento

%T=zeros(_nSujetos,length(inicio:fin));C=zeros(_nSujetos,length(inicio:fin));
%P=zeros(_nSujetos,length(inicio:fin));S=zeros(_nSujetos,length(inicio:fin));

probxExp=[];
probAux=[];
fallasxExp=[];
probCdadoCoD=[]; %% [ p(c|c) p(d|c) ;p(c|d) p(d|d)];
probAux2= zeros(4,2);
for i=1:_nSujetos
  probTotal.(indiceSujeto(i,:)) = zeros(4,2); % [T C P S]'                %agregar matrices Q para cada sujeto en estructura
  probAux = zeros(4,2);
endfor
controlFallasXexp=zeros(_nSujetos,length(inicio:(fin)));
controlFallas=zeros(1,_nSujetos);
auxFallas=1;
%_ultimosX=10;
for i=_vSujetos
  ultimo=numfields(matricesQxExp.(indiceSujeto(i,:)));
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
          ++controlFallasXexp(i,j);
        elseif (k==3)
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-2)==0)&&(todo.(indice(j+1,:))(i)._respuestasEXP(k-1)==0)
            % nada
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-1)!=0)
            auxFallas+=1;
          else
            a="MIERDA!!!"
          endif
          ++controlFallas(i);%%%
          ++controlFallasXexp(i,j);
        else
          auxFallas+=1;
          ++controlFallas(i);
          ++controlFallasXexp(i,j);
        endif
      elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k)==2) %COOPERAR DADO:
        if (k>1) 
          if (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2)%que Traiciono (imposible x TFT)%
            ++probTotal.(indiceSujeto(i,:))(1,1);
            ++probAux(1,1);
            ++probAux2(2,1); %p(c|d)
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++probTotal.(indiceSujeto(i,:))(2,1);
            ++probAux(2,1);
            ++probAux2(1,1); %p(c|c)
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1) %Nocooperacion mutua %
            ++probTotal.(indiceSujeto(i,:))(3,1);
            ++probAux(3,1);
            ++probAux2(2,1); %p(c|d)
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++probTotal.(indiceSujeto(i,:))(4,1);
            ++probAux(4,1);
            ++probAux2(1,1); %p(c|c)
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
            ++probAux(1,2);
            ++probAux2(2,2); %p(d|d)
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==2) %Cooperacion mutua%
            ++probTotal.(indiceSujeto(i,:))(2,2);
            ++probAux(2,2);
            ++probAux2(1,2); %p(d|c)
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==1)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)=1)%Nocooperacion mutua %
            ++probTotal.(indiceSujeto(i,:))(3,2);
            ++probAux(3,2);
            ++probAux2(2,2); %p(d|d)
          elseif (todo.(indice(j+1,:))(i)._respuestasEXP(k-auxFallas)==2)&&(todo.(indice(j+1,:))(i)._respuestasOPO(k-auxFallas)==1)%fue estafado%
            ++probTotal.(indiceSujeto(i,:))(4,2);
            ++probAux(4,2);
            ++probAux2(1,2); %p(d|c)
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
    probxExp.(indiceSujeto(i,:)).(indice(j+1,:))=probAux;
    probCdadoCoD.(indiceSujeto(i,:)).(indice(j+1,:))=probAux2;
    probAux =zeros(4,2);
    fallasxExp.(indiceSujeto(i,:)).(indice(j+1,:))=controlFallas(i);
  endfor
  
endfor

% Transformando probabilidades de eleccion al intervalo [0,1] 
% promediando las ultimas 10 sesiones por sujetos
probxExpTotalN=zeros(4,2,_nSujetos);
probxExpTotal=zeros(4,2,_nSujetos);
probxExpTotal_CD=zeros(4,2,_nSujetos);
for i=_vSujetos
  ultimo=numfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    for l=1:4
      if sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2)(l)!=0
        probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(l,:)=probxExp.(indiceSujeto(i,:)).(indice(j+1,:))(l,:)./sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2)(l);
      else
        probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(l,:)=[0 0];
      endif
    endfor
    %probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))=probxExp.(indiceSujeto(i,:)).(indice(j+1,:))./sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2);
    probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)+probxExpN.(indiceSujeto(i,:)).(indice(j+1,:));
    probxExpTotal(:,:,i)=probxExpTotal(:,:,i)+probxExp.(indiceSujeto(i,:)).(indice(j+1,:));
    % prob C|X dos estados C y D
    probxExpTotal_CD(:,:,i)=probxExpTotal_CD(:,:,i)+probCdadoCoD.(indiceSujeto(i,:)).(indice(j+1,:));
  endfor
endfor

for i=1:_nSujetos
  %probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)./(length(primero:ultimo)-sum(controlFallasXexp,2))(i);
  probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)./length(primero:ultimo);
endfor

% transformar frecuencias de elecion total del exp 
probTotalN=zeros(4,2,_nSujetos);
for i=1:_nSujetos
  probTotalN(:,:,i)=probTotal.(indiceSujeto(i,:))/sum(sum(probTotal.(indiceSujeto(i,:))));
endfor

% Prob de ellcion dado un determinado estado. P(c|T) P(c|R) P(c|S) P(c|P)
probEleccion=zeros(size(probxExpTotal));
for i=1:_nSujetos
  for j=1:4
    if sum(probxExpTotal(j,:,i),2)!=0
      probEleccion(j,:,i)=probxExpTotal(j,:,i)./sum(probxExpTotal(j,:,i),2);
    endif
  endfor
endfor

% Prob de elecion dado un determinado estado. P(c|c) P(d|c) P(c|d) P(d|d)
probxExpTotal_CD_N=probxExpTotal_CD;
for i=1:_nSujetos
  for j=1:2
    if sum(probxExpTotal(j,:,i),2)!=0
      probxExpTotal_CD_N(j,:,i)=probxExpTotal_CD_N(j,:,i)./sum(probxExpTotal_CD_N(j,:,i),2);
    endif
  endfor
endfor


probEleccionSem=zeros(size(probxExpTotal));
for i=_vSujetos
  ultimo=numfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  aux1=[];
  aux2=[];
  for j=primero:ultimo
    aux1=[aux1 probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(:,1)];
    aux2=[aux2 probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))(:,2)];
  endfor
  probEleccionSem(:,1,i)=sem(aux1,2);
  probEleccionSem(:,2,i)=sem(aux2,2);
endfor

for i=_vSujetos
  hhh=figure;
  h=errorbar([1:4],probEleccion(:,1,i),probEleccionSem(:,1,i),'*k');
  hold on;%set(h, "linewidth", 2);     
  h=bar([1:4],probEleccion(:,1,i),'facecolor', 'g', 'edgecolor','b', "linewidth", 2);
  h=plot([0:5],[.5 .5 .5 .5 .5 .5],"--r");
  axis ("tic[yz]", "labely[xyz]");
  set(h, "linewidth", 2);  
  legend("SEM","MEAN","Half prob");
  %hh=xlabel("T=1 --- R=2 --- P=3 --- S=4");set(hh, "fontsize", 14);
  hh=ylabel("P(C|X)");set(hh, "fontsize", 14);
  hh=title(strcat("Probability of Cooperation given outcome: ",_txtSujetos(i,:)));
  set(hh, "fontsize", 14);
  axis ("tic[yz]", "labely[xyz]");
  t=text([1:4], -.04*ones(1,4), {"P(c|T)"; "P(c|R)";"P(c|P)";"P(c|S)"},"fontsize",14);
  axis([0 5 0 1]);
  hold off;grid on;  
  name=strcat("figura_iPD_1_2_9s_13s/fig_finales/prob_C_giveno_Outcome/",_txtSujetos(i,:));
  name=strcat(name,".png");
  print(hhh, name);
endfor
