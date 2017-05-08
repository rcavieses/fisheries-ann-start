function [mcl]=turbocla(year,LatitudS,LatitudN,LongitudW,LongitudE)
%these function calculate the average sst from an area, the data must be
%from MODIS-Aqua at ocean color and you have to order your data on folders whit 
%the name of month in spanish. For the next version these will not be
%nessesari.
% Ricardo Cavieses at UABCS rcavieses@gmail.com
display('espere un momento por favor')
 meses=[ {'/enero/'} ,{'/febrero/'} ,{'/marzo/'} ,{'/abril/'}, {'/mayo/'} ,{'/junio/'} ,{'/julio/'} ,{'/agosto/'} ,{'/septiembre/'},{'/octubre/'},{'/noviembre/'}, {'/diciembre/'}]' ;
meses=char(meses);
direc=strcat(year,meses);
mcl=zeros(12,1);
for j=1:12
    nombre0=char(direc(j,:)); 
 nombre=('/media/ricardo/TOSHIBA EXT/archivos_hdf/aqua/');%you should change the path
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
cla = flipdim(double(hdfread(ubi(k,:),'chlor_a')),2);
[a,b]=size(lat);
%Aplica ecuacion de escala para cla
 slope = double(cell2mat(hdfread(ubi(k,:),'slope')));
 inter = double(cell2mat(hdfread(ubi(k,:),'intercept')));
 cla = cla * slope + inter;

%Flags de tierra y datos no validos
bad = cell2mat((hdfread(ubi(k,:),'bad_value_scaled')));
cla(cla == bad) = NaN; %tierra
cla(cla < 0 | cla > 64) = NaN;%Fuera de escala

A=[reshape(lat',1,(a*b));reshape(lon',1,(a*b));reshape(cla',1,(a*b))];
B=A(:,A(1,:)>LatitudS&A(1,:)<LatitudN);
C=B(:,B(2,:)>LongitudW&B(2,:)<LongitudE);
D=C(3,:); 
mclad(k)=nanmean(D); 
end
display(meses(j,:))
    mmcl=nanmean(mclad); 
    clear A B C D M ans chlor_a h1 lat lee_archivos long nombre ubi directorio mcld2 nombre nombre1 nombre0 a b CloudID inter k lon numdata numdescr qualsst slope sst
 mcl(j)=mmcl
end
clear nombre0 meses direc year
display('Proceso finalizado')
display('gracias')
clear ans emclm j k mcldmcl mclm mcld numdata numdescr sst