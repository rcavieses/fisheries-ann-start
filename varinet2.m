clear
load('/home/ricardo/Documentos/maestria/resultados/modelofinal/modelo.mat')
clear modcap
load('/home/ricardo/Documentos/maestria/resultados/modelofinal/modverd.mat')
Pron=72;

n=1000;
i=1;

Deltax4=zeros(n,Pron);
Deltax3=zeros(n,Pron);

while i<=n
delay=6;
    %obtiene un indice aleatorio para la comparación
    in=randi([delay,length(inputTest)-Pron],1,1);
    Tv=(TargTest(:,2)-3.1597e+05)/3.0810e+05;
    Tz=[Tv];
    r=length(Tz);
    pt=in+delay+Pron;
      if pt>r 
        i=i+0;
      else

        %prepara las variables
T=Tz(in:pt,:);%serie de trabajo

I=inputTest(in:pt,:);
Ir=I((delay+1):end,:)';
sst=tonndata([I(1:delay,1)' zeros(1,Pron)],1,0);
cla=tonndata([I(1:delay,2)' zeros(1,Pron)],1,0);

%pronóstico de sst
[xc,xic,aic] = preparets(modsst,{},{},sst);
ysst = modsst(xc,xic,aic);
ysst2=cell2mat(ysst);
isst=[cell2mat(sst(1:6)) ysst2(1:end)];
izsst=(isst-22.1)/3.2;%corregir esto
Deltax1(i,:)=ysst2(1,:)-Ir(1,1:(end));

%pronóstico de cla
[xc,xic,aic] = preparets(modcla,{},{},cla);
ycla = modcla(xc,xic,aic);
ycla2=cell2mat(ycla);
icla2=[cell2mat(cla(1:6)) ycla2(1:end)];
izcla=(icla2-1.6)/1.18;%corregir esto
Deltax2(i,:)=ycla2(1,:)-Ir(2,1:(end));

%pronóstico captura
delay=7;
Ty=T(1:delay,:)';
Tr=T((delay+1):end,:)';
target=tonndata([ Ty zeros(1,Pron)],1,0);
input=tonndata([izsst(1:end)' izcla(1:end)']',1,0);
 [xc,xic,aic,tc] = preparets(modver,input,{},target);
 ycap=modver(xc,xic,aic);
 yc2cap=cell2mat(ycap);
  Deltax3(i,:)=yc2cap(1,:)-Tr(1,1:(end));
 i=i+1;
    end
end
vari1=var(Deltax1);
desv1=sqrt(vari1);
banda1=(1.96*desv1)/(sqrt(n));
vari2=var(Deltax2);
desv2=sqrt(vari2);
banda2=(1.96*desv2)/(sqrt(n));
y1sst=ysst2+banda1;
y2sst=ysst2-banda1;
y1cla=ycla2+banda2;
y2cla=ycla2-banda2;

%obtiene las bandas de pronóstico al 95% de confianza pesca
vari3=var(Deltax3);
desv3=sqrt(vari3);
banda3=(1.96*desv3)/(sqrt(n));

%obtiene las fechas de la simulación
display('simulación correspondiente a:')
dat=datestr(Fecha(in));
dat2=datestr(Fecha(in+Pron));
display(dat)

% %grafica la simulación de verdillo
% figure1=figure('Name','Verdillo');
% axes2 = axes('Parent',figure1);
% xlim(axes2,[0 Pron+1]);
% ylim(axes2,[-4 4]);
% annotation(figure1,'textbox',...
%      [0.135699853587115 0.828654149850851 0.106613469985359 0.0823170731707317],...
%     'String',{'simulación:',dat,dat2},...
%     'FitBoxToText','on');
% hold on
% plot(y(2,:),'-*b',  'DisplayName','Pronóstico'); 
% plot(T(delay+1:end-1,2),'-or','DisplayName','Real');
% plot(y3,'--k','DisplayName','banda superior');
% plot(y4,'--k','DisplayName','banda inferior');
% legend(axes2,'show')
% xlabel('meses')
% ylabel('desviación estandar')
