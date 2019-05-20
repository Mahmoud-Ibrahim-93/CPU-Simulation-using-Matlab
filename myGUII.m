function varargout = myGUII(varargin)
% MYGUII MATLAB code for myGUII.fig
%      MYGUII, by itself, creates a new MYGUII or raises the existing
%      singleton*.
%
%      H = MYGUII returns the handle to a new MYGUII or the handle to
%      the existing singleton*.
%
%      MYGUII('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUII.M with the given input arguments.
%
%      MYGUII('Property','Value',...) creates a new MYGUII or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before myGUII_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myGUII_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help myGUII

% Last Modified by GUIDE v2.5 19-May-2019 22:51:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myGUII_OpeningFcn, ...
                   'gui_OutputFcn',  @myGUII_OutputFcn, ...
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


% --- Executes just before myGUII is made visible.
function myGUII_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myGUII (see VARARGIN)

% Choose default command line output for myGUII
handles.output = hObject;

% Update handles structure
set(handles.axes1,'Units','normalized')
set(handles.figure1,'PaperUnits','normalized')
handles.NumberOfDisplayedMemoryLocations=15;








set(handles.axes1,'Position',[.05 0.05 .9 0.9])

[handles.MemorySize,handles.simulationStruct]=startSimulation(0);

% Set the GUI title
title(handles.axes1,'CPU Simulation')
% Set the Window default state to be maximized
hObject.WindowState='Maximized';
% normalize objects units
set(handles.memorySlider,'Units','normalized')
set(handles.jmp2End,'Units','normalized')
set(handles.startBtn,'Units','normalized')
set(handles.updateSim,'Units','normalized')
set(handles.pauseResumeBtn,'Units','normalized')


% Adjust the position of txt jump2End
% 'Position' is [x y width height])
set(handles.jmp2End,'Position',[0.05 0.95 0.3 0.04])

% Adjust the position of button updateSim
% 'Position' is [x y width height])
set(handles.updateSim,'Position',[0.23 0.95 0.15 0.04])

% Adjust the position of PAUSE/RESUME button 
% 'Position' is [x y width height])
set(handles.pauseResumeBtn,'Position',[0.615 0.95 0.15 0.04])

% Adjust the position of strat button
% 'Position' is [x y width height])
set(handles.startBtn,'Position',[.8 0.95 0.15 0.04])
% Adjust the position of the memory slider
% 'Position' is [x y width height])
set(handles.memorySlider,'Position',[.95 0.05 0.05 0.9])
% set(handles.jmp2End,'BackgroundColor','none')
% Initial value of the axes (x axis 0 to 1 , y axis from 0 to 1 )
xlim(handles.axes1,[0 1])
ylim(handles.axes1,[0 1])

%  remove any numbers of the `is and y-axis
set(handles.axes1,'xtick',[]);
set(handles.axes1,'ytick',[]);

% Create a box around the drawing
box on

handles.memorySlider.Max=handles.MemorySize-handles.NumberOfDisplayedMemoryLocations;
handles.memorySlider.Min=0;
handles.memorySlider.SliderStep=[1/(handles.MemorySize-1),1/(handles.MemorySize-1)];
handles.memorySlider.Value=handles.memorySlider.Max;

% block(floorscount,floor_rooms_count,origin_x,origin_y,room_width,room_height)
handles.ram_title= block(1,1,.68,.9,.3,.08);
handles.ram_title.fillLocation(1,1,'Main Memory');
handles.ram_title.building(1,1).txtObj.FontSize=32;
handles.ram_subTitles= block(1,2,.68,.8,.15,.04);
handles.ram_subTitles.fillLocation(1,1,'Address');
handles.ram_subTitles.building(1,1).txtObj.FontSize=26;
handles.ram_subTitles.fillLocation(1,2,'Value');
handles.ram_subTitles.building(1,2).txtObj.FontSize=26;
handles.ram= block(handles.NumberOfDisplayedMemoryLocations,2,.68);


for i = 0 : size(handles.ram.building,1)-1
    handles.ram.fillLocation(i+1,1,strcat('0x',dec2hex(i,8)));
end


handles.Registers_title= block(1,1,.050,.3,.3,.08);
handles.Registers_title.fillLocation(1,1,'Registers');
handles.Registers_title.building(1,1).txtObj.FontSize=32;
handles.Registers=block (4,2,0.05,.05);
handles.Registers.fillLocation(1,1,'Program Counter-PC');
handles.Registers.fillLocation(2,1,'Stack Pointer SP');
handles.Registers.fillLocation(3,1,'General Register R0');
handles.Registers.fillLocation(4,1,'General Register R1');

handles.IR_title= block(1,1,.050,.9,.18,.05);
handles.IR_title.fillLocation(1,1,'Executed Instruction');
handles.IR_title.building(1,1).txtObj.FontSize=20;

handles.IR_Value= block(1,1,.25,.9,.19,.05);
handles.IR_Value.fillLocation(1,1,'00000000000000000');
handles.IR_Value.building(1,1).txtObj.FontSize=20;


handles.InstructionDescription= block(1,1,.05,.7,.45,.2);
s='Here Lies the Description of the instruction being\nexecuted';
handles.InstructionDescription.fillLocation(1,1,sprintf(s));
handles.InstructionDescription.building(1,1).txtObj.FontSize=20;

handles.AddressingMode_title= block(1,1,.050,.6,.18,.05);
handles.AddressingMode_title.fillLocation(1,1,'Addressing mode');
handles.AddressingMode_title.building(1,1).txtObj.FontSize=20;

handles.AddressingMode_Value= block(1,1,.25,.6,.19,.05);
handles.AddressingMode_Value.fillLocation(1,1,'0');
handles.AddressingMode_Value.building(1,1).txtObj.FontSize=20;


handles.AddressingModeDescription= block(1,1,.05,.4,.45,.2);
s='Here Lies the Description of the Addressing mode\nbeing executed';
handles.AddressingModeDescription.fillLocation(1,1,sprintf(s));
handles.AddressingModeDescription.building(1,1).txtObj.FontSize=20;











guidata(hObject, handles);









% UIWAIT makes myGUII wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = myGUII_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Set the Window default state to be maximized
hObject.WindowState='Maximized';


% guidata(hObject, handles);

% pause(2)
% Registers.building(5,1).swap(ram.building(10,1));
% pause(.2);
% Registers.building(5,1).moveRight(.15);



% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




guidata(hObject, handles);


% --- Executes on button press in jmp2End.
function jmp2End_Callback(hObject, eventdata, handles)
% hObject    handle to jmp2End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of jmp2End


% --- Executes on button press in startBtn.
function startBtn_Callback(hObject, eventdata, handles)
% hObject    handle to startBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% guidata(hObject, handles);
% pivot=round(handles.memorySlider.Value);
% count=1;
% for i = pivot : pivot+handles.NumberOfDisplayedMemoryLocations-1
%     disp(handles.ram.building(count,1).txtObj.String);
% %     set(handles.ram.building(count,1).txtObj,'String','fffffffff');
% %     drawnow
%     disp(handles.ram.building(count,1).txtObj.String);
%     handles.ram.fillLocation(count,1,'fffffffff');
%     drawnow
%     count=count+1;
% end
% guidata(hObject, handles);

disp(handles.memorySlider.Value)

% --- Executes on slider movement.
function memorySlider_Callback(hObject, eventdata, handles)
% hObject    handle to memorySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
pivot=round(handles.memorySlider.Value);
count=0;
for i =  pivot:pivot+handles.NumberOfDisplayedMemoryLocations-1
    handles.ram.fillLocation(handles.NumberOfDisplayedMemoryLocations-count,1,strcat('0x',dec2hex(handles.MemorySize-i-1,8)));
%     drawnow
    count=count+1;

end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function memorySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to memorySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in updateSim.
function updateSim_Callback(hObject, eventdata, handles)
% hObject    handle to updateSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Please wait until simulation object is created then the color of the axes would change')
[handles.MemorySize,handles.simulationStruct]=startSimulation(1);
guidata(hObject, handles);
set(handles.axes1,'Color',[rand rand rand])


% --- Executes on button press in pauseResumeBtn.
function pauseResumeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to pauseResumeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
