
function [Best_Score,BestFit,Convergence_curve,Trajectories,fitness_history, position_history]=SSCSO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

%% 记录历史位置
Trajectories=zeros(SearchAgents_no,Max_iter);
position_history=zeros(SearchAgents_no,Max_iter,dim);
fitness_history=zeros(SearchAgents_no,Max_iter);


BestFit=zeros(1,dim);    %%%%定义种群初始位置
Best_Score=inf;        %%%%定义最优初始值，可根据求极大值和极小值进行更换

lowerbound=ones(1,dim).*(lb);                              % Lower limit for variables
upperbound=ones(1,dim).*(ub);  

%% 10种 混沌映射类型选择，1-10分别为，tent、Logistic、Cubic、chebyshev、Piecewise、sinusoidal、Sine,ICMIC, Circle,Bernoulli
Positions = repmat(lowerbound,SearchAgents_no,1)+chaos(3,SearchAgents_no,dim).* repmat((upperbound-lowerbound),SearchAgents_no,1);  

% Positions=initialization(SearchAgents_no,dim,ub,lb);
Convergence_curve=zeros(1,Max_iter);
t=0;
p=[1:360];
for i=1:size(Positions,1)   %%%%给种群个体进行编号
    fitness(i)=fobj(Positions(i,:));    %%%%计算每个搜索代理的目标函数，计算每个种群个体的适应度值
    if fitness(i)<Best_Score        %%%%搜索代理更新，若适应度值小于最优值
        Best_Score=fitness(i);      %%%%将适应度值定义为最优值
        BestFit=Positions(i,:);     %%%%将此适应度值对应的种群个体定为最优种群个体
    end
end
pX = Positions;     %%%%%与pFit相对应的个体最佳位置
pFit = fitness;

while t<Max_iter

    for i=1:SearchAgents_no
        position_history(i,t+1,:)=pX(i,:);
        Trajectories(:,t+1)=pX(:,1);
        fitness_history(i,t+1)=pFit(1,i);
    end
    

    S=2;                                    %%% S is maximum Sensitivity range
    rg=S-((S)*t/(Max_iter));                %%%% guides R
    k=5;
    z = exp(k*cos(pi*(1-(t/Max_iter))));    %%%%%螺旋搜索因子策略
    for i=1:size(Positions,1)

        r=rand*rg;
        R=((2*rg)*rand)-rg;                 %%%%   controls to transtion phases
        for j=1:size(Positions,2)
            teta=RouletteWheelSelection(p);
            if((-1<=R)&&(R<=1))              %%%% R value is between -1 and 1
                Rand_position=abs(rand*BestFit(j)-pX(i,j));
                Positions(i,j)=BestFit(j)-r*Rand_position*cos(teta);
            else
                cp=floor(SearchAgents_no*rand()+1);
                CandidatePosition =pX(cp,:);
                % Positions(i,j)=r*(CandidatePosition(j)-rand*Positions(i,j));    %%%%%原始沙猫群算法搜索
                
                l = 0.01 .*( CandidatePosition(j) - BestFit(j));
                Positions(i,j)=exp(z*l) * cos(2*pi*l)*r*(CandidatePosition(j)-rand*pX(i,j));     %%%%%融合螺旋搜索因子后的搜索
            end
        end
    end

    for i=1:size(Positions,1)

        %%%%边界控制，返回超出搜索空间边界的搜索代理
        Flag4ub=Positions(i,:)>ub;     %%%%若某个种群个体超出上边界
        Flag4lb=Positions(i,:)<lb;     %%%%若某个种群个体超出下边界
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;  %%%%将种群个体限制在约束边界之内

        %%%%计算每个搜索代理的目标函数
        fitness(i)=fobj(Positions(i,:));   %%%%计算某个种群个体的适应度值

        %%%%搜索代理更新
        if (fitness( i ) < pFit( i ))    %%%%更新个体最优
            pFit( i ) = fitness( i );
            pX(i, :) = Positions( i, : );
        end               
        if  pFit( i )<Best_Score         %%%%更新全局最优
            Best_Score=pFit(i);
            BestFit=pX(i,:);
        end
    end

    [fmax,idx]=max(pFit);
    worse = pX(idx,:);
    c=randperm(SearchAgents_no);
    b=c(1:30);
    for i =  1:length(b)      % Equation (5)   %%%%%麻雀警戒机制
        if( fitness(b(i))>Best_Score)
            Positions(b(i),:)=BestFit+(randn(1,dim)).*(abs(( pX(b(i),:)-BestFit)));
        else
            Positions(b(i),:) =pX(b(i),:)+(2*rand(1)-1)*(abs(pX(b(i),:)-worse))/ ( pFit(b(i))-fmax+1e-50);
        end
        Flag4ub=Positions(b(i),:)>ub;
        Flag4lb=Positions(b(i),:)<lb;
        Positions(b(i),:)=(Positions(b(i),:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        fitness(b(i))=fobj(Positions(b(i),:));
    end                                                                                                            

    for i=1:size(Positions,1) 
        if (fitness(i) < pFit(i))
            pFit( i ) = fitness( i );
            pX(i, :) = Positions( i, : );
        end
        if  pFit( i )<Best_Score
            Best_Score=pFit(i);
            BestFit=pX(i,:);
        end


    end


    t=t+1;
    Convergence_curve(t)=Best_Score;   %%%%记录当前迭代次数下的最优值
end
end