function varargout = ky_gui_move_scan_xyz(varargin)
% ky_gui_move_scan_xyz M-file for ky_gui_move_scan_xyz.fig
%      ky_gui_move_scan_xyz, by itself, creates a new ky_gui_move_scan_xyz or raises the existing
%      singleton*.
%
%      H = ky_gui_move_scan_xyz returns the handle to a new ky_gui_move_scan_xyz or the handle to
%      the existing singleton*.
%
%      ky_gui_move_scan_xyz('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ky_gui_move_scan_xyz.M with the given input arguments.
%
%      ky_gui_move_scan_xyz('Property','Value',...) creates a new ky_gui_move_scan_xyz or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Motor_seq_simple_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ky_gui_move_scan_xyz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ky_gui_move_scan_xyz
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Last Modified by GUIDE v2.5 13-Jan-2017 13:04:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ky_gui_move_scan_xyz_OpeningFcn, ...
    'gui_OutputFcn',  @ky_gui_move_scan_xyz_OutputFcn, ...
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


% --- Executes just before ky_gui_move_scan_xyz is made visible.
function ky_gui_move_scan_xyz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ky_gui_move_scan_xyz (see VARARGIN)

% Choose default command line output for ky_gui_move_scan_xyz
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handles.nofolder='C:\Users\JiHoon\Documents\MATLAB';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.settings = ky_xyz_init ('xyz');
handles.sel_ch1 = 1;
handles.sel_ch2 = 0;
handles.sel_ch3 = 0;
handles.sel_ch4 = 0;
handles.settings.move_stage_time = 0;
handles.scope_option='RS';
handles.rs_scope_ip = '171.64.84.150';
set(handles.pushbutton_read_xyz,'Enable','on');

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ky_gui_move_scan_xyz_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_read_xyz.
function pushbutton_read_xyz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_xyz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cur_pos = ky_xyz_get_position(handles.settings);
% Read an absolute distance
temp_x = cur_pos(1);
temp_y = cur_pos(2);
temp_z = cur_pos(3);

handles.current_x = temp_x;
handles.current_y = temp_y;
handles.current_z = temp_z;

set(handles.edit_current_x,'String',[]);
set(handles.edit_current_x,'String',num2str(handles.current_x));
disp(num2str(handles.current_x));
set(handles.edit_current_y,'String',[]);
set(handles.edit_current_y,'String',num2str(handles.current_y));
disp(num2str(handles.current_y));
set(handles.edit_current_z,'String',[]);
set(handles.edit_current_z,'String',num2str(handles.current_z));
disp(num2str(handles.current_z));

guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Motorized Positioner function %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in popupmenu_abcd.

% --- Executes on button press in pushbutton_scan_xy.
function pushbutton_scan_xy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_scan_xy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Sending Moving Commands

timeout = 2; % timeout for waiting the move to be completed
sample_size = handles.scope_sample_size;
axis = 'xyz';
if(handles.sel_ch1)
    ch_read = [1];
end
if(handles.sel_ch2)
    ch_read = [ch_read 2];
end
if(handles.sel_ch3)
    ch_read = [ch_read 3];
end
if(handles.sel_ch4)
    ch_read = [ch_read 4];
end
switch handles.scope_option;
    case 'RS'
        scope_addr = handles.rs_scope_ip;
        handles.settings = ky_hydro_init_scan(scope_addr, sample_size, axis, ch_read);
        cur_pos = ky_xyz_get_position(handles.settings);
        % Read an absolute distance
        temp_x = cur_pos(1);
        temp_y = cur_pos(2);
        temp_z = cur_pos(3);
        handles.settings.scan_xy = ky_hydro_scan_xy(handles.settings, [temp_x temp_x+handles.scan_x_range], handles.scan_x_points, [temp_y temp_y+handles.scan_y_range], handles.scan_y_points);
        scan_data = handles.settings.scan_xy;
        save_data(scan_data,'xy',handles)
    case 'HP'
        
end
guidata(hObject,handles);

% --- Executes on button press in pushbutton_scan_yz.
function pushbutton_scan_yz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_scan_yz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

timeout = 2; % timeout for waiting the move to be completed
sample_size = handles.scope_sample_size;
axis = 'xyz';
if(handles.sel_ch1)
    ch_read = [1];
end
if(handles.sel_ch2)
    ch_read = [ch_read 2];
end
if(handles.sel_ch3)
    ch_read = [ch_read 3];
end
if(handles.sel_ch4)
    ch_read = [ch_read 4];
end
switch handles.scope_option;
    case 'RS'
        scope_addr = handles.rs_scope_ip;
        handles.settings = ky_hydro_init_scan(scope_addr, sample_size, axis, ch_read);
        cur_pos = ky_xyz_get_position(handles.settings);
        % Read an absolute distance
        temp_x = cur_pos(1);
        temp_y = cur_pos(2);
        temp_z = cur_pos(3);
        handles.settings.scan_yz = ky_hydro_scan_yz(handles.settings, [temp_y temp_y+handles.scan_y_range], handles.scan_y_points, [temp_z temp_z+handles.scan_z_range], handles.scan_z_points);
        scan_data = handles.settings.scan_yz;
        save_data(scan_data,'yz',handles)
    case 'HP'
        
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton_scan_xyz.
function pushbutton_scan_xyz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_scan_xyz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timeout = 2; % timeout for waiting the move to be completed
sample_size = handles.scope_sample_size;
axis = 'xyz';
if(handles.sel_ch1)
    ch_read = [1];
end
if(handles.sel_ch2)
    ch_read = [ch_read 2];
end
if(handles.sel_ch3)
    ch_read = [ch_read 3];
end
if(handles.sel_ch4)
    ch_read = [ch_read 4];
end
switch handles.scope_option;
    case 'RS'
        scope_addr = handles.rs_scope_ip;
        handles.settings = ky_hydro_init_scan(scope_addr, sample_size, axis, ch_read);
        cur_pos = ky_xyz_get_position(handles.settings);
        % Read an absolute distance
        temp_x = cur_pos(1);
        temp_y = cur_pos(2);
        temp_z = cur_pos(3);
        handles.settings.scan_xyz = ky_hydro_scan_volume(handles.settings, [temp_x temp_x+handles.scan_x_range], handles.scan_x_points, [temp_y temp_y+handles.scan_y_range], handles.scan_y_points, [temp_z temp_z+handles.scan_z_range], handles.scan_z_points);
        scan_data = handles.settings.scan_xyz;
        save_data(scan_data,'xyz',handles)
    case 'HP'
        
end
guidata(hObject,handles);


function save_data(scan_data,scan_type,handles)
time_stamp = clock;
file_name = [handles.FileName '_' num2str(time_stamp(1)) num2str(time_stamp(2)) num2str(time_stamp(3)) num2str(time_stamp(4)) num2str(time_stamp(5))];
if(strcmp(scan_type,'xy'))
    save([file_name '_xy.MAT'],'scan_data');
    print_message(sprintf('%s Saved',[file_name '_xy.MAT']),handles);
elseif(strcmp(scan_type,'yz'))
    save([file_name '_yz.MAT'],'scan_data');
    print_message(sprintf('%s Saved',[file_name '_yz.MAT']),handles);
    
elseif(strcmp(scan_type,'xyz'))
    save([file_name '_xyz.MAT'],'scan_data');
    print_message(sprintf('%s Saved',[file_name '_xyz.MAT']),handles);
else
    print_message(sprintf('scan type is not correct'),handles);
end
%handles.FileName


% --- Executes on button press in pushbutton_set_limit_xyz.
function pushbutton_set_limit_xyz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_limit_xyz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.settings = ky_xyz_set_limits(handles.settings, [handles.limit_x_start handles.limit_x_end], [handles.limit_y_start handles.limit_y_end], [handles.limit_z_start handles.limit_z_end]);
guidata(hObject,handles);


% --- Executes on button press in pushbutton_move_absolute.
function pushbutton_move_absolute_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_move_absolute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ky_xyz_goto_position(handles.settings, handles.abs_x,handles.abs_y,handles.abs_z)

% --- Executes on button press in pushbutton_move_relative.
function pushbutton_move_relative_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_move_relative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ky_xyz_goto_rel_position(handles.settings, handles.rel_x,handles.rel_y,handles.rel_z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom functoin %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function print_message(message_out,handles)
set(handles.editMessage,'String',[]);
set(handles.editMessage,'String',message_out);
disp(message_out);

function new_handles=check_measurement_parameter(handles)


if isfield(handles,'limit_x_start') &&...
        isfield(handles,'limit_y_start') &&...
        isfield(handles,'limit_z_start')&&...
        isfield(handles,'limit_x_end') &&...
        isfield(handles,'limit_y_end') &&...
        isfield(handles,'limit_z_end')
    if ((handles.limit_x_start >= 0) && (handles.limit_x_start <= 150))&&...
            ((handles.limit_y_start >= 0) && (handles.limit_y_start <= 50))&&...
            ((handles.limit_z_start >= 0) && (handles.limit_z_start <= 50))&&...
            ((handles.limit_x_end >= handles.limit_x_start) && (handles.limit_x_end <= 150))&&...
            ((handles.limit_y_end >= handles.limit_y_start) && (handles.limit_y_end <= 50))&&...
            ((handles.limit_z_end >= handles.limit_z_start) && (handles.limit_z_end <= 50))
        set(handles.pushbutton_set_limit_xyz,'Enable','on');
    else
        set(handles.pushbutton_set_limit_xyz,'Enable','off');
    end
end

if(isfield(handles,'rel_x') &&...
        isfield(handles,'rel_y') &&...
        isfield(handles,'rel_z'))
    set(handles.pushbutton_move_relative,'Enable','on');
else
    set(handles.pushbutton_move_relative,'Enable','off');
end

if(isfield(handles,'abs_x') &&...
        isfield(handles,'abs_y') &&...
        isfield(handles,'abs_z'))
    set(handles.pushbutton_move_absolute,'Enable','on');
else
    set(handles.pushbutton_move_absolute,'Enable','off');
end

if(isfield(handles,'FileName') &&...
        isfield(handles,'scope_sample_size') &&...
        isfield(handles,'sel_ch1') &&...
        isfield(handles,'sel_ch2') &&...
        isfield(handles,'sel_ch3') &&...
        isfield(handles,'sel_ch4') &&...
        isfield(handles,'scan_x_range') &&...
        isfield(handles,'scan_y_range') &&...
        isfield(handles,'scan_x_points') &&...
        isfield(handles,'scan_y_points'))
    set(handles.pushbutton_scan_xy,'Enable','on');
else
    set(handles.pushbutton_scan_xy,'Enable','off');
end
if(isfield(handles,'FileName') &&...
        isfield(handles,'scope_sample_size') &&...
        isfield(handles,'sel_ch1') &&...
        isfield(handles,'sel_ch2') &&...
        isfield(handles,'sel_ch3') &&...
        isfield(handles,'sel_ch4') &&...
        isfield(handles,'scan_y_range') &&...
        isfield(handles,'scan_z_range') &&...
        isfield(handles,'scan_y_points') &&...
        isfield(handles,'scan_z_points'))
    set(handles.pushbutton_scan_yz,'Enable','on');
else
    set(handles.pushbutton_scan_yz,'Enable','off');
end

if(isfield(handles,'FileName') &&...
        isfield(handles,'scope_sample_size') &&...
        isfield(handles,'sel_ch1') &&...
        isfield(handles,'sel_ch2') &&...
        isfield(handles,'sel_ch3') &&...
        isfield(handles,'sel_ch4') &&...
        isfield(handles,'scan_x_range') &&...
        isfield(handles,'scan_y_range') &&...
        isfield(handles,'scan_z_range') &&...
        isfield(handles,'scan_x_points') &&...
        isfield(handles,'scan_y_points') &&...
        isfield(handles,'scan_z_points'))
    set(handles.pushbutton_scan_xyz,'Enable','on');
else
    set(handles.pushbutton_scan_xyz,'Enable','off');
end
new_handles=handles;



function plot_figure(handles,holding)

switch holding
    case {'on'}
        axes(handles.axesFig1);
        hold on;
    case {'off'}
        axes(handles.axesFig1);
        hold off;
end

axes(handles.axesFig1);
for m = 1:handles.set_row
    for n = 1:handles.set_column
        pos = [handles.m_seq_x0(m,n)- 0.03 handles.m_seq_y0(m,n)- 0.03 0.06 0.06];
        rectangle('Position',pos,'Curvature',[1 1])
        hold on;
    end
end
plot([handles.ax handles.bx handles.cx handles.dx handles.ax],[handles.ay handles.by handles.cy handles.dy handles.ay],'r');
xlabel('X[mm]');
ylabel('Y[mm]');

function r = IsMoving(StatusBits)
% Read StatusBits returned by GetStatusBits_Bits method and determine if
% the motor shaft is moving; Return 1 if moving, return 0 if stationary
r = bitget(abs(StatusBits),5)||bitget(abs(StatusBits),6);

% guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Text Edit functoin %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
print_message(sprintf('Directory : %s',handles.FileName),handles);

guidata(hObject,handles);

function edit_scan_x_range_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scan_x_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scan_x_range as text
%        str2double(get(hObject,'String')) returns contents of edit_scan_x_range as a double
handles.scan_x_range = str2double(get(hObject,'String'));
print_message(sprintf('Scan X Range[mm] : %2.2fmm',handles.scan_x_range),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_scan_y_range_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scan_y_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scan_y_range as text
%        str2double(get(hObject,'String')) returns contents of edit_scan_y_range as a double
handles.scan_y_range = str2double(get(hObject,'String'));
print_message(sprintf('Scan Y Range[mm] : %2.2fmm',handles.scan_y_range),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_scan_z_range_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scan_z_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scan_z_range as text
%        str2double(get(hObject,'String')) returns contents of edit_scan_z_range as a double
handles.scan_z_range = str2double(get(hObject,'String'));
print_message(sprintf('Scan Z Range[mm] : %2.2fmm',handles.scan_z_range),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);





function edit_scan_x_points_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scan_x_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scan_x_points as text
%        str2double(get(hObject,'String')) returns contents of edit_scan_x_points as a double
handles.scan_x_points = str2double(get(hObject,'String'));
print_message(sprintf('Num of X Points: %d',handles.scan_x_points),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_scan_y_points_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scan_y_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scan_y_points as text
%        str2double(get(hObject,'String')) returns contents of edit_scan_y_points as a double
handles.scan_y_points = str2double(get(hObject,'String'));
print_message(sprintf('Num of Y Points: %d',handles.scan_y_points),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_scan_z_points_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scan_z_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scan_z_points as text
%        str2double(get(hObject,'String')) returns contents of edit_scan_z_points as a double
handles.scan_z_points = str2double(get(hObject,'String'));
print_message(sprintf('Num of Z Points: %d',handles.scan_z_points),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_current_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_current_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_current_x as text
%        str2double(get(hObject,'String')) returns contents of edit_current_x as a double
handles.current_x = str2double(get(hObject,'String'));
print_message(sprintf('Currentx :%f',handles.current_x),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_current_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_current_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_current_y as text
%        str2double(get(hObject,'String')) returns contents of edit_current_y as a double
handles.current_y = str2double(get(hObject,'String'));
print_message(sprintf('Current y :%f',handles.current_y),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_current_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_current_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_current_z as text
%        str2double(get(hObject,'String')) returns contents of edit_current_z as a double
handles.current_z = str2double(get(hObject,'String'));
print_message(sprintf('Current z :%f',handles.current_z),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);




function edit_abs_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_abs_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_abs_x as text
%        str2double(get(hObject,'String')) returns contents of edit_abs_x as a double
handles.abs_x = str2double(get(hObject,'String'));
print_message(sprintf('Absolute X :%f',handles.abs_x),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_abs_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_abs_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_abs_y as text
%        str2double(get(hObject,'String')) returns contents of edit_abs_y as a double
handles.abs_y = str2double(get(hObject,'String'));
print_message(sprintf('Absolute y :%f',handles.abs_y),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_abs_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_abs_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_abs_z as text
%        str2double(get(hObject,'String')) returns contents of edit_abs_z as a double
handles.abs_z = str2double(get(hObject,'String'));
print_message(sprintf('Absolute z :%f',handles.abs_z),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_rel_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rel_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rel_x as text
%        str2double(get(hObject,'String')) returns contents of edit_rel_x as a double
handles.rel_x = str2double(get(hObject,'String'));
print_message(sprintf('Absolute x :%f',handles.rel_x),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_rel_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rel_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rel_y as text
%        str2double(get(hObject,'String')) returns contents of edit_rel_y as a double
handles.rel_y = str2double(get(hObject,'String'));
print_message(sprintf('Absolute y :%f',handles.rel_y),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_rel_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rel_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rel_z as text
%        str2double(get(hObject,'String')) returns contents of edit_rel_z as a double
handles.rel_z = str2double(get(hObject,'String'));
print_message(sprintf('Absolute z :%f',handles.rel_z),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes on selection change in popupmenu_scope.
function popupmenu_scope_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_scope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_scope contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_scope
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'RS_Scope'
        handles.scope_option='RS';
        print_message('RS Scope is selected',handles);
    case 'HP_Scope'
        handles.scope_option='HP';
        print_message('HP Scope is selected',handles);
end
guidata(hObject,handles);


function edit_rs_scope_ip_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rs_scope_ip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rs_scope_ip as text
%        str2double(get(hObject,'String')) returns contents of edit_rs_scope_ip as a double
handles.rs_scope_addr = get(hObject,'String');
print_message(sprintf('RS Scope[IP] :%s',handles.rs_scope_addr),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hp_scope_gpib_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hp_scope_gpib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hp_scope_gpib as text
%        str2double(get(hObject,'String')) returns contents of edit_hp_scope_gpib as a double
handles.hp_scope_addr = str2double(get(hObject,'String'));
print_message(sprintf('HP Scope[GPIB] :%d',handles.hp_scope_addr),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_limit_x_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit_x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit_x_start as text
%        str2double(get(hObject,'String')) returns contents of edit_limit_x_start as a double

handles.limit_x_start = str2double(get(hObject,'String'));
print_message(sprintf('Limit start x :%f',handles.limit_x_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_start_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_y as text
%        str2double(get(hObject,'String')) returns contents of edit_start_y as a double

handles.limit_y_start = str2double(get(hObject,'String'));
print_message(sprintf('Limit start y :%f',handles.limit_y_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_start_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_z as text
%        str2double(get(hObject,'String')) returns contents of edit_start_z as a double

handles.limit_z_start = str2double(get(hObject,'String'));
print_message(sprintf('Limit start z :%f',handles.limit_z_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_limit_end_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit_end_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit_end_x as text
%        str2double(get(hObject,'String')) returns contents of edit_limit_end_x as a double

handles.limit_x_end = str2double(get(hObject,'String'));
print_message(sprintf('Limit end x :%f',handles.limit_x_end),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_limit_end_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit_end_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit_end_y as text
%        str2double(get(hObject,'String')) returns contents of edit_limit_end_y as a double
handles.limit_y_end = str2double(get(hObject,'String'));
print_message(sprintf('Limit end y :%f',handles.limit_y_end),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_limit_end_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit_end_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit_end_z as text
%        str2double(get(hObject,'String')) returns contents of edit_limit_end_z as a double
handles.limit_z_end = str2double(get(hObject,'String'));
print_message(sprintf('Limit end z :%f',handles.limit_z_end),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_scope_sample_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scope_sample_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scope_sample_size as text
%        str2double(get(hObject,'String')) returns contents of edit_scope_sample_size as a double
handles.scope_sample_size = str2double(get(hObject,'String'));
print_message(sprintf('scope_sample_size :%f',handles.scope_sample_size),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes on button press in checkbox_ch1.
function checkbox_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ch1
handles.sel_ch1 = get(hObject,'Value');
if(handles.sel_ch1)
    print_message(sprintf('ch1 is selcted'),handles);
else
    print_message(sprintf('ch1 is not selcted'),handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes on button press in checkbox_ch2.
function checkbox_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ch2
handles.sel_ch2 = get(hObject,'Value');
if(handles.sel_ch2)
    print_message(sprintf('ch2 is selcted'),handles);
else
    print_message(sprintf('ch2 is not selcted'),handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes on button press in checkbox_ch3.
function checkbox_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ch3
handles.sel_ch3 = get(hObject,'Value');
if(handles.sel_ch3)
    print_message(sprintf('ch3 is selcted'),handles);
else
    print_message(sprintf('ch3 is not selcted'),handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes on button press in checkbox_ch4.
function checkbox_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ch4
handles.sel_ch4 = get(hObject,'Value');
if(handles.sel_ch4)
    print_message(sprintf('ch4 is selcted'),handles);
else
    print_message(sprintf('ch4 is not selcted'),handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
function edit_scan_x_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scan_x_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_scan_y_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scan_y_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_scan_x_points_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scan_x_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_current_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_current_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_current_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_current_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_current_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_current_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_limit_x_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit_x_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_start_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_start_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_abs_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_abs_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_abs_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_abs_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_abs_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_abs_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_rel_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rel_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_rel_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rel_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_rel_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rel_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function popupmenu_scope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_scope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

% --- Executes during object creation, after setting all properties.
function edit_rs_scope_ip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rs_scope_ip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_hp_scope_gpib_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hp_scope_gpib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_scan_y_points_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scan_y_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_limit_end_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit_end_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_limit_end_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit_end_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function edit_limit_end_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit_end_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_scope_sample_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scope_sample_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_scan_z_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scan_z_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_scan_z_points_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scan_z_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


