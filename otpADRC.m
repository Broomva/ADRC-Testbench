function [wc,bo,Gobs] = otpADRC(HH,c)
[num, den] = tfdata(HH,'v');
b0 = num(2);
a1 = den(1);
a0 = den(2);

%[A,B,C,D] = tf2ss(b0,[a1 a0]);
%cs = ss(A,B,C,D);

wc = 1/(c*a1);
wo = 10/((1-c)*a1);
bo = b0/(c*a1);


Aobs = [0 1; 0 0];
Bobs = [bo; 0];
Cobs = [1 0];

l1 = 2*wo;
l2 = wo^2;

L = (place(Aobs',Cobs',[-l1 -l2]))';
Aaobs = Aobs - L*Cobs;
Baobs = [Bobs L];
Caobs = [1 0; 0 1];
Daobs = [0 0; 0 0];
Gobs = ss(Aaobs,Baobs,Caobs,Daobs);
end
