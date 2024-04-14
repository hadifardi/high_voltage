clc; close all; clearvars;

screenSize = get(0, 'ScreenSize');
screenWidth = screenSize(3);

f1 = figure(1);
f1Position = get(f1, 'Position');
f1Position(1) = 0;
set(f1, 'Position', f1Position)
title('W-plane')
xlabel('u')
ylabel('v')

f2 = figure(2);
f2Position = get(f2, 'Position');
f2Position(1) = ceil(screenWidth/2);
set(f2, 'Position', f2Position)
title('Z-plane')
xlabel('x')
ylabel('y')

a = 1;
lines_number = 15;
map_grid(lines_number, a);

function map_grid(n, a)
    u = linspace(-pi/2, pi/2,n);
    v = linspace(-1,1,n);
    
    for i = 1:n
        % vertical line
        u_vert = linspace(u(i), u(i), n);
        
        figure(1)
        hold on
        plot(u_vert, v, 'k')
        hold off
        
        figure(2)
        hold on
        map_line(u_vert, v, a)
        hold off
    end
    
    for i = 1:n
        % horizontal line
        v_horz = linspace(v(i), v(i), n);
        
        figure(1)
        hold on
        plot(u, v_horz, 'k')
        hold off
        
        figure(2)
        hold on
        map_line(u, v_horz, a)
        hold off
    end
end

function map_line(u, v, a)
    if length(u) >= 50
        n = length(u);
    else
        n = 50;
    end
    u = edit_linespace(u, n);
    v = edit_linespace(v, n);
    
    x = a .* sin(u) .* cosh(v);
    y = a .* cos(u) .* sinh(v);
    plot(x, y, 'k')
end

function lineSpace = edit_linespace(input, n)
    first_val = input(1);
    last_val = input(end);
    lineSpace = linspace(first_val, last_val ,n);
end
