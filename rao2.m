function Rao2 ()
clc

pop = 10; % Population size
var = 30; % Number of design variables
maxFes = 30000; % Maximum functions evaluation
maxGen = floor(maxFes/pop); % Maximum number of iterations
mini = -100*ones(1,var);
maxi = 100*ones(1,var);
[row,var] = size(mini);
x = zeros(pop,var);
for i=1:var
 x(:,i) = mini(i)+(maxi(i)-mini(i))*rand(pop,1);
end
f = objective(x);
gen=1;
while(gen <= maxGen)
 xnew = updatepopulation(x,f);
 xnew = trimr(mini,maxi,xnew);
 fnew = objective(xnew);
 for i=1:pop
 if(fnew(i)<f(i))
 x(i,:) = xnew(i,:);
 f(i) = fnew(i);
 end
 end
 disp(['Iteration No. = ',num2str(gen)])

128
 disp('%%%%%%%% Final population %%%%%%%%%')
 disp([x,f])
 fnew = []; xnew = [];
 [fopt(gen),ind] = min(f);
 xopt(gen,:)= x(ind,:);
 gen = gen+1;
end
[val,ind] = min(fopt);
Fes = pop*ind;
disp(['Optimum value = ',num2str(val,10)])
end

%%The objective function is given below.
function [f] = objective(x)
[r,c]=size(x);
for i=1:r
 y=0;
 for j=1:c
 y=y+(x(i,j))^2; % Sphere function
 end
 z(i)=y;
end
f=z';
end
function [xnew]=updatepopulation(x,f)
[row,col]=size(x);
[t,tindex]=min(f);
Best=x(tindex,:);
[w,windex]=max(f);
worst=x(windex,:);
xnew=zeros(row,col);
for i=1:row
 k=randi(row);
 while (k==i)
 k=randi(row);
 end
 if (f(i)<f(k))
 for j=1:col
 r=rand(1,2);
 xnew(i,j)=x(i,j)+r(1)*(Best(j)-worst(j))+r(2)*(abs(x(i,j))-abs(x(k,j)));
 end
 else
 for j=1:col
 r=rand(1,2);
 xnew(i,j)=x(i,j)+r(1)*(Best(j)-worst(j))+r(2)*(abs(x(k,j))-abs(x(i,j)));
 end
 end
end
end
function [z] = trimr(mini,maxi,x)
[row,col]=size(x);
for i=1:col
 x(x(:,i)<mini(i),i)=mini(i);

 x(x(:,i)>maxi(i),i)=maxi(i);
end
z=x;
end
