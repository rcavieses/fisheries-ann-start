[netc]=creanarx(input,target,6,10)
I=tonndata(inputest,0,0);
a=[test(1:6)' 0 0 0 0 0]';
T=tonndata(test,0,0);
[xc,xic,aic,tc] = preparets(netc,I,{},T);
yc= netc(xc,xic,aic);
y=cell2mat(yc);
y=y'
plot(y)