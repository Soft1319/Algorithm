% This function draw the benchmark functions
function func_plot_cec2017(func_name,dim)

[lb,ub,dim,fobj]=Get_Functions_cec2017(func_name,dim);

x=-100:2:100; y=x; % xµÄ·¶Î§ÔÚ [-100,100]

L=length(x);
f=[];

for i=1:L
    for j=1:L
        if dim==2
            f(i,j)=fobj([x(i),y(j)]);
        else
            f(i,j)=fobj([x(i),y(j),zeros(1,dim-2)]);
        end
    end
end
surfc(x,y,f,'LineStyle','none');
title(['cec2017-F' num2str(func_name)])
xlabel('x_1');
ylabel('x_2');
zlabel('F( x_1 , x_2 )')
set(gca,'color','none')
grid on
box on
end
