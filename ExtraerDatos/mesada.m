probxExpTotalN=zeros(4,2,_nSujetos);
probxExpTotal=zeros(4,2,_nSujetos);
for i=1:_nSujetos
  ultimo=nfields(matricesQxExp.(indiceSujeto(i,:)));
  primero=ultimo-_ultimosX+1;
  for j=primero:ultimo
    for k=1:4
      if probxExp.(indiceSujeto(i,:)).(indice(j+1,:))!=0
        probxExpN.(indiceSujeto(i,:)).(indice(j+1,:))=probxExp.(indiceSujeto(i,:)).(indice(j+1,:))/sum(probxExp.(indiceSujeto(i,:)).(indice(j+1,:)),2);
        probxExpTotalN(:,:,i)=probxExpTotalN(:,:,i)+probxExpN.(indiceSujeto(i,:)).(indice(j+1,:));
        probxExpTotal(:,:,i)=probxExpTotal(:,:,i)+probxExp.(indiceSujeto(i,:)).(indice(j+1,:));
      endif
  endfor
endfor
