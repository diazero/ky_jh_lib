function varargout = ky_rect32_uniformity(varargin)
% ky_rect32_uniformity M-file for ky_rect32_uniformity.fig
%      ky_rect32_uniformity, by itself, creates a new ky_rect32_uniformity or raises the existing
%      singleton*.
%
%      H = ky_rect32_uniformity returns the handle to a new ky_rect32_uniformity or the handle to
%      the existing singleton*.
%
%      ky_rect32_uniformity('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ky_rect32_uniformity.M with the given input arguments.
%
%      ky_rect32_uniformity('Property','Value',...) creates a new ky_rect32_uniformity or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Motor_seq_simple_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ky_rect32_uniformity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ky_rect32_uniformity
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Last Modified by GUIDE v2.5 14-Nov-2016 23:47:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ky_rect32_uniformity_OpeningFcn, ...
    'gui_OutputFcn',  @ky_rect32_uniformity_OutputFcn, ...
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


% --- Executes just before ky_rect32_uniformity is made visible.
function ky_rect32_uniformity_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ky_rect32_uniformity (see VARARGIN)

% Choose default command line output for ky_rect32_uniformity
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.xyz_abcd = 'a';
handles.move_option = 'manual';
handles.gpib_cmut_hv = 5;
handles.instrument_cmut_hv = 'PS310';

handles.rs_scope_ip = '171.64.84.150';
handles.rs_scope_sample_size = 5000;
handles.settings = ky_xyz_init ('xyz');
handles.sel_ch1 = 1;
handles.sel_ch2 = 0;
handles.sel_ch3 = 0;
handles.sel_ch4 = 0;
handles.settings.move_stage_time = 0;
handles.fpga_com = 'COM14';
handles.fpga_baudrate = 9600; % default in VHDL design

beam_id = 1:960;
k= 1;
for m = 1:32
    for n=  1:32
        if(m ==n)||(m == 33-n)
        else
            handles.data.beam_num(m,n) = beam_id(k)-1;
            k = k +1;
        end
    end
end



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ky_rect32_uniformity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ky_rect32_uniformity_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonreadxyz.
function pushbuttonreadxyz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonreadxyz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cur_pos = ky_xyz_get_position(handles.settings);
% Read an absolute distance
temp_x = cur_pos(1);
temp_y = cur_pos(2);
temp_z = cur_pos(3);

switch handles.xyz_abcd
    case {'a'}
        handles.ax = temp_x;
        handles.ay = temp_y;
    case {'b'}
        handles.bx = temp_x;
        handles.by = temp_y;
    case {'c'}
        handles.cx = temp_x;
        handles.cy = temp_y;
    case {'d'}
        handles.dx = temp_x;
        handles.dy = temp_y;
end

switch handles.xyz_abcd
    case {'a'}
        set(handles.editax,'String',[]);
        set(handles.editax,'String',num2str(handles.ax));
        disp(num2str(handles.ax));
        set(handles.editay,'String',[]);
        set(handles.editay,'String',num2str(handles.ay));
        disp(num2str(handles.ay));
    case {'b'}
        set(handles.editbx,'String',[]);
        set(handles.editbx,'String',num2str(handles.bx));
        disp(num2str(handles.bx));
        set(handles.editby,'String',[]);
        set(handles.editby,'String',num2str(handles.by));
        disp(num2str(handles.by));
    case {'c'}
        set(handles.editcx,'String',[]);
        set(handles.editcx,'String',num2str(handles.cx));
        disp(num2str(handles.cx));
        set(handles.editcy,'String',[]);
        set(handles.editcy,'String',num2str(handles.cy));
        disp(num2str(handles.cy));
    case {'d'}
        set(handles.editdx,'String',[]);
        set(handles.editdx,'String',num2str(handles.dx));
        disp(num2str(handles.dx));
        set(handles.editdy,'String',[]);
        set(handles.editdy,'String',num2str(handles.dy));
        disp(num2str(handles.dy));
end
guidata(hObject, handles);



% --- Executes on button press in pushbuttonsavedata.
function pushbuttonsavedata_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonsavedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Bias_Instrument=handles.instrument_cmut_hv;
GpibBias=handles.gpib_cmut_hv;
if(handles.bias_step == 0)
    handles.bias_step = 1;
end
Bias_Index=handles.bias_start:handles.bias_step:handles.bias_stop;
handles.data.bias_index = Bias_Index;
handles.data.bias_wave_form   = zeros(32,32,length(Bias_Index),handles.rs_scope_sample_size); % pre-allocate output waveform matrix
[handles.scope, success] = ky_scope_rs_init(handles.rs_scope_ip, handles.rs_scope_sample_size);
cur_pos = ky_xyz_get_position(handles.settings);
k = 1;
% Read an absolute distance

handles.data.z = cur_pos(3);
if(handles.sel_ch1 == 1)
handles.sel_ch = 1;
end
if(handles.sel_ch2 == 1)
handles.sel_ch = 2;
end
if(handles.sel_ch3 == 1)
handles.sel_ch = 3;
end
if(handles.sel_ch4 == 1)
handles.sel_ch = 4;
end
print_message('Measurement Start!',handles);

for m =  handles.row_start:handles.row_stop
    for n = handles.col_start:handles.col_stop
        if(m ==n)||(m == 33-n)
        else
            tic;
            temp = dec2bin(handles.data.beam_num(m,n),16);
            bit2 = temp(2:9);
            bit1 = temp(10:16);
            %UART communication : Transfer BID
            ky_uart(handles.fpga_com,handles.fpga_baudrate,'set_lsb1',bin2dec(bit1));
            ky_uart(handles.fpga_com,handles.fpga_baudrate,'set_msb',bin2dec(bit2));
            
            % Motrized Positioner : Move stage
            ky_xyz_goto_position(handles.settings, handles.data.x(m,n),handles.data.y(m,n),handles.data.z)
            % Change Bias
            for i=1:length(Bias_Index)
                Bias = Bias_Index(i);   % Bias Voltage
                if(length(Bias_Index) ==1)
                else
                print_message(sprintf('Set Bias Voltage to %d',Bias),handles);
                kypib('PS310',GpibBias,'set','volt',Bias);
                %pause(30*i);
                end
                % Read data
                print_message(sprintf('Read Data (%d V)',Bias),handles);
                
                arr_structs              = ky_scope_rs_get_ch_data(handles.scope, handles.sel_ch); % grabs/stores data
                if handles.rs_scope_sample_size ~= arr_structs.num_samples % tests to make sure the amount of samples grabbed is correct
                    error('The sample size used on Scope is different from the sample size stored in settings');
                end
                handles.data.bias_wave_form(m,n,i,:) = arr_structs.data; % stores the waveform data
                handles.data.fs = arr_structs.fs;
                
                dt = 1/arr_structs.fs;
                time = dt:dt:dt*length(arr_structs.data);
                 axes(handles.axesFig2);
                 plot(time*10^6,arr_structs.data,'linewidth',2);
                xlabel('Time [us]');
                ylabel('Voltage [V]');
                % Save File
                %pause(1);
            end
            unit_time_sec = toc;
            total_time_sec = unit_time_sec*(960-handles.data.beam_num(m,n))
            k = k+1;
            total_time_hr = fix(total_time_sec/60/60);   % integer part
            total_time_min = fix(rem(total_time_sec,60*60)/60);
            total_time_sec = rem(total_time_sec,60);
            % kypib('PS310',GpibBias,'set','volt',0);
            print_message(sprintf('Beam ID : %d, Remaining Time : %2.2f hr, %2.2f min, %2.2f sec',handles.data.beam_num(m,n),total_time_hr,total_time_min,total_time_sec),handles);
        end
    end
    save_row_data(handles,m);
end
save_data(handles);

function save_data(handles)
file_name=handles.FileName;
data = handles.data;
save([file_name '.MAT'],'data');
print_message(sprintf('%s Saved',[file_name '.MAT']),handles);

function save_row_data(handles,row_n)
file_name=handles.FileName;
data = handles.data;
save([file_name '_' num2str(row_n) '.MAT'],'data');
print_message(sprintf('%s Saved',[file_name '.MAT']),handles);

% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axesFig1);
cla;
% W1_D16
%m =32;
%n = 25;
%start_n = 5;
%end_n = 29;

%W1_D4
% m =31;
% n = 32;
% start_m = 2; 
% end_m = 32;
% start_n = 1;
% end_n = 32;

% W1_D7
start_m = 1; 
end_m = 32;
m =end_m-start_m+1;
start_n = 2;
end_n = 31;
n = end_n-start_n+1;

data.x0(:,1) = linspace(handles.ax, handles.dx, m);
data.x0(:,n) = linspace(handles.bx, handles.cx, m);
data.y0(:,1) = linspace(handles.ay, handles.dy, m);
data.y0(:,n) = linspace(handles.by, handles.cy, m);

for i = 1:m
    data.x0(i,:) = linspace(data.x0(i,1), data.x0(i,n),n);
    data.y0(i,:) = linspace(data.y0(i,1), data.y0(i,n),n);
end
% col extrapoloation
for i = 1:m
    data.ext_x0(i,:) = interp1(start_n:end_n,data.x0(i,1:n),1:32,'linear','extrap');
    data.ext_y0(i,:) = interp1(start_n:end_n,data.y0(i,1:n),1:32,'linear','extrap');
end

% row extrapoloation
% for i = 1:n
%     data.ext_x0(:,i) = interp1(start_m:end_m,data.x0(1:m,i),1:32,'linear','extrap');
%     data.ext_y0(:,i) = interp1(start_m:end_m,data.y0(1:m,i),1:32,'linear','extrap');
% end

for m = 1:32
    for n = 1:32
%         if(n>30)
%         else
%             pos = [data.x0(m,n)- 0.1 data.y0(m,n)- 0.1 0.2 0.2];
%             rectangle('Position',pos,'Curvature',[1 1])
%             hold on;
%         end
        pos = [data.ext_x0(m,n)- 0.1 data.ext_y0(m,n)- 0.1 0.2 0.2];
        rectangle('Position',pos,'Curvature',[1 1])
        hold on;
    end
end
plot([handles.ax handles.bx handles.cx handles.dx handles.ax],[handles.ay handles.by handles.cy handles.dy handles.ay],'r');
xlabel('X[mm]');
ylabel('Y[mm]');
%saveas(gcf,'grid_interp','png');
handles.data.x = data.ext_x0;
handles.data.y = data.ext_y0;
guidata(hObject,handles);

function editFileName_Callback(hObject, eventdata, handles)
% hObject    handle to editFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFileName as text
%        str2double(get(hObject,'String')) returns contents of editFileName as a double
FileNameTemp=get(hObject,'String');

flag=0;
if length(FileNameTemp)>0
    for i=1:length(FileNameTemp)
        if FileNameTemp(i)=='\'
            flag=1;
            break;
        end
    end
    
    if flag==0 % No Folder information
        handles.FileName=[handles.nofolder FileNameTemp];
    else % Folder information
        handles.FileName=FileNameTemp;
    end
end

handles=check_measurement_parameter(handles);

guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Motorized Positioner function %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in popupmenu_abcd.
function popupmenu_abcd_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_abcd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_abcd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_abcd
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'a position'
        handles.xyz_abcd='a';
        print_message('a position is selected',handles);
    case 'b position'
        handles.xyz_abcd='b';
        print_message('b position is selected',handles);
    case 'c position'
        handles.xyz_abcd='c';
        print_message('c position is selected',handles);
    case 'd position'
        handles.xyz_abcd='d';
        print_message('d position is selected',handles);
    case 'else'
        handles.xyz_abcd='a';
        print_message('default: a position is selected',handles);
end

guidata(hObject,handles);


function edit_motorX_Callback(hObject, eventdata, handles)
% hObject    handle to edit_motorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_motorX as text
%        str2double(get(hObject,'String')) returns contents of edit_motorX as a double
handles.motorX = str2double(get(hObject,'String'));
print_message(sprintf('X[mm] : %2.2fmm',handles.motorX),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_motorY_Callback(hObject, eventdata, handles)
% hObject    handle to edit_motorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_motorY as text
%        str2double(get(hObject,'String')) returns contents of edit_motorY as a double
handles.motorY = str2double(get(hObject,'String'));
print_message(sprintf('Y[mm] : %2.2fmm',handles.motorY),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes on button press in pushbutton_move.
function pushbutton_move_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Sending Moving Commands
cur_pos = ky_xyz_get_position(handles.settings);
% Read an absolute distance
temp_x = cur_pos(1);
temp_y = cur_pos(2);
temp_z = cur_pos(3);
handles.data.z = temp_z;

switch handles.move_option;
    case 'manual'
        % Move a absolute distance
        ky_xyz_goto_position(handles.settings, handles.motorX,handles.motorY,handles.motorZ)
    case 'array'
        ky_xyz_goto_position(handles.settings, handles.data.x(handles.row,handles.column),handles.data.y(handles.row,handles.column),handles.data.z)
        beam_num = handles.data.beam_num(handles.row,handles.column);
        temp = dec2bin(beam_num,16);
        %         bit2 = temp(1:8);
        %         bit1 = temp(9:16);
        bit2 = temp(2:9);
        bit1 = temp(10:16);
        %UART communication : Transfer BID
        
        ky_uart(handles.fpga_com,handles.fpga_baudrate,'set_lsb1',bin2dec(bit1));
        ky_uart(handles.fpga_com,handles.fpga_baudrate,'set_msb',bin2dec(bit2));
end
guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom functoin %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function print_message(message_out,handles)
set(handles.editMessage,'String',[]);
set(handles.editMessage,'String',message_out);
disp(message_out);

function new_handles=check_measurement_parameter(handles)
if isfield(handles,'FileName')
    
    if (~isempty(handles.FileName))
        set(handles.pushbuttonsavedata,'Enable','on');
    else
        set(handles.pushbuttonsavedata,'Enable','off');
    end
    
else
    set(handles.pushbuttonsavedata,'Enable','off');
end

if isfield(handles,'motorX') &&...
        isfield(handles,'motorY')
    if ((handles.motorX >= 0) && (handles.motorX <= 25))&&...
            ((handles.motorY >= 0) && (handles.motorY <= 25))&&...
        set(handles.pushbutton_move,'Enable','on');
    else
        set(handles.pushbutton_move,'Enable','off');
    end
elseif isfield(handles,'row') &&...
        isfield(handles,'column')
    if((handles.row > 0) && (handles.row <= 32))&&...
            ((handles.column > 0) && (handles.column <= 32))
        set(handles.pushbutton_move,'Enable','on');
    else
        set(handles.pushbutton_move,'Enable','off');
    end
else
    set(handles.pushbutton_move,'Enable','off');
end


set(handles.pushbuttonreadxyz,'Enable','on');
set(handles.pushbutton_plot,'Enable','on');

new_handles=handles;

% guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unnecessary function but required for GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function editMessage_Callback(hObject, eventdata, handles)
% hObject    handle to editMessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMessage as text
%        str2double(get(hObject,'String')) returns contents of editMessage as a double


% --- Executes during object creation, after setting all properties.
function editMessage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_motorX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_motorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_motorY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_motorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_motorZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_motorZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editax_Callback(hObject, eventdata, handles)
% hObject    handle to editax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editax as text
%        str2double(get(hObject,'String')) returns contents of editax as a double
handles.ax = str2double(get(hObject,'String'));
print_message(sprintf('ax : %2.2fmm',handles.ax),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function editay_Callback(hObject, eventdata, handles)
% hObject    handle to editay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editay as text
%        str2double(get(hObject,'String')) returns contents of editay as a double
handles.ay = str2double(get(hObject,'String'));
print_message(sprintf('ay : %2.2fmm',handles.ay),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editay_CreateFcn(hObject, ~, handles)
% hObject    handle to editay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editbx_Callback(hObject, eventdata, handles)
% hObject    handle to editbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editbx as text
%        str2double(get(hObject,'String')) returns contents of editbx as a double
handles.bx = str2double(get(hObject,'String'));
print_message(sprintf('bx : %2.2fmm',handles.bx),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editbx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editby_Callback(hObject, eventdata, handles)
% hObject    handle to editby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editby as text
%        str2double(get(hObject,'String')) returns contents of editby as a double
handles.by = str2double(get(hObject,'String'));
print_message(sprintf('by : %2.2fmm',handles.by),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editby_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editcx_Callback(hObject, eventdata, handles)
% hObject    handle to editcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editcx as text
%        str2double(get(hObject,'String')) returns contents of editcx as a double
handles.cx = str2double(get(hObject,'String'));
print_message(sprintf('cx : %2.2fmm',handles.cx),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editcx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editcy_Callback(hObject, eventdata, handles)
% hObject    handle to editcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editcy as text
%        str2double(get(hObject,'String')) returns contents of editcy as a double
handles.cy = str2double(get(hObject,'String'));
print_message(sprintf('cy : %2.2fmm',handles.cy),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editcy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editcy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editdx_Callback(hObject, eventdata, handles)
% hObject    handle to editdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdx as text
%        str2double(get(hObject,'String')) returns contents of editdx as a double
handles.dx = str2double(get(hObject,'String'));
print_message(sprintf('dx : %2.2fmm',handles.dx),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editdx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editdy_Callback(hObject, eventdata, handles)
% hObject    handle to editdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdy as text
%        str2double(get(hObject,'String')) returns contents of editdy as a double
handles.dy = str2double(get(hObject,'String'));
print_message(sprintf('dy : %2.2fmm',handles.dy),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editdy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function popupmenu_abcd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_abcd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_move.
function popupmenu_move_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_move contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_move
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'Manual'
        handles.move_option='manual';
        print_message('Manual X/Y/Z is selected',handles);
    case 'Array'
        handles.move_option='array';
        print_message('Array row/column is selected',handles);
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_move_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_row_Callback(hObject, eventdata, handles)
% hObject    handle to edit_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_row as text
%        str2double(get(hObject,'String')) returns contents of edit_row as a double
handles.row = str2double(get(hObject,'String'));
print_message(sprintf('Move to Row : %d',handles.row),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_column_Callback(hObject, eventdata, handles)
% hObject    handle to edit_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_column as text
%        str2double(get(hObject,'String')) returns contents of edit_column as a double
handles.column = str2double(get(hObject,'String'));
print_message(sprintf('Move to Column :%d',handles.column),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);




function edit_set_row_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_row as text
%        str2double(get(hObject,'String')) returns contents of edit_set_row as a double
handles.set_row = str2double(get(hObject,'String'));
print_message(sprintf('Set Row :%d',handles.set_row),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_set_column_Callback(hObject, eventdata, handles)
% hObject    handle to edit_set_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_set_column as text
%        str2double(get(hObject,'String')) returns contents of edit_set_column as a double
handles.set_column = str2double(get(hObject,'String'));
print_message(sprintf('Set Column :%d',handles.set_column),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function edit_column_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_set_row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_set_column_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_set_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bias_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bias_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bias_start as text
%        str2double(get(hObject,'String')) returns contents of edit_bias_start as a double
handles.bias_start = str2double(get(hObject,'String'));
print_message(sprintf('bias_start : %2.2f [V]',handles.bias_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_bias_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bias_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bias_stop_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bias_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bias_stop as text
%        str2double(get(hObject,'String')) returns contents of edit_bias_stop as a double
handles.bias_stop = str2double(get(hObject,'String'));
print_message(sprintf('bias_stop : %2.2f [V]',handles.bias_stop),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_bias_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bias_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bias_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bias_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bias_step as text
%        str2double(get(hObject,'String')) returns contents of edit_bias_step as a double
handles.bias_step = str2double(get(hObject,'String'));
print_message(sprintf('bias_step : %2.2f [V]',handles.bias_step),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_bias_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bias_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fpga_com_Callback(hObject, ~, handles)
% hObject    handle to edit_fpga_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fpga_com as text
%        str2double(get(hObject,'String')) returns contents of edit_fpga_com as a double
handles.fpga_com = str2double(get(hObject,'String'));
print_message(sprintf('FPGA COM PORT : %2.2f [V]',handles.fpga_com),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_fpga_com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fpga_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_baudrate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_baudrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_baudrate as text
%        str2double(get(hObject,'String')) returns contents of edit_baudrate as a double
handles.fpga_baudrate = str2double(get(hObject,'String'));
print_message(sprintf('FPGA baud rate : %2.2f [V]',handles.fpga_baudrate),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_baudrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_baudrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ac_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ac_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ac_start as text
%        str2double(get(hObject,'String')) returns contents of edit_ac_start as a double
handles.ac_start = str2double(get(hObject,'String'));
print_message(sprintf('AC Start : %2.2f [V]',handles.ac_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_ac_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ac_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ac_stop_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ac_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ac_stop as text
%        str2double(get(hObject,'String')) returns contents of edit_ac_stop as a double
handles.ac_stop = str2double(get(hObject,'String'));
print_message(sprintf('AC Stop : %2.2f [V]',handles.ac_stop),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_ac_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ac_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ac_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ac_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ac_step as text
%        str2double(get(hObject,'String')) returns contents of edit_ac_step as a double
handles.ac_step = str2double(get(hObject,'String'));
print_message(sprintf('AC step : %2.2f [V]',handles.ac_step),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_ac_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ac_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_row_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_row_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_row_start as text
%        str2double(get(hObject,'String')) returns contents of edit_row_start as a double
handles.row_start = str2double(get(hObject,'String'));
print_message(sprintf('Row Start : %d',handles.row_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_row_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_row_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_row_stop_Callback(hObject, eventdata, handles)
% hObject    handle to edit_row_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_row_stop as text
%        str2double(get(hObject,'String')) returns contents of edit_row_stop as a double
handles.row_stop = str2double(get(hObject,'String'));
print_message(sprintf('Row Stop : %d',handles.row_stop),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_row_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_row_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_col_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_col_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_col_start as text
%        str2double(get(hObject,'String')) returns contents of edit_col_start as a double
handles.col_start = str2double(get(hObject,'String'));
print_message(sprintf('column Start : %d',handles.col_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_col_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_col_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_col_stop_Callback(hObject, eventdata, handles)
% hObject    handle to edit_col_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_col_stop as text
%        str2double(get(hObject,'String')) returns contents of edit_col_stop as a double
handles.col_stop = str2double(get(hObject,'String'));
print_message(sprintf('column Stop : %d',handles.col_stop),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_col_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_col_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scope_sample_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scope_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scope_sample as text
%        str2double(get(hObject,'String')) returns contents of edit_scope_sample as a double
handles.rs_scope_sample_size = str2double(get(hObject,'String'));
print_message(sprintf('Scope Sample : %d',handles.rs_scope_sample_size),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_scope_sample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scope_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'ch1'
        handles.sel_ch=1;
        print_message('Ch1 is selected',handles);
    case 'ch2'
        handles.sel_ch=2;
        print_message('Ch2 is selected',handles);
    case 'ch3'
        handles.sel_ch=3;
        print_message('Ch3 is selected',handles);
    case 'ch4'
        handles.sel_ch=4;
        print_message('Ch4 is selected',handles);
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
