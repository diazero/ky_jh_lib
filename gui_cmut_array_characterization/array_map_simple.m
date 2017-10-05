function varargout = array_map_simple(varargin)
% array_map_simple M-file for array_map_simple.fig
%      array_map_simple, by itself, creates a new array_map_simple or raises the existing
%      singleton*.
%
%      H = array_map_simple returns the handle to a new array_map_simple or the handle to
%      the existing singleton*.
%
%      array_map_simple('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in array_map_simple.M with the given input arguments.
%
%      array_map_simple('Property','Value',...) creates a new array_map_simple or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Motor_seq_simple_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to array_map_simple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help array_map_simple

% Last Modified by GUIDE v2.5 10-Apr-2016 20:25:49
% Written by Ji Hoon Jang (diazero@stanford.edu)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @array_map_simple_OpeningFcn, ...
    'gui_OutputFcn',  @array_map_simple_OutputFcn, ...
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


% --- Executes just before array_map_simple is made visible.
function array_map_simple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to array_map_simple (see VARARGIN)

% Choose default command line output for array_map_simple
handles.output = hObject;

%%%%%%%%%%%%%%%%  Start of Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.nofolder='';
handles.sel_current = 0;
handles.sel_ring = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes array_map_simple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = array_map_simple_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in radiobuttoncurrent.
function radiobuttoncurrent_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttoncurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttoncurrent
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.sel_current = 1;
else
	handles.sel_current = 0;
end
guidata(hObject, handles);


% --- Executes on button press in pushbuttonload.
function pushbuttonload_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.sel_current == 1)
        print_message(sprintf('Current plot'),handles);
        temp = load('-mat',[handles.FileName,'_current.MAT']);
        handles.current = temp.data.array_current;
        plot_current(hObject, eventdata, handles);
else
row_n = 801;
bias_n = length(handles.Bias_Index);
handles.freq= zeros(row_n,handles.rowsize,handles.colsize,bias_n);
handles.mag= zeros(row_n,handles.rowsize,handles.colsize,bias_n);
handles.phase= zeros(row_n,handles.rowsize,handles.colsize,bias_n);
handles.openflag= zeros(handles.rowsize,handles.colsize,bias_n);
handles.shortflag= zeros(handles.rowsize,handles.colsize);
handles.current= zeros(bias_n,handles.rowsize,handles.colsize);
for i = 1:handles.rowsize
    for j = 1:handles.colsize
        for k = 1:bias_n
        if(exist([handles.FileName,'_',num2str(handles.Bias_Index(k)),'_',num2str(i),'_',num2str(j),'.MAT']) == 2) %#ok<EXIST>
            [handles.freq(:,i,j,k),handles.mag(:,i,j,k),handles.phase(:,i,j,k)] = MAT_importfile([handles.FileName,'_',num2str(handles.Bias_Index(k)),'_',num2str(i),'_',num2str(j),'.MAT']);
            handles.openflag(i,j,k) = peak_search_NW_high(handles.freq(:,i,j,k),handles.mag(:,i,j,k),handles.phase(:,i,j,k));
        else
            handles.openflag(i,j,k) = 0;
        end
        end
    end
end
% temp = load('-mat',[handles.FileName,'_current.MAT']);
% handles.shortflag = temp.data.array_short;
% handles.current = temp.data.array_current;
for i = 1:handles.rowsize
    temp = load('-mat',[handles.FileName,'_current_',num2str(i),'.MAT']);
    handles.shortflag(i,:) = temp.data.array_short(i,:);
    handles.current(:,i,:) = temp.data.array_current(:,i,:);
end
draw_table(hObject, eventdata, handles);

guidata(hObject, handles);
end

function draw_table(hObject, eventdata, handles)
%# matrix
axes(handles.axesFig3);
cla reset;
% M = rand(handles.rowsize,handles.colsize);
% [handles.rowsize handles.colsize] = size(M);
if(handles.sel_ring == 1)
    temp_rowsize = handles.colsize/32;
    temp_colsize = 32;
    %# text location and labels
    [xloc yloc] = meshgrid(1:temp_colsize,1:temp_rowsize);
    xloc = xloc(:); yloc = yloc(:);
    xticklabels = cellstr( num2str((1:temp_colsize)','%d') );
    yticklabels = cellstr( num2str((1:temp_rowsize)','%d') );
    
    % plot colored cells
    % 0 = short(red) 0.25 = no contact(black) 0.5 = normal(white) 0.75 = weak(yellow) 1 = open(blue) ;
    
    bias_n = find(handles.Bias_Index ==handles.maskbias);
    mask = reshape(handles.openflag(:,:,bias_n),temp_colsize,temp_rowsize)';
    temp_shortflag = reshape(handles.shortflag,temp_colsize,temp_rowsize)';
    mask(temp_shortflag==1) = 0;
    
    mseq_mask = handles.openflag(:,:,bias_n);
    mseq_mask(handles.shortflag==1) = 0;
    % re_current = reshape(handles.current(bias_n,:,:),temp_rowsize,temp_colsize);
    % str = strtrim(cellstr( num2str(re_current(:),'%.3g') ));
    h = imagesc(mask);
    % handles.mask = mask;
    % set(h, 'AlphaData',mask)
    colormap([1 0 0;0 0 0;1 1 1;1 1 0;0 0 1]);            %# colormap([0 1 0])
    caxis([0 1]);
    set(gca, 'Box','on', 'XAxisLocation','top', 'YDir','reverse', ...
        'XLim',[0 temp_colsize]+0.5, 'YLim',[0 temp_rowsize]+0.5, 'TickLength',[0 0], ...
        'XTick',1:temp_colsize, 'YTick',1:temp_rowsize, ...
        'XTickLabel',xticklabels, 'YTickLabel',yticklabels, ...
        'LineWidth',2, 'Color','none', ...
        'FontWeight','bold', 'FontSize',7, 'DataAspectRatio',[1 1 1]);
    
    %# plot grid
    xv1 = repmat((2:temp_colsize)-0.5, [2 1]); xv1(end+1,:) = NaN;
    xv2 = repmat([0.5;temp_colsize+0.5;NaN], [1 temp_rowsize-1]);
    yv1 = repmat([0.5;temp_rowsize+0.5;NaN], [1 temp_colsize-1]);
    yv2 = repmat((2:temp_rowsize)-0.5, [2 1]); yv2(end+1,:) = NaN;
    line([xv1(:);xv2(:)], [yv1(:);yv2(:)], 'Color','k', 'HandleVisibility','off')
    file_name = handles.FileName;
    save([file_name '_mask.MAT'],'mask');
    data.freq = handles.freq;
    data.mag = handles.mag;
    data.phase = handles.phase;
    save([file_name '_data.MAT'],'data');
    print_message(sprintf('%s Saved',[file_name '_mask.MAT']),handles);
    mseqFileName = handles.mseqFileName;
    save_mseq(mseqFileName,mseq_mask);
    % guidata(hObject,handles);
    %# plot text
    % text(xloc, yloc, str, 'FontSize',8, 'HorizontalAlignment','center');
else
    
    %# text location and labels
    [xloc yloc] = meshgrid(1:handles.colsize,1:handles.rowsize);
    xloc = xloc(:); yloc = yloc(:);
    xticklabels = cellstr( num2str((1:handles.colsize)','%d') );
    yticklabels = cellstr( num2str((1:handles.rowsize)','%d') );
    
    % plot colored cells
    % 0 = short(red) 0.25 = no contact(black) 0.5 = normal(white) 0.75 = weak(yellow) 1 = open(blue) ;
    
    bias_n = find(handles.Bias_Index ==handles.maskbias);
    mask = handles.openflag(:,:,bias_n);
    mask(handles.shortflag==1) = 0;
    % re_current = reshape(handles.current(bias_n,:,:),handles.rowsize,handles.colsize);
    % str = strtrim(cellstr( num2str(re_current(:),'%.3g') ));
    h = imagesc(mask);
    % handles.mask = mask;
    % set(h, 'AlphaData',mask)
    colormap([1 0 0;0 0 0;1 1 1;1 1 0;0 0 1]);            %# colormap([0 1 0])
    caxis([0 1]);
    set(gca, 'Box','on', 'XAxisLocation','top', 'YDir','reverse', ...
        'XLim',[0 handles.colsize]+0.5, 'YLim',[0 handles.rowsize]+0.5, 'TickLength',[0 0], ...
        'XTick',1:handles.colsize, 'YTick',1:handles.rowsize, ...
        'XTickLabel',xticklabels, 'YTickLabel',yticklabels, ...
        'LineWidth',2, 'Color','none', ...
        'FontWeight','bold', 'FontSize',7, 'DataAspectRatio',[1 1 1]);
    
    %# plot grid
    xv1 = repmat((2:handles.colsize)-0.5, [2 1]); xv1(end+1,:) = NaN;
    xv2 = repmat([0.5;handles.colsize+0.5;NaN], [1 handles.rowsize-1]);
    yv1 = repmat([0.5;handles.rowsize+0.5;NaN], [1 handles.colsize-1]);
    yv2 = repmat((2:handles.rowsize)-0.5, [2 1]); yv2(end+1,:) = NaN;
    line([xv1(:);xv2(:)], [yv1(:);yv2(:)], 'Color','k', 'HandleVisibility','off')
    file_name = handles.FileName;
    save([file_name '_mask.MAT'],'mask');
    data.freq = handles.freq;
    data.mag = handles.mag;
    data.phase = handles.phase;
    save([file_name '_data.MAT'],'data');
    print_message(sprintf('%s Saved',[file_name '_mask.MAT']),handles);
    mseqFileName = handles.mseqFileName
    save_mseq(mseqFileName,mask)
    % guidata(hObject,handles);
    %# plot text
    % text(xloc, yloc, str, 'FontSize',8, 'HorizontalAlignment','center');
end

function save_mseq(mseqFileName,mask)
% 0 = short(red) 0.25 = no contact(black) 0.5 = normal(white) 0.75 = weak(yellow) 1 = open(blue) ;
temp = load('-mat',[mseqFileName,'.MAT']);
mseq = temp.mseq;
[m1,n1] = find(mask==0);
[m2,n2] = find(mask==0.25);
[m3,n3] = find(mask==0.5);
[m4,n4] = find(mask==0.75);
[m5,n5] = find(mask==1);

[row_n, col_n] = size(mask);
% m = [m1;m2;m3;m4;m5];
% n = [n1;n2;n3;n4;n5];
% list_n = length(m);
n_short = length(m1)
n_no_contact = length(m2)
n_normal = length(m3)
n_weak = length(m4)
n_open = length(m5)

s = 1;
x = 1;
n = 1;
w = 1;
o = 1;

for i = 1:row_n
    for j = 1:col_n
        if(sum(m1(find(n1 == j))== i) == 1)
            % short
            s_mseq.data_x(s) = mseq.data_x(i,j);
            s_mseq.data_y(s) = mseq.data_y(i,j);
            s_mseq.data_z(s) = mseq.data_z(i,j);
            s_mseq.row(s) = i;
            s_mseq.col(s) = j;
            s = s+1;
        elseif(sum(m2(find(n2 == j))== i) == 1)
            % no contact
            x_mseq.data_x(x) = mseq.data_x(i,j);
            x_mseq.data_y(x) = mseq.data_y(i,j);
            x_mseq.data_z(x) = mseq.data_z(i,j);
            x_mseq.row(x) = i;
            x_mseq.col(x) = j; 
            x = x+1;
        elseif(sum(m3(find(n3 == j))== i) == 1)
            % normal
            n_mseq.data_x(n) = mseq.data_x(i,j);
            n_mseq.data_y(n) = mseq.data_y(i,j);
            n_mseq.data_z(n) = mseq.data_z(i,j);  
            n_mseq.row(n) = i;
            n_mseq.col(n) = j;          
            n = n+1;
        elseif(sum(m4(find(n4 == j))== i) == 1)
            % weak
            w_mseq.data_x(w) = mseq.data_x(i,j);
            w_mseq.data_y(w) = mseq.data_y(i,j);
            w_mseq.data_z(w) = mseq.data_z(i,j); 
            w_mseq.row(w) = i;
            w_mseq.col(w) = j;           
            w = w+1;
        elseif(sum(m5(find(n5 == j))== i) == 1)
            % open
            o_mseq.data_x(o) = mseq.data_x(i,j);
            o_mseq.data_y(o) = mseq.data_y(i,j);
            o_mseq.data_z(o) = mseq.data_z(i,j);  
            o_mseq.row(o) = i;
            o_mseq.col(o) = j;          
            o = o+1;
        end
    end
end
if(n_short> 0)
mseq = s_mseq;
save([mseqFileName '_short.MAT'],'mseq');
end
if(n_no_contact > 0)
mseq = x_mseq;
save([mseqFileName '_no_contact.MAT'],'mseq');
end
if(n_normal> 0)
mseq = n_mseq;
save([mseqFileName '_normal.MAT'],'mseq');
end
if(n_weak > 0)
mseq = w_mseq;
save([mseqFileName '_weak.MAT'],'mseq');
end
if(n_open > 0)
mseq = o_mseq;
save([mseqFileName '_open.MAT'],'mseq');
end

function plot_current(hObject, eventdata, handles)
%# matrix
axes(handles.axesFig3);
cla reset;
bias_index = find(handles.Bias_Index ==handles.maskbias);
cc=hsv(handles.rowsize);
for i = 1:handles.rowsize
    plot(1:handles.colsize,reshape(handles.current(bias_index,i,:),1,handles.colsize),'color',cc(i,:));
    hold on;
    grid on;
    legendInfo{i} = ['ROW' num2str(i)];
end
    xlabel('Column');
    ylabel('Current[A]');
    row_n = 1:handles.rowsize;
legend(legendInfo);

function open_flag = peak_search_W(freq,mag,phase)
sear_min = 4e6;
sear_max = 10e6;
[~,ind_min] = min(abs(freq - sear_min));
[~,ind_max] = min(abs(freq - sear_max));
[magmax,maglocs1] = max(mag(ind_min:ind_max));
[magmin,maglocs2] = min(mag(ind_min:ind_max));
[phasemax,phaselocs] = max(phase(ind_min:ind_max));
[phasemin,~] = min(phase(:));
avgphase = mean(phase(:));
% 0 = short(red) 0.25 = no contact(black) 0.5 = normal(white) 0.75 = weak(yellow) 1 = open(blue) ;
md_phase = max(abs(diff(phase(:))));
md_mag = max(abs(diff(mag(:))));
if(phasemax>90)||(phasemin<-100)||(magmax>1.5e5)||(magmin>2.5e4)||(md_mag>10e4)
    open_flag = 0.25;
elseif(phaselocs>(ind_max-ind_min)/4)&&(phaselocs<(ind_max-ind_min)*3/4)&&(phasemax>-20)
    if(avgphase>-40)||(phasemax<-30)
        open_flag = 0.75;
    else
        open_flag = 0.5;
    end
else
    open_flag = 1;
end

function open_flag = peak_search_NW(freq,mag,phase)
sear_min = 8e6;
sear_max = 14e6;
[~,ind_min] = min(abs(freq - sear_min));
[~,ind_max] = min(abs(freq - sear_max));
[magmax,maglocs1] = max(mag(ind_min:ind_max));
[magmin,maglocs2] = min(mag(ind_min:ind_max));
[phasemax,phaselocs] = max(phase(ind_min:ind_max));
[phasemin,~] = min(phase(:));
avgphase = mean(phase(:));
% 0 = short(red) 0.25 = no contact(black) 0.5 = normal(white) 0.75 = weak(yellow) 1 = open(blue) ;
md_phase = max(abs(diff(phase(:))));
md_mag = max(abs(diff(mag(:))));
if(phasemax>90)||(phasemin<-100)||(magmax>1.5e5)||(magmin>2.5e4)||(md_mag>10e4)
    open_flag = 0.25;
elseif(phaselocs>(ind_max-ind_min)/4)&&(phaselocs<(ind_max-ind_min)*3/4)&&(phasemax>-20)
    if(avgphase>-40)||(phasemax<-30)
        open_flag = 0.75;
    else
        open_flag = 0.5;
    end
else
    open_flag = 1;
end

function open_flag = peak_search_NW_high(freq,mag,phase)
sear_min = 5e6;
sear_max = 11e6;
[~,ind_min] = min(abs(freq - sear_min));
[~,ind_max] = min(abs(freq - sear_max));
[magmax,maglocs1] = max(mag(ind_min:ind_max));
[magmin,maglocs2] = min(mag(ind_min:ind_max));
[phasemax,phaselocs] = max(phase(ind_min:ind_max));
[phasemin,~] = min(phase(:));
avgphase = mean(phase(:));
% 0 = short(red) 0.25 = no contact(black) 0.5 = normal(white) 0.75 = weak(yellow) 1 = open(blue) ;
md_phase = max(abs(diff(phase(:))));
md_mag = max(abs(diff(mag(:))));
if(phasemax>90)||(phasemin<-100)||(magmax>2.5e5)||(magmin>2.5e4)
    open_flag = 0.25;
elseif(phaselocs>(ind_max-ind_min)/4)&&(phaselocs<(ind_max-ind_min)*3/4)&&(phasemax>-20)
    if(avgphase>-40)||(phasemax<-30)
        open_flag = 0.75;
    else
        open_flag = 0.5;
    end
else
    open_flag = 1;
end


function [data1, data2, data3] = MAT_importfile(fileToRead1)
newData1 = load('-mat', fileToRead1);

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end
data1 = newData1.(vars{i})(:,1);
data2 = newData1.(vars{i})(:,2);
data3 = newData1.(vars{i})(:,3);



function editFileName_fig_Callback(hObject, eventdata, handles)
% hObject    handle to editFileName_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFileName_fig as text
%        str2double(get(hObject,'String')) returns contents of editFileName_fig as a double
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
        handles.FileName_fig=[handles.nofolder FileNameTemp];
    else % Folder information
        handles.FileName_fig=FileNameTemp;
    end
end

handles=check_measurement_parameter(handles);

guidata(hObject,handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom functoin %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function print_message(message_out,handles)
set(handles.editMessage,'String',[]);
set(handles.editMessage,'String',message_out);
disp(message_out);


% guidata(hObject,handles);
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

function new_handles=check_measurement_parameter(handles)
% handles.Bias_Index


if isfield(handles,'Bias_Index') &&...
        isfield(handles,'rowsize') &&...
        isfield(handles,'colsize') &&...
        isfield(handles,'FileName') &&...
        isfield(handles,'mseqFileName')
    if(handles.rowsize>0) &&(handles.colsize>0)
        set(handles.pushbuttonload,'Enable','on');
    else
        set(handles.pushbuttonload,'Enable','off');
    end
else
    set(handles.pushbuttonload,'Enable','off');
end

if isfield(handles,'setbias') &&...
        isfield(handles,'setrow') &&...
        isfield(handles,'setcol')
    if(handles.setrow>0) &&(handles.setrow<=handles.rowsize)&&...
            (handles.setcol>0) &&(handles.setcol<=handles.colsize)&&...
            (((handles.setbias>=handles.Vstart) &&(handles.setbias<=handles.Vend))||...
            ((handles.setbias<=handles.Vstart) &&(handles.setbias>=handles.Vend)))
        set(handles.pushbuttonplot,'Enable','on');
        set(handles.pushbuttoncolup,'Enable','on');
        set(handles.pushbuttoncoldown,'Enable','on');    
        set(handles.pushbutton_draw,'Enable','on');
    else
        set(handles.pushbuttonplot,'Enable','off');
        set(handles.pushbuttoncolup,'Enable','off');
        set(handles.pushbuttoncoldown,'Enable','off'); 
        set(handles.pushbutton_draw,'Enable','off');
    end
else
    set(handles.pushbuttonplot,'Enable','off');
    set(handles.pushbuttoncolup,'Enable','off');
        set(handles.pushbuttoncoldown,'Enable','off');    
end

if(isfield(handles,'FileName_fig'))
    set(handles.pushbuttonsave,'Enable','on');
else
    set(handles.pushbuttonsave,'Enable','off');
end
new_handles=handles;


function plot_figure12(data,handles,holding)

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
plot(data(:,1),data(:,2),'b','linewidth',2);
axes(handles.axesFig2);
plot(data(:,1),data(:,3),'b','linewidth',2);


axes(handles.axesFig1);
xlabel('Frequency (Hz)');
ylabel('Amplitude (Ohm)');
if(min(data(:,2))==max(data(:,2)))
else
axis([5e6 15e6 min(data(:,2))/10 max(data(:,2))])
end

axes(handles.axesFig2);
xlabel('Frequency (Hz)');
ylabel('Phase (Degree)');
axis([5e6 15e6 -100 90])

handles.setrow,handles.setcol
% axis([1e1 12e6 -100 max(data(:,3))+10])

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
function editFileName_fig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFileName_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonplot.
function pushbuttonplot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(isfield(handles,'indicator'))
    delete(handles.indicator);
end
bias_index = find(handles.Bias_Index ==handles.setbias);
data(:,1) = handles.freq(:,handles.setrow,handles.setcol,bias_index);
data(:,2) = handles.mag(:,handles.setrow,handles.setcol,bias_index);
data(:,3) = handles.phase(:,handles.setrow,handles.setcol,bias_index);
plot_figure12(data,handles,'off');
axes(handles.axesFig3);
%# plot grid
% handles.indicator = line([handles.setcol-0.5 handles.setcol+0.5 handles.setcol+0.5 handles.setcol-0.5],[handles.setrow-0.5 handles.setrow-0.5 handles.setrow+0.5 handles.setrow+0.5] ,'Color','r', 'LineWidth',2);
handles.indicator = line([handles.setcol-0.5 handles.setcol+0.5],[handles.setrow-0.5 handles.setrow+0.5] ,'Color','k', 'LineWidth',2);

print_message(sprintf('current : %2.2f uA',handles.current(bias_index,handles.setrow,handles.setcol)*1e6),handles);
guidata(hObject,handles);

% --- Executes on button press in pushbuttonsave.
function pushbuttonsave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axesFig3);
figure();
image(F.cdata);
% set(gcf, 'Box','on', 'XAxisLocation','top', 'YDir','reverse', ...
%     'XLim',[0 handles.colsize]+0.5, 'YLim',[0 handles.rowsize]+0.5, 'TickLength',[0 0], ...
%     'XTick',1:handles.colsize, 'YTick',1:handles.rowsize, ...
%     'LineWidth',2, 'Color','none', ...
%     'FontWeight','bold', 'FontSize',8, 'DataAspectRatio',[1 1 1]);
file_name_fig=handles.FileName_fig;
saveas(gcf,[file_name_fig '.png']);
close(gcf);



function edit_startbias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_startbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_startbias as text
%        str2double(get(hObject,'String')) returns contents of edit_startbias as a double
handles.Vstart=str2double(get(hObject,'String'));
handles=build_bias_list(hObject, eventdata, handles);
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function edit_startbias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_startbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_endbias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_endbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_endbias as text
%        str2double(get(hObject,'String')) returns contents of edit_endbias as a double
handles.Vend=str2double(get(hObject,'String'));
handles=build_bias_list(hObject, eventdata, handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_endbias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_endbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stepbias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stepbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stepbias as text
%        str2double(get(hObject,'String')) returns contents of edit_stepbias as a double
handles.Vstep=str2double(get(hObject,'String'));
handles=build_bias_list(hObject, eventdata, handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_stepbias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stepbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rowsize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rowsize as text
%        str2double(get(hObject,'String')) returns contents of edit_rowsize as a double
handles.rowsize=str2double(get(hObject,'String'));
print_message(sprintf('Row Size : %d',handles.rowsize),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_rowsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_colsize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_colsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_colsize as text
%        str2double(get(hObject,'String')) returns contents of edit_colsize as a double
handles.colsize=str2double(get(hObject,'String'));
print_message(sprintf('Column Size : %d',handles.colsize),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_colsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_colsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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




function edit_setbias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_setbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_setbias as text
%        str2double(get(hObject,'String')) returns contents of edit_setbias as a double
handles.setbias=str2double(get(hObject,'String'));
print_message(sprintf('Set Bias to %d',handles.setbias),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_setbias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_setbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_setrow_Callback(hObject, eventdata, handles)
% hObject    handle to edit_setrow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_setrow as text
%        str2double(get(hObject,'String')) returns contents of edit_setrow as a double
handles.setrow=str2double(get(hObject,'String'));
print_message(sprintf('Set Row to %d',handles.setrow),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_setrow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_setrow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_setcol_Callback(hObject, eventdata, handles)
% hObject    handle to edit_setcol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_setcol as text
%        str2double(get(hObject,'String')) returns contents of edit_setcol as a double
handles.setcol=str2double(get(hObject,'String'));
print_message(sprintf('Set Column to %d',handles.setcol),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


function edit_maskbias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maskbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maskbias as text
%        str2double(get(hObject,'String')) returns contents of edit_maskbias as a double
handles.maskbias=str2double(get(hObject,'String'));
print_message(sprintf('Set Mask Bias to %d V',handles.maskbias),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_setcol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_setcol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_maskbias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maskbias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function editmseqFilename_Callback(hObject, eventdata, handles)
% hObject    handle to editmseqFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editmseqFilename as text
%        str2double(get(hObject,'String')) returns contents of editmseqFilename as a double
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
        handles.mseqFileName=[handles.nofolder FileNameTemp];
    else % Folder information
        handles.mseqFileName=FileNameTemp;
    end
end

handles=check_measurement_parameter(handles);

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editmseqFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editmseqFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttoncolup.
function pushbuttoncolup_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncolup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.sel_ring == 1)
    handles.setcol=handles.setcol+1;
    handles.setrow=1;
    set(handles.edit_setcol,'String',num2str(handles.setcol));
    set(handles.edit_setrow,'String',num2str(handles.setrow));
elseif(handles.setcol>31)
%     handles.setcol=handles.setcol+1; %handles.setcol=1;
%     handles.setrow=1; %handles.setrow=handles.setrow+1;
    handles.setcol=1;
    handles.setrow=handles.setrow+1;
    set(handles.edit_setcol,'String',num2str(handles.setcol));
    set(handles.edit_setrow,'String',num2str(handles.setrow));
else
    handles.setcol=handles.setcol+1;
    set(handles.edit_setcol,'String',num2str(handles.setcol));
end
set(handles.edit_setcol,'String',num2str(handles.setcol));
print_message(sprintf('Set Column to %d',handles.setcol),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);
pushbuttonplot_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbuttoncoldown.
function pushbuttoncoldown_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncoldown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.setcol=handles.setcol-1;
set(handles.edit_setcol,'String',num2str(handles.setcol));
print_message(sprintf('Set Column to %d',handles.setcol),handles);
handles=check_measurement_parameter(handles);
guidata(hObject,handles);
pushbuttonplot_Callback(hObject, eventdata, handles);


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.sel_ring = 1;
else
	handles.sel_ring = 0;
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton_draw.
function pushbutton_draw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axesFig3);
%# plot grid
% handles.indicator = line([handles.setcol-0.5 handles.setcol+0.5 handles.setcol+0.5 handles.setcol-0.5],[handles.setrow-0.5 handles.setrow-0.5 handles.setrow+0.5 handles.setrow+0.5] ,'Color','r', 'LineWidth',2);
handles.indicator = line([handles.setcol-0.5 handles.setcol+0.5],[handles.setrow-0.5 handles.setrow+0.5] ,'Color','k', 'LineWidth',2);
guidata(hObject,handles);