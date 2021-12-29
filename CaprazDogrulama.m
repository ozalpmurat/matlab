%% Çapraz Doğrulama
% cvpartition komutu ile kolayca çapraz kat doğrulama (k-fold validation)
% uygulaması yaabiliyoruz. k değişkeni, verinin kaç kat yapılacağını
% belirliyor.
%
% Kodların kullanımı serbesttir.
% Murat Özalp, 2021
%

clear all

%% PARAMETRELER
k = 5; % Kaç kat doğrulama yapılsın?

%% Verileri yükle
% İRİS için alttaki 3 satır açık kalsın, sonraki ikisini açıklama yap.
% load fisheriris;
% X = meas;
% Y = species;

% Altta katlamanın kolay incelenmesi için küçük veri seti uydurdum.
% İstersen yukarıdaki İris veri setini de kullanabilirsin.
X=[0 0;1 -1;2 -2;3 -3;4 -4;5 -5;6 -6;7 -7;8 -8;9 -9];
Y=[10;11;12;13;14;15;16;17;18;19];

%% Kategorik verileri sayısala çevir
Y = grp2idx(Y);

%% Çapraz doğrulama
% cvpartition komutu, istenen sayıda index vektörü oluşturur. Vektörde
% istenen değerler "1", istenmeyen değerler için "0" kullanılır. Eğitim ve
% test verisini çağırırken bu vektörü index olarak kullanırsak, veriyi
% ayrıştırmış oluruz.
cv = cvpartition(length(X),'kfold',k);
TumCaprazKatHatalari = zeros(k);
for CaprazKat = 1:k
    Xegitim=X(cv.training(CaprazKat),:);
    Yegitim=Y(cv.training(CaprazKat),:);
    Xtest=X(cv.test(CaprazKat),:);
    Ytest=Y(cv.test(CaprazKat),:);
    % Buradan sonra her çapraz katta çalıştırılması gereken komutar
    % yazılacak. Eğitim ve test verisi her katta değişecek. Tüm satırlar
    % hem eğitimde hem de testte kullanılmış olacak. Örnek olması için
    % birkaç saçma satır ben yazdım.
    fprintf("\n%d. kat: Test setinin Y verileri:",CaprazKat)
    Ytest'
end
