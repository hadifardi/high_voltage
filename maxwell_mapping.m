clc; close all ; clearvars;

screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);

f1 = figure(1);
f1Position = get(f1, 'Position');
f1Position(1) = 0;
set(f1, 'Position', f1Position)
xlabel('u')
ylabel('v')

f2 = figure(2);
f2Position = get(f2, 'Position');
f2Position(1) = ceil(screenWidth/2);
set(f2, 'Position', f2Position)
xlabel('x')
ylabel('y')


% over all configuration
a = 1;
point_number = 20;
plate_length = 3.5;
step_size = 0.3;

% horizontal lines configuration
h_L = -pi;
h_H = pi;

horizontal_range = h_L: step_size : h_H;
if (horizontal_range(end) ~= h_H)
    horizontal_range(end + 1) = h_H;
end

% vertical lines configuration
v_L = -plate_length * pi;
v_H = pi;

vertical_range = v_L: step_size : v_H;
if (v_H - vertical_range(end) > step_size)
    vertical_range(end + 1) = v_H;
end

for c = horizontal_range
    [u_horz, v_horz] = horizontal_line(c, point_number, -plate_length * pi, pi);
    
    figure(1)
    hold on
    plot(u_horz, v_horz, 'k')
    hold off

    figure(2)
    hold on
    [x_horz, y_horz] = maxwell_map(u_horz, v_horz, a);
    plot(x_horz, y_horz, 'k')
    hold off
end

for c = vertical_range
    [u_vert, v_vert] = vertical_line(c, point_number, -pi, pi);
    
    figure(1)
    hold on
    plot(u_vert, v_vert, 'k')
    hold off

    figure(2)
    hold on
    [x_vert, y_vert] = maxwell_map(u_vert, v_vert, a);
    plot(x_vert, y_vert, 'k')
    hold off
end

function [u, v] = vertical_line(c, point_number, min_v, max_v)
    % u = c with <point_number> points
    % min_v < v < max_v
    
    u = linspace(c, c, point_number);
    v = linspace(min_v, max_v, point_number);
end

function [u, v] = horizontal_line(c, point_number, min_u, max_u)
    % v = c with <point_number> points
    % min_u < u < max_u
    
    u = linspace(min_u, max_u, point_number);
    v = linspace(c, c, point_number); 
end

function [x, y] = maxwell_map(u, v, a)
    if length(u) >= 50
        n = length(u);
    else
        n = 50;
    end
    
    u = edit_linespace(u, n);
    v = edit_linespace(v, n);
    
    x = (1 + u + exp(u) .* cos(v)) .* a / pi;
    y = (v + exp(u) .* sin(v)) .* a / pi;
end

function lineSpace = edit_linespace(input, n)
    first_val = input(1);
    last_val = input(end);
    lineSpace = linspace(first_val, last_val ,n);
end