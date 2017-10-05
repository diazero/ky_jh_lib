function varargout = HIFU_simple(varargin)
% HIFU_simple M-file for HIFU_simple.fig
%      HIFU_simple, by itself, creates a new HIFU_simple or raises the existing
%      singleton*.
%
%      H = HIFU_simple returns the handle to a new HIFU_simple or the handle to
%      the existing singleton*.
%
%      HIFU_simple('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HIFU_simple.M with the given input arguments.
%
%      HIFU_simple('Property','Value',...) creates a new HIFU_simple or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HIFU_simple_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HIFU_simple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HIFU_simple

% Last Modified by GUIDE target_amp_ch1.5 01-Dec-2016 18:08:12
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @HIFU_simple_OpeningFcn, ...
    'gui_OutputFcn',  @HIFU_simple_OutputFcn, ...
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


% --- Executes just before HIFU_simple is made visible.
function HIFU_simple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HIFU_simple (see VARARGIN)

% Choose default command line output for HIFU_simple
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% handles.nofolder='D:\Users\kkpark\Matlab_Experiment\GUI\Nofolder\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handles.FileName='C:\Users\JiHoon\Documents\MATLAB\KY_SCAN_DATA';

handles.sel_amp = 0;
handles.sel_ch = 1;

handles.dds_com1 = 'COM5';
handles.dds_com2 = 'COM6';
handles.sel_ch2=0;
handles.target_amp = 0;
handles.target_phase_ch0 = 0;
handles.target_phase_ch1 = 45;
handles.target_phase_ch2 = 90;
handles.target_phase_ch3 = 135;
handles.target_phase_ch4 = 180;
handles.target_phase_ch5 = 225;
handles.target_phase_ch6 = 270;
handles.target_phase_ch7 = 315;

handles.target_amp_ch0 = 0;
handles.target_amp_ch1 = 0;
handles.target_amp_ch2 = 0;
handles.target_amp_ch3 = 0;
handles.target_amp_ch4 = 0;
handles.target_amp_ch5 = 0;
handles.target_amp_ch6 = 0;
handles.target_amp_ch7 = 0;

handles.phase_avg_ch0 = 0;
handles.phase_avg_ch1 = 0;
handles.phase_avg_ch2 = 0;
handles.phase_avg_ch3 = 0;
handles.phase_avg_ch4 = 0;
handles.phase_avg_ch5 = 0;
handles.phase_avg_ch6 = 0;
handles.phase_avg_ch7 = 0;

handles.time_delay = 0.1;

handles.serial_rate = 19200;
handles.rs_scope_ip = '171.64.84.150';
handles.rs_scope_sample_size = 5000;
handles.scope_ch = [3 4];
handles.control_ch = 1;

handles=check_measurement_parameter(handles);
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = HIFU_simple_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Push button function %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_calibrate.
function pushbutton_calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.sel_ch<4)
    my_dds = serial(handles.dds_com1,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
else
    my_dds = serial(handles.dds_com2,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
end
fopen(my_dds);
target_phase = 0:10:70;
input_phase = target_phase;
for i = 1:length(target_phase)
    i
    switch num2str(handles.sel_ch)
        case '1'
            N = floor(input_phase(i)*16384/360)
            fprintf(my_dds,['p2 ' num2str(N)])
        case '2'
            N = floor(input_phase(i)*16384/360)
            fprintf(my_dds,['p1 ' num2str(N)])
        case '3'
            phase = wrapTo360(input_phase(i)+180)
            N = floor(phase*16384/360)
            fprintf(my_dds,['p0 ' num2str(N)])
        case '4'
            N = floor(input_phase(i)*16384/360)
            fprintf(my_dds,['p3 ' num2str(N)])
        case '5'
            N = floor(input_phase(i)*16384/360)
            fprintf(my_dds,['p2 ' num2str(N)])
        case '6'
            N = floor(input_phase(i)*16384/360)
            fprintf(my_dds,['p1 ' num2str(N)])
        case '7'
            phase = wrapTo360(input_phase(i)+180)
            N = floor(phase*16384/360)
            fprintf(my_dds,['p0 ' num2str(N)])
            
    end
    out1 = fscanf(my_dds)
    out1 = fscanf(my_dds)
    
    
    [scope, success] = ky_scope_rs_init(handles.rs_scope_ip, handles.rs_scope_sample_size);
    
    arr_structs              = ky_scope_rs_get_ch_data(scope, handles.scope_ch); % grabs/stores data
    if(isempty(arr_structs(1).num_samples))
    else
        if handles.rs_scope_sample_size ~= arr_structs(1).num_samples % tests to make sure the amount of samples grabbed is correct
            error('The sample size used on Scope is different from the sample size stored in settings');
        end
        ch1_data = arr_structs(1).data; % stores the waveform data
        ch2_data = arr_structs(2).data; % stores the waveform data
        
        data.fs = arr_structs.fs;
        data_f = 5e6;
        dt = 1/arr_structs(1).fs;
        time = dt:dt:dt*arr_structs(1).num_samples;
        axes(handles.axesFig2);
        cla;
        plot(time*10^6,ch1_data,'linewidth',1);
        hold on;
        plot(time*10^6,ch2_data,'linewidth',1);
        xlabel('Time [us]');
        ylabel('Voltage [V]');
        nom_ch1_data = ch1_data/max(ch1_data);
        nom_ch2_data = ch2_data/max(ch2_data);
        
        [acor,lag] = xcorr(nom_ch1_data,nom_ch2_data);
        [~,I] = max(acor);
        lagDiff = lag(I);
        timeDiff = lagDiff*dt;
        temp_ph(i) = timeDiff*data_f*360;
        if(abs(temp_ph(i)) >180)
            if(temp_ph(i)>0)
                temp_ph(i) = temp_ph(i)-360;
            else
                temp_ph(i) = 360+temp_ph(i);
            end
        else
            temp_ph(i) = temp_ph(i)
        end
        diff_ph(i) = target_phase(i)+temp_ph(i);
        if(abs(diff_ph(i)) >180)
            if(diff_ph(i)>0)
                diff_ph(i) = diff_ph(i)-360;
            else
                diff_ph(i) = 360+diff_ph(i);
            end
        else
            diff_ph(i) = diff_ph(i);
        end
        pause(1);
    end
end
fclose(my_dds);
%%
axes(handles.axesFig1);
cla;
plot(target_phase,diff_ph,'--o')
xlabel('target phase')
ylabel('phase difference')
% axis([min(target_phase) max(target_phase) -100 100])
axes(handles.axesFig3);
cla;

plot(target_phase,temp_ph,'--o')
hold on;
plot(target_phase,-target_phase,'--o')
xlabel('target phase')
ylabel('phase difference')
legend('measured','target');
% end
if(mean(diff_ph)<0)
temp_ph = -mean(abs(diff_ph));
else
    temp_ph = mean(abs(diff_ph));
end
temp_var_ph = std(abs(diff_ph));
switch num2str(handles.sel_ch)
    case '0'
        handles.phase_avg_ch0 = temp_ph;
        set(handles.edit_phase_avg_ch0,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch0,'String',num2str(temp_var_ph));
    case '1'
        handles.phase_avg_ch1 = temp_ph;
        set(handles.edit_phase_avg_ch1,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch1,'String',num2str(temp_var_ph));
    case '2'
        handles.phase_avg_ch2 = temp_ph;
        set(handles.edit_phase_avg_ch2,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch2,'String',num2str(temp_var_ph));
    case '3'
        handles.phase_avg_ch3 = temp_ph;
        set(handles.edit_phase_avg_ch3,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch3,'String',num2str(temp_var_ph));
    case '4'
        handles.phase_avg_ch4 = temp_ph;
        set(handles.edit_phase_avg_ch4,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch4,'String',num2str(temp_var_ph));
    case '5'
        handles.phase_avg_ch5 = temp_ph;
        set(handles.edit_phase_avg_ch5,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch5,'String',num2str(temp_var_ph));
    case '6'
        handles.phase_avg_ch6 = temp_ph;
        set(handles.edit_phase_avg_ch6,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch6,'String',num2str(temp_var_ph));
    case '7'
        handles.phase_avg_ch7 = temp_ph;
        set(handles.edit_phase_avg_ch7,'String',num2str(temp_ph));
        set(handles.edit_phase_var_ch7,'String',num2str(temp_var_ph));
end
guidata(hObject, handles);



% --- Executes on button press in pushbutton_update_amp.
function pushbutton_update_selected_amp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.sel_ch2<4)
    my_dds = serial(handles.dds_com1,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
else
    my_dds = serial(handles.dds_com2,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
end
fopen(my_dds);

switch num2str(handles.sel_ch2)
    case '0'
        fprintf(my_dds,['v3 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch0 = handles.target_amp;
        set(handles.edit_target_amp_ch0,'String',num2str(handles.target_amp));
    case '1'
        fprintf(my_dds,['v2 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch1 = handles.target_amp;
        set(handles.edit_target_amp_ch1,'String',num2str(handles.target_amp));
    case '2'
        fprintf(my_dds,['v1 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch2 = handles.target_amp;
        set(handles.edit_target_amp_ch2,'String',num2str(handles.target_amp));
    case '3'
        fprintf(my_dds,['v0 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch3 = handles.target_amp;
        set(handles.edit_target_amp_ch3,'String',num2str(handles.target_amp));
    case '4'
        fprintf(my_dds,['v3 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch4 = handles.target_amp;
        set(handles.edit_target_amp_ch4,'String',num2str(handles.target_amp));
    case '5'
        fprintf(my_dds,['v2 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch5 = handles.target_amp;
        set(handles.edit_target_amp_ch5,'String',num2str(handles.target_amp));
    case '6'
        fprintf(my_dds,['v1 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch6 = handles.target_amp;
        set(handles.edit_target_amp_ch6,'String',num2str(handles.target_amp));
    case '7'
        fprintf(my_dds,['v0 ' num2str(handles.target_amp)])
        out1 = fscanf(my_dds)
        out2 = fscanf(my_dds)
        pause(handles.time_delay);
        handles.target_amp_ch7 = handles.target_amp;
        set(handles.edit_target_amp_ch7,'String',num2str(handles.target_amp));
end
fclose(my_dds);
guidata(hObject, handles);


function pushbutton_update_amp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

my_dds = serial(handles.dds_com1,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');

fopen(my_dds);
fprintf(my_dds,'M N')
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)

fprintf(my_dds,['v3 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch0 = handles.sel_amp;
set(handles.edit_target_amp_ch0,'String',num2str(handles.sel_amp));

fprintf(my_dds,['v2 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch1 = handles.sel_amp;
set(handles.edit_target_amp_ch1,'String',num2str(handles.sel_amp));


fprintf(my_dds,['v1 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch2 = handles.sel_amp;
set(handles.edit_target_amp_ch2,'String',num2str(handles.sel_amp));


fprintf(my_dds,['v0 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch3 = handles.sel_amp;
set(handles.edit_target_amp_ch3,'String',num2str(handles.sel_amp));

fclose(my_dds);

my_dds = serial (handles.dds_com2,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
fopen(my_dds);
fprintf(my_dds,'M N')
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)

fprintf(my_dds,['v3 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch4 = handles.sel_amp;
set(handles.edit_target_amp_ch4,'String',num2str(handles.sel_amp));


fprintf(my_dds,['v2 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch5 = handles.sel_amp;
set(handles.edit_target_amp_ch5,'String',num2str(handles.sel_amp));


fprintf(my_dds,['v1 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch6 = handles.sel_amp;
set(handles.edit_target_amp_ch6,'String',num2str(handles.sel_amp));


fprintf(my_dds,['v0 ' num2str(handles.sel_amp)])
out1 = fscanf(my_dds)
out2 = fscanf(my_dds)
pause(handles.time_delay);
handles.target_amp_ch7 = handles.sel_amp;
set(handles.edit_target_amp_ch7,'String',num2str(handles.sel_amp));


fclose(my_dds);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton_update_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton_calibrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





function check_channel_phase(hObject, eventdata, handles)
if(handles.control_ch<4)
    my_dds = serial(handles.dds_com1,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
else
    my_dds = serial(handles.dds_com2,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
end
fopen(my_dds);

[scope, success] = ky_scope_rs_init(handles.rs_scope_ip, handles.rs_scope_sample_size);

arr_structs              = ky_scope_rs_get_ch_data(scope, handles.scope_ch); % grabs/stores data
if handles.rs_scope_sample_size ~= arr_structs(1).num_samples % tests to make sure the amount of samples grabbed is correct
    error('The sample size used on Scope is different from the sample size stored in settings');
end
ch1_data = arr_structs(1).data; % stores the waveform data
ch2_data = arr_structs(2).data; % stores the waveform data

data.fs = arr_structs(1).fs;
data_f = 5e6;
dt = 1/arr_structs(1).fs;
time = dt:dt:dt*arr_structs(1).num_samples;

axes(handles.axesFig2);
cla;
plot(time*10^6,ch1_data,'linewidth',1);
hold on;
plot(time*10^6,ch2_data,'linewidth',1);
xlabel('Time [us]');
ylabel('Voltage [V]');
legend('Measured Channel','Reference Channel(Ch0)');

ptp_ch1_data = max(ch1_data) - min(ch1_data);
ptp_ch2_data = max(ch2_data) - min(ch2_data);
nom_ch1_data = (ch1_data-max(ch1_data)/2)/max(ch1_data);
nom_ch2_data = (ch2_data-max(ch2_data)/2)/max(ch2_data);

[acor,lag] = xcorr(nom_ch1_data,nom_ch2_data);
[~,I] = max(acor);
lagDiff = lag(I);
timeDiff = lagDiff*dt;

temp_ph = timeDiff*data_f*360
if(abs(temp_ph) >180)
    if(temp_ph<0)
        temp_ph = 360+temp_ph;
    else
        temp_ph = -360+temp_ph;
    end
else
    temp_ph = temp_ph;
end
fclose(my_dds);

switch num2str(handles.control_ch)
    case '0'
        handles.meas_phase_ch0 = temp_ph;
        set(handles.edit_meas_phase_ch0,'String',num2str(temp_ph));
        handles.meas_amp_ch0 = ptp_ch1_data;
        set(handles.edit_meas_amp_ch0,'String',num2str(ptp_ch2_data));
    case '1'
        handles.meas_phase_ch1 = temp_ph;
        set(handles.edit_meas_phase_ch1,'String',num2str(temp_ph));
        handles.meas_amp_ch1 = ptp_ch2_data;
        set(handles.edit_meas_amp_ch1,'String',num2str(ptp_ch1_data));
    case '2'
        handles.meas_phase_ch2 = temp_ph;
        set(handles.edit_meas_phase_ch2,'String',num2str(temp_ph));
        handles.meas_amp_ch2 = ptp_ch2_data;
        set(handles.edit_meas_amp_ch2,'String',num2str(ptp_ch1_data));
    case '3'
        handles.meas_phase_ch3 = temp_ph;
        set(handles.edit_meas_phase_ch3,'String',num2str(temp_ph));
        handles.meas_amp_ch3 = ptp_ch2_data;
        set(handles.edit_meas_amp_ch3,'String',num2str(ptp_ch1_data));
    case '4'
        handles.meas_phase_ch4 = temp_ph;
        set(handles.edit_meas_phase_ch4,'String',num2str(temp_ph));
        handles.meas_amp_ch4 = ptp_ch2_data;
        set(handles.edit_meas_amp_ch4,'String',num2str(ptp_ch1_data));
    case '5'
        handles.meas_phase_ch5 = temp_ph;
        set(handles.edit_meas_phase_ch5,'String',num2str(temp_ph));
        handles.meas_amp_ch5 = ptp_ch2_data;
        set(handles.edit_meas_amp_ch5,'String',num2str(ptp_ch1_data));
    case '6'
        handles.meas_phase_ch6 = temp_ph;
        set(handles.edit_meas_phase_ch6,'String',num2str(temp_ph));
        handles.meas_amp_ch6 = ptp_ch2_data;
        set(handles.edit_meas_amp_ch6,'String',num2str(ptp_ch1_data));
    case '7'
        handles.meas_phase_ch7 = temp_ph;
        set(handles.edit_meas_phase_ch7,'String',num2str(temp_ph));
        handles.meas_amp_ch7 = ptp_ch2_data;
        set(handles.edit_meas_amp_ch7,'String',num2str(ptp_ch1_data));
end
        set(handles.edit_meas_amp_ch0,'String',num2str(ptp_ch2_data));
guidata(hObject, handles);


function update_channel_phase(hObject, eventdata, handles)

if(handles.control_ch<4)
    my_dds = serial(handles.dds_com1,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
else
    my_dds = serial(handles.dds_com2,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
end
fopen(my_dds);

switch num2str(handles.control_ch)
    case '0'
        phase = wrapTo360(handles.target_phase_ch0+handles.phase_avg_ch0);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p3 ' num2str(N)])
    case '1'
        phase = wrapTo360(handles.target_phase_ch1+handles.phase_avg_ch1);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p2 ' num2str(N)])
    case '2'
        phase = wrapTo360(handles.target_phase_ch2+handles.phase_avg_ch2);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p1 ' num2str(N)])
    case '3'
        phase = wrapTo360(handles.target_phase_ch3+handles.phase_avg_ch3+180);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p0 ' num2str(N)])
    case '4'
        phase = wrapTo360(handles.target_phase_ch4+handles.phase_avg_ch4);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p3 ' num2str(N)])
    case '5'
        phase = wrapTo360(handles.target_phase_ch5+handles.phase_avg_ch5);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p2 ' num2str(N)])
    case '6'
        phase = wrapTo360(handles.target_phase_ch6+handles.phase_avg_ch6);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p1 ' num2str(N)])
    case '7'
        phase = wrapTo360(handles.target_phase_ch7+handles.phase_avg_ch7+180);
        N = floor((phase)*16384/360)
        fprintf(my_dds,['p0 ' num2str(N)])
        
end
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
fclose(my_dds);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_update_phase.
function pushbutton_update_phase_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

my_dds = serial(handles.dds_com1,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
fopen(my_dds);

phase = wrapTo360(handles.target_phase_ch0+handles.phase_avg_ch0);
N = floor((phase)*16384/360)
fprintf(my_dds,['p3 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

phase = wrapTo360(handles.target_phase_ch1+handles.phase_avg_ch1);
N = floor((phase)*16384/360)
fprintf(my_dds,['p2 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

phase = wrapTo360(handles.target_phase_ch2+handles.phase_avg_ch2);
N = floor((phase)*16384/360)
fprintf(my_dds,['p1 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

phase = wrapTo360(handles.target_phase_ch3+handles.phase_avg_ch3+180);
N = floor((phase)*16384/360)
fprintf(my_dds,['p0 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

fclose(my_dds);

my_dds = serial(handles.dds_com2,'BaudRate',handles.serial_rate,'DataBits',8,'Parity','none','StopBits',1,'Terminator','CR');
fopen(my_dds);

phase = wrapTo360(handles.target_phase_ch4+handles.phase_avg_ch4);
N = floor((phase)*16384/360)
fprintf(my_dds,['p3 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

phase = wrapTo360(handles.target_phase_ch5+handles.phase_avg_ch5);
N = floor((phase)*16384/360)
fprintf(my_dds,['p2 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

phase = wrapTo360(handles.target_phase_ch6+handles.phase_avg_ch6);
N = floor((phase)*16384/360)
fprintf(my_dds,['p1 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

phase = wrapTo360(handles.target_phase_ch7+handles.phase_avg_ch7+180);
N = floor((phase)*16384/360)
fprintf(my_dds,['p0 ' num2str(N)])
out1 = fscanf(my_dds)
out1 = fscanf(my_dds)
pause(handles.time_delay);

fclose(my_dds);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_update_ch0.
function pushbutton_check_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 0;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch0.
function pushbutton_update_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 0;
update_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_check_ch1.
function pushbutton_check_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 1;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch1.
function pushbutton_update_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 1;
update_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_check_ch2.
function pushbutton_check_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 2;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch2.
function pushbutton_update_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 2;
update_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_check_ch3.
function pushbutton_check_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 3;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch3.
function pushbutton_update_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 3;
update_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_check_ch4.
function pushbutton_check_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 4;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch4.
function pushbutton_update_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 4;
update_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_check_ch5.
function pushbutton_check_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 5;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch5.
function pushbutton_update_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 5;
update_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_check_ch6.
function pushbutton_check_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 6;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch6.
function pushbutton_update_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 6;
update_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_check_ch7.
function pushbutton_check_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 7;
check_channel_phase(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_update_ch7.
function pushbutton_update_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_update_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.control_ch = 7;
update_channel_phase(hObject, eventdata, handles);


function print_message(message_out,handles)
set(handles.editMessage,'String',[]);
set(handles.editMessage,'String',message_out);
disp(message_out);

function new_handles=check_measurement_parameter(handles)

set(handles.pushbutton_calibrate,'Enable','on');
set(handles.pushbutton_update_selected_amp,'Enable','on');
set(handles.pushbutton_update_amp,'Enable','on');
set(handles.pushbutton_update_phase,'Enable','on');
set(handles.pushbutton_update_ch0,'Enable','on');
set(handles.pushbutton_update_ch1,'Enable','on');
set(handles.pushbutton_update_ch2,'Enable','on');
set(handles.pushbutton_update_ch3,'Enable','on');
set(handles.pushbutton_update_ch4,'Enable','on');
set(handles.pushbutton_update_ch5,'Enable','on');
set(handles.pushbutton_update_ch6,'Enable','on');
set(handles.pushbutton_update_ch7,'Enable','on');
set(handles.pushbutton_check_ch0,'Enable','on');
set(handles.pushbutton_check_ch1,'Enable','on');
set(handles.pushbutton_check_ch2,'Enable','on');
set(handles.pushbutton_check_ch3,'Enable','on');
set(handles.pushbutton_check_ch4,'Enable','on');
set(handles.pushbutton_check_ch5,'Enable','on');
set(handles.pushbutton_check_ch6,'Enable','on');
set(handles.pushbutton_check_ch7,'Enable','on');
set(handles.pushbutton_save_phase_diff,'Enable','on');
set(handles.pushbutton_load_phase_diff,'Enable','on');

new_handles=handles;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Popup Menu function %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on selection change in popupmenu_amp.
function popupmenu_amp_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_amp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_amp
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case '0'
        handles.sel_amp=0;
        print_message('Amp 0 is selected',handles);
    case '100'
        handles.sel_amp=100;
        print_message('Amp 100 is selected',handles);
    case '200'
        handles.sel_amp=200;
        print_message('Amp 200 is selected',handles);
    case '300'
        handles.sel_amp=300;
        print_message('Amp 300 is selected',handles);
    case '400'
        handles.sel_amp=400;
        print_message('Amp 400 is selected',handles);
    case '500'
        handles.sel_amp=500;
        print_message('Amp 500 is selected',handles);
    case '600'
        handles.sel_amp=600;
        print_message('Amp 600 is selected',handles);
    case '700'
        handles.sel_amp=700;
        print_message('Amp 700 is selected',handles);
    case '800'
        handles.sel_amp=800;
        print_message('Amp 800 is selected',handles);
    case '900'
        handles.sel_amp=900;
        print_message('Amp 900 is selected',handles);
    case '1000'
        handles.sel_amp=1023;
        print_message('Amp 1000 is selected',handles);
    case 'else'
        handles.sel_amp=0;
        print_message('default: ch1 position is selected',handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



% --- Executes on selection change in popupmenu_ch.
function popupmenu_ch_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ch

str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'ch0'
        handles.sel_ch=0;
        print_message('ch0 is selected',handles);
    case 'ch1'
        handles.sel_ch=1;
        print_message('ch1 is selected',handles);
    case 'ch2'
        handles.sel_ch=2;
        print_message('ch2 is selected',handles);
    case 'ch3'
        handles.sel_ch=3;
        print_message('ch3 is selected',handles);
    case 'ch4'
        handles.sel_ch=4;
        print_message('ch4 is selected',handles);
    case 'ch5'
        handles.sel_ch=5;
        print_message('ch5 is selected',handles);
    case 'ch6'
        handles.sel_ch=6;
        print_message('ch6 is selected',handles);
    case 'ch7'
        handles.sel_ch=7;
        print_message('ch7 is selected',handles);
    case 'else'
        handles.sel_ch=1;
        print_message('default: ch1 position is selected',handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Edit Text function %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
        if (FileNameTemp(i)=='\')||(FileNameTemp(i)=='/')
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

function edit_target_phase_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch0 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch0 as a double
handles.target_phase_ch0 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch0 : %2.2f ',handles.target_phase_ch0),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_target_phase_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch1 as a double
handles.target_phase_ch1 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch1 : %2.2f ',handles.target_phase_ch1),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_target_phase_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch2 as a double
handles.target_phase_ch2 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch2 : %2.2f ',handles.target_phase_ch2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_target_phase_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch3 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch3 as a double
handles.target_phase_ch3 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch3 : %2.2f ',handles.target_phase_ch3),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_target_phase_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch4 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch4 as a double
handles.target_phase_ch4 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch4 : %2.2f ',handles.target_phase_ch4),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_target_phase_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch5 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch5 as a double
handles.target_phase_ch5 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch5 : %2.2f ',handles.target_phase_ch5),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_target_phase_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch6 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch6 as a double
handles.target_phase_ch6 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch6 : %2.2f ',handles.target_phase_ch6),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_target_phase_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_phase_ch7 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_phase_ch7 as a double
handles.target_phase_ch7 = str2double(get(hObject,'String'));
print_message(sprintf('Phase ch7 : %2.2f ',handles.target_phase_ch7),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, af
function edit_target_amp_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch0 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch0 as a double
handles.target_amp_ch0 = str2double(get(hObject,'String'));
print_message(sprintf('V0 : %2.2f ',handles.target_amp_ch0),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_amp_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch1 as a double
handles.target_amp_ch1 = str2double(get(hObject,'String'));
print_message(sprintf('V1 : %2.2f ',handles.target_amp_ch1),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_amp_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch2 as a double
handles.target_amp_ch2 = str2double(get(hObject,'String'));
print_message(sprintf('V2 : %2.2f ',handles.target_amp_ch2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_amp_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch3 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch3 as a double
handles.target_amp_ch3 = str2double(get(hObject,'String'));
print_message(sprintf('V3 : %2.2f ',handles.target_amp_ch3),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_amp_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch4 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch4 as a double
handles.target_amp_ch4 = str2double(get(hObject,'String'));
print_message(sprintf('V4 : %2.2f ',handles.target_amp_ch4),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_amp_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch5 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch5 as a double
handles.target_amp_ch5 = str2double(get(hObject,'String'));
print_message(sprintf('V5 : %2.2f ',handles.target_amp_ch5),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_amp_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch6 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch6 as a double
handles.target_amp_ch6 = str2double(get(hObject,'String'));
print_message(sprintf('V6 : %2.2f ',handles.target_amp_ch6),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_amp_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_target_amp_ch7 as text
%        str2double(get(hObject,'String')) returns contents of edit_target_amp_ch7 as a double
handles.target_amp_ch7 = str2double(get(hObject,'String'));
print_message(sprintf('V7 : %2.2f ',handles.target_amp_ch7),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_target_amp_ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_amp_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_dds1_com_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dds1_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dds1_com as text
%        str2double(get(hObject,'String')) returns contents of edit_dds1_com as a double

handles.dds_com1 = get(hObject,'String');
print_message(sprintf('dds_com1 : %s ',handles.dds_com1),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_dds1_com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dds1_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_dds_com2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dds_com2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dds_com2 as text
%        str2double(get(hObject,'String')) returns contents of edit_dds_com2 as a double
handles.dds_com2 = get(hObject,'String');
print_message(sprintf('dds_com2 : %s ',handles.dds_com2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_dds_com2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dds_com2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unnecessary function but required for GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edit_target_phase_ch0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_target_phase_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_target_phase_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_target_phase_ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_target_phase_ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_target_phase_ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_target_phase_ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_target_phase_ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_target_phase_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
function popupmenu_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popupmenu_ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure Phase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function edit_meas_phase_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch0 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch0 as a double

% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_meas_phase_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch1 as a double

% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_meas_phase_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch2 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_meas_phase_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch3 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch3 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_meas_phase_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch4 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch4 as a double

% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_meas_phase_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch5 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch5 as a double

% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_meas_phase_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch6 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch6 as a double

% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_meas_phase_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_phase_ch7 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_phase_ch7 as a double

% --- Executes during object creation, after setting all properties.
function edit_meas_phase_ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_phase_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function axesFig1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesFig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesFig1

% --- Executes during object creation, after setting all properties.
function axesFig2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesFig2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesFig2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase difference variance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function edit_phase_avg_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch0 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch0 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_phase_avg_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch1 as a double

% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_phase_avg_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch2 as a double

% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_phase_avg_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch3 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch3 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_phase_avg_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch4 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch4 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_phase_avg_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch5 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch5 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_phase_avg_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch6 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch6 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_phase_avg_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_avg_ch7 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_avg_ch7 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_avg_ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_avg_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase difference variance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit_phase_var_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch0 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch0 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_phase_var_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch1 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_phase_var_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch2 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_phase_var_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch3 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch3 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_phase_var_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch4 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch4 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_phase_var_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch5 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch5 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_phase_var_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch6 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch6 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_phase_var_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase_var_ch7 as text
%        str2double(get(hObject,'String')) returns contents of edit_phase_var_ch7 as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_var_ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase_var_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure Amplitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function edit_meas_amp_ch0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch0 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch0 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_meas_amp_ch4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch4 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch4 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_meas_amp_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch1 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_meas_amp_ch5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch5 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch5 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_meas_amp_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch2 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_meas_amp_ch3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch3 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch3 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_meas_amp_ch6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch6 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch6 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_meas_amp_ch7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meas_amp_ch7 as text
%        str2double(get(hObject,'String')) returns contents of edit_meas_amp_ch7 as a double


% --- Executes during object creation, after setting all properties.
function edit_meas_amp_ch7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meas_amp_ch7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text70_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text71_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text68_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text63_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text69_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text67_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text61_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text54_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text55_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text56_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text57_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text58_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text59_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text60_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




function edit_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_filename as a double
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
        handles.FileName=[handles.nofolder FileNameTemp];
    else % Folder information
        handles.FileName=FileNameTemp;
    end
end

handles=check_measurement_parameter(handles);
print_message(sprintf('%s',[handles.FileName '.MAT']),handles);

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_phase_diff.
function pushbutton_save_phase_diff_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_phase_diff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

phase_avg(1) = handles.phase_avg_ch1;
phase_avg(2) = handles.phase_avg_ch2;
phase_avg(3) = handles.phase_avg_ch3;
phase_avg(4) = handles.phase_avg_ch4;
phase_avg(5) = handles.phase_avg_ch5;
phase_avg(6) = handles.phase_avg_ch6;
phase_avg(7) = handles.phase_avg_ch7;
file_name=handles.FileName;
save([file_name '.MAT'],'phase_avg');
print_message(sprintf('%s Saved',[file_name '.MAT']),handles);


% --- Executes on button press in pushbutton_load_phase_diff.
function pushbutton_load_phase_diff_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_phase_diff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load(handles.FileName);
handles.phase_avg_ch1= phase_avg(1);
handles.phase_avg_ch2= phase_avg(2);
handles.phase_avg_ch3= phase_avg(3);
handles.phase_avg_ch4= phase_avg(4);
handles.phase_avg_ch5= phase_avg(5);
handles.phase_avg_ch6= phase_avg(6);
handles.phase_avg_ch7= phase_avg(7);
set(handles.edit_phase_avg_ch1,'String',num2str(handles.phase_avg_ch1));
set(handles.edit_phase_avg_ch2,'String',num2str(handles.phase_avg_ch2));
set(handles.edit_phase_avg_ch3,'String',num2str(handles.phase_avg_ch3));
set(handles.edit_phase_avg_ch4,'String',num2str(handles.phase_avg_ch4));
set(handles.edit_phase_avg_ch5,'String',num2str(handles.phase_avg_ch5));
set(handles.edit_phase_avg_ch6,'String',num2str(handles.phase_avg_ch6));
set(handles.edit_phase_avg_ch7,'String',num2str(handles.phase_avg_ch7));
file_name=handles.FileName;

print_message(sprintf('%s loaded',[file_name '.MAT']),handles);
guidata(hObject,handles);


% --- Executes on selection change in popupmenu_ch2.
function popupmenu_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ch2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ch2

str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'ch0'
        handles.sel_ch2=0;
        print_message('ch0 is selected',handles);
    case 'ch1'
        handles.sel_ch2=1;
        print_message('ch1 is selected',handles);
    case 'ch2'
        handles.sel_ch2=2;
        print_message('ch2 is selected',handles);
    case 'ch3'
        handles.sel_ch2=3;
        print_message('ch3 is selected',handles);
    case 'ch4'
        handles.sel_ch2=4;
        print_message('ch4 is selected',handles);
    case 'ch5'
        handles.sel_ch2=5;
        print_message('ch5 is selected',handles);
    case 'ch6'
        handles.sel_ch2=6;
        print_message('ch6 is selected',handles);
    case 'ch7'
        handles.sel_ch2=7;
        print_message('ch7 is selected',handles);
    case 'else'
        handles.sel_ch2=1;
        print_message('default: ch1 position is selected',handles);
end
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ch_target_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ch_target_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ch_target_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_ch_target_amp as a double
handles.target_amp = str2double(get(hObject,'String'));
print_message(sprintf('amp : %2.2f ',handles.target_amp),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_ch_target_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ch_target_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
