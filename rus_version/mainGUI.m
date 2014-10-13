function varargout = mainGUI(varargin)
% MAINGUI MATLAB code for mainGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGUI

% Last Modified by GUIDE v2.5 18-Jul-2014 07:52:49

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mainGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mainGUI is made visible.
function mainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainGUI (see VARARGIN)

% Choose default command line output for mainGUI
handles.output = hObject;
handles.imp=[];
handles.imphil=[];
handles.listcont=0;
handles.setbtn=0;
handles.leftbord=[];
handles.freq=[];
handles.rightbord=[];
handles.firstbord=0;
handles.secondbord=0;
handles.thirdbord=0;
handles.listsize=NaN;
handles.exall=0;
handles.g0={};
handles.fc={};
handles.pos={};
handles.strlistbox4={};
handles.t={};
handles.s={};
handles.s_gauss={};
handles.s_hat={};
handles.drall=0;
handles.FullFileName='';
handles.theresold=NaN;
handles.channel=NaN;
handles.filt=false;
handles.power=[];
handles.freq_center=[];
handles.ind_beg=[];
handles.Fs=3000000;
handles.max_imp=NaN;
handles.min_imp=NaN;

set(handles.pushbutton4,'Enable','off');
set(handles.pushbutton7,'Enable','off');
set(handles.slider6,'Value',0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%set(hObject,'HandleVisibility','callback');


% --- Outputs from this function are returned to the command line.
function varargout = mainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Find Impulses
function pushbutton1_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
    
    if(isempty(handles.FullFileName))
        msgbox('Откройте, пожалуйста, файл для обработки.','Error','error');
    else
        M=inputdlg('Введите порог');
       if ~isempty(M)
        handles.theresold=str2num(M{1});
        guidata(hObject,handles);
        
    if(~isnan(handles.theresold) && ~isnan(handles.channel))
     [imps, imphilb, ind_beg, max_imp, min_imp]=findImp(handles.theresold,handles.channel,handles.FullFileName,handles.filt);
     handles.imp=imps;
     handles.imphil=imphilb;
     handles.max_imp=max_imp;
     handles.min_imp=min_imp;
     handles.ind_beg=ind_beg;
     guidata(hObject,handles);
    
    vars={};
    sz=size(imps);
    if(sz== 0)
        msgbox('Импульсы не найдены','Error','error');
        vars={''};
    end
    for i=1:sz(2)
        num=num2str(i);
        vars{end+1}=strcat('Imp_',num);
    end
  set(handles.listbox2,'String',vars);
  handles.listsize=sz(2);
  if(sz(2)~=0)
      handles.listcont=1;
  end
    
  handles.leftbord(1:sz(2))=NaN;
  handles.rightbord(1:sz(2))=NaN;
    end
       end
    end
  
  guidata(hObject,handles);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Set
function pushbutton14_Callback(hObject, eventdata, handles)
         handles=guidata(hObject);
       if(handles.listcont<=0)
            msgbox('Выберете, пожалуйста, импульс.','Error','error');
       else
         handles.leftbord(handles.listcont)= str2double(get(handles.edit7,'String'));
         handles.rightbord(handles.listcont)= str2double(get(handles.edit8,'String'));
         if(isnan(handles.leftbord(handles.listcont)) || isnan(handles.rightbord(handles.listcont)) )
             msgbox('Введите, пожалуйста, границы.','Error','error');
         end
         if(~isnan(handles.leftbord(handles.listcont)) && ~isnan(handles.rightbord(handles.listcont)) )
           set(handles.edit9,'String',num2str(handles.rightbord(handles.listcont)-handles.leftbord(handles.listcont)+1));
           if(rem(handles.rightbord(handles.listcont)-handles.leftbord(handles.listcont)+1,2)~=0)
              msgbox('Сделайте, пожалуйста, четную длину.','Error','error');
           end
         end
       end
         guidata(hObject,handles);

    

% Set All
function pushbutton15_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
       if(isnan(handles.listsize))
            msgbox('Выберете, пожалуйста, импульс.','Error','error');
       else
         handles.leftbord(1:handles.listsize)= str2double(get(handles.edit7,'String'));
         handles.rightbord(1:handles.listsize)= str2double(get(handles.edit8,'String'));
 
         if(isnan(handles.leftbord(handles.listcont)) || isnan(handles.rightbord(handles.listcont)) )
             msgbox('Введите, пожалуйста границы.','Error','error');
         end
         if(~isnan(handles.leftbord(handles.listcont)) && ~isnan(handles.rightbord(handles.listcont)) )
           set(handles.edit9,'String',num2str(handles.rightbord(handles.listcont)-handles.leftbord(handles.listcont)+1));
           if(rem(handles.rightbord(handles.listcont)-handles.leftbord(handles.listcont)+1,2)~=0)
              msgbox('Сделайте, пожалуйста, четную длину.','Error','error');
           end
         end
       end
         guidata(hObject,handles);
    

% Next for Synthesis
function pushbutton7_Callback(hObject, eventdata, handles)
   handles=guidata(hObject);
   
    if(handles.drall>handles.listsize)
      handles.drall=0;
      set(handles.pushbutton7,'Enable','off');
      guidata(hObject,handles);
    end
    
      if(handles.drall>0)
         plot(handles.axes3,handles.t{handles.drall}, [handles.s{handles.drall},handles.s_gauss{handles.drall}]);
         legend(handles.axes3,'true','by gauss');
         xlabel(handles.axes3,'Время,   мкс');
         
         plot(handles.axes6,handles.t{handles.drall}, real(handles.s_hat{handles.drall}));
         legend(handles.axes6,'comp. 1', 'comp. 2', 'comp. 3');
         xlabel(handles.axes6,'Время,   мкс');
         
         handles.drall=handles.drall+1;
         guidata(hObject,handles);
      end

% Draw
function pushbutton8_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
    sz=size(handles.strlistbox4);
    
    if(sz(2)>0)
        contents = cellstr(get(handles.listbox4,'String')); %returns listbox4 contents as cell array
        valcont=contents{get(handles.listbox4,'Value')};
        val=str2num(valcont(7:end));
    
         plot(handles.axes3,handles.t{val}, [handles.s{val},handles.s_gauss{val}]);
         legend(handles.axes3,'true','by gauss');
         xlabel(handles.axes3,'Время,   мкс');
         
         plot(handles.axes6,handles.t{val}, real(handles.s_hat{val}));
         legend(handles.axes6,'comp. 1', 'comp. 2', 'comp. 3');
         xlabel(handles.axes6,'Время,   мкс');
    end
    

% Draw All
function pushbutton9_Callback(hObject, eventdata, handles)
   handles=guidata(hObject);
   sz=size(handles.strlistbox4);
   
   handles.drall=2;
   
   if(sz(2)==handles.listsize)
       set(handles.pushbutton7,'Enable','on');
        plot(handles.axes3,handles.t{1}, [handles.s{1},handles.s_gauss{1}]);
         legend(handles.axes3,'true','by gauss');
         xlabel(handles.axes3,'Время,   мкс');
         
         plot(handles.axes6,handles.t{1}, real(handles.s_hat{1}));
         legend(handles.axes6,'comp. 1', 'comp. 2', 'comp. 3');
         xlabel(handles.axes6,'Время,   мкс');
   else
       msgbox('Не все импульсы синетзированы.','Error','error');
   end
   
   guidata(hObject,handles);


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Synthesize
function pushbutton10_Callback(hObject, eventdata, handles)
 handles=guidata(hObject);
 lengthOfextractArr = length(handles.g0); %lenght of extract components array
 
  if(handles.listcont==0)
      msgbox('Не обработан ни один импульс. Нажмите, пожалуйста, кнопку "Найти импульсы"','Error','error');
  elseif(handles.listcont>lengthOfextractArr || isempty(handles.g0{handles.listcont}) || isempty(handles.fc{handles.listcont})...
          || isempty(handles.pos{handles.listcont}) )
      msgbox('Импульс не разбит на компоненты. Нажмите, пожалуйста, кнопку "Извлечь"','Error','error');
  else
      [handles.t{handles.listcont}, handles.s{handles.listcont}, handles.s_gauss{handles.listcont},...
          handles.s_hat{handles.listcont}] = synthesis_comp(handles.g0{handles.listcont}...
         ,handles.fc{handles.listcont},handles.pos{handles.listcont} );
     
     handles.strlistbox4{end+1}=  strcat('S_Imp_',num2str(handles.listcont));
     handles.strlistbox4=sort(handles.strlistbox4);
     
     set(handles.listbox4,'String',handles.strlistbox4);
  end
  
  guidata(hObject,handles);

% Synthesize All
function pushbutton11_Callback(hObject, eventdata, handles)
   handles=guidata(hObject);
   flag=true;
   
   if(isnan(handles.listsize))
       msgbox('Не обработан ни один импульс. Нажмите, пожалуйста, кнопку "Find Impulses"','Error','error');
       flag=false;
   else
       for i=1:handles.listsize
           if( isempty(handles.g0{i}) || isempty(handles.fc{i})|| isempty(handles.pos{i}) )
               msgbox('Не все компоненты доступны.','Error','error');
               flag=false;
           end
       end
   end
   
   if(flag==true)
       for i=1:handles.listsize
         [handles.t{i}, handles.s{i}, handles.s_gauss{i},...
          handles.s_hat{i}] = synthesis_comp(handles.g0{i} ,handles.fc{i},handles.pos{i} );
     
         handles.strlistbox4{i}=  strcat('S_Imp_',num2str(i));
       end
     
       set(handles.listbox4,'String',handles.strlistbox4);
   end
    guidata(hObject,handles);   


% Delete All
function pushbutton3_Callback(hObject, eventdata, handles)
  handles=guidata(hObject);
  
  set(handles.listbox2,'String',{});
  handles.imp=[];
  handles.imphil=[];
  handles.listcont=0;
  handles.setbtn=0;
  handles.leftbord=[];
  handles.rightbord=[];
  handles.freq=[];
  handles.listsize=NaN;
  handles.exall=0;

  guidata(hObject,handles);


% ListBox Imp
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%    contents = cellstr(get(hObject,'String')); %returns listbox2 contents as cell array
%    valcont=contents{get(hObject,'Value')}; %returns selected item from listbox2
%    handles=guidata(hObject);
   handles.listcont=get(hObject,'Value');
   
   s=handles.imp(:,handles.listcont);
   %L=size(s,1);
   
   plot(handles.axes2,s,'HitTest','off');
   % plot([1:L]/handles.Fs*1e6, s);
   set(handles.axes2,'YLim',[handles.min_imp-0.05 handles.max_imp+0.05]);
   set(handles.axes2,'ButtonDownFcn',@axes2_ButtonDownFcn);
  
     guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Next
function pushbutton4_Callback(hObject, eventdata, handles)
  handles=guidata(hObject);
  
  if(handles.exall>handles.listsize)
      handles.exall=0;
      set(handles.pushbutton4,'Enable','off');
      
      ind_good = [1:size(handles.imp,2)];
      
      power_norm = sqrt(sum(handles.power.^2));
      fract = handles.power.^2./(ones(size(handles.power,1),1)*power_norm.^2);
      
      figure(5);
      plot(handles.ind_beg(ind_good)/handles.Fs,handles.freq_center(1:3,ind_good)','.-');
      title('Центральная частота компонент');
      ylabel('кГц');
      xlabel('Время,   с')

      figure(6);
      plot(handles.ind_beg(ind_good)/handles.Fs,handles.power(:,ind_good)','.-');
      title('Энергия компонент');
      xlabel('Время,   с')

      figure(7);
      plot(handles.ind_beg(ind_good)/handles.Fs,fract(:,ind_good)','.-');
      title('Parts of component energy');
      xlabel('Время,   с')
      
      guidata(hObject,handles);
  end
  
  if(handles.exall>0)
      [handles.g0{handles.exall}, handles.fc{handles.exall}, handles.pos{handles.exall}]=...
          extractComp(handles.imp(:,handles.exall),handles.imphil(:,handles.exall),handles.leftbord(handles.exall),...
        handles.rightbord(handles.exall),handles.freq);
     
     
      L=handles.rightbord(handles.exall)-handles.leftbord(handles.exall)+1;
      g0re=real(handles.g0{handles.exall});
      handles.power(1:size(handles.g0{handles.exall},2),handles.exall) = sqrt(sum(g0re.^2)/L)';
      handles.freq_center(1:size(handles.g0{handles.exall},2), handles.exall) = handles.fc{handles.exall};
      
      handles.exall=handles.exall+1;
      guidata(hObject,handles);
  end


% Extract
function pushbutton5_Callback(hObject, eventdata, handles)
  handles=guidata(hObject);
  freq=[];
  temp=[];
   temp(1)=str2double(get(handles.edit1,'String'));
   temp(2)=str2double(get(handles.edit2,'String'));
   temp(3)=str2double(get(handles.edit3,'String'));
  for i=1:3
      if(~isnan(temp(i)))
          freq(end+1)=temp(i);
      end
  end
  handles.freq=freq;
   if(isempty(freq))
       msgbox('Введите, пожалуйста, границы компонент.','Error','error');
   end
   if(handles.listcont==0)
       msgbox('Не выбран импульс.','Error','error');
   
   elseif(isnan(handles.leftbord(handles.listcont)) || isnan(handles.rightbord(handles.listcont)) )
       msgbox('Введите, пожалуйста границы.','Error','error');
   end
    
   
  if(handles.listcont~=0 && ~isempty(freq) && ~isnan(handles.leftbord(handles.listcont))...
     && ~isnan(handles.rightbord(handles.listcont))&& ~isempty(handles.imp) && ~isempty(handles.imphil) )
     [handles.g0{handles.listcont}, handles.fc{handles.listcont}, handles.pos{handles.listcont}]=...
         extractComp(handles.imp(:,handles.listcont),handles.imphil(:,handles.listcont),...
          handles.leftbord(handles.listcont),handles.rightbord(handles.listcont),freq);
  end
  
  guidata(hObject,handles);


% Extract All
function pushbutton6_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
    flag=true;
   freq=[];
   temp=[];
   temp(1)=str2double(get(handles.edit1,'String'));
   temp(2)=str2double(get(handles.edit2,'String'));
   temp(3)=str2double(get(handles.edit3,'String'));
  for i=1:3
      if(~isnan(temp(i)))
          freq(end+1)=temp(i);
      end
  end
  handles.freq=freq;
   if(isempty(freq))
       msgbox('Введите, пожалуйста, границы компонент.','Error','error');
       flag=false;
   end
   
    if(~isnan(handles.listsize))
     for i=1:handles.listsize
         if(isnan(handles.leftbord(i)) || isnan(handles.rightbord(i)))
              msgbox('Не все данные введены.','Error','error');
              flag=false;
              break;
         end
     end
    end
    
    handles.exall=2;
    valcheckbox=get(handles.checkbox1,'Value');
    
    if(valcheckbox==1 && flag==true && ~isempty(handles.imp) && ~isempty(handles.imphil))
        for i=1:handles.listsize
            [handles.g0{i}, handles.fc{i}, handles.pos{i}]=...
            extractComp(handles.imp(:,i),handles.imphil(:,i),handles.leftbord(i),...
            handles.rightbord(i),handles.freq);
     
     
            L=handles.rightbord(i)-handles.leftbord(i)+1;
            g0re=real(handles.g0{i});
            handles.power(1:size(handles.g0{i},2),i) = sqrt(sum(g0re.^2)/L)';
            handles.freq_center(1:size(handles.g0{i},2), i) = handles.fc{i};
       
            guidata(hObject,handles);
        end
        
         handles.exall=0;
      
      ind_good = [1:size(handles.imp,2)];
      
      power_norm = sqrt(sum(handles.power.^2));
      fract = handles.power.^2./(ones(size(handles.power,1),1)*power_norm.^2);
      
      figure(5);
      plot(handles.ind_beg(ind_good)/handles.Fs,handles.freq_center(1:3,ind_good)','.-');
      title('Центральная частота компонент');
      ylabel('кГц');
      xlabel('Время,   с')

      figure(6);
      plot(handles.ind_beg(ind_good)/handles.Fs,handles.power(:,ind_good)','.-');
      title('Энергия компонент');
      xlabel('Время,   с')

      figure(7);
      plot(handles.ind_beg(ind_good)/handles.Fs,fract(:,ind_good)','.-');
      title('Parts of component energy');
      xlabel('Время,   с')
      
      guidata(hObject,handles);
    
    elseif(flag==true && ~isempty(handles.imp) && ~isempty(handles.imphil))
         set(handles.pushbutton4,'Enable','on');
    [handles.g0{1}, handles.fc{1}, handles.pos{1}]=...
        extractComp(handles.imp(:,1),handles.imphil(:,1),handles.leftbord(1),...
        handles.rightbord(1),freq);
    
    L=handles.rightbord(1)-handles.leftbord(1)+1;
    g0re=real(handles.g0{1});
    handles.power(1:size(handles.g0{1},2),1) = sqrt(sum(g0re.^2)/L)';
    handles.freq_center(1:size(handles.g0{1},2), 1) = handles.fc{1};
    
    end
    
     guidata(hObject,handles);

% freq border 1
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% freq border 1
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% freq border 2
function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


%  freq border 2
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% freq border 3
function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% freq border 3
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
   handles=guidata(hObject); 
    valbtn=get(handles.radiobutton2,'Value');
      
  if(valbtn==1)

   key=get(gcf,'SelectionType');
   
   if isequal(key,'normal')
        C=get(gca,'CurrentPoint');
        x=C(1,1);
        
        set(handles.edit7,'String',num2str(ceil(x)));
        set(gcf,'WindowButtonUpFcn',@axes2_ButtonUpFcn);
   end
   
   
  end
   
  function axes2_ButtonUpFcn(hObject, eventdata, handles)
      handles=guidata(hObject);
      valbtn=get(handles.radiobutton2,'Value');
      
  if(valbtn==1)
     
      C=get(gca,'CurrentPoint');
        x=C(1,1);
        y=C(1,2);
        
        %узнаем пределы осей
        xlim=get(handles.axes2,'XLim');
        ylim=get(handles.axes2,'YLim');
        
        %проверяем был ли щелчек в пределах осей
        inaxes=xlim(1)<x && xlim(2)>x &&...
               ylim(1)<y && ylim(2)>y;
        
       if inaxes
        set(handles.edit8,'String',num2str(ceil(x)));
        lb=str2num(get(handles.edit7,'String'));
        set(handles.edit9,'String',num2str(ceil(x)-lb+1));
       else
         % msgbox('Вторая граница вне пределов осей.','Error','error'); 
       end
       
  end
       
       
   


% --------------------------------------------------------------------
function Open_file_Callback(hObject, eventdata, handles)
   
    
    handles=guidata(gcf);
   [FileName,PathName]=uigetfile('*.wav');
   if(FileName~=0)
        Clear_All(hObject);
        
        handles.FullFileName=[PathName FileName];
        % Read the part of the signal
        size_s = wavread(handles.FullFileName,'size');
        len_signal = size_s(1);
         
       if(len_signal<4e6)
           [s,Fs,nbits] = wavread( handles.FullFileName);
           set(handles.slider6,'Enable', 'off')
       else
        [s,Fs,nbits] = wavread( handles.FullFileName,[1 4e6]); 
        %s=downsample(s,5);
        set(handles.slider6,'Min',0,'Max',len_signal/1000000-4,'SliderStep',[0.4 0.4],'Visible','on');
       end
       
        sz=size(s);
     if(sz(2)>1)
       [channel,ok]=listdlg('ListString',{'1','2'},'Name','Find impulses',...
        'PromptString','Канал','SelectionMode','single','ListSize',[100 50]);
        if(ok==0) 
            channel=NaN;
        end
     else
         channel=1;
     end
     
     
       if(~isnan(channel))
         s = s(:,channel);
         plot(handles.axes1,s);
         set(handles.axes1,'XLim',[1 4e6]);
       end
         handles.channel=channel;
       guidata(hObject,handles);
   end


% --------------------------------------------------------------------
function Save_File_Callback(hObject, eventdata, handles)
   
  


% --------------------------------------------------------------------
function Gauss_signal_Callback(hObject, eventdata, handles)
 handles=guidata(hObject);
    sz=size(handles.strlistbox4);
    
    Fs = 3e6;
    Fsk = Fs/1e3;
    
  if(sz(2)>0)
        contents = cellstr(get(handles.listbox4,'String')); %returns listbox4 contents as cell array
        valcont=contents{get(handles.listbox4,'Value')};
        val=str2num(valcont(end));
        
       [FileName,PathName]= uiputfile('*.wav','DialogTitle','_signal_gauss');
    if(FileName~=0)
       wavwrite(handles.s_gauss{val}, Fsk*1e3, [PathName FileName]);
    end
    
  end

  

% --------------------------------------------------------------------
function Gauss_component_1_Callback(hObject, eventdata, handles)
 handles=guidata(hObject);
    sz=size(handles.strlistbox4);
    
    Fs = 3e6;
    Fsk = Fs/1e3;
    
  if(sz(2)>0)
        contents = cellstr(get(handles.listbox4,'String')); %returns listbox4 contents as cell array
        valcont=contents{get(handles.listbox4,'Value')};
        val=str2num(valcont(end));
        
    
       [FileName,PathName]= uiputfile('*.wav','DialogTitle',['_comp' num2str(1) '_gauss']);
       if(FileName~=0)
         wavwrite(real(handles.s_hat{val}(:,1)), Fsk*1e3, [PathName FileName]);
       end
     
  end


% --------------------------------------------------------------------
function Gauss_component_2_Callback(hObject, eventdata, handles)
 handles=guidata(hObject);
    sz=size(handles.strlistbox4);
    
    Fs = 3e6;
    Fsk = Fs/1e3;
    
  if(sz(2)>0)
        contents = cellstr(get(handles.listbox4,'String')); %returns listbox4 contents as cell array
        valcont=contents{get(handles.listbox4,'Value')};
        val=str2num(valcont(end));
        
    
       [FileName,PathName]= uiputfile('*.wav','DialogTitle',['_comp' num2str(2) '_gauss']);
       if(FileName~=0)
         wavwrite(real(handles.s_hat{val}(:,2)), Fsk*1e3, [PathName FileName]);
       end
     
  end


% --------------------------------------------------------------------
function Gauss_component_3_Callback(hObject, eventdata, handles)
 handles=guidata(hObject);
    sz=size(handles.strlistbox4);
    
    Fs = 3e6;
    Fsk = Fs/1e3;
    
  if(sz(2)>0)
        contents = cellstr(get(handles.listbox4,'String')); %returns listbox4 contents as cell array
        valcont=contents{get(handles.listbox4,'Value')};
        val=str2num(valcont(end));
        
    
       [FileName,PathName]= uiputfile('*.wav','DialogTitle',['_comp' num2str(3) '_gauss']);
       if(FileName~=0)
         wavwrite(real(handles.s_hat{val}(:,3)), Fsk*1e3, [PathName FileName]);
       end
     
  end


% Choose border by mouse
function radiobutton2_Callback(hObject, eventdata, handles)
    handles=guidata(hObject);
    valbtn=get(hObject,'Value');
    
   if(valbtn==1)
   zoom off
   pan off
   set(handles.radiobutton3,'Value',0);
   set(handles.radiobutton4,'Value',0);
   end

% zoom
function radiobutton3_Callback(hObject, eventdata, handles)
     valbtn=get(hObject,'Value');
  if(valbtn==1)
   zoom on
   set(handles.radiobutton2,'Value',0);
   set(handles.radiobutton4,'Value',0);
  else
      zoom off
  end
  

% pan
function radiobutton4_Callback(hObject, eventdata, handles)
     valbtn=get(hObject,'Value');
  if(valbtn==1)
    pan on
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
  else
      pan off
  end


% --------------------------------------------------------------------
function Filtering_Callback(hObject, eventdata, handles)
  handles=guidata(hObject);
  FiltState=get(hObject,'Checked');
  if isequal(FiltState,'off')
   set(hObject,'Checked','on');
   handles.filt=true;
  else
      set(hObject,'Checked','off');
      handles.filt=false;
  end
  
  guidata(hObject,handles);


% Slider
function slider6_Callback(hObject, eventdata, handles)
  handles=guidata(hObject);
  val=get(hObject,'Value');

 if(~isequal(handles.FullFileName,''))
        % Read the part of the signal
        size_s = wavread(handles.FullFileName,'size');
        len_signal = size_s(1);
        
         temp1=floor(val*1000000);
         temp2=floor(val*1000000+4e6);
         if(temp1==0)
             temp1=1;
             temp2=4e6;
              [s,Fs] = wavread( handles.FullFileName,[temp1 temp2]);
         elseif(temp2>len_signal)
             temp2=len_signal;
           [s,Fs] = wavread( handles.FullFileName,[temp1 temp2]);
         else
           [s,Fs] = wavread( handles.FullFileName,[temp1 temp2]); 
         end
        
         s = s(:,handles.channel);
         plot(handles.axes1,[temp1:temp2],s);
         set(handles.axes1,'XLim',[temp1 temp2]);
       
 end



% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
function Clear_All(hObject)
    handles=guidata(hObject);
       
handles.imp=[];
handles.imphil=[];
handles.listcont=0;
handles.setbtn=0;
handles.leftbord=[];
handles.freq=[];
handles.rightbord=[];
handles.firstbord=0;
handles.secondbord=0;
handles.thirdbord=0;
handles.listsize=NaN;
handles.exall=0;
handles.g0={};
handles.fc={};
handles.pos={};
handles.strlistbox4={};
handles.t={};
handles.s={};
handles.s_gauss={};
handles.s_hat={};
handles.drall=0;
handles.FullFileName='';
handles.theresold=NaN;
handles.channel=NaN;
handles.filt=false;
handles.power=[];
handles.freq_center=[];
handles.ind_beg=[];
handles.Fs=3000000;
handles.max_imp=NaN;
handles.min_imp=NaN;

 set(handles.listbox2,'String',{});
 set(handles.listbox4,'String',{});
 set(handles.edit1,'String','');
 set(handles.edit2,'String','');
 set(handles.edit3,'String','');
 set(handles.edit7,'String','');
 set(handles.edit8,'String','');
 set(handles.edit9,'String','');
 cla(handles.axes1);
 cla(handles.axes2);
 cla(handles.axes3);
 cla(handles.axes6);
 
 guidata(hObject,handles);
        
