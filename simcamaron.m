function y=simcamaron(netc,Input,Target_Delay,pron)
%Help: netc es la rna  
%Input debe ser del tama�o del delay + el pron
%Target debe tener el tama�o del delay
%pron puede ser x tama�o seg�n datos que se tengan para validar
pron=zeros(pron,1);
T=tonndata([Target_Delay' pron']',0,0);
I=tonndata(Input,0,0);
[xc,xic,aic] = preparets(netc,I,{},T);
yc = netc(xc,xic,aic);
y=cell2mat(yc)';
end
