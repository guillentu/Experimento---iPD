function x = discriminar(str)
  clear x;
  str
  %-Varialbes--------------------------------
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
  _eleccion=[];
  _reloj=[];    %D reloj en cuante regresiva
  _umbral=3;    %F umbra para elegir desde numeron random
  _duarcionT=0; %Y duracion del trial
  _listaRndStr=""; %E
  _respuestasIzq=[];%R respuestas R(0)=izq y R(1)=der
  _respuestasDer=[];%diferentes cajas en columnas           
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
  x(1)._nTrial=[];   %A=[];
                %B
  x(1)._eleccion=[]; %eleccion por refuerzo de 1 o 2 pellet
  x(1)._reloj=[];    %D reloj en cuante regresiva
  x(1)._umbral=[];    %F umbra para elegir desde numeron random
  x(1)._duarcionT=0; %Y duracion del trial
  x(1)._listaRndStr=""; %E
  x(1)._respuestasIzq=[];%R respuestas R(0)=izq y R(1)=der
  x(1)._respuestasDer=[];%diferentes cajas en columnas
  %-------------------------------------------------------
 
  _file=str;
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
  _fileStr=fgetl(_fid);         %lee lineas

  while (feof(_fid)==0)
    txt=fgetl(_fid);
    
    pos=strchr(txt,":");
    if (strcmp("Start Date",txt(1:pos-1))==1)
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
    elseif (strcmp("C",txt(1:pos-1))==1)
      _eleccion=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("D",txt(1:pos-1))==1)
      _reloj=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("F",txt(1:pos-1))==1)
      _umbral=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("Y",txt(1:pos-1))==1)
      _duarcionT=str2num(txt((pos+2):length(txt)));
    elseif (strcmp("E",txt(1:pos-1))==1)
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      _listaRndStr=txt((pos+2):length(txt));
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      _listaRndStr=strcat(_listaRndStr , txt((pos+2):length(txt)));
    elseif (strcmp("R",txt(1:pos-1))==1)
      txt=fgetl(_fid);
      pos=strchr(txt,":");
      i=0;
      _respuestasIzq=str2num(txt((pos+(i+1)*8+i*5):(pos+(i+1)*8+(i+1)*5)));
      i++;
      _respuestasDer=str2num(txt((pos+(i+1)*8+i*5):(pos+(i+1)*8+(i+1)*5)));
      cargar=1;
    else
      %printf("NADA\n");
    endif

    %---------------------------------------------------------
    %if _experiment=="17"
      
    if cargar==1
      x(_box)._fileStr=_fileStr;
      x(_box)._startDateStr=_startDateStr;
      x(_box)._endDateStr=_endDateStr;
      x(_box)._subjectStr=_subjectStr;
      x(_box)._experiment=_experiment;
      x(_box)._groupStr=_groupStr;
      x(_box)._box=_box;
      x(_box)._msnStr=_msnStr;
      x(_box)._startTime=_startTime;
      x(_box)._endTime=_endTime;
      x(_box)._nTrial=[x(_box)._nTrial _nTrial];   %A=[];
                    %B
      x(_box)._eleccion = [x(_box)._eleccion _eleccion];
      x(_box)._reloj=[x(_box)._reloj _reloj];    %D reloj en cuante regresiva
      x(_box)._umbral=[x(_box)._umbral _umbral];    %F umbra para elegir desde numeron random
      x(_box)._duarcionT=_duarcionT; %Y duracion del trial
      x(_box)._listaRndStr=_listaRndStr; %E
      x(_box)._respuestasIzq=[x(_box)._respuestasIzq _respuestasIzq];%R respuestas R(0)=izq y R(1)=der
      x(_box)._respuestasDer=[x(_box)._respuestasDer _respuestasDer];%diferentes cajas en columnas
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