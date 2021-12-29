%% KNN Uygulaması
% KNN uygulaması yapılarak iris veri setinde sınıflandırma yapılıyor.
% 
% ÖNEMLİ: Eğer çok boyutlu veri ile 2-boyutlu düzlemde görselleştirme
% yapmak istenirse ya PCA gibi bir yöntem ile boyut indirgeme yapmak lazım
% ya da MRMR gibi bir yöntem ile önemli olan 2 sütunu seçmek lazım. İris'te
% 2 ve 4 numaralı sütunların veriyi temsil etme konusunda değerli olduğunu
% FSCMRMR ile başka uygulamada öğrendiğim için burada doğrudan onları
% seçtim.

% Model fit edildikten sonra modele test verilerini gönderip doğruluk
% hesabı yapıyoruz. Son olarak modele 1 tane örnek veri gönderip buna
% tahmin yaptırıyoruz. Bu kısmı biraz fantazi. Modele elle veri göndermek
% isteyenler için. Aslında gerçek hayatta uygulanacak yeri tam da burası
% oluyor. Sistem sınıflandırma ise bir kere fit edildikten (eğitildikten)
% sonra gerçek hayatta da böyle kullanılacak.
% 
% Kodların kullanımında bir kısıtlama bulunmamaktadır. Elden geldiğince
% sade ve anlaşılır yazmaya çalıştım. Çünkü ileride unuttup ta buraya
% baktığım zaman kolay hatırlamak istiyorum :)
% 
% Murat Özalp, 2021
%%

clear all

% iris veri setini yükle
load fisheriris
X = meas;
Y = species;

% Verileri grafikte göster
gscatter(X(:,2),X(:,4),Y)

% Çapraz katlama yöntemi ile eğitim-test ayırma
% Burada sadece 1-kat test ve eğitim ayrımı uygulanıyor.
cv = cvpartition(size(X,1),'KFold',5); % %20-%80 test-eğitim ayır
idx = cv.training(1); % Her kat için ayrı hesap yapackasan; buradaki 1'i, k'ya kadar döngüye sok.
XTrain = X(idx,:); XTest  = X(~idx,:);
YTrain = Y(idx,:); YTest  = Y(~idx,:);

% K-NN uygulaması
model = ClassificationKNN.fit(XTrain,YTrain);   % K-NN modeli fit et
YTahmin = predict(model, XTest); % eğitilmiş modele test verilerini gönder

% Doğruluk hesabı
YTahminNumerik = grp2idx(YTahmin);  % Kategorik verileri sayısala çevir. Doğruluğu hesaplamak için lazım az sonra
YTestNumerik = grp2idx(YTest);
Dogruluk = mean(double(YTestNumerik == YTahminNumerik))*100 % Doğruluk=DoğruTahmin/TahminSayısı

% Eğitilmiş modele 1 tane test verisi nasıl gönderilir?
% Literatürde bu kısım pek olmaz. Sistemin doğruluğunu öğrenmektir önemli
% olan. Onu da zaten yukarıda öğrendik.
OrnekVeri = [1, 3, 2, 0.7];
OrnekTahmin = predict(model, OrnekVeri)

% Örnek veriyi grafiğe ekle
line(OrnekVeri(2),OrnekVeri(4),'marker','x','color',...
    'k','markersize',20,'linewidth',2,'DisplayName','Örnek veri')
legend('Location','best')
