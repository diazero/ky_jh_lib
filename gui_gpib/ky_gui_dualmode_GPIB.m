function varargout = ky_gui_dualmode_GPIB(varargin)
% ky_gui_dualmode_GPIB M-file for ky_gui_dualmode_GPIB.fig
%      ky_gui_dualmode_GPIB, by itself, creates a new ky_gui_dualmode_GPIB or raises the existing
%      singleton*.
%
%      H = ky_gui_dualmode_GPIB returns the handle to a new ky_gui_dualmode_GPIB or the handle to
%      the existing singleton*.
%
%      ky_gui_dualmode_GPIB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ky_gui_dualmode_GPIB.M with the given input arguments.
%
%      ky_gui_dualmode_GPIB('Property','Value',...) creates a new ky_gui_dualmode_GPIB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Motor_seq_simple_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ky_gui_dualmode_GPIB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ky_gui_dualmode_GPIB

% Last Modified by GUIDE v2.5 24-Sep-2016 19:43:47
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ky_gui_dualmode_GPIB_OpeningFcn, ...
    'gui_OutputFcn',  @ky_gui_dualmode_GPIB_OutputFcn, ...
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


% --- Executes just before ky_gui_dualmode_GPIB is made visible.
function ky_gui_dualmode_GPIB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ky_gui_dualmode_GPIB (see VARARGIN)

% Choose default command line output for ky_gui_dualmode_GPIB
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handles.nofolder='C:\Users\JiHoon\Documents\MATLAB';
handles.gpib_vdd = 1;
handles.gpib_hvdd = 2;
handles.gpib_hvdd2 = 3;
handles.gpib_dc_bias2 = 4; 
handles.gpib_cmut_hv = 5;
handles.gpib_temp = 6;

handles.instrument_vdd = 'HP_E3631A';
handles.instrument_hvdd = 'HP_E3631A';
handles.instrument_hvdd2 = 'HP_E3634A';
handles.instrument_dc_bias2 = 'HP_E3631A';
handles.instrument_cmut_hv = 'PS310';
handles.instrument_temp = 'SR630';

handles.sel_ch=1;
handles.rs_scope_ip = '171.64.84.150';
handles.rs_scope_sample_size = 5000;
handles.cmut_hv_start = 15;
handles.cmut_hv_end = 45;
handles.cmut_hv_step = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.vdd_brd =0;
handles.vdd_ic =0;
handles.hvref =0;
handles.hvdd =0;
handles.hvdd2 =0;
handles.dc_bias2_ch1 =0;
handles.dc_bias2_ch2 =0;
handles.cmut_hv =0;


handles.imaging_vdd_brd =5;
handles.imaging_vdd_ic =5;
handles.imaging_hvref =15.5;
handles.imaging_hvdd =4.5;
handles.imaging_hvdd2 =0;
handles.imaging_dc_bias2_ch1 =0;
handles.imaging_dc_bias2_ch2 =0;
handles.imaging_cmut_hv =45;

handles.hifu_vdd_brd =5;
handles.hifu_vdd_ic =5;
handles.hifu_hvref =20;
handles.hifu_hvdd =0;
handles.hifu_hvdd2 =40;
handles.hifu_dc_bias2_ch1 =5;
handles.hifu_dc_bias2_ch2 =25;
handles.hifu_cmut_hv =45;
set(handles.pushbutton_set_vdd,'Enable','on');
set(handles.pushbutton_set_hvdd,'Enable','on');
set(handles.pushbutton_set_hvdd2,'Enable','on');
set(handles.pushbutton_set_dc_bias2,'Enable','on');
set(handles.pushbutton_set_cmut_hv,'Enable','on');
set(handles.pushbutton_read,'Enable','on');
set(handles.pushbutton_off_vdd,'Enable','on');
set(handles.pushbutton_off_hvdd,'Enable','on');
set(handles.pushbutton_off_hvdd2,'Enable','on');
set(handles.pushbutton_off_dc_bias2,'Enable','on');
set(handles.pushbutton_off_cmut_hv,'Enable','on');
set(handles.pushbutton_read_temp,'Enable','on');
set(handles.pushbutton_imaging,'Enable','on');
set(handles.pushbutton_hifu,'Enable','on');
set(handles.pushbutton_off_all,'Enable','on');

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ky_gui_dualmode_GPIB_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_read_temp.
function pushbutton_read_temp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.read_temp = kypib(handles.instrument_temp,handles.gpib_temp,'read','temp',2);

set(handles.edit_temp,'String',[]);
set(handles.edit_temp,'String',num2str(handles.read_temp,'%2.2f'));
disp(['TEMPERATURE:' num2str(handles.read_temp)]);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%RETVAL = KPIB('INSTRUMENT', GPIB, 'COMMAND', VALUE, CHANNEL, AUX, VERBOSE)
% kypib(handles.instrument_vdd,handles.gpib_vdd,'on',1);
handles.read_vdd_brd = kypib(handles.instrument_vdd,handles.gpib_vdd,'read',1);

% kypib(handles.instrument_vdd,handles.gpib_vdd,'on',2);
handles.read_vdd_ic = kypib(handles.instrument_vdd,handles.gpib_vdd,'read',2);

% kypib(handles.instrument_hvdd,handles.gpib_hvdd,'on',1);
handles.read_hvdd = kypib(handles.instrument_hvdd,handles.gpib_hvdd,'read',1);

% kypib(handles.instrument_hvdd,handles.gpib_hvdd,'on',2);
handles.read_hvref = kypib(handles.instrument_hvdd,handles.gpib_hvdd,'read',2);

% kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'on',2);
handles.read_hvdd2 = kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'read',1);

% kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on',1);
handles.read_dc_bias2_ch1 = kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'read',1);

% kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on',2);
handles.read_dc_bias2_ch2 = kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'read',2);

% kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'on');
handles.read_cmut_hv.volt = kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'read','volt');
handles.read_cmut_hv.curr = kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'read','current');

set(handles.edit_vdd_brd,'String',[]);
set(handles.edit_vdd_brd,'String',num2str(handles.read_vdd_brd.volt,'%2.2f'));
disp(['VDD_BRD, VOLT:' num2str(handles.read_vdd_brd.volt,'%2.2f')]);
set(handles.edit_vdd_brd_curr,'String',[]);
set(handles.edit_vdd_brd_curr,'String',num2str(handles.read_vdd_brd.curr,'%2.2f'));
disp(['VDD_BRD, CURR:' num2str(handles.read_vdd_brd.curr,'%2.2f')]);

set(handles.edit_vdd_ic,'String',[]);
set(handles.edit_vdd_ic,'String',num2str(handles.read_vdd_ic.volt,'%2.2f'));
disp(['VDD_IC, VOLT:' num2str(handles.read_vdd_ic.volt,'%2.2f')]);
set(handles.edit_vdd_ic_curr,'String',[]);
set(handles.edit_vdd_ic_curr,'String',num2str(handles.read_vdd_ic.curr,'%2.2f'));
disp(['VDD_IC, CURR:' num2str(handles.read_vdd_ic.curr,'%2.2f')]);


set(handles.edit_hvdd,'String',[]);
set(handles.edit_hvdd,'String',num2str(handles.read_hvdd.volt,'%2.2f'));
disp(['HVDD, VOLT:' num2str(handles.read_hvdd.volt,'%2.2f')]);
set(handles.edit_hvdd_curr,'String',[]);
set(handles.edit_hvdd_curr,'String',num2str(handles.read_hvdd.curr,'%2.2f'));
disp(['HVDD, CURR:' num2str(handles.read_hvdd.curr,'%2.2f')]);

set(handles.edit_hvref,'String',[]);
set(handles.edit_hvref,'String',num2str(handles.read_hvref.volt,'%2.2f'));
disp(['HVREF, VOLT:' num2str(handles.read_hvref.volt,'%2.2f')]);
set(handles.edit_hvref_curr,'String',[]);
set(handles.edit_hvref_curr,'String',num2str(handles.read_hvref.curr,'%2.2f'));
disp(['HVREF, CURR:' num2str(handles.read_hvref.curr,'%2.2f')]);

set(handles.edit_hvdd2,'String',[]);
set(handles.edit_hvdd2,'String',num2str(handles.read_hvdd2.volt,'%2.2f'));
disp(['HVDD2, VOLT:' num2str(handles.read_hvdd2.volt,'%2.2f')]);
set(handles.edit_hvdd2_curr,'String',[]);
set(handles.edit_hvdd2_curr,'String',num2str(handles.read_hvdd2.curr,'%2.2f'));
disp(['HVDD2, CURR:' num2str(handles.read_hvdd2.curr,'%2.2f')]);

set(handles.edit_dc_bias2_ch1,'String',[]);
set(handles.edit_dc_bias2_ch1,'String',num2str(handles.read_dc_bias2_ch1.volt,'%2.2f'));
disp(['DC_BIAS2_CH1, VOLT:' num2str(handles.read_dc_bias2_ch1.volt,'%2.2f')]);
set(handles.edit_dc_bias2_ch1_curr,'String',[]);
set(handles.edit_dc_bias2_ch1_curr,'String',num2str(handles.read_dc_bias2_ch1.curr,'%2.2f'));
disp(['DC_BIAS2_CH1, CURR:' num2str(handles.read_dc_bias2_ch1.curr,'%2.2f')]);

set(handles.edit_dc_bias2_ch2,'String',[]);
set(handles.edit_dc_bias2_ch2,'String',num2str(handles.read_dc_bias2_ch2.volt,'%2.2f'));
disp(['DC_BIAS2_CH2, VOLT:' num2str(handles.read_dc_bias2_ch2.volt,'%2.2f')]);
set(handles.edit_dc_bias2_ch2_curr,'String',[]);
set(handles.edit_dc_bias2_ch2_curr,'String',num2str(handles.read_dc_bias2_ch2.curr,'%2.2f'));
disp(['DC_BIAS2_CH2, CURR:' num2str(handles.read_dc_bias2_ch2.curr,'%2.2f')]);

set(handles.edit_cmut_hv,'String',[]);
set(handles.edit_cmut_hv,'String',num2str(handles.read_cmut_hv.volt,'%2.2f'));
disp(['CMUT_HV, VOLT:' num2str(handles.read_cmut_hv.volt,'%2.2f')]);
set(handles.edit_cmut_hv_curr,'String',[]);
set(handles.edit_cmut_hv_curr,'String',num2str(handles.read_cmut_hv.curr,'%2.2f'));
disp(['CMUT_HV, CURR:' num2str(handles.read_cmut_hv.curr,'%2.2f')]);



guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Motorized Positioner function %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in popupmenu_abcd.

% --- Executes on button press in pushbutton_set_vdd.
function pushbutton_set_vdd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_vdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_vdd,handles.gpib_vdd,'on');
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',handles.vdd_brd,1);
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',handles.vdd_ic,2);


% --- Executes on button press in pushbutton_set_hvdd.
function pushbutton_set_hvdd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'on');
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',handles.hvdd,1);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',handles.hvref,2);


% --- Executes on button press in pushbutton_set_hvdd2.
function pushbutton_set_hvdd2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'on');
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'set',handles.hvdd2,2);

% --- Executes on button press in pushbutton_set_dc_bias2.
function pushbutton_set_dc_bias2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_dc_bias2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on');
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',handles.dc_bias2_ch1,1);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',handles.dc_bias2_ch2,2);


% --- Executes on button press in pushbutton_set_cmut_hv.
function pushbutton_set_cmut_hv_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.cmut_hv<100)
kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'on');
kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'set','volt',handles.cmut_hv,1);
end


% --- Executes on button press in pushbutton_imaging.
function pushbutton_imaging_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_imaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton_off_all_Callback(hObject, eventdata, handles)
kypib(handles.instrument_vdd,handles.gpib_vdd,'on');
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',handles.imaging_vdd_brd,1);
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',handles.imaging_vdd_ic,2);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'on');
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',handles.imaging_hvdd,1);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',handles.imaging_hvref,2);
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'on');
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'set',handles.imaging_hvdd2,2);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on');
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',handles.imaging_dc_bias2_ch1,1);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on');
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',handles.imaging_dc_bias2_ch2,2);
% kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'on');
% kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'set','volt',handles.imaging_cmut_hv,1);


% --- Executes on button press in pushbutton_hifu.
function pushbutton_hifu_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hifu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton_off_all_Callback(hObject, eventdata, handles)
kypib(handles.instrument_vdd,handles.gpib_vdd,'on');
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',handles.hifu_vdd_brd,1);
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',handles.hifu_vdd_ic,2);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'on');
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',handles.hifu_hvdd,1);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',handles.hifu_hvref,2);
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'on');
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'set',handles.hifu_hvdd2,2);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on');
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',handles.hifu_dc_bias2_ch1,1);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on');
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',handles.hifu_dc_bias2_ch2,2);
% kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'on');
% kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'set','volt',handles.hifu_cmut_hv,1);


% --- Executes on button press in pushbutton_off_all.
function pushbutton_off_all_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_off_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on');
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',0,1);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',0,2);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'off');
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'on');
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'set',0,2);
kypib(handles.instrument_hvdd,handles.gpib_hvdd2,'off');
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'on');
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',0,1);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',0,2);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'off');
kypib(handles.instrument_vdd,handles.gpib_vdd,'on');
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',0,1);
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',0,2);
kypib(handles.instrument_vdd,handles.gpib_vdd,'off');


% --- Executes on button press in pushbutton_set_vdd.
function pushbutton_off_vdd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_vdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_vdd,handles.gpib_vdd,'on');
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',0,1);
kypib(handles.instrument_vdd,handles.gpib_vdd,'set',0,2);
kypib(handles.instrument_vdd,handles.gpib_vdd,'off');


% --- Executes on button press in pushbutton_set_hvdd.
function pushbutton_off_hvdd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'on');
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',0,1);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'set',0,2);
kypib(handles.instrument_hvdd,handles.gpib_hvdd,'off');


% --- Executes on button press in pushbutton_set_hvdd2.
function pushbutton_off_hvdd2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'on');
kypib(handles.instrument_hvdd2,handles.gpib_hvdd2,'set',0,2);
kypib(handles.instrument_hvdd,handles.gpib_hvdd2,'off');

% --- Executes on button press in pushbutton_set_dc_bias2.
function pushbutton_off_dc_bias2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_dc_bias2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'on');
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',0,1);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'set',0,2);
kypib(handles.instrument_dc_bias2,handles.gpib_dc_bias2,'off');


% --- Executes on button press in pushbutton_set_cmut_hv.
function pushbutton_off_cmut_hv_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'on');
kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'set','volt',0,1);
kypib(handles.instrument_cmut_hv,handles.gpib_cmut_hv,'off');




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
        set(handles.pushbutton_savedata,'Enable','on');
    else
        set(handles.pushbutton_savedata,'Enable','off');
    end
    
else
    set(handles.pushbutton_savedata,'Enable','off');
end


new_handles=handles;


% --- Executes on button press in pushbutton_savedata.
function pushbutton_savedata_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Pre-Allocate matrices
Bias_Instrument=handles.instrument_cmut_hv;
GpibBias=handles.gpib_cmut_hv;
Bias_Index=handles.cmut_hv_start:handles.cmut_hv_step:handles.cmut_hv_end;
handles.scope_info.bias_index = Bias_Index;
handles.scope_info.bias_wave_form   = zeros(handles.rs_scope_sample_size, length(Bias_Index)); % pre-allocate output waveform matrix
[handles.scope, success] = ky_scope_rs_init(handles.rs_scope_ip, handles.rs_scope_sample_size);

print_message('Measurement Start!',handles);

% % If the initial bias voltage is too high, increase it by step
% if Bias_Instrument=='PS310'
%     if abs(Bias_Index(1))>=30
%         for i=1:(floor(Bias_Index(1)/5))
%             kypib('PS310',GpibBias,'set','volt',i*5);
%             pause(1);
%         end
%     end
% end

for i=1:length(Bias_Index)
    Bias = Bias_Index(i);   % Bias Voltage
    print_message(sprintf('Set Bias Voltage to %d',Bias),handles);
    kypib('PS310',GpibBias,'set','volt',Bias);
    pause(10);
    
    % Read data
    print_message(sprintf('Read Data (%d V)',Bias),handles);
    
    arr_structs              = ky_scope_rs_get_ch_data(handles.scope, handles.sel_ch); % grabs/stores data
    if handles.rs_scope_sample_size ~= arr_structs.num_samples % tests to make sure the amount of samples grabbed is correct
        error('The sample size used on Scope is different from the sample size stored in settings');
    end
    handles.scope_info.bias_wave_form(:,i) = arr_structs.data; % stores the waveform data
    handles.scope_info.fs = arr_structs.fs;
    
    dt = 1/arr_structs.fs;
    time = dt:dt:dt*length(arr_structs.data);
    axes(handles.axes1);
    plot(time*10^6,arr_structs.data,'linewidth',2);
    xlabel('Time [us]');
    ylabel('Voltage [V]');
    % Save File
end
data = handles.scope_info;
file_name=handles.FileName;
save([file_name '.MAT'],'data');
print_message(sprintf('%s Saved',[file_name '.MAT']),handles);

% kypib('PS310',GpibBias,'set','volt',0);
print_message('Measurement Done!',handles);


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
print_message(sprintf('file_name :%s',handles.FileName),handles);

guidata(hObject,handles);


function edit_vdd_brd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vdd_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vdd_brd as text
%        str2double(get(hObject,'String')) returns contents of edit_vdd_brd as a double
handles.vdd_brd = str2double(get(hObject,'String'));
print_message(sprintf('vdd_brd :%f',handles.vdd_brd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_imaging_vdd_brd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_vdd_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_vdd_brd as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_vdd_brd as a double
handles.imaging_vdd_brd = str2double(get(hObject,'String'));
print_message(sprintf('imaging_vdd_brd :%f',handles.imaging_vdd_brd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hifu_vdd_brd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_vdd_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_vdd_brd as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_vdd_brd as a double
handles.hifu_vdd_brd = str2double(get(hObject,'String'));
print_message(sprintf('hifu_vdd_brd :%f',handles.hifu_vdd_brd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_vdd_ic_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vdd_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vdd_ic as text
%        str2double(get(hObject,'String')) returns contents of edit_vdd_ic as a double
handles.vdd_ic = str2double(get(hObject,'String'));
print_message(sprintf('vdd_ic :%f',handles.vdd_ic),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_imaging_vdd_ic_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_vdd_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_vdd_ic as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_vdd_ic as a double
handles.imaging_vdd_ic = str2double(get(hObject,'String'));
print_message(sprintf('imaging_vdd_ic :%f',handles.imaging_vdd_ic),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hifu_vdd_ic_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_vdd_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_vdd_ic as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_vdd_ic as a double
handles.hifu_vdd_ic = str2double(get(hObject,'String'));
print_message(sprintf('hifu_vdd_ic :%f',handles.hifu_vdd_ic),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hvdd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hvdd as text
%        str2double(get(hObject,'String')) returns contents of edit_hvdd as a double
handles.hvdd = str2double(get(hObject,'String'));
print_message(sprintf('hvdd :%f',handles.hvdd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_imaging_hvdd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_hvdd as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_hvdd as a double
handles.imaging_hvdd = str2double(get(hObject,'String'));
print_message(sprintf('imaging_hvdd :%f',handles.imaging_hvdd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_hifu_hvdd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_hvdd as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_hvdd as a double
handles.hifu_hvdd = str2double(get(hObject,'String'));
print_message(sprintf('hifu_hvdd :%f',handles.hifu_hvdd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_hvref_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hvref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hvref as text
%        str2double(get(hObject,'String')) returns contents of edit_hvref as a double
handles.hvref = str2double(get(hObject,'String'));
print_message(sprintf('hvref :%f',handles.hvref),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_imaging_hvref_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_hvref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_hvref as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_hvref as a double
handles.imaging_hvref = str2double(get(hObject,'String'));
print_message(sprintf('imaging_hvref :%f',handles.imaging_hvref),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hifu_hvref_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_hvref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_hvref as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_hvref as a double
handles.hifu_hvref = str2double(get(hObject,'String'));
print_message(sprintf('hifu_hvref :%f',handles.hifu_hvref),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_hvdd2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hvdd2 as text
%        str2double(get(hObject,'String')) returns contents of edit_hvdd2 as a double
handles.hvdd2 = str2double(get(hObject,'String'));
print_message(sprintf('hvdd2 :%f',handles.hvdd2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_imaging_hvdd2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_hvdd2 as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_hvdd2 as a double
handles.imaging_hvdd2 = str2double(get(hObject,'String'));
print_message(sprintf('imaging_hvdd2 :%f',handles.imaging_hvdd2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hifu_hvdd2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_hvdd2 as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_hvdd2 as a double
handles.hifu_hvdd2 = str2double(get(hObject,'String'));
print_message(sprintf('hifu_hvdd2 :%f',handles.hifu_hvdd2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_dc_bias2_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dc_bias2_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_dc_bias2_ch1 as a double
handles.dc_bias2_ch1 = str2double(get(hObject,'String'));
print_message(sprintf('dc_bias2_ch1 :%f',handles.dc_bias2_ch1),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_imaging_dc_bias2_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_dc_bias2_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_dc_bias2_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_dc_bias2_ch1 as a double
handles.imaging_dc_bias2_ch1 = str2double(get(hObject,'String'));
print_message(sprintf('imaging_dc_bias2_ch1 :%f',handles.imaging_dc_bias2_ch1),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_hifu_dc_bias2_ch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_dc_bias2_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_dc_bias2_ch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_dc_bias2_ch1 as a double
handles.hifu_dc_bias2_ch1 = str2double(get(hObject,'String'));
print_message(sprintf('hifu_dc_bias2_ch1 :%f',handles.hifu_dc_bias2_ch1),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_dc_bias2_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dc_bias2_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_dc_bias2_ch2 as a double
handles.dc_bias2_ch2 = str2double(get(hObject,'String'));
print_message(sprintf('dc_bias2_ch2 :%f',handles.dc_bias2_ch2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_imaging_dc_bias2_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_dc_bias2_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_dc_bias2_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_dc_bias2_ch2 as a double
handles.imaging_dc_bias2_ch2 = str2double(get(hObject,'String'));
print_message(sprintf('imaging_dc_bias2_ch2 :%f',handles.imaging_dc_bias2_ch2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hifu_dc_bias2_ch2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_dc_bias2_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_dc_bias2_ch2 as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_dc_bias2_ch2 as a double
handles.hifu_dc_bias2_ch2 = str2double(get(hObject,'String'));
print_message(sprintf('hifu_dc_bias2_ch2 :%f',handles.hifu_dc_bias2_ch2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_cmut_hv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cmut_hv as text
%        str2double(get(hObject,'String')) returns contents of edit_cmut_hv as a double
handles.cmut_hv = str2double(get(hObject,'String'));
print_message(sprintf('cmut_hv :%f',handles.cmut_hv),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_imaging_cmut_hv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_imaging_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_imaging_cmut_hv as text
%        str2double(get(hObject,'String')) returns contents of edit_imaging_cmut_hv as a double
handles.imaging_cmut_hv = str2double(get(hObject,'String'));
print_message(sprintf('imaging_cmut_hv :%f',handles.imaging_cmut_hv),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_hifu_cmut_hv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hifu_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hifu_cmut_hv as text
%        str2double(get(hObject,'String')) returns contents of edit_hifu_cmut_hv as a double
handles.hifu_cmut_hv = str2double(get(hObject,'String'));
print_message(sprintf('hifu_cmut_hv :%f',handles.hifu_cmut_hv),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);




function edit_cmut_hv_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cmut_hv_start as text
%        str2double(get(hObject,'String')) returns contents of edit_cmut_hv_start as a double
handles.cmut_hv_start = str2double(get(hObject,'String'));
print_message(sprintf('Cmut HV Start :%f',handles.cmut_hv_start),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_cmut_hv_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cmut_hv_end as text
%        str2double(get(hObject,'String')) returns contents of edit_cmut_hv_end as a double
handles.cmut_hv_end = str2double(get(hObject,'String'));
print_message(sprintf('Cmut HV End :%f',handles.cmut_hv_end),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_cmut_hv_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cmut_hv_step as text
%        str2double(get(hObject,'String')) returns contents of edit_cmut_hv_step as a double
handles.cmut_hv_step = str2double(get(hObject,'String'));
print_message(sprintf('Cmut HV Step :%f',handles.cmut_hv_step),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_temp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_temp as text
%        str2double(get(hObject,'String')) returns contents of edit_temp as a double
handles.temp = str2double(get(hObject,'String'));
print_message(sprintf('Temperature :%f',handles.temp),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_gpib_vdd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gpib_vdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gpib_vdd as text
%        str2double(get(hObject,'String')) returns contents of edit_gpib_vdd as a double
handles.gpib_vdd = str2double(get(hObject,'String'));
print_message(sprintf('gpib_vdd :%f',handles.gpib_vdd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_gpib_hvdd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gpib_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gpib_hvdd as text
%        str2double(get(hObject,'String')) returns contents of edit_gpib_hvdd as a double
handles.gpib_hvdd = str2double(get(hObject,'String'));
print_message(sprintf('gpib_hvdd :%f',handles.gpib_hvdd),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_gpib_hvdd2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gpib_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gpib_hvdd2 as text
%        str2double(get(hObject,'String')) returns contents of edit_gpib_hvdd2 as a double
handles.gpib_hvdd2 = str2double(get(hObject,'String'));
print_message(sprintf('gpib_hvdd2 :%f',handles.gpib_hvdd2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_gpib_dc_bias2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gpib_dc_bias2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gpib_dc_bias2 as text
%        str2double(get(hObject,'String')) returns contents of edit_gpib_dc_bias2 as a double
handles.gpib_dc_bias2 = str2double(get(hObject,'String'));
print_message(sprintf('gpib_dc_bias2 :%f',handles.gpib_dc_bias2),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_gpib_cmut_hv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gpib_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gpib_cmut_hv as text
%        str2double(get(hObject,'String')) returns contents of edit_gpib_cmut_hv as a double
handles.gpib_cmut_hv = str2double(get(hObject,'String'));
print_message(sprintf('gpib_cmut_hv :%f',handles.gpib_cmut_hv),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

function edit_gpib_temp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gpib_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gpib_temp as text
%        str2double(get(hObject,'String')) returns contents of edit_gpib_temp as a double
handles.gpib_temp = str2double(get(hObject,'String'));
print_message(sprintf('gpib_temp :%f',handles.gpib_temp),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);



function edit_rs_scope_ip_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rs_scope_ip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rs_scope_ip as text
%        str2double(get(hObject,'String')) returns contents of edit_rs_scope_ip as a double
handles.rs_scope_ip = get(hObject,'String');
print_message(sprintf('rs_scope_ip :%s',handles.rs_scope_ip),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_rs_scope_sample_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rs_scope_sample_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rs_scope_sample_size as text
%        str2double(get(hObject,'String')) returns contents of edit_rs_scope_sample_size as a double
handles.rs_scope_sample_size = str2double(get(hObject,'String'));
print_message(sprintf('rs_scope_sample_size :%f',handles.rs_scope_sample_size),handles);
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
function edit_vdd_brd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vdd_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_imaging_vdd_brd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_vdd_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_vdd_ic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vdd_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_imaging_vdd_ic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_vdd_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_hvref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hvref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_imaging_hvref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_hvref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_hvdd2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_imaging_hvdd2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_hvdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_imaging_hvdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes during object creation, after setting all properties.
function edit_dc_bias2_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function edit_imaging_dc_bias2_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_dc_bias2_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_cmut_hv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_imaging_cmut_hv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_hifu_vdd_brd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_vdd_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_hifu_vdd_ic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_vdd_ic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_hifu_hvref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_hvref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_hifu_hvdd2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_hifu_hvdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function edit_hifu_dc_bias2_ch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_dc_bias2_ch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_hifu_cmut_hv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_gpib_vdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gpib_vdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_gpib_hvdd2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gpib_hvdd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_gpib_hvdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gpib_hvdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_gpib_dc_bias2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gpib_dc_bias2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_gpib_cmut_hv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gpib_cmut_hv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_gpib_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gpib_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_vdd_brd_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vdd_brd_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vdd_brd_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_vdd_brd_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_vdd_brd_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vdd_brd_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vdd_ic_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vdd_ic_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vdd_ic_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_vdd_ic_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_vdd_ic_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vdd_ic_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hvref_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hvref_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hvref_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_hvref_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_hvref_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hvref_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hvdd2_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hvdd2_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hvdd2_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_hvdd2_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_hvdd2_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hvdd2_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hvdd_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hvdd_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hvdd_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_hvdd_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_hvdd_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hvdd_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dc_bias2_ch1_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch1_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dc_bias2_ch1_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_dc_bias2_ch1_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_dc_bias2_ch1_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch1_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cmut_hv_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cmut_hv_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_cmut_hv_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_cmut_hv_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_dc_bias2_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_imaging_dc_bias2_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_imaging_dc_bias2_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_hifu_dc_bias2_ch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hifu_dc_bias2_ch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dc_bias2_ch2_curr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch2_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dc_bias2_ch2_curr as text
%        str2double(get(hObject,'String')) returns contents of edit_dc_bias2_ch2_curr as a double


% --- Executes during object creation, after setting all properties.
function edit_dc_bias2_ch2_curr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dc_bias2_ch2_curr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function edit_cmut_hv_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_cmut_hv_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_cmut_hv_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cmut_hv_step (see GCBO)
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
function edit_rs_scope_sample_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rs_scope_sample_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_ch_sel.
function popupmenu_ch_sel_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ch_sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ch_sel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ch_sel
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
function popupmenu_ch_sel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ch_sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
