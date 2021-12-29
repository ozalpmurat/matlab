%% Normalizasyon uygulaması ve Kategoriyi numerik değere çevirme
% normalizasyon kısmında, verinin istenen sütunları a-b arasına
% getiriliyor.
% Numerikleştirme aşamasında kategorik (metinsel) gelen verileri sayısala
% çeviriyoruz.
% Normalizasyon ve Numerikleştirme aşamaları makine öğrenmesi
% uygulamalarında gerekli olabiliyor. Normalizasyon için farklı yöntemler
% ve uygulamalar mevcut. Diğer yöntemler farklı veri setlerinde ve farklı
% makine öğrenmesi uygulamalarında daha farklı sonuçlar verebilir.
% 
% Kodların kullanımı serbesttir.
% Murat Özalp, 2021
%

clear all

%% Verileri yükle
load fisheriris;
X = meas;
Y = species;

%% Kategorik verileri sayısala çevir
DonusturulecekSutunlar = [1]; % Birden fazla olursa [1 4 6 18] gibi yazılabilir
NumerikY = numeriklestir(Y, DonusturulecekSutunlar);

%% Normalizasyon yap
NormallesecekSutunlar = [2 3 4]; % İriste zaten 4 sütun var, farkı görmek için ilki hariç diğerlerini yazdım.
NormalizeX = normalizasyon(X, 0, 1, NormallesecekSutunlar); % Tüm değerlerin 0 ve 1 arasına getirilmesini istiyorum.

%%
% AŞAĞIDA FONKSİYONLAR

%% Numerikleştirme fonksiyonu
function [NumerikVeri] = numeriklestir(OrjinalVeri, NumeriklestirilecekSutunlar)
NumerikVeri = zeros(size(OrjinalVeri));  % Aşağıda döngünün her aşamasında boyutu değişmesin diye
for i = 1:size(OrjinalVeri,2)
    if ismember(i,NumeriklestirilecekSutunlar)
        % Kategorik sütunu numerik değere çevir
        NumerikVeri(:,i) = grp2idx(OrjinalVeri(:,i));
    else
        % Sütunu değiştirmeden al
        NumerikVeri(:,i) = OrjinalVeri(:,i);
    end % if
end % for
end % func.


%% Normalizasyon fonksiyonu
function [X] = normalizasyon(Xorjinal, nmin, nmax, AyarlanacakSutunlar)
X = zeros(size(Xorjinal)); % Aşağıda döngünün her aşamasında boyutu değişmesin diye
for i = 1:size(Xorjinal,2)
    if ismember(i,AyarlanacakSutunlar)
        % Kategorik sütunu numerik değere çevir
        veri = Xorjinal(:,i);
        if (max(veri)-min(veri)) ~= 0
            % Kesirin paydasında 0 olmaması için kontrol ediyoruz.
            X(:,i) = nmin + ((veri - min(veri))*(nmax-nmin) / (max(veri)-min(veri))); % Veriler nmin-nmax aralığına getirilsin
        end % if
    else
        % Sütunu değiştirmeden al
        X(:,i) = Xorjinal(:,i);
    end % if
end % for
end % func.
