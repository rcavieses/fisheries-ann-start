clear
load('/home/ricardo/Documentos/maestria/resultados/modelofinal/modelo.mat')
Pron=72;
delay=6;
n=1000;
i=1;
% Deltax1=zeros(n,Pron);
% Deltax2=zeros(n,Pron);
Deltax4=zeros(n,Pron);
Deltax3=zeros(n,Pron);
while i<=n
    %%
    %obtiene un indice aleatorio para la comparación
    in=randi([delay,length(inputTest)-Pron],1,1);
    Tp=(TargTest(:,1)-3.9501e+05)/3.2761e+05;
    Tv=(TargTest(:,2)-3.1597e+05)/3.0810e+05;
    Tz=[Tp Tv];
    r=length(Tz);
    pt=in+delay+Pron;
    %%
    %condiciona el ciclo
    if pt>r 
        i=i+0;
    else
        %%
        %prepara las variables
T=Tz(in:pt,:);%serie de trabajo
Ty=T(1:delay,:)';
Tr=T((delay+1):end,:)';
target=tonndata([ Ty zeros(2,Pron)],1,0);
I=inputTest(in:pt,:);
Ir=I((delay+1):end,:)';
sst=tonndata([I(1:delay,1)' zeros(1,Pron)],1,0);
cla=tonndata([I(1:delay,2)' zeros(1,Pron)],1,0);
%%
%pronóstico de sst
[xc,xic,aic] = preparets(modsst,{},{},sst);
ysst = modsst(xc,xic,aic);
ysst2=cell2mat(ysst);
isst=[cell2mat(sst(1:6)) ysst2(1:end)];
izsst=(isst-22.1)/3.2;
Deltax1(i,:)=ysst2(1,:)-Ir(1,1:(end));
%%
%pronóstico de cla
[xc,xic,aic] = preparets(modcla,{},{},cla);
ycla = modcla(xc,xic,aic);
ycla2=cell2mat(ycla);
icla2=[cell2mat(cla(1:6)) ycla2(1:end)];
izcla=(icla2-1.6)/1.18;
Deltax2(i,:)=ycla2(1,:)-Ir(2,1:(end));
%%
%pronóstico captura
input=tonndata([izsst(2:end)' izcla(2:end)']',1,0);
 [xc,xic,aic,tc] = preparets(modcap,input,{},target);
 ycap=modcap(xc,xic,aic);
 yc2cap=cell2mat(ycap);
  Deltax3(i,:)=yc2cap(1,:)-Tr(1,1:(end-1));
 Deltax4(i,:)=yc2cap(2,:)-Tr(2,1:(end-1));
 i=i+1;
    end
end
%%
%obtiene las bandas de pronóstico al 95% de confianza variables ambientales
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
vari4=var(Deltax4);
desv4=sqrt(vari4);
banda4=(1.96*desv4)/(sqrt(n));

 y= yc2cap;
 y1=yc2cap(1,:)+banda3;
y2=yc2cap(1,:)-banda3;
y3=yc2cap(2,:)+banda4;
y4=yc2cap(2,:)-banda4;
%%
%obtiene las fechas de la simulación
display('simulación correspondiente a:')
dat=datestr(Fecha(in));
dat2=datestr(Fecha(in+Pron));
display(dat)

%%
%grafica la simulación de pierna
figure1=figure('Name','Pierna');
axes1 = axes('Parent',figure1);
xlim(axes1,[0 Pron+1]);
ylim(axes1,[-4 4]);
annotation(figure1,'textbox',...
    [0.135699853587115 0.828654149850851 0.106613469985359 0.0823170731707317],...
    'String',{'simulación:',dat,dat2},...
    'FitBoxToText','on');
hold on
plot(y(1,:),'-*b',  'DisplayName','Pronóstico'); 
plot(T(delay+1:end-1,1),'-or', 'DisplayName','Real');
plot(y2,'--k','DisplayName','banda inferior');
plot(y1,'--k','DisplayName','banda superior');
legend(axes1,'show')
xlabel('meses')
ylabel('desviación estandar')

%%
%grafica la simulación de verdillo
figure2=figure('Name','Verdillo');
axes2 = axes('Parent',figure2);
xlim(axes2,[0 Pron+1]);
ylim(axes2,[-4 4]);
annotation(figure2,'textbox',...
     [0.135699853587115 0.828654149850851 0.106613469985359 0.0823170731707317],...
    'String',{'simulación:',dat,dat2},...
    'FitBoxToText','on');
hold on
plot(y(2,:),'-*b',  'DisplayName','Pronóstico'); 
plot(T(delay+1:end-1,2),'-or','DisplayName','Real');
plot(y3,'--k','DisplayName','banda superior');
plot(y4,'--k','DisplayName','banda inferior');
legend(axes2,'show')
xlabel('meses')
ylabel('desviación estandar')
%%
%Grafica la simulación de tsm
figure3=figure('Name','TSM');
axes3=axes('Parent',figure3);
xlim(axes3,[0 Pron+2]);
annotation(figure3,'textbox',...
     [0.135699853587115 0.828654149850851 0.106613469985359 0.0823170731707317],...
    'String',{'simulación:',dat,dat2},...
    'FitBoxToText','on');
hold on
plot(ysst2,'-*b',  'DisplayName','Pronóstico'); 
plot(I(delay+1:end,1),'-or','DisplayName','Real');
plot(y1sst,'--k','DisplayName','banda superior');
plot(y2sst,'--k','DisplayName','banda inferior');
legend(axes3,'show');
xlabel('meses')
ylabel('°C')

%%
%Grafica la simulación de cla
figure4=figure('Name','Cla');
axes4=axes('Parent',figure4);
xlim(axes4,[0 Pron+2]);
annotation(figure4,'textbox',...
     [0.135699853587115 0.828654149850851 0.106613469985359 0.0823170731707317],...
    'String',{'simulación:',dat,dat2},...
    'FitBoxToText','on');
hold on
plot(ycla2,'-*b',  'DisplayName','Pronóstico'); 
plot(I(delay+1:end,2),'-or','DisplayName','Real');
plot(y1cla,'--k','DisplayName','banda superior');
plot(y2cla,'--k','DisplayName','banda inferior');
legend(axes4,'show');
xlabel('meses')
ylabel('mg m^(-3)')
% %%
% %Regresión de pronostico-real Pierna
% clear i
% i=1;
% Rpierna=zeros(Pron);
% while i<length(y(:,1))
%         [r]=regression(y(1,i)',T(delay+1:delay+i,1));
%         Rpierna(i)=r;
%         i=i+1;
% end
% 
% figure5=figure('Name','Regresion-Pierna');
% axes5=axes('Parent',figure5);
% xlim(axes5, [0 Pron])
% annotation(figure5,'textbox',...
%      [0.135699853587115 0.828654149850851 0.106613469985359 0.0823170731707317],...
%     'String',{'simulación:',dat,dat2},...
%     'FitBoxToText','on');
% hold on
% plot(Rpierna,'or')
% %%
% %Regresión de pronostico-real Verdillo
% clear i
% i=1;
% Rverdillo=zeros(Pron);
% while i<length(y(:,2))
%         [r]=regression(y(2,i)',T(delay+1:i,2));
%         Rverdillo(i)=r;
%         i=i+1;
% end
% %%
% %Regresión de pronostico-real TSM
% clear i
% i=1;
% Rsst=zeros(Pron);
% while i<length(ysst2)
%         [r]=regression(ysst2,I(delay+1:i,1));
%         Rsst(i)=r;
%         i=i+1;
% end
% %%
% %Regresión de pronostico-real Cla
% clear i
% i=1;
% Rcla=zeros(Pron);
% while i<length(ycla2)
%         [r]=regression(ycla2,I(delay+1:i,1));
%         Rcla(i)=r;
%         i=i+1;
% end