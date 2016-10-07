for i=1:_nSujetos
  A=floor(100*QQTotmarkov(:,:,i));
  %A=[253 11; 11 10]
  p=nchoosek(A(1,1)+A(1,2),A(1,1))*nchoosek(A(2,1)+A(2,2),A(2,1))/nchoosek(sum(sum(A)),(A(1,1)+A(2,1)))
endfor
  