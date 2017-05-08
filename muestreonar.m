function[mse1,r1]=muestreonar(Imptrain,TargetTrain, InpTest,TargTest,delay,HLS,Pron)
i2=delay;
j2=HLS;
% i2=input('delay:');
% j2=input('HLS:');
% Pron=input('pron:');
mse1=zeros(i2,j2); ; r1=zeros(i2,j2) ;
%mse2=zeros(i2,j2) 
%r2=zeros(i2,j2);
for i=1:i2;
for j=1:j2;
[mse1(i,j), r1(i,j) ]=searchnarx3(Imptrain,TargetTrain, InpTest,TargTest,i,j,Pron);
end
end
end
%para encontrar el optimo
% o1=min(c(c>=0));
%  [R1,C1]=find(c==o1)
%  o2=min(c2(c2>=0))
%  [R2,C2]=find(c2==o2)