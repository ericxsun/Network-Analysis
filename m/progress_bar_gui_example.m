function progress_bar_gui_example()
%PROGRESS_BAR_GUI_EXAMPLE Gui progress bar demo.
%   PROGRESS_BAR_GUI_EXAMPLE() shows the examples for gui progress bar.
%   
%   Algorithm:
%
%   Note:
%
%   Example:
%
%   Ref:
%
%   See also: WAITBAR, PROGRESS_BAR_CONSOLE, PROGRESS_BAR_CONSOLE_EXAMPLE, 
%             PROGRESS_BAR_GUI
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$
%

%--------------------------------------------------------------------------

%single bar
max_val = 500;
progress_bar_gui('test');

for i = 1 : max_val
    pause(0.01);    %do some long running operation
    progress_bar_gui(i / max_val);
end

%multi bar
%update one bar at a time
m = 4;
n = 3;
p = 100;

progress_bar_gui(0, 0, 0);  %initalize 3 bars

for i = 1 : m
    progress_bar_gui([], 0);    %reset 2nd bar
    
    for j = 1 : n
        progress_bar_gui([], [], 0);    %reset 3rd bar
        
        for k = 1 : p
            pause(0.01);    %do some long running operation
            progress_bar_gui([], [], k / p);    %update 3rd bar
        end
        
        progress_bar_gui([], j / n);    %update 2nd bar
    end
    
    progress_bar_gui(i / m);    %update 1st bar
end

%use labels and update all bars at time
m = 4;
n = 3;
p = 100;

progress_bar_gui('monte carlo trials', 'simulation', 'component');

for i = 1 : m   
    for j = 1 : n        
        for k = 1 : p
            pause(0.01);    %do some long running operation
            
            frac3 = k / p;
            frac2 = ((j - 1) + frac3) / n;
            frac1 = ((i - 1) + frac2) / m;
            
            progress_bar_gui(frac1, frac2, frac3);
        end
    end
end

%--------------------------------------------------------------------------
end