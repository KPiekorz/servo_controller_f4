% 
% VarName1 = VarName1(1621:3436);
% 
% figure(1)
% plot(VarName1)
% 
% VarName2(1:1621) = 0;
% VarName2 = VarName2(1621:3436);

t = 0:0.001:((1816*0.001)-0.001);

figure(2)
plot(t, VarName1, t, VarName2)
hold on

%estymacja transmitancji obiektu
%funkcja iddata przyjmuje: dane wyjsciowe, dane wejsciowe, czas probkowania
in_data = iddata(VarName1, VarName2, 0.001);


%funkcja tfest przyjmuje: dane wejsciowo-wyjściowe jako struktura iddata,
%ilosc biegunow, ilosc zer, nazwe i wartosc parametru do ustawienia (Ts to
%czas probkowania).
% motor_tf = tfest(in_data, 2, 0, 'Ts', 0.001)
motor_tf = tfest(in_data, 1)

 
%wykres odpowiedzi skokowej transmitancji silnika
[y, t] = step(motor_tf);
y = y*100;

% figure(3)
plot(t, y, 'r')
hold on

% pid tunning
% motor_tf_c = d2c(motor_tf)
[C_pdi,info] = pidtune(motor_tf_c,'PID')

%wykres odpowiedzi skokowej transmitancji silnika
motor_tf_zamk = feedback(C_pdi*motor_tf_c, 1); 
[y, t] = step(motor_tf_zamk);
y = y*100;

% figure(3)
plot(t, y, 'r')
