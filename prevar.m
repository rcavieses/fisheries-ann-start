function [InputTest ,TargTest ]=prevar(Imptrain,TargetTrain)
% prepara datos para entrenar y probar una RNA
%Inptrain : datos de entrada entrenamiento, 
%InpTn: datos de entrada para el Test
%Targtrain:datos de salida para el entrenamiento
%Targtest: datos de validación del test.

 vari=var(Imptrain);
 men=mean(Imptrain);
 l=length(Imptrain);
 z=zeros(l,3);
 for i=1:l
     z(i,1)=(Imptrain(i,1)-men(1,1))/sqrt(vari(1,1));
     z(i,2)=(Imptrain(i,2)-men(1,2))/sqrt(vari(1,2));
  end
 InputTest=tonndata(z,0,0);
  
 vari2=var(TargetTrain);
 men2=mean(TargetTrain);
 l2=length(TargetTrain);
  z2=zeros(l2,2);
  for i=1:l2
     z2(i,1)=(TargetTrain(i,1)-men2(1,1))/sqrt(vari2(1,1));
     z2(i,2)=(TargetTrain(i,2)-men2(1,2))/sqrt(vari2(1,2));
  end
  TargTest=tonndata(z2,0,0);
  
end


