function varargout = Motor_seq_simple(varargin)
% Motor_seq_simple M-file for Motor_seq_simple.fig
%      Motor_seq_simple, by itself, creates a new Motor_seq_simple or raises the existing
%      singleton*.
%
%      H = Motor_seq_simple returns the handle to a new Motor_seq_simple or the handle to
%      the existing singleton*.
%
%      Motor_seq_simple('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Motor_seq_simple.M with the given input arguments.
%
%      Motor_seq_simple('Property','Value',...) creates a new Motor_seq_simple or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Motor_seq_simple_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Motor_seq_simple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Motor_seq_simple
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Last Modified by GUIDE v2.5 17-Mar-2015 01:56:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Motor_seq_simple_OpeningFcn, ...
    'gui_OutputFcn',  @Motor_seq_simple_OutputFcn, ...
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


% --- Executes just before Motor_seq_simple is made visible.
function Motor_seq_simple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Motor_seq_simple (see VARARGIN)

% Choose default command line output for Motor_seq_simple
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



handles.nofolder='D:\Users\kkpark\Matlab_Experiment\GUI\Nofolder\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.XSN=83850015;
handles.YSN=83850018;
handles.ZSN=83850013;
handles.xyz_abcd = 'a';
handles.move_option = 'manual';

fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 400; % figure window size;Width
fpos(4) = 1800; % Height

fig = figure('Position', fpos,...
    'Menu','None',...
    'Name','APT GUI');

%% Create ActiveX Controller
% h = actxcontrol('MGMOTOR.MGMotorCtrl.1',[20 20 600 400 ], f);

% X-axis

handles.h_Motor_transX = actxcontrol('MGMOTOR.MGMotorCtrl.1', [0 800 600 400], fig);
% Start the control
handles.h_Motor_transX.StartCtrl;
% Set the serial number
set(handles.h_Motor_transX, 'HWSerialNum', handles.XSN);
pause(0.1);
% Identify the device
handles.h_Motor_transX.Identify;


% Y-axis

handles.h_Motor_transY = actxcontrol('MGMOTOR.MGMotorCtrl.1', [0 400 600 400], fig);
% Start the control
handles.h_Motor_transY.StartCtrl;
% Set the serial number
set(handles.h_Motor_transY, 'HWSerialNum', handles.YSN);
pause(0.1);
% Identify the device
handles.h_Motor_transY.Identify;

% Z-axis

handles.h_Motor_transZ = actxcontrol('MGMOTOR.MGMotorCtrl.1', [0 0 600 400], fig);
% Start the control
handles.h_Motor_transZ.StartCtrl;
% Set the serial number
set(handles.h_Motor_transZ, 'HWSerialNum', handles.ZSN);
pause(0.1);
% IdentifZ the device
handles.h_Motor_transZ.Identify;


pause(5); % waiting for the GUI to load up;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Motor_seq_simple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Motor_seq_simple_OutputFcn(hObject, eventdata, handles)
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

% Read an absolute distance
temp_x = handles.h_Motor_transX.GetPosition_Position(0);
temp_y = handles.h_Motor_transY.GetPosition_Position(0);
temp_z = handles.h_Motor_transZ.GetPosition_Position(0);

switch handles.xyz_abcd
    case {'a'}
        handles.ax = temp_x;
        handles.ay = temp_y;
        handles.az = temp_z;
    case {'b'}
        handles.bx = temp_x;
        handles.by = temp_y;
        handles.bz = temp_z;
    case {'c'}
        handles.cx = temp_x;
        handles.cy = temp_y;
        handles.cz = temp_z;
    case {'d'}
        handles.dx = temp_x;
        handles.dy = temp_y;
        handles.dz = temp_z;
end

switch handles.xyz_abcd
    case {'a'}
        set(handles.editax,'String',[]);
        set(handles.editax,'String',num2str(handles.ax));
        disp(num2str(handles.ax));
        set(handles.editay,'String',[]);
        set(handles.editay,'String',num2str(handles.ay));
        disp(num2str(handles.ay));
        set(handles.editaz,'String',[]);
        set(handles.editaz,'String',num2str(handles.az));
        disp(num2str(handles.az));
    case {'b'}
        set(handles.editbx,'String',[]);
        set(handles.editbx,'String',num2str(handles.bx));
        disp(num2str(handles.bx));
        set(handles.editby,'String',[]);
        set(handles.editby,'String',num2str(handles.by));
        disp(num2str(handles.by));
        set(handles.editbz,'String',[]);
        set(handles.editbz,'String',num2str(handles.bz));
        disp(num2str(handles.bz));
    case {'c'}
        set(handles.editcx,'String',[]);
        set(handles.editcx,'String',num2str(handles.cx));
        disp(num2str(handles.cx));
        set(handles.editcy,'String',[]);
        set(handles.editcy,'String',num2str(handles.cy));
        disp(num2str(handles.cy));
        set(handles.editcz,'String',[]);
        set(handles.editcz,'String',num2str(handles.cz));
        disp(num2str(handles.cz));
    case {'d'}
        set(handles.editdx,'String',[]);
        set(handles.editdx,'String',num2str(handles.dx));
        disp(num2str(handles.dx));
        set(handles.editdy,'String',[]);
        set(handles.editdy,'String',num2str(handles.dy));
        disp(num2str(handles.dy));
        set(handles.editdz,'String',[]);
        set(handles.editdz,'String',num2str(handles.dz));
        disp(num2str(handles.dz));
end
guidata(hObject, handles);



% --- Executes on button press in pushbuttonsavedata.
function pushbuttonsavedata_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonsavedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m = handles.set_row;
n = handles.set_column;
plot_figure(handles,'off');
mseq.data_x = zeros(m,n);
mseq.data_y = zeros(m,n);
mseq.data_z = zeros(m,n);
% data(:,1) = reshape(handles.m_seq_x0,32*32,1);
% data(:,2) = reshape(handles.m_seq_y0,32*32,1);
mseq.data_x = handles.m_seq_x0;
mseq.data_y = handles.m_seq_y0;
mseq.data_z = handles.m_seq_z0;
file_name=handles.FileName;
save_data(mseq,file_name,handles);

function save_data(mseq,file_name,handles)

% if handles.datatype=='MAT'
save([file_name '.MAT'],'mseq');
print_message(sprintf('%s Saved',[file_name '.MAT']),handles);
%     % modify data
%     data(:,4)=data(:,2); % Amp
%     data(:,5)=data(:,3); % Phase
%     data(:,2)=data(:,4).*cos(data(:,5)*pi/180); % Re
%     data(:,3)=data(:,4).*sin(data(:,5)*pi/180); % Im
%     save([file_name '.TXT'],'-ASCII','data');
%     print_message(sprintf('%s Saved',[file_name '.TXT']),handles);
% end

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



function edit_motorZ_Callback(hObject, eventdata, handles)
% hObject    handle to edit_motorZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_motorZ as text
%        str2double(get(hObject,'String')) returns contents of edit_motorZ as a double
handles.motorZ = str2double(get(hObject,'String'));
print_message(sprintf('Z[mm] : %2.2fmm',handles.motorZ),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes on button press in pushbutton_move.
function pushbutton_move_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Sending Moving Commands
timeout = 2; % timeout for waiting the move to be completed
switch handles.move_option;
    case 'manual'
        % Move a absolute distance
        handles.h_Motor_transX.SetAbsMovePos(0,handles.motorX);
        handles.h_Motor_transX.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transX.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('X move Done');
                break;
            end
        end
        
        handles.h_Motor_transY.SetAbsMovePos(0,handles.motorY);
        handles.h_Motor_transY.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transY.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Y move Done');
                break;
            end
        end
        
        handles.h_Motor_transZ.SetAbsMovePos(0,handles.motorZ);
        handles.h_Motor_transZ.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Z move Done');
                break;
            end
        end
    case 'array'
        m = handles.set_row;
        n = handles.set_column;
        % gen_array(hObject,handles);
        handles.m_seq_x0 = zeros(m,n);
        handles.m_seq_y0 = zeros(m,n);
        handles.m_seq_z0 = zeros(m,n);
        
        handles.m_seq_x0(:,1) = linspace(handles.ax, handles.dx, m);
        handles.m_seq_x0(:,n) = linspace(handles.bx, handles.cx, m);
        handles.m_seq_y0(:,1) = linspace(handles.ay, handles.dy, m);
        handles.m_seq_y0(:,n) = linspace(handles.by, handles.cy, m);
        handles.m_seq_z0(:,1) = linspace(handles.az, handles.dz, m);
        handles.m_seq_z0(:,n) = linspace(handles.bz, handles.cz, m);
        for i = 1:m
            handles.m_seq_x0(i,:) = linspace(handles.m_seq_x0(i,1), handles.m_seq_x0(i,n),n);
            handles.m_seq_y0(i,:) = linspace(handles.m_seq_y0(i,1), handles.m_seq_y0(i,n),n);
            handles.m_seq_z0(i,:) = linspace(handles.m_seq_z0(i,1), handles.m_seq_z0(i,n),n);
        end
        
        % Move a absolute distance
        handles.h_Motor_transX.SetAbsMovePos(0,handles.m_seq_x0(handles.row,handles.column));
        handles.h_Motor_transX.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transX.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('X move Done');
                break;
            end
        end
        
        handles.h_Motor_transY.SetAbsMovePos(0,handles.m_seq_y0(handles.row,handles.column));
        handles.h_Motor_transY.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transY.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Y move Done');
                break;
            end
        end
        
        handles.h_Motor_transZ.SetAbsMovePos(0,handles.m_seq_z0(handles.row,handles.column));
        handles.h_Motor_transZ.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Z move Done');
                break;
            end
        end
        pause(5);
        handles.h_Motor_transZ.SetAbsMovePos(0,handles.m_seq_z0(handles.row,handles.column)+3);
        handles.h_Motor_transZ.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Z move Done');
                break;
            end
        end
    case 'ring'
        m = 1;
        n = handles.set_column;
        % gen_array(hObject,handles);
        handles.m_seq_x0 = zeros(m,n);
        handles.m_seq_y0 = zeros(m,n);
        handles.m_seq_z0 = zeros(m,n);
        
        
        i_x = 0;
        i_y = 4245;
        r_s = 4245;
        r_l = 4031;
        
        s_x(1) = 0;
        s_y(1) = r_s;
        
        l_x(1) = r_l*sin(2*pi/64*(1/2));
        l_y(1) = r_l*cos(2*pi/64*(1/2));
        
        x(1) = s_x(1);
        y(1) = s_y(1);
        x(2) = l_x(1);
        y(2) = l_y(1);
        
        k = 3;
        for i = 2:128
            s_x(i) = r_s*sin(2*pi/64*(i-1));
            s_y(i) = r_s*cos(2*pi/64*(i-1));
            
            l_x(i) = r_l*sin(2*pi/64*(i-1/2));
            l_y(i) = r_l*cos(2*pi/64*(i-1/2));
            
            x(k) = s_x(i);
            y(k) = s_y(i);
            k = k+1;
            
            x(k) = l_x(i);
            y(k) = l_y(i);
            k = k+1;
            
        end
        y = y -4245;
        
        vx1 = abs(handles.cx-handles.ax);
        vy1 = abs(handles.cy-handles.ay);
        vx_1 = vx1/sqrt(vx1^2+vy1^2);
        vy_1 = vy1/sqrt(vx1^2+vy1^2);
        
        vx2 = abs(handles.dx-handles.bx);
        vy2 = abs(handles.dy-handles.by);
        vx_2 = vx2/sqrt(vx2^2+vy2^2);
        vy_2 = vy2/sqrt(vx2^2+vy2^2);
        
        rot_d1 = acosd(vy_1);
        rot_d2 = acosd(vx_2);
        handles.rot_d = (rot_d1+rot_d2)/2
        rot_mat = [cosd(handles.rot_d) -sind(handles.rot_d); sind(handles.rot_d) cosd(handles.rot_d)];
        
        for i = 1:128
            temp = (rot_mat*[x(i);y(i)])';
            handles.m_seq_x0(1,i) = temp(1);
            handles.m_seq_y0(1,i) = temp(2);
        end
        handles.m_seq_z0(1,1:33) = linspace(handles.az, handles.bz, n/4+1);
        handles.m_seq_z0(1,33:65) = linspace(handles.bz, handles.cz, n/4+1);
        handles.m_seq_z0(1,65:97) = linspace(handles.cz, handles.dz, n/4+1);
        temp(1:33) = linspace(handles.dz, handles.az, n/4+1);
        handles.m_seq_z0(1,97:128) = temp(1:32);
        
        % Move a absolute distance
        handles.h_Motor_transX.SetAbsMovePos(0,handles.m_seq_x0(handles.row,handles.column));
        handles.h_Motor_transX.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transX.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('X move Done');
                break;
            end
        end
        
        handles.h_Motor_transY.SetAbsMovePos(0,handles.m_seq_y0(handles.row,handles.column));
        handles.h_Motor_transY.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transY.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Y move Done');
                break;
            end
        end
        
        handles.h_Motor_transZ.SetAbsMovePos(0,handles.m_seq_z0(handles.row,handles.column));
        handles.h_Motor_transZ.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Z move Done');
                break;
            end
        end
        pause(5);
        handles.h_Motor_transZ.SetAbsMovePos(0,handles.m_seq_z0(handles.row,handles.column)+3);
        handles.h_Motor_transZ.MoveAbsolute(0,1==0);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(2); % pause 2 seconds;
                disp('Z move Done');
                break;
            end
        end
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
        isfield(handles,'motorY') &&...
        isfield(handles,'motorZ')
    if ((handles.motorX >= 0) && (handles.motorX <= 25))&&...
            ((handles.motorY >= 0) && (handles.motorY <= 25))&&...
            ((handles.motorZ >= 0) && (handles.motorZ <= 25))
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

new_handles=handles;


function r = IsMoving(StatusBits)
% Read StatusBits returned by GetStatusBits_Bits method and determine if
% the motor shaft is moving; Return 1 if moving, return 0 if stationary
r = bitget(abs(StatusBits),5)||bitget(abs(StatusBits),6);

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


% --- Executes during object creation, after setting all properties.
function editay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editaz_Callback(hObject, eventdata, handles)
% hObject    handle to editaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editaz as text
%        str2double(get(hObject,'String')) returns contents of editaz as a double


% --- Executes during object creation, after setting all properties.
function editaz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editaz (see GCBO)
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



function editbz_Callback(hObject, eventdata, handles)
% hObject    handle to editbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editbz as text
%        str2double(get(hObject,'String')) returns contents of editbz as a double


% --- Executes during object creation, after setting all properties.
function editbz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbz (see GCBO)
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



function editcz_Callback(hObject, eventdata, handles)
% hObject    handle to editcz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editcz as text
%        str2double(get(hObject,'String')) returns contents of editcz as a double


% --- Executes during object creation, after setting all properties.
function editcz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editcz (see GCBO)
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



function editdz_Callback(hObject, eventdata, handles)
% hObject    handle to editdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdz as text
%        str2double(get(hObject,'String')) returns contents of editdz as a double


% --- Executes during object creation, after setting all properties.
function editdz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdz (see GCBO)
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
