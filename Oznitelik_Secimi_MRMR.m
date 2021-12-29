%% FSCMRMR ile Öznitelik Seçimi
% Hangi özniteliklerin (sütunların) daha değerli (istediğimiz çıkışı verme
% konusunda daha faydalı) olduğunu öğrenmek için kullanılıyor. İris'te 4
% tane öznitelik var. Grafik ile kolayca hangilerinin daha değerli olduğu
% görülüyor.
% 
% Kodların kullanımında kısıtlama bulunmamaktadır
% Murat Özalp, 2021
% 

clear all
load fisheriris;
X = meas;
Y = species;
clear meas species

%% Öznitelik Seçimi - MRMR (Minimum Redundancy Maximum Relevance) algoritması
[index, etki] = fscmrmr(X,Y); % Feature Selection Classification MRMR
OznitelikEtkileri = [(1:size(X,2));etki]'; % Etki miktarı ve Öznitleik numarasını bir tabloda tut.
OznitelikEtkileriSirali = sortrows(OznitelikEtkileri,2,'descend')
barh(etki)
title('Özniteliklerin Sınıflandırmaya Etkisi')
xlabel('Etki miktarı')
ylabel('Öznitelik numarası')
