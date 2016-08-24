function x = extraerDatos_iPD_abril_corregido(str)
%%%% SE CORRIGIO LOS SIGNOS DE LA VARIABLE VENTANAS (M)
    clear x;
  str
  %-Varialbes--------------------------------
%sujetos
  _1A="1A_1B";
  _2A="2A_1B";
  _3A="3A_504";
  _4A="4A_504";
  _5A="5A_505";
  _6A="6A_505";
  _7A="7A_2B";
  _8A="8A_2B";
  _9A="9A_506";
  _10A="10A_506";
  _3B="2B_11A";
  _4B="2B_11A";

  cargar=0;       %cargar datos en estructura
  boxChoose=1;
  _fileStr="";
  _startDateStr="";
  _endDateStr="";
  _subjectStr="";
  _experiment=0;
  _groupStr="";
  _box=0;
  _msnStr="";
  _startTime="";
  _endTime="";
  _nTrial=[];   %A=[];
                %B
  _come=[];       %C Come Uno o DOS Pellets
  _umbral=3;    %F umbra para elegir desde numeron random
  _tiempoITI=0; %Q tiempo de ITI
  _duarcionT=0; %Y duracion del trial
  _reloj=[];    %D reloj en cuante regresiva
  _listaRndStr=""; %E
  _respuestasEXP=[];%R respuestas R(0)=izq y R(1)=der
  _respuestasOPO=[];%diferentes cajas en columnas           
  _ventana=zeros(1,31); % Ventana de palanquoe para el oponente (evaluar en que momento lo hace el exp)
  _controlITI=[];%(0)Control de palanq ITI ; cant palanq (1)IZQ y (2)DER
  %---------------------------------------------------------
  x(1)._fileStr="";
  x(1)._startDateStr="";
  x(1)._endDateStr="";
  x(1)._subjectStr="";
  x(1)._experiment=0;
  x(1)._groupStr="";
  x(1)._box=0;
  x(1)._msnStr="";
  x(1)._startTime="";
  x(1)._endTime="";
  x(1)._nTrial=[];      %A=[];
                        %B
  x(1)._come=[];        %come UNO o DOS Pellets
  x(1)._umbral=[];      %F umbra para elegir desde numeron random
  x(1)._tiempoITI=0;    %D reloj en cuante regresiva
  x(1)._duarcionT=0;    %Y duracion del trial
  x(1)._reloj=[];       %D reloj en cuante regresiva
  x(1)._listaRndStr=""; %E
  x(1)._respuestasEXP=[];%R respuestas R(0)=izq y R(1)=der
  x(1)._respuestasOPO=[];%diferentes cajas en columnas
  x(1)._ventanas=[];
  x(1)._controlITI=[];%S (0)Control de palanq ITI ; cant palanq (1)IZQ y (2)DER
  %-------------------------------------------------------

  %_file="alternarPalanca/!2015-12-01_22h08m.Subject ged-alternanpalanca";%dia de prueba del prog
  %_file="alternarPalanca/!2015-12-01_22h21m.Subject ged-alternanPalanca";% idem
  _file=str;%"alternarPalanca/!2015-12-02_20h49m.Subject ged-alternanPalancas";
  %*file="alternarPalanca/!2015-12-02_20h57m.Subject ged-alternanPalanca";
  %*_file="alternarPalanca/!2015-12-02_21h08m.Subject ged-alternanPalanca";
  %*_file="alternarPalanca/!2015-12-02_21h22m.Subject ged-alternanPalanca";
  %*_file="alternarPalanca/!2015-12-03_18h04m.Subject ged-alternarRnd";
  %_file="alternarPalanca/!2015-12-03_18h17m.Subject ged-alternanRnd";
  %_file="alternarPalanca/!2015-12-03_18h28m.Subject ged-alternanRnd";
  %_file="alternarPalanca/!2015-12-03_20h29m.Subject ged-alternanRnd";
  %_file="alternarPalanca/!2015-12-03_20h37m.Subject ged-alternanRnd";
  %_file="alternarPalanca/!2015-12-05_15h21m.Subject ged-alternanRnd";
  %X_file="alternarPalanca/!2015-12-05_15h43m.Subject ged-alternanRnd";
  %X_file="alternarPalanca/!2015-12-05_15h44m.Subject ged-alternanRnd";
  %_file="alternarPalanca/!2015-12-05_15h48m.Subject ged-alternanRnd";
  %_file="alternarPalanca/!2015-12-05_16h26m.Subject ged-alternanRndCastigo";
  %_file="alternarPalanca/!2015-12-05_16h36m.Subject ged-alternanRndCastigo";
  %_file="alternarPalanca/!2015-12-06_22h55m.Subject ged-alternanRndCastigo";
  %_file="alternarPalanca/!2015-12-06_23h05m.Subject ged-alternanRndCastigo";
  %_file="alternarPalanca/!2015-12-06_23h43m.Subject ged-alternanRndCastigo";
  %_file="alternarPalanca/!2015-12-06_23h49m.Subject ged-alternanRndCastigo";
  %_file="alternarPalanca/!2015-12-08_19h22m.Subject ged-alternanRndCastigo";
  %_file="alternarPalanca/!2015-12-08_19h32m.Subject ged-alternanRndCastigo";

  _fid = fopen(_file);   %abre el archivo
  _count=0;
  _trials=0;
  _txt=fgetl(_fid);
  _txt=fgetl(_fid);
  while (feof(_fid)==0)
    if length(_txt)==0 
      _count++;
      if(_count==3)
        _trials++;
        _count=0;
      endif
    endif
    _txt=fgetl(_fid);
  endwhile
  fclose(_fid);
  %--------------------------------------------------------
  _fid = fopen (_file);   %abre el archivo
%  _fileStr=fgetl(_fid);         %lee lineas

  while (feof(_fid)==0)
    txt=fgetl(_fid);   
    pos=strchr(txt,":");
    if (strcmp("File",txt(1:pos-1))==1)
      _fileStr=txt;
    elseif (strcmp("Start Date",txt(1:pos-1))==1)
      _startDateStr=txt((pos+2):length(txt));
    elseif (strcmp("End Date",txt(1:pos-1))==1)
      _endDateStr=txt((pos+2):length(txt));
    elseif (strcmp("Subject",txt(1:pos-1))==1)
      _subjectStr=txt((pos+2):length(txt));
    elseif (strcmp("Experiment",txt(1:pos-1))==1)
      _experiment=txt((pos+2):length(txt));
    elseif (strcmp("Group",txt(1:pos-1))==1)
      _groupStr=txt((pos+2):length(txt));
    elseif (strcmp("Box",txt(1:pos-1))==1)
     _box=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("MSN",txt(1:pos-1))==1)
      _msnStr=txt((pos+2):length(txt));
    elseif (strcmp("Start Time",txt(1:pos-1))==1)
      _startTime=txt((pos+2):length(txt));
    elseif (strcmp("End Time",txt(1:pos-1))==1)
      _endTime=txt((pos+2):length(txt));
    elseif (strcmp("A",txt(1:pos-1))==1)
      _nTrial=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("D",txt(1:pos-1))==1)
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      i=0;
      _reloj_0=str2num(txt((pos+(i+1)*7+i*5):(pos+(i+1)*7+(i+1)*5)));
      i++;
      _reloj_1=str2num(txt((pos+(i+1)*7+i*5):(pos+(i+1)*7+(i+1)*5)));
      i++;
      _reloj_2=str2num(txt((pos+(i+1)*7+i*5):(pos+(i+1)*7+(i+1)*5)));
      _reloj=[_reloj_0;_reloj_1;;_reloj_2];
    elseif (strcmp("C",txt(1:pos-1))==1)
      _come=str2num(txt((pos+2):length(txt)));
			txt=fgetl(_fid);
      pos=strchr(txt,":");
      i=0;
      _come_0=str2num(txt((pos+(i+1)*7+i*5):(pos+(i+1)*7+(i+1)*5)));
      i++;
			_come_1=str2num(txt((pos+(i+1)*7+i*5):(pos+(i+1)*7+(i+1)*5)));
      i++;
			_come_2=str2num(txt((pos+(i+1)*7+i*5):(pos+(i+1)*7+(i+1)*5)));
		  _come=[_come_0;_come_1;_come_2];
    elseif (strcmp("F",txt(1:pos-1))==1)
      _umbral=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("Q",txt(1:pos-1))==1)
       _tiempoITI=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("Y",txt(1:pos-1))==1)
      _duarcionT=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("E",txt(1:pos-1))==1)
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      _listaRndStr=txt((pos+2):length(txt));
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      _listaRndStr=strcat(_listaRndStr , txt((pos+2):length(txt)));
    elseif (strcmp("M",txt(1:pos-1))==1)
      for j=0:6
        txt=fgetl(_fid);
        pos=strchr(txt,":") 
        i=0;
        k=4;
        if (j==6) %j=6 significa fila = 7 
          k=0;
        endif
        pos= pos - 4
        txt
        for i=0:k
          _ventana(5*(j)+(i+1))=str2num(txt((pos+13-4):(pos+13+4)));
          pos=pos + 13;
        endfor
      endfor
    elseif (strcmp("R",txt(1:pos-1))==1)
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      i=0;
      _respuestasEXP=str2num(txt((pos+(i+1)*8+i*5):(pos+(i+1)*8+(i+1)*5)));
      i++;
      _respuestasOPO=str2num(txt((pos+(i+1)*8+i*5):(pos+(i+1)*8+(i+1)*5)));
    elseif (strcmp("S",txt(1:pos-1))==1)
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      i=1;
      _controlITI_0=str2num(txt((pos+(i)*13-7):((pos+(i)*13))));%str2num(txt((pos+(i+1)*8+i*5):(pos+(i+1)*8+(i+1)*5)));
      i++;
      _controlITI_1=str2num(txt((pos+(i)*13-7):((pos+(i)*13))));
      i++;
      _controlITI_2=str2num(txt((pos+(i)*13-7):((pos+(i)*13))));
      _controlITI=[_controlITI_0; _controlITI_1; _controlITI_2];
      cargar=1;
    else
      %printf("NADA\n");
    endif

    
    %---------------------------------------------------------
    %if _experiment=="17"
    
    _sujeto=0; 
    if cargar==1
			if strcmp(_groupStr,"1A_1B")
				_sujeto=1;
			elseif strcmp(_groupStr,"2A_1B")
				_sujeto=2;
			elseif strcmp(_groupStr,"3A_504")
				_sujeto=3;
		  elseif strcmp(_groupStr,"4A_504")
				_sujeto=4;
			elseif strcmp(_groupStr,"5A_505")
				_sujeto=5;
			elseif strcmp(_groupStr,"6A_505")
				_sujeto=6;
			elseif strcmp(_groupStr,"7A_2B")
				_sujeto=7;
			elseif strcmp(_groupStr,"8A_2B")
				_sujeto=8;
			elseif strcmp(_groupStr,"9A_506")
				_sujeto=9;
			elseif strcmp(_groupStr,"9A_1B")
				_sujeto=9;
			elseif strcmp(_groupStr,"10A_506")
				_sujeto=10;
      elseif strcmp(_groupStr,"10A_504")
				_sujeto=10;
      elseif strcmp(_groupStr,"10A_505")
				_sujeto=10;
			elseif strcmp(_groupStr,"3B_11A")
				_sujeto=11;
			elseif strcmp(_groupStr,"4B_11A")
				_sujeto=12;
			endif

      x(_sujeto)._fileStr=_fileStr;
      x(_sujeto)._startDateStr=_startDateStr;
      x(_sujeto)._endDateStr=_endDateStr;
      x(_sujeto)._subjectStr=_subjectStr;
      x(_sujeto)._experiment=_experiment;
      x(_sujeto)._groupStr=_groupStr;
      x(_sujeto)._box=_box;
      x(_sujeto)._msnStr=_msnStr;
      x(_sujeto)._startTime=_startTime;
      x(_sujeto)._endTime=_endTime;
      x(_sujeto)._nTrial=[x(_sujeto)._nTrial _nTrial];   %A=[];
                    %B
      x(_sujeto)._come=[x(_sujeto)._come _come];
      x(_sujeto)._umbral=[x(_sujeto)._umbral _umbral];    %F umbra para elegir desde numeron random
      x(_sujeto)._tiempoITI=[x(_sujeto)._tiempoITI _tiempoITI];    %D reloj en cuante regresiva
      x(_sujeto)._duarcionT=_duarcionT; %Y duracion del trial
      x(_sujeto)._reloj=[x(_sujeto)._reloj _reloj];    %D reloj en cuante regresiva
      x(_sujeto)._listaRndStr=_listaRndStr; %E
      x(_sujeto)._respuestasEXP=[x(_sujeto)._respuestasEXP _respuestasEXP];%R respuestas R(0)=izq y R(1)=der
      x(_sujeto)._respuestasOPO=[x(_sujeto)._respuestasOPO _respuestasOPO];%diferentes cajas en columnas
      x(_sujeto)._ventanas=[x(_sujeto)._ventanas; _ventana];
      x(_sujeto)._controlITI=[x(_sujeto)._controlITI _controlITI];%(0)Control de palanq ITI ; cant palanq (1)IZQ y (2)DER
      cargar=0;
    endif
    %-------------------------------------------------------  

  endwhile

  fclose(_fid);  
endfunction

%[s, e, te, m, t, nm, sp] = regexp (txt, ":","once"); %//separa por :

%findstr(txt,"        ")
%txt(((5+2)+21+1):(5+2+21+5))
%str2num(ss)
%strchr(txt,":",3)
%strcmp(ss,"Start Date")
