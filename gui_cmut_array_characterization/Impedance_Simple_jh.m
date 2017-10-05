function varargout = Impedance_Simple_jh(varargin)
% Impedance_Simple_jh M-file for Impedance_Simple_jh.fig
%      Impedance_Simple_jh, by itself, creates a new Impedance_Simple_jh or raises the existing
%      singleton*.
%
%      H = Impedance_Simple_jh returns the handle to a new Impedance_Simple_jh or the handle to
%      the existing singleton*.
%
%      Impedance_Simple_jh('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Impedance_Simple_jh.M with the given input arguments.
%
%      Impedance_Simple_jh('Property','Value',...) creates a new Impedance_Simple_jh or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Impedance_Simple_jh_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Impedance_Simple_jh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Impedance_Simple_jh

% Last Modified by GUIDE v2.5 20-Mar-2015 00:19:52
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Impedance_Simple_jh_OpeningFcn, ...
    'gui_OutputFcn',  @Impedance_Simple_jh_OutputFcn, ...
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







% --- Executes just before Impedance_Simple_jh is made visible.
function Impedance_Simple_jh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Impedance_Simple_jh (see VARARGIN)

% Choose default command line output for Impedance_Simple_jh
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


handles.Simulation = 0;
handles.Input = 0.05 ; % Input Voltage (Minimum value)
handles.GpibAddress=2; % GPIB address of Impedence Analyzer
handles.GpibBias=14; % GPIB address of Power supply
handles.Bias_Instrument='PS310'; % Default Bias Instrument
handles.figureformat='ZP'; % Default figure format
handles.datatype='MAT';
handles.FinalSpan=0;

handles.nofolder='D:\Users\kkpark\Matlab_Experiment\GUI\Nofolder\';
handles.motor_move='OFF';

if(handles.Simulation)
else
    %%% Machine init
    handles.ioHS=kyvisaHS(1,'4294A',handles.GpibAddress,'open');
    kyvisaHS(handles.ioHS,'4294A',handles.GpibAddress,'init');
    kyvisaHS(handles.ioHS,'4294A',handles.GpibAddress,'set','BW',1); % Set fastest BW
    kyvisaHS(handles.ioHS,'4294A',handles.GpibAddress,'set','Para','Z'); % Z-Phase measurement
    kyvisaHS(handles.ioHS,'4294A',handles.GpibAddress,'set','Input',handles.Input);  % Set Input Voltage
    fclose(handles.ioHS);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.XSN=83850015;
handles.YSN=83850018;
handles.ZSN=83850013;
fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 400; % figure window size;Width
fpos(4) = 1800; % Height

fig = figure('Position', fpos,...
    'Menu','None',...
    'Name','APT GUI');

%% Create ActiveX Controller
% h = actxcontrol('MGMOTOR.MGMotorCtrl.1',[20 20 600 400 ], f);

% X-axis
if(handles.Simulation)
else
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
    
end
pause(5); % waiting for the GUI to load up;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Impedance_Simple_jh wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = Impedance_Simple_jh_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonStartMeasurement.
function pushbuttonStartMeasurement_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStartMeasurement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Bias_Instrument=handles.Bias_Instrument;
GpibBias=handles.GpibBias;
GpibAddress=handles.GpibAddress;
Bias_Index=handles.Bias_Index;
StartFrequency=handles.StartFrequency;
StopFrequency=handles.StopFrequency;
FinalSpan=handles.FinalSpan;
handles.ioHS=kyvisaHS(1,'4294A',GpibAddress,'open');
data=kyvisaHS(handles.ioHS,'4294A',GpibAddress,'read');

CenterFrequency=(StartFrequency+StopFrequency)/2;
SpanFrequency=abs(StartFrequency-StopFrequency);

% Set Center Frequency
kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Center',CenterFrequency);
% Set Span Frequency
kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Span',SpanFrequency);
% Set Bias Voltage
if(strcmp(handles.motor_move,'ON'))||(strcmp(handles.motor_move,'RE-ON'))
    move_row_start = handles.move_row_start;
    move_row_end = handles.move_row_end;
    move_column_start = handles.move_column_start;
    move_column_end = handles.move_column_end;
    [m,n] = size(handles.mseq.data_x);
    array_short = zeros(m,n);
    array_current = zeros(length(handles.Bias_Index),m,n);
    for i = move_row_start:move_row_end
        for j = move_column_start:move_column_end
            %% Sending Moving Commands
            print_message(sprintf('Move to (%d,%d))',i,j),handles);
            timeout = 1; % timeout for waiting the move to be completed
            % Move a absolute distance
            handles.h_Motor_transX.SetAbsMovePos(0,handles.mseq.data_x(i,j));
            handles.h_Motor_transX.MoveAbsolute(0,1==0);
            print_message(sprintf('Move to X = %2.2f',handles.mseq.data_x(i,j)),handles);
            
            t1 = clock; % current time
            while(etime(clock,t1)<timeout)
                % wait while the motor is active; timeout to avoid dead loop
                s = handles.h_Motor_transX.GetStatusBits_Bits(0);
                if (IsMoving(s) == 0)
                    pause(2); % pause 2 seconds;
                    %                 handles.h_Motor_transX.MoveHome(0,0);
                    print_message('X Move Done',handles);
                    
                    break;
                end
            end
            
            handles.h_Motor_transY.SetAbsMovePos(0,handles.mseq.data_y(i,j));
            handles.h_Motor_transY.MoveAbsolute(0,1==0);
            print_message(sprintf('Move to Y = %2.2f',handles.mseq.data_y(i,j)),handles);
            
            t1 = clock; % current time
            while(etime(clock,t1)<timeout+1)
                % wait while the motor is active; timeout to avoid dead loop
                s = handles.h_Motor_transY.GetStatusBits_Bits(0);
                if (IsMoving(s) == 0)
                    pause(2); % pause 2 seconds;
                    %                 handles.h_Motor_transY.MoveHome(0,0);
                    print_message('Y Move Done',handles);
                    break;
                end
            end
            
            handles.h_Motor_transZ.SetAbsMovePos(0,handles.mseq.data_z(i,j));
            handles.h_Motor_transZ.MoveAbsolute(0,1==0);
            print_message(sprintf('Move to Z = %2.2f',handles.mseq.data_z(i,j)),handles);
            
            t1 = clock; % current time
            while(etime(clock,t1)<timeout)
                % wait while the motor is active; timeout to avoid dead loop
                s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
                if (IsMoving(s) == 0)
                    pause(2); % pause 2 seconds;
                    %                 handles.h_Motor_transZ.MoveHome(0,0);
                    print_message('Z Move Done',handles);
                    break;
                end
            end
            if(strcmp(handles.motor_move,'ON'))
                [temp_short, temp_current] = measure_imp_bias(hObject, eventdata, handles,i,j);
            elseif(strcmp(handles.motor_move,'RE-ON'))
                [temp_short, temp_current] = measure_imp_bias(hObject, eventdata, handles,handles.mseq.row(j),handles.mseq.col(j));
            end
            array_short(i,j) = temp_short;
            array_current(:,i,j) = temp_current;
            print_message('CURRENT TESTING',handles);

            handles.h_Motor_transZ.SetAbsMovePos(0,handles.mseq.data_z(i,j)+2);
            handles.h_Motor_transZ.MoveAbsolute(0,1==0);
            print_message(sprintf('Probe Up to Z = %2.2f',handles.mseq.data_z(i,j)+2),handles);
            t1 = clock; % current time
            while(etime(clock,t1)<timeout+1)
                % wait while the motor is active; timeout to avoid dead loop
                s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
                if (IsMoving(s) == 0)
                    pause(2); % pause 2 seconds;
                    %                 handles.h_Motor_transZ.MoveHome(0,0);
                    print_message('Z Move Done',handles);
                    break;
                end
            end
        end
        if(strcmp(handles.motor_move,'ON'))
%             file_name=sprintf('%s_current',handles.FileName);
            file_name=sprintf('%s',[handles.FileName '_current_' num2str(i)]);
            data.array_short = array_short;
            data.array_current = array_current;
            save([file_name '.MAT'],'data');
            print_message(sprintf('%s Saved',[file_name '.MAT']),handles);
        end
    end
else
    measure_imp_bias(hObject, eventdata, handles,handles.motor_row,handles.motor_column)
end
fclose(handles.ioHS);
if(strcmp(handles.motor_move,'ON'))
file_name=sprintf('%s_current',handles.FileName);
data.array_short = array_short;
data.array_current = array_current;
save([file_name '.MAT'],'data');
print_message(sprintf('%s Saved',[file_name '.MAT']),handles);
end
guidata(hObject, handles);




% --- Executes on button press in pushbuttonGrab.
function [array_short, array_current] = measure_imp_bias(hObject, eventdata, handles,row,column)
% hObject    handle to pushbuttonGrab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Transfer variable into simplified form
Bias_Instrument=handles.Bias_Instrument;
GpibBias=handles.GpibBias;
GpibAddress=handles.GpibAddress;
Bias_Index=handles.Bias_Index;
StartFrequency=handles.StartFrequency;
StopFrequency=handles.StopFrequency;
FinalSpan=handles.FinalSpan;
array_current = zeros(length(Bias_Index),1);
array_short = 0;
delta_z = 0.01;
timeout = 1;
print_message('Measurement Start!',handles);
% Open GPIB
% handles.ioHS=kyvisaHS(1,'4294A',GpibAddress,'open');
% data=kyvisaHS(handles.ioHS,'4294A',GpibAddress,'read');

% If the initial bias voltage is too high, increase it by step
if Bias_Instrument=='PS310'
    if abs(Bias_Index(1))>=30
        for i=1:(floor(Bias_Index(1)/5))
            kypib('PS310',GpibBias,'set','volt',i*5);
            pause(0.5);
        end
    end
end

for i=1:length(Bias_Index)
    for k = 1:5
    Bias = Bias_Index(i);   % Bias Voltage
    print_message(sprintf('Set Bias Voltage to %d',Bias),handles);
%     
%     CenterFrequency=(StartFrequency+StopFrequency)/2;
%     SpanFrequency=abs(StartFrequency-StopFrequency);
%     
%     % Set Center Frequency
%     kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Center',CenterFrequency);
%     % Set Span Frequency
%     kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Span',SpanFrequency);
%     % Set Bias Voltage
    if Bias_Instrument=='PS310'
        kypib('PS310',GpibBias,'set','volt',Bias);
    else
        kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Bias',Bias);
    end
    pause(0.5);
    if((strcmp(handles.motor_move,'ON'))||(strcmp(handles.motor_move,'RE-ON')))

     temp= kypib('PS310',GpibBias,'read','current');
     array_current(i,1) = temp;
    if(array_current(i,1) > handles.current_limit)
        array_short = 1;
        print_message(sprintf('Shorted CMUT element'),handles);
        break;
    end
    end
    % Read data
    print_message(sprintf('Read Data (%d V)',Bias),handles);
    data=kyvisaHS(handles.ioHS,'4294A',GpibAddress,'read');
    plot_figure12(data,handles,'b','off');
    
    %%%%%%%%%%%%%%%%%%%%
    % For second sweep
    %%%%%%%%%%%%%%%%%%%%
    if FinalSpan>0
        
        [a,b]=max(data(:,3)); % Phase
        %     [a,b]=max(abs(data(:,2).*cos(Phase*pi/180))); % Find real part
        %     [a,b]=max(abs(data(:,2))); % Find amplitude part
        
        % Change frequency range for second sweep
        CenterFrequency=data(b,1);
        SpanFrequency=FinalSpan;
        
        % Set Center Frequency
        kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Center',CenterFrequency);
        % Set Span Frequency
        kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Span',SpanFrequency);
        
        % Read data
        print_message(sprintf('Read Data, Second Sweep (%d V)',Bias),handles);
        data2=kyvisaHS(handles.ioHS,'4294A',GpibAddress,'read');
        plot_figure12(data2,handles,'r','on');
        
        % Merge data and data2 into data
        % If the frequency range of data2 is included in data
        % corresponding frequency of data is deleted
        data1=data;
        clear data;
        if (data2(801,1)<data1(801,1)) && (data2(1,1)>data1(1,1))
            for j=801:-1:1
                if data1(j,1)<data2(801,1) && data1(j,1)>data2(1,1)
                    data1(j,:)=[];
                end
            end
            data=[data1; data2];
            data=sortrows(data,1);
        else
            data=[data1; data2];
            data=sortrows(data,1);
        end
    end
    if(strcmp(handles.motor_move,'ON'))
    if((max(data(:,3))<90)&&(min(data(:,3))>-90)&&(max(data(:,2))<1e5)&&(min(data(:,2))<2.5e4))
        break;
    else
        handles.h_Motor_transZ.SetAbsMovePos(0,handles.mseq.data_z(row,column)-delta_z*k);
        handles.h_Motor_transZ.MoveAbsolute(0,1==0);
        print_message(sprintf('Move to Z = %2.2f',handles.mseq.data_z(row,column)-delta_z*k),handles);
        
        t1 = clock; % current time
        while(etime(clock,t1)<timeout)
            % wait while the motor is active; timeout to avoid dead loop
            s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
            if (IsMoving(s) == 0)
                pause(1); % pause 2 seconds;
                %                 handles.h_Motor_transZ.MoveHome(0,0);
                print_message('Z Move Done',handles);
                break;
            end
        end
    end
    else
        break;
    end
    end
    if(array_short == 1)
        break;
    end
    if(row == 0)&&(column==0)
        % Save File
        file_name=sprintf('%s_%d',handles.FileName,Bias);
        save_data(data,file_name,handles);
    else
        % Save File
        file_name=sprintf('%s_%d_%d_%d',handles.FileName,Bias,row,column);
        save_data(data,file_name,handles);
    end
end


%%%%%%%%%%%%%%%%%
% Reset the frequency span and bias to initial condition
%%%%%%%%%%%%%%%%%
% CenterFrequency=(StartFrequency+StopFrequency)/2;
% SpanFrequency=abs(StartFrequency-StopFrequency);
% % Set Center Frequency
% kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Center',CenterFrequency);
% % Set Span Frequency
% kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Span',SpanFrequency);
% Set Bias Voltage
if Bias_Instrument=='PS310'
    kypib('PS310',GpibBias,'set','volt',0);
else
    kyvisaHS(handles.ioHS,'4294A',GpibAddress,'set','Bias',0);
end
% kyvisaHS(handles.ioHS,'4294A',handles.GpibAddress,'init');
print_message('Measurement Done!',handles);
% fclose(handles.ioHS);


% --- Executes on button press in pushbuttonGrab.
function pushbuttonGrab_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGrab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ioHS=kyvisaHS(1,'4294A',handles.GpibAddress,'open');
data=kyvisaHS(handles.ioHS,'4294A',handles.GpibAddress,'read');

plot_figure12(data,handles,[0 0.5 0],'off');

fclose(handles.ioHS);

file_name=handles.FileName;
save_data(data,file_name,handles);

function save_data(data,file_name,handles)

% There are two file formats
% "MAT"
%   Column 1 : Frequeney        (Hz)
%   Column 2 : Amplitude        (Ohm)
%   Column 3 : Phase            (Degree)
% "TXT"
%   Column 1 : Frequeney        (Hz)
%   Column 2 : Real             (Ohm)
%   Column 3 : Imaginary        (Ohm)
%   Column 4 : Amplitude        (Ohm)
%   Column 5 : Phase            (Degree)


if handles.datatype=='MAT'
    save([file_name '.MAT'],'data');
    print_message(sprintf('%s Saved',[file_name '.MAT']),handles);
else
    % modify data
    data(:,4)=data(:,2); % Amp
    data(:,5)=data(:,3); % Phase
    data(:,2)=data(:,4).*cos(data(:,5)*pi/180); % Re
    data(:,3)=data(:,4).*sin(data(:,5)*pi/180); % Im
    save([file_name '.TXT'],'-ASCII','data');
    print_message(sprintf('%s Saved',[file_name '.TXT']),handles);
end



function plot_figure12(data,handles,color,holding)

if handles.figureformat=='RX'
    data_new(:,1)=data(:,1);
    data_new(:,2)=data(:,2).*cos(data(:,3)*pi/180);
    data_new(:,3)=data(:,2).*sin(data(:,3)*pi/180);
    data=data_new;
    clear data_new;
end

switch holding
    case {'on'}
        axes(handles.axesFig1);
        hold on;
        axes(handles.axesFig2);
        hold on;
    case {'off'}
        axes(handles.axesFig1);
        hold off;
        axes(handles.axesFig2);
        hold off;
end
axes(handles.axesFig1);
plot(data(:,1),data(:,2),'color',color,'linewidth',2);
axes(handles.axesFig2);
plot(data(:,1),data(:,3),'color',color,'linewidth',2);

if handles.figureformat=='RX'
    axes(handles.axesFig1);
    xlabel('Frequency (Hz)');
    ylabel('Real (Ohm)');
    axes(handles.axesFig2);
    xlabel('Frequency (Hz)');
    ylabel('Imaginary (Ohm)');
else
    axes(handles.axesFig1);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude (Ohm)');
    axes(handles.axesFig2);
    xlabel('Frequency (Hz)');
    ylabel('Phase (Degree)');
end





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




function editFstart_Callback(hObject, eventdata, handles)
% hObject    handle to editFstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFstart as text
%        str2double(get(hObject,'String')) returns contents of editFstart as a double
handles.StartFrequency=str2double(get(hObject,'String'));
print_message('Start Frequency Changed',handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);





function editFend_Callback(hObject, eventdata, handles)
% hObject    handle to editFend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFend as text
%        str2double(get(hObject,'String')) returns contents of editFend as a double
handles.StopFrequency=str2double(get(hObject,'String'));
print_message('Stop Frequency Changed',handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);




function editFspan_Callback(hObject, eventdata, handles)
% hObject    handle to editFspan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFspan as text
%        str2double(get(hObject,'String')) returns contents of editFspan as a double
handles.FinalSpan=str2double(get(hObject,'String'));
if handles.FinalSpan==0
    print_message('Second Sweep Deactivated',handles);
else
    print_message('Second Sweep Activated',handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);






% --- Executes on selection change in popupmenuBiasKind.
function popupmenuBiasKind_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuBiasKind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenuBiasKind contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuBiasKind

str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'PS310'
        handles.Bias_Instrument='PS310';
    case '4294A'
        handles.Bias_Instrument='4294A';
end

print_message('Bias Instrument Changed',handles);
guidata(hObject,handles);



function editVstart_Callback(hObject, eventdata, handles)
% hObject    handle to editVstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVstart as text
%        str2double(get(hObject,'String')) returns contents of editVstart as a double
% a=handles.Bias_Index
% b=handles.Vstart
handles.Vstart=str2double(get(hObject,'String'));
handles=build_bias_list(hObject, eventdata, handles);
guidata(hObject,handles);




function editVend_Callback(hObject, eventdata, handles)
% hObject    handle to editVend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVend as text
%        str2double(get(hObject,'String')) returns contents of editVend as a double

handles.Vend=str2double(get(hObject,'String'));
handles=build_bias_list(hObject, eventdata, handles);
guidata(hObject,handles);



function editVstep_Callback(hObject, eventdata, handles)
% hObject    handle to editVstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVstep as text
%        str2double(get(hObject,'String')) returns contents of editVstep as a double
handles.Vstep=str2double(get(hObject,'String'));
handles=build_bias_list(hObject, eventdata, handles);
guidata(hObject,handles);





% --- Executes on selection change in popupmenuDataType.
function popupmenuDataType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuDataType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenuDataType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuDataType
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'MAT'
        handles.datatype='MAT';
    case 'TXT'
        handles.datatype='TXT';
end
guidata(hObject,handles);





% --- Executes on selection change in popupmenuFigureFormat.
function popupmenuFigureFormat_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFigureFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenuFigureFormat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFigureFormat
% Determine the selected data set.

str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'Z-Phase'
        handles.figureformat='ZP';
    case 'Re-Im'
        handles.figureformat='RX';
end

guidata(hObject,handles);

% --- Executes on selection change in popupmenu_motor_on.
function popupmenu_motor_on_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_motor_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_motor_on contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_motor_on
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'ON'
        handles.motor_move='ON';
        print_message('Motor Move ON',handles);
    case 'OFF'
        handles.motor_move='OFF';
        print_message('Motor Move OFF',handles);
    case 'RE-ON'
        handles.motor_move='RE-ON';
        print_message('Motor Move RE-ON',handles);
end

guidata(hObject,handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Motorized Positioner function %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edit_motor_row_Callback(hObject, eventdata, handles)
% hObject    handle to edit_motor_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_motor_row as text
%        str2double(get(hObject,'String')) returns contents of edit_motor_row as a double
handles.motor_row = str2double(get(hObject,'String'));
print_message(sprintf('Row 1 - %d',handles.motor_row),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_motor_column_Callback(hObject, eventdata, handles)
% hObject    handle to edit_motor_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_motor_column as text
%        str2double(get(hObject,'String')) returns contents of edit_motor_column as a double
handles.motor_column = str2double(get(hObject,'String'));
print_message(sprintf('Column 1 - %d',handles.motor_column),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes on button press in pushbutton_move.
function pushbutton_move_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Sending Moving Commands
timeout = 4; % timeout for waiting the move to be completed
%h.MoveJog(0,1); % Jog

% Move a absolute distance
handles.h_Motor_transX.SetAbsMovePos(0,handles.mseq.data_x(handles.motor_row,handles.motor_column));
handles.h_Motor_transX.MoveAbsolute(0,1==0);

t1 = clock; % current time
while(etime(clock,t1)<timeout)
    % wait while the motor is active; timeout to avoid dead loop
    s = handles.h_Motor_transX.GetStatusBits_Bits(0);
    if (IsMoving(s) == 0)
        pause(2); % pause 2 seconds;
        print_message(sprintf('X moved to %2.4f',handles.mseq.data_x(handles.motor_row,handles.motor_column)),handles);
        break;
    end
end

handles.h_Motor_transY.SetAbsMovePos(0,handles.mseq.data_y(handles.motor_row,handles.motor_column));
handles.h_Motor_transY.MoveAbsolute(0,1==0);

t1 = clock; % current time
while(etime(clock,t1)<timeout)
    % wait while the motor is active; timeout to avoid dead loop
    s = handles.h_Motor_transY.GetStatusBits_Bits(0);
    if (IsMoving(s) == 0)
        pause(2); % pause 2 seconds;
        print_message(sprintf('Y moved to %2.4f',handles.mseq.data_y(handles.motor_row,handles.motor_column)),handles);
        break;
    end
end

handles.h_Motor_transZ.SetAbsMovePos(0,handles.mseq.data_z(handles.motor_row,handles.motor_column));
handles.h_Motor_transZ.MoveAbsolute(0,1==0);

t1 = clock; % current time
while(etime(clock,t1)<timeout)
    % wait while the motor is active; timeout to avoid dead loop
    s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
    if (IsMoving(s) == 0)
        pause(2); % pause 2 seconds;
        print_message(sprintf('Z moved to %2.4f',handles.mseq.data_z(handles.motor_row,handles.motor_column)),handles);
        break;
    end
end
% pause(10); % pause 2 seconds;
% 
% handles.h_Motor_transZ.SetAbsMovePos(0,handles.mseq.data_z(handles.motor_row,handles.motor_column)+3);
% handles.h_Motor_transZ.MoveAbsolute(0,1==0);
% t1 = clock; % current time
% while(etime(clock,t1)<timeout)
%     % wait while the motor is active; timeout to avoid dead loop
%     s = handles.h_Motor_transZ.GetStatusBits_Bits(0);
%     if (IsMoving(s) == 0)
%         pause(2); % pause 2 seconds;
%         print_message('Z probe moved up',handles);
%         break;
%     end
% end
function edit_mseq_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mseq_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mseq_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_mseq_filename as a double
FileNameTemp=get(hObject,'String');

flag=0;
if length(FileNameTemp)>0
    for i=1:length(FileNameTemp)
        if (FileNameTemp(i)=='\')||(FileNameTemp(i)=='/')
            flag=1;
            break;
        end
    end
    
    if flag==0 % No Folder information
        handles.mseq_FileName=[handles.nofolder FileNameTemp];
        print_message('File dose not exist',handles);
    else % Folder information
        if(exist(FileNameTemp,'file')==2)
            handles.mseq_FileName=FileNameTemp;
            handles=check_measurement_parameter(handles);
            temp_xyz = load('-mat', handles.mseq_FileName);
            handles.mseq = temp_xyz.mseq;
            [m,n] = size(handles.mseq.data_x);
            print_message(sprintf('File is loaded(%d x %d)',m,n),handles);
        else
            print_message('File dose not exist',handles);
            
        end
    end
end


guidata(hObject,handles);


function edit_move_row_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_move_row_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_move_row_start as text
%        str2double(get(hObject,'String')) returns contents of edit_move_row_start as a double
handles.move_row_start = str2double(get(hObject,'String'));
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_move_row_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_move_row_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_move_row_end as text
%        str2double(get(hObject,'String')) returns contents of edit_move_row_end as a double
handles.move_row_end = str2double(get(hObject,'String'));
print_message(sprintf('MOVE : Column %d - %d',handles.move_row_start,handles.move_row_end),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_move_column_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_move_column_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_move_column_start as text
%        str2double(get(hObject,'String')) returns contents of edit_move_column_start as a double
handles.move_column_start = str2double(get(hObject,'String'));
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_move_column_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_move_column_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_move_column_end as text
%        str2double(get(hObject,'String')) returns contents of edit_move_column_end as a double
handles.move_column_end = str2double(get(hObject,'String'));
print_message(sprintf('MOVE : Column %d - %d',handles.move_column_start,handles.move_column_end),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_current_limit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_current_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_current_limit as text
%        str2double(get(hObject,'String')) returns contents of edit_current_limit as a double
handles.current_limit = str2double(get(hObject,'String'));
print_message(sprintf('Current limit set to %2.2f uA',handles.current_limit*1e6),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom function %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function print_message(message_out,handles)
set(handles.editMessage,'String',[]);
set(handles.editMessage,'String',message_out);
disp(message_out);


function new_handles=build_bias_list(hObject, eventdata, handles)

if isfield(handles,'Vstart') && isfield(handles,'Vstep') && isfield(handles,'Vend')
    %     handles.Bias_Index
    if (handles.Vstart)==(handles.Vend)
        handles.Bias_Index=(handles.Vstart);
    else
        handles.Bias_Index=([handles.Vstart:handles.Vstep:handles.Vend]);
    end
    if length(handles.Bias_Index)==1
        print_message(sprintf('Bias Voltages Set, Bias=%d V',(handles.Bias_Index)),handles);
    elseif length(handles.Bias_Index)>1
        print_message(sprintf('Bias Voltages Set, Bias= %d ... %d V, %d Point',handles.Bias_Index(1),handles.Bias_Index(length(handles.Bias_Index)), length(handles.Bias_Index)),handles);
    else
        print_message(sprintf('Bias Voltages Error'),handles);
    end
end
handles=check_measurement_parameter(handles);
new_handles=handles;


% guidata(hObject,handles);

function new_handles=check_measurement_parameter(handles)
% handles.Bias_Index
if isfield(handles,'Bias_Index') &&...
        isfield(handles,'StartFrequency') &&...
        isfield(handles,'StopFrequency') &&...
        isfield(handles,'FileName')
    
    if ~isempty(handles.Bias_Index>0) && (~isempty(handles.FileName))
        set(handles.pushbuttonStartMeasurement,'Enable','on');
    else
        set(handles.pushbuttonStartMeasurement,'Enable','off');
    end
    
else
    set(handles.pushbuttonStartMeasurement,'Enable','off');
end

if isfield(handles,'motor_row') &&...
        isfield(handles,'motor_column')
    if ((handles.motor_row >= 1) && (handles.motor_row <= 32))&&...
            ((handles.motor_column >= 1) && (handles.motor_column <= 32))
        set(handles.pushbutton_move,'Enable','on');
    else
        set(handles.pushbutton_move,'Enable','off');
    end
    
else
    set(handles.pushbutton_move,'Enable','off');
end

if isfield(handles,'FileName')
    if ~isempty(handles.FileName)
        set(handles.pushbuttonGrab,'Enable','on');
    else
        set(handles.pushbuttonGrab,'Enable','off');
    end
else
    set(handles.pushbuttonGrab,'Enable','off');
end

new_handles=handles;


function r = IsMoving(StatusBits)
% Read StatusBits returned by GetStatusBits_Bits method and determine if
% the motor shaft is moving; Return 1 if moving, return 0 if stationary
r = bitget(abs(StatusBits),5)||bitget(abs(StatusBits),6);

% guidata(hObject,handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unnecessary function but required for GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popupmenuFigureFormat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFigureFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editVstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popupmenuDataType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuDataType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
function editFstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editFend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editFspan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFspan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popupmenuBiasKind_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuBiasKind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editVstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editVend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_motor_row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_motor_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_motor_column_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_motor_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_mseq_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mseq_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popupmenu_motor_on_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_motor_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_move_row_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_move_row_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_move_column_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_move_column_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_move_row_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_move_row_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_move_column_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_move_column_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function edit_current_limit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_current_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
