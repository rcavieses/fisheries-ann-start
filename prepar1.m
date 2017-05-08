function [InputTrain ,TargTrain ,inputTest,TargTest]=prepar1(Imptrain,TargetTrain, InpTest,TargTest)
% prepara datos para entrenar y probar una RNA
%Inptrain : datos de entrada entrenamiento, 
%InpTn: datos de entrada para el Test
%Targtrain:datos de salida para el entrenamiento
%Targtest: datos de validación del test.

 vari=var(Imptrain);
 men=mean(Imptrain);
 l=length(Imptrain);
 z=zeros(l,1);
 for i=1:l
     z(i,1)=(Imptrain(i,1)-men(1,1))/sqrt(vari(1,1));
    % z(i,2)=(Imptrain(i,2)-men(1,2))/sqrt(vari(1,2));
 end
 InputTrain=tonndata(z,0,0);
  
 vari2=var(TargetTrain);
 men2=mean(TargetTrain);
 l2=length(TargetTrain);
  z2=zeros(l2,1);
  for i=1:l2
     z2(i,1)=(TargetTrain(i,1)-men2(1,1))/sqrt(vari2(1,1));
    % z2(i,2)=(TargetTrain(i,2)-men2(1,2))/sqrt(vari2(1,2));
  end
  TargTrain=tonndata(z2,0,0);
  
  vari3=var(InpTest);
 men3=mean(InpTest);
 l3=length(InpTest);
 z3=zeros(l3,1);
  for i=1:l3
     z3(i,1)=(InpTest(i,1)-men3(1,1))/sqrt(vari3(1,1));
    % z3(i,2)=(InpTest(i,2)-men3(1,2))/sqrt(vari3(1,2));
  end
 inputTest=z3;
 
 vari4=var(TargTest);
 men4=mean(TargTest);
 l4=length(TargTest);
 
 z4=zeros(l4,1);
  for i=1:l4
     z4(i,1)=(TargTest(i,1)-men4(1,1))/sqrt(vari4(1,1));
 %    z4(i,2)=(TargTest(i,2)-men4(1,2))/sqrt(vari4(1,2));
  end
 TargTest=z4;
end


