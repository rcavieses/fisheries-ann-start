function [msst]=turbo(year,LatitudS,LatitudN,LongitudW,LongitudE)
%these function calculate the average sst from an area, the data must be
%from MODIS-Aqua at ocean color and you have to order your data on folders whit 
%the name of month in spanish. For the next version these will not be
%nessesari.
% Ricardo Cavieses cavieses@uabcs.mx
display('espere un momento por favor')
 meses=[ {'/enero/'} ,{'/febrero/'} ,{'/marzo/'} ,{'/abril/'}, {'/mayo/'} ,{'/junio/'} ,{'/julio/'} ,{'/agosto/'} ,{'/septiembre/'},{'/octubre/'},{'/noviembre/'}, {'/diciembre/'}]' ;
meses=char(meses);
direc=strcat(year,meses);
msst=zeros(12,1);
for j=1:12
    nombre0=char(direc(j,:)); 
 nombre=('/home/ricardo/Documentos/maestria/datos/sst/');%you should change the path
 nombre1=strcat(nombre,nombre0);
 h1='*.hdf';
 directorio=strcat(nombre1,h1);
lee_archivos=dir(directorio);
M=[];
for k=1:length(lee_archivos)
M(k,:)=lee_archivos(k).name;
end
ubi=strcat(nombre1,M);
clear k
for k=1:length(lee_archivos);
lon = double(flipdim(hdfread(ubi(k,:),'longitude'),2));
lon(lon==-999) = nan;
lat = flipdim(double(hdfread(ubi(k,:),'latitude')),2);
lat(lat==-999) = nan;
sst = double(flipdim(hdfread(ubi(k,:),'sst'),2));
%Uses function for scal sst
slope = double(cell2mat(hdfread(ubi(k,:),'slope')));
inter = double(cell2mat(hdfread(ubi(k,:),'intercept')));
sst = sst * slope + inter;
[a,b]=size(lat);
%earth flags and non valid data (qualsst == 3)
qualsst = double(flipdim(hdfread(ubi(k,:),'qual_sst'),2));
sst(qualsst == 3) = NaN; %
sst(sst < -2 | sst > 37.5) = NaN;% out of scale

A=[reshape(lat',1,(a*b));reshape(lon',1,(a*b));reshape(sst',1,(a*b))];
B=A(:,A(1,:)>LatitudS&A(1,:)<LatitudN);
C=B(:,B(2,:)>LongitudW&B(2,:)<LongitudE);
D=C(3,:); 
msstd(k)=nanmean(D); 
end
display(meses(j,:))
msstm=nanmean(msstd)
clear A B C D M ans chlor_a h1 lat lee_archivos long nombre ubi directorio mcld2 nombre nombre1 nombre0 a b CloudID inter k lon numdata numdescr qualsst slope sst
    msst(j)=msstm; 
end
clear nombre0 meses direc year
display('Proceso finalizado')
display('gracias')
clear ans emclm j k mcldmcl mclm mcld numdata numdescr sst
