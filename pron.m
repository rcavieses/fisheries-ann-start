function [I,T,x]= pron(inputTest,TargTest,delay,Pron);
 DT1=inputTest(1:delay+Pron,:);
 I=tonndata(DT1,0,0);
 T=tonndata([TargTest(1:delay,:)' zeros(1,Pron)]',0,0);%modifique zeros 
 x=TargTest((delay+1):(delay+Pron),:)';
 end 