function [reg,mser]=searchnar(Input,DataTest,Nunmin,NuNmax,minDo,maxDo,Pron)
% [reg,mser]=searchnar(Input,DataTest,Nunmin,NuNmax,minDo,maxDo,Pron)
%Help: Input es la variable que se desea predecir con la red, DataTest es
%una serie de datos de la variable con la que se hace una evaluación de la
%red, NuN es el número de neuronas que se quieren probar y maxDo es el
%número máximo de Delay y este no puede ser mayor a 5, esto debido a que el
%numero de datos que se están ingresando como data test es igual a 12
%dividido en dos grupos, si se le da mayor delay se ingresarán datos a
%pasado.


%Preparar los datos para entrenar la red

targetSeries=tonndata(Input,0,0);

%cilco para crear las redes
 mser=zeros(((maxDo-minDo)+1),(NuNmax-Nunmin+1));
 reg=zeros((maxDo-minDo)+1,(NuNmax-Nunmin)+1);
for D=1:(maxDo-minDo)+1
    for j=1:(NuNmax-Nunmin)+1
       
% Crea la "Nonlinear Autoregressive Network"
delay=minDo+(D-1); 
Neuron=Nunmin+j-1;
feedbackDelays = 1:delay;
hiddenLayerSize = Neuron;
net = narnet(feedbackDelays,hiddenLayerSize);

%se preparan los datos para entrenar la red
[inputs,inputStates,layerStates,targets] = preparets(net,{},{},targetSeries);
net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio = 5/100;
net.divideParam.testRatio = 5/100;

% Entrenar la red
[net,tr] = train(net,inputs,targets,inputStates,layerStates);
outputs = net(inputs,inputStates,layerStates);
errors = gsubtract(targets,outputs);
% Cerrar el cilco de la red.
netc = closeloop(net);
%preparar datos para predicciones a 6 ceros
DT1=DataTest(1:delay);
DT2=zeros(1,Pron);%reajusta esta parte para que evalue a diferentes D
DT3=[DT1' DT2];
DT4=tonndata(DT3,1,0);
%predicción
[xc,xic,aic,tc] = preparets(netc,{},{},DT4);
yc = netc(xc,xic,aic); 
% t=length(yc);
% if t<6 
%  break
%    display('son necesarios mas datos para test') 
% else
yc1=yc(1:Pron);
%Validación
DV1=DataTest(delay:(delay+Pron)-1)';
DV2=tonndata(DV1,1,0);
mser(D,j)= perform(netc,DV2,yc1);
[r,m,b]=regression(DV2,yc1);
reg(D,j)=r;
    end
    end
end

