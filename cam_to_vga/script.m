y=dlmread('C:\Users\Lab User\Desktop\dataRGB.txt');
x=reshape(y,1,307200);
dlmwrite('C:\Users\Lab User\Desktop\RGB.txt',x,'delimiter','\n');