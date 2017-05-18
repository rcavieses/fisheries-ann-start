function Input=prevar(I1)
% función para el ingreso de las variables predictoras en una RNA.
%I1=input('ingrese la matriz predictora')
a1= size(I1);
if a1(1)<a1(2);
  I1=I1';
  else 
  I1=I1;
end
 display(' quiere  utilizar una media propia  o no');
 a2=input('no=0 si=1') ;

 if a2==0
 m1=nanmean(I1);
     else
    m1=input('ingrese la media');
 end
 
 display('quiere ingresar la varianza o la calculo?');
 a3=input('si=1 no=0');
  if a3==1;
 var1=input('ingrese la varianza');
    else
    var1=nanvar(I1);
      end

    %normalizar los datos
    
    n=1;
    
 while n<=a1(2);
   
    for i=1:a1(1);
        z(i,n)=(I1(i,n)-m1(n))/sqrt(var1(n));
     end
     n=n+1  ;    
 end
 Input=z;
end
