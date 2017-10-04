function [banda] = varinet( netc,input,target,n,pron )
%n es el tama�o de muestra, la muestra es n veces simulaciones en
%diferentes partes de la base de datos, input son la variables de entrada y
%target son las variables objetivo, pron es la longitud de pron�stico.  
%   se compara la simulaci�n con el dato real y se obtiene la diferencia,
%   posteriormente se calcula la varianza de esta diferencia y se calcula
%   la distribucion de probabilidad de error.
%sirve para cada red que tenga una matriz input de (3,j) y un target de
%(1,j)
%elaborado por Ricardo Cavieses y Victor Mendez
%Universidad Aut�nomad de Baja California Sur
%Laboratorio de simulacion de sistemas
%Departamento de Ingenier�a en Pesquer�as
%cavieses@uabcs.mx

delay=netc.numInputDelays;
i=1;
Delta=zeros(n,pron);
while i<=n
    %genera un indice aleatorio para obtener los datos
    in=randi([delay,length(input)-pron],1,1);
    
    r=length(target);
    %calcula el tama�o de la matriz que se esta ingresando
    %al pron�stico para no exceder el tama�o de la matriz
    pt=in+r+delay; 
    %si la longitud de pron�stico excede el tama�o de la bd 
    %se obtiene un nuevo indice aleatorio
    if pt>r 
        i=i+0;%no se cuenta este paso
    else
        INPaleatorio=input(in:pron,:);%selecciona el input aleatoriamente
        %selecciona el target aleatoriamente, de tama�o del delay
        Targetaleatorio=target(in:in+delay-1,:);
        TargetValidacion=target(in+delay:pt);
        y=simcamaron(netc,INPaleatorio,Targetaleatorio,pron);
        Delta(i,:)=(TargetValidacion-y)';
        i=i+1;
    end
vari=var(Delta);
desv=sqrt(vari);
banda=(1.96*desv)/sqrt(n);
end

