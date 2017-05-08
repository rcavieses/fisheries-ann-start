function [mse1,r1]=searchnarx2(InputTrain,TargTrain,inputTest,TargTest,delay,HLS,Pron)
if delay+Pron> length(TargTest)
      display('ingrese TargTest mas extenzo'), 
else
[netc]=creanarx(InputTrain, TargTrain,delay,HLS);
[I,T,x]=pron(inputTest,TargTest,delay,Pron);
 [xc,xic,aic,tc] = preparets(netc,I,{},T);
yc = netc(xc,xic,aic);
yc1=cell2mat(yc);
 mse1= perform(netc,x(:,1),yc(:,1));%hacer un ciclo para poder meter n cantidad de vectores de pron
 %mse2= perform(netc,x(:,2),yc(:,2));
 r1=regression(x(1,:),yc1(1,:));
%r2=regression(x(2,:),yc1(2,:));
end
end
