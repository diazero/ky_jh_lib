function varargout = ky_gui_plot_scan_dataz(varargin)
% ky_gui_plot_scan_dataz M-file for ky_gui_plot_scan_dataz.fig
%      ky_gui_plot_scan_dataz, by itself, creates a new ky_gui_plot_scan_dataz or raises the existing
%      singleton*.
%
%      H = ky_gui_plot_scan_dataz returns the handle to a new ky_gui_plot_scan_dataz or the handle to
%      the existing singleton*.
%
%      ky_gui_plot_scan_dataz('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ky_gui_plot_scan_dataz.M with the given input arguments.
%
%      ky_gui_plot_scan_dataz('Property','Value',...) creates a new ky_gui_plot_scan_dataz or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Motor_seq_simple_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ky_gui_plot_scan_dataz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ky_gui_plot_scan_dataz
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Last Modified by GUIDE v2.5 21-Sep-2016 15:58:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ky_gui_plot_scan_dataz_OpeningFcn, ...
    'gui_OutputFcn',  @ky_gui_plot_scan_dataz_OutputFcn, ...
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


% --- Executes just before ky_gui_plot_scan_dataz is made visible.
function ky_gui_plot_scan_dataz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ky_gui_plot_scan_dataz (see VARARGIN)

% Choose default command line output for ky_gui_plot_scan_dataz
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handles.nofolder='C:\Users\JiHoon\Documents\MATLAB';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.sel_ch1 = 0;
handles.sel_ch2 = 0;
handles.sel_ch3 = 0;
handles.sel_ch4 = 0;
handles.sel_x = 1;
handles.sel_y = 1;
handles.sel_z = 1;

axes(handles.axes1);
    imagesc(1:2,1:2,[1 1;1 1])
    xlabel('X [mm]')
    ylabel('Y [mm]')
axes(handles.axes2);
plot(1e-9:1e-9:1e-6,zeros(length(1e-9:1e-9:1e-6)),'LineWidth',2)
xlabel('time [s]')
ylabel('Vpp [V]')
% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ky_gui_plot_scan_dataz_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_read_xyz.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom functoin %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function print_message(message_out,handles)
set(handles.edit_message,'String',[]);
set(handles.edit_message,'String',message_out);
disp(message_out);

function new_handles=check_measurement_parameter(handles)

set(handles.pushbutton_plot_scan_data,'Enable','on');
set(handles.pushbutton_plot_waveform,'Enable','on');
set(handles.pushbutton_convert_pressure,'Enable','on');

new_handles=handles;


% guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Text Edit functoin %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in checkbox_ch1.
function checkbox_sel_ch1_Callback(hObject, eventdata, handles)
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
function checkbox_sel_ch2_Callback(hObject, eventdata, handles)
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
function checkbox_sel_ch3_Callback(hObject, eventdata, handles)
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
function checkbox_sel_ch4_Callback(hObject, eventdata, handles)
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


% --- Executes on button press in pushbutton_save_plots.
function pushbutton_save_plots_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton_plot_scan_data.
function pushbutton_plot_scan_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_scan_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load(handles.filename_scan_data);

if(strcmp(handles.filename_scan_data(end-5:end),'xy.MAT'))
    handles.scan_data = scan_data;
    [handles.scan_sample_size,handles.num_x,handles.num_y] = size(handles.scan_data.wave_form);
    
    set(handles.edit_num_x,'String',[]);
    set(handles.edit_num_x,'String',num2str(handles.num_x));
    disp(num2str(handles.num_x));
    set(handles.edit_num_y,'String',[]);
    set(handles.edit_num_y,'String',num2str(handles.num_y));
    disp(num2str(handles.num_y));
    % Fill these in from scan
    Vpp = zeros(handles.num_x,handles.num_y);
    
    figure;
    plot(handles.scan_data.wave_form(:,1,1))
    xlabel('Points')
    ylabel('output voltage [V]')
    title('Select signal length start then end')
    [timeindex,NA] = ginput(2);
    timeindex=floor(timeindex);
    handles.time_min = timeindex(1);
    handles.time_max = timeindex(2);
    close;
    clist = colormap('jet');
    
    for i=1:handles.num_x
        for j=1:handles.num_y
            Vpp(i,j)=max(handles.scan_data.wave_form(handles.time_min:handles.time_max,i,j))-min(handles.scan_data.wave_form(handles.time_min:handles.time_max,i,j));
        end
    end
    axes(handles.axes1);
    imagesc(handles.scan_data.coordinates(1,:,1),squeeze(handles.scan_data.coordinates(2,1,:))',Vpp')
    xlabel('X [mm]')
    ylabel('Y [mm]')
    colorbar;
    figure;
    imagesc(handles.scan_data.coordinates(1,:,1),squeeze(handles.scan_data.coordinates(2,1,:))',Vpp')
    xlabel('X [mm]')
    ylabel('Y [mm]')
    colorbar;
    saveas(gcf,[handles.filename '_xy_scan'],'png')
    close;
    guidata(hObject,handles);
    
elseif(strcmp(handles.filename_scan_data(end-5:end),'yz.MAT'))
    handles.scan_data = scan_data;
    [handles.scan_sample_size,handles.num_y,handles.num_z] = size(handles.scan_data.wave_form);

    set(handles.edit_num_y,'String',[]);
    set(handles.edit_num_y,'String',num2str(handles.num_y));
    disp(num2str(handles.num_y));
        
    set(handles.edit_num_z,'String',[]);
    set(handles.edit_num_z,'String',num2str(handles.num_z));
    disp(num2str(handles.num_z));
    % Fill these in from scan
    Vpp = zeros(handles.num_y,handles.num_z);
    
    figure;
    plot(handles.scan_data.wave_form(:,1,1))
    xlabel('Points')
    ylabel('output voltage [V]')
    title('Select signal length start then end')
    [timeindex,NA] = ginput(2);
    timeindex=floor(timeindex);
    handles.time_min = timeindex(1);
    handles.time_max = timeindex(2);
    close;
    clist = colormap('jet');
    
    for i=1:handles.num_y
        for j=1:handles.num_z
            Vpp(i,j)=max(handles.scan_data.wave_form(handles.time_min:handles.time_max,i,j))-min(handles.scan_data.wave_form(handles.time_min:handles.time_max,i,j));
        end
    end
    axes(handles.axes1);
    imagesc(squeeze(handles.scan_data.coordinates(2,:,1)),squeeze(handles.scan_data.coordinates(3,1,:))',Vpp')
    xlabel('Y [mm]')
    ylabel('Z [mm]')
    colorbar;
    figure;
        imagesc(squeeze(handles.scan_data.coordinates(2,:,1)),squeeze(handles.scan_data.coordinates(3,1,:))',Vpp')
    xlabel('Y [mm]')
    ylabel('Z [mm]')
    colorbar;
    saveas(gcf,[handles.filename '_yz_scan'],'png')
    close;
    guidata(hObject,handles);
    
elseif(strcmp(handles.filename_scan_data(end-5:end),'xyz.MAT'))
    handles.scan_data = scan_data;
    [handles.scan_sample_size,handles.num_x,handles.num_y,handles.num_z] = size(handles.scan_data.wave_form);

    set(handles.edit_num_x,'String',[]);
    set(handles.edit_num_x,'String',num2str(handles.num_x));
    disp(num2str(handles.num_x));
    
    set(handles.edit_num_y,'String',[]);
    set(handles.edit_num_y,'String',num2str(handles.num_y));
    disp(num2str(handles.num_y));
        
    set(handles.edit_num_z,'String',[]);
    set(handles.edit_num_z,'String',num2str(handles.num_z));
    disp(num2str(handles.num_z));
    % Fill these in from scan
    Vpp = zeros(handles.num_x,handles.num_y,handles.num_z);
    
    figure;
    plot(handles.scan_data.wave_form(:,1,1,1))
    xlabel('Points')
    ylabel('output voltage [V]')
    title('Select signal length start then end')
    [timeindex,NA] = ginput(2);
    timeindex=floor(timeindex);
    handles.time_min = timeindex(1);
    handles.time_max = timeindex(2);
    close;
    clist = colormap('jet');
    for i=1:handles.num_x
        for j=1:handles.num_y
            for k=1:handles.num_z
                Vpp(i,j,k)=max(handles.scan_data.wave_form(handles.time_min:handles.time_max,i,j,k))-min(handles.scan_data.wave_form(handles.time_min:handles.time_max,i,j,k));
            end
        end
    end
    p = handles.sel_x;

    axes(handles.axes1);
    imagesc(squeeze(handles.scan_data.coordinates(2,p,:,1)),squeeze(handles.scan_data.coordinates(3,p,1,:))',Vpp')
    xlabel('Y [mm]')
    ylabel('Z [mm]')
    colorbar;
    figure;
    imagesc(squeeze(handles.scan_data.coordinates(2,p,:,1)),squeeze(handles.scan_data.coordinates(3,p,1,:))',Vpp')
    xlabel('Y [mm]')
    ylabel('Z [mm]')
    colorbar;
    saveas(gcf,[handles.filename '_yz_scan'],'png')
    close;
    guidata(hObject,handles);
else
end




% --- Executes on button press in pushbutton_plot_waveform.
function pushbutton_plot_waveform_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_waveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p = handles.sel_x;
q = handles.sel_y;
r = handles.sel_z;

dt = 1/handles.scan_data.scope_info.fs;
time = handles.time_min*dt:dt:(handles.time_max)*dt;
if(strcmp(handles.filename_scan_data(end-5:end),'xy.MAT'))
    handles.vdata = handles.scan_data.wave_form(handles.time_min:handles.time_max,p,q);
    handles.file_name_point = [handles.filename '_waveform_' num2str(p) '_' num2str(q)];
elseif(strcmp(handles.filename_scan_data(end-5:end),'yz.MAT'))
    handles.vdata = handles.scan_data.wave_form(handles.time_min:handles.time_max,q,r);
    handles.file_name_point = [handles.filename '_waveform_' num2str(q) '_' num2str(r)];
else
end

axes(handles.axes2);
plot(time,handles.vdata,'LineWidth',2)
handles.vdata_ptp = max(handles.vdata) - min(handles.vdata);
del = 0.1*(max(handles.vdata)-min(handles.vdata));
axis([handles.time_min*dt handles.time_max*dt min(handles.vdata)-del max(handles.vdata)+del]);
xlabel('time [s]')
ylabel('Vpp [V]')
[max_v max_i] = max(handles.vdata);
[min_v min_i] = min(handles.vdata)
text(time(max_i),handles.vdata(max_i),['Maximum voltage = ' num2str(max_v)]);
text(time(min_i),handles.vdata(min_i),['Minimum voltage = ' num2str(min_v)]);
figure;
plot(time,handles.vdata,'LineWidth',2)
del = 0.1*(max(handles.vdata)-min(handles.vdata));
axis([handles.time_min*dt handles.time_max*dt min(handles.vdata)-del max(handles.vdata)+del]);
xlabel('time [s]')
ylabel('Vpp [V]')
text(time(max_i),handles.vdata(max_i),['Maximum voltage = ' num2str(max_v)]);
text(time(min_i),handles.vdata(min_i),['Minimum voltage = ' num2str(min_v)]);
saveas(gcf,handles.file_name_point,'png')
save_data.time = time;
save_data.dt = dt;
save_data.vdata = handles.vdata;
save([handles.filename '_waveform_data.MAT'],'save_data');
close;
guidata(hObject,handles);

% --- Executes on button press in pushbutton_convert_pressure.
function pushbutton_convert_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_convert_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tukey_param  = 0.5;
signal.f = handles.vdata;
fs = handles.scan_data.scope_info.fs;
signal.t_axis = (0:length(signal.f)-1)/fs; 
spectrum      = ky_fft_and_window(handles.vdata, fs, tukey_param);
metrics       = ky_get_spectrum_metrics(spectrum);
metrics.name  = '';
if(strcmp(handles.hp_option,'1656'))
signal.f_pa   = signal.f * ky_volt_to_pa(metrics.fc,'1656');
elseif(strcmp(handles.hp_option,'1364'))
signal.f_pa   = signal.f * ky_volt_to_pa(metrics.fc,'1364');    
else
end
signal.f_pa_pp = max(signal.f_pa)-min(signal.f_pa);
metrics.name  = sprintf('Ptp Pressure = %2.3f MPa',signal.f_pa_pp/1e6);
figure;
ky_plot_hydrophone_metrics(metrics, signal, spectrum);
saveas(gcf,[handles.file_name_point '_acoustic'],'png')
guidata(hObject,handles);

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
        if FileNameTemp(i)=='\'
            flag=1;
            break;
        end
    end
    
    if flag==0 % No Folder information
        handles.filename = [handles.nofolder FileNameTemp];
    else % Folder information
        handles.filename = FileNameTemp;
    end
end
print_message(sprintf('%s',handles.filename),handles);

handles=check_measurement_parameter(handles);

guidata(hObject,handles);



function edit_num_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_x as text
%        str2double(get(hObject,'String')) returns contents of edit_num_x as a double


function edit_num_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_y as text
%        str2double(get(hObject,'String')) returns contents of edit_num_y as a double


function edit_num_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_z as text
%        str2double(get(hObject,'String')) returns contents of edit_num_z as a double

% --- Executes on selection change in popupmenu_hydrophone_type.
function popupmenu_hydrophone_type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_hydrophone_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_hydrophone_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_hydrophone_type
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
    case 'New Hydrophone'
        handles.hp_option='1656';
        print_message('1656 is selected',handles);
    case 'Old Hydrophone'
        handles.hp_option='1364';
        print_message('1364 is selected',handles);
end
guidata(hObject,handles);

function edit_filename_scan_data_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filename_scan_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filename_scan_data as text
%        str2double(get(hObject,'String')) returns contents of edit_filename_scan_data as a double
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
        handles.filename_scan_data = [handles.nofolder FileNameTemp];
    else % Folder information
        handles.filename_scan_data = FileNameTemp;
    end
end
print_message(sprintf('%s',handles.filename_scan_data),handles);

handles=check_measurement_parameter(handles);

guidata(hObject,handles);


function edit_sel_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sel_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sel_x as text
%        str2double(get(hObject,'String')) returns contents of edit_sel_x as a double
handles.sel_x = str2double(get(hObject,'String'));
print_message(sprintf('Select X point : %2.2f',handles.sel_x),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_sel_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sel_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sel_y as text
%        str2double(get(hObject,'String')) returns contents of edit_sel_y as a double
handles.sel_y = str2double(get(hObject,'String'));
print_message(sprintf('Select Y point : %2.2f',handles.sel_y),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_sel_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sel_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sel_z as text
%        str2double(get(hObject,'String')) returns contents of edit_sel_z as a double
handles.sel_z = str2double(get(hObject,'String'));
print_message(sprintf('Select Z point : %2.2f',handles.sel_z),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unnecessary function but required for GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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



% --- Executes during object creation, after setting all properties.
function edit_num_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_num_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_sel_x_CreateFcn(hObject, eventdata, ~)
% hObject    handle to edit_sel_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_sel_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sel_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function popupmenu_hydrophone_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_hydrophone_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_filename_scan_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filename_scan_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_message_Callback(hObject, eventdata, handles)
% hObject    handle to edit_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_message as text
%        str2double(get(hObject,'String')) returns contents of edit_message as a double


% --- Executes during object creation, after setting all properties.
function edit_message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_num_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_sel_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sel_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
