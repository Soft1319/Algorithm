

% This function draws the benchmark functions

function Copy_of_func_plot(func_name)

[lb,ub,dim,fobj]=Get_Functions_cec2017(func_name,30);

switch func_name 
    case 1 
        x=-100:2:100; y=x; %[-100,100]
        
    case 2 
        x=-100:2:100; y=x; %[-10,10]
        
    case 3 
        x=-100:2:100; y=x; %[-100,100]
    case 4 
        x=-100:2:100; y=x; %[-100,100]
    case 5 
        x=-200:2:200; y=x; %[-5,5]
    case 6 
        x=-100:2:100; y=x; %[-100,100]
    case 7 
        x=-1:0.03:1;  y=x;  %[-1,1]
    case 8 
        x=-500:10:500;y=x; %[-500,500]
    case 9 
        x=-5:0.1:5;   y=x; %[-5,5]    
    case 10 
        x=-20:0.5:20; y=x;%[-500,500]
    case 11 
        x=-500:10:500; y=x;%[-0.5,0.5]
    case 12 
        x=-10:0.1:10; y=x;%[-pi,pi]
    case 13 
        x=-5:0.08:5; y=x;%[-3,1]
    case 14 
        x=-100:2:100; y=x;%[-100,100]
    case 15 
        x=-5:0.1:5; y=x;%[-5,5]
    case 16 
        x=-1:0.01:1; y=x;%[-5,5]
    case 17
        x=-5:0.1:5; y=x;%[-5,5]
    case 18 
        x=-5:0.06:5; y=x;%[-5,5]
    case 19 
        x=-5:0.1:5; y=x;%[-5,5]
    case 20 
        x=-5:0.1:5; y=x;%[-5,5]        
    case 21 
        x=-5:0.1:5; y=x;%[-5,5]
    case 22 
        x=-5:0.1:5; y=x;%[-5,5]     
    case 23 
        x=-5:0.1:5; y=x;%[-5,5] 
    case 24 
        x=-5:0.1:5; y=x;%[-5,5]
    case 25 
        x=-5:0.1:5; y=x;%[-5,5]
    case 26 
        x=-5:0.1:5; y=x;%[-5,5]
    case 27 
        x=-5:0.1:5; y=x;%[-5,5]
    case 28 
        x=-5:0.1:5; y=x;%[-5,5]
    case 29 
        x=-5:0.1:5; y=x;%[-5,5]
    case 30 
        x=-5:0.1:5; y=x;%[-5,5]
end    

    

L=length(x);
f=[];

for i=1:L
    for j=1:L
        if strcmp(func_name,15)==0 && strcmp(func_name,19)==0 && strcmp(func_name,20)==0 && strcmp(func_name,21)==0 && strcmp(func_name,22)==0 && strcmp(func_name,23)==0
            f(i,j)=fobj([x(i),y(j)]);
        end
        if strcmp(func_name,15)==1
            f(i,j)=fobj([x(i),y(j),0,0]);
        end
        if strcmp(func_name,19)==1
            f(i,j)=fobj([x(i),y(j),0]);
        end
        if strcmp(func_name,20)==1
            f(i,j)=fobj([x(i),y(j),0,0,0,0]);
        end       
        if strcmp(func_name,21)==1 || strcmp(func_name,22)==1 ||strcmp(func_name,23)==1
            f(i,j)=fobj([x(i),y(j),0,0]);
        end          
    end
end

surfc(x,y,f,'LineStyle','none');

end

