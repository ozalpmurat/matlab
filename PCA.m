%% PCA (Temel Bileşen Analizi)
% Uygulamasını ibasit olması için ris veri seti ile yapıyoruz.
% PCA, orjinal veriyi değiştirir. Bambaşka yeni veri üretir. Yeni üretilen
% veri, orjinal veriyi temsil eder. % kaç oranda temsil etmek istiyorsak
% ona uygun sayıda temel bileşen kullanmalıyız. Temel bileşenler, PCA
% projeksiyonu (izdüşüm) sonucunda elde edilen yeni verilerdir.

% ÖNEMLİ:
% Eğer veri tahmini için PCA kullanılacaksa, eğitim ve test verisine ayrı
% ayrı PCA yapılmalıdır. Hatta daha detaylı ifade edelim: Önce eğitim
% verisine PCA yapılır. Bu PCA projeksiyonunun sonucunda bir katsayı
% matrisi elde edilir. Test verileri de bu katsayı matrisine gönderilir.
% Matlab'ın PCA yardım sayfasının alt tarafında bir yerde bu anlatılıyor
% örnek kodlarla. Eğer eğitim-test verisini ayırmadan önce PCA yapılırsa,
% "data leakage" denilen problem ortaya çıkar.
% 
% Kodların kullanımı serbesttir.
% Murat Özalp, 2021

clear all

%% İris yükle
load fisheriris;
X = meas;

%% Kaç tane temel bileşen alırsak, orjinal veriyi % kaç temsil etmiş oluruz?
[Katsayilar, TemelBilesenler, Varyans, ~,        BilesenAgirliklari, mu] = pca(X);
% PCA bitti :)

% Kaç bileşen alırsak veriyi % kaç temsil edebiliyoruz?
BilesenTemsilAgirliklari=cumsum(BilesenAgirliklari); % Şöyle de oluyor: cumsum(Varyans)./sum(Varyans)*100
BilesenNo=(1:1:size(BilesenTemsilAgirliklari,1))';
fprintf('PCA sonucunda üretilen verilerden kaç bileşen alırsak,\norijinal veriyi %% kaç temsil edebiliyoruz?\n')
fprintf('%0.0f %0.6f\n',[BilesenNo,BilesenTemsilAgirliklari]')

% Grafikle görelim
plot(BilesenTemsilAgirliklari)
plot(BilesenTemsilAgirliklari,'-bs','LineWidth',1,'MarkerSize',5,'MarkerEdgeColor','r','MarkerFaceColor','r')
hold on
yline(95,'--r','Orjinal verinin %95 oranında temsili')
ax = gca; ax.XTick = unique(round(ax.XTick)); % Grafikte ara değerleri göstermesin
title('PCA ile veri temsil oranı')
xlabel('Kullanılacak temel bileşen sayısı')
ylabel('Orijinal verinin temsil oranı %')
grid on; grid minor;
