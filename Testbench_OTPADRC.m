clc, clear

n = 4; % Number of points to iterate over to

c = 0.67; % 0.6748289; Controller tunning parameter initial value
cs = tf(1,[0.1 2]);% Control system. Desired poles First Order Transfer Function

[A,B,C,D] = tf2ss([1],[1 1]); % For simulation purposes. Dynamics of objective system

for i=1:n
    % Controller function
    [wc,bo,obs] = otpADRC(cs,c)

    a = sim('Testbench_Algorithm');
    
    time = a.simout.Time;
    % time = downsample(time,100);
    % times (:,i) = time;
    z = c*ones(size(time));
    y = a.simout.Data(:,1);
    u = a.simout.Data(:,2);
    % data = downsample(data,100);
    % datas(:,i) = data;
    
    c = c + 0.04
    if c >= 1
        break
    end
    % tov = tov+1;
    
    axis([-0.2 10 0 1 -0.2 2]);
    axis square,grid on,hold on
    subplot(1,2,1);
    plot3(time,z,y,'LineWidth',1.5,'Color','b')
    axis([-0.2 10 0 1 -0.2 2]);
    axis square,grid on,hold on
    subplot(1,2,2); 
    plot3(time,z,u,'LineWidth',1.5,'Color','b')
end