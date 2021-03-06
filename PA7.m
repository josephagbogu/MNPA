% Name: Agbogu Chidera Joseph
% Student No: 1010506053
% Course: ELEC 4700
% PA 7

G = zeros(6, 6); 

%Resistances:
r1 = 1;
r2 = 2;
r3 = 10;
r4 = 0.1; 
r0 = 1000; 

%Conductances:
G1 = 1/r1;
G2 = 1/r2;
G3 = 1/r3;
G4 = 1/r4;
G0 = 1/r0;

%Additional Parameters:
alpha = 100;
cap = 0.25;
L = 0.2;
vin = zeros(1, 20);
vo = zeros(1, 20);
v3 = zeros(1, 20);

G(1, 1) = 1;                                    
G(2, 1) = -G1; 
G(2, 2) = G1 + G2; 
G(2, 3) = 1; 
G(3 ,2) = -1; 
G(3, 4) = 1;                      
G(4, 3) = -1; 
G(4, 4) = G3;  
G(5, 4) = alpha*G3;
G(5, 5) = 1; 
G(6, 5) = -G4;
G(6, 6) = G4 + G0;   


C = zeros(6, 6);

C(2, 1) = -cap; C(2, 2) = cap;
C(3, 3) = L;

F = zeros(1, 6);
v = -10;

for i = 1:21
    vin(i) = v;
    F(1) = vin(i);
    
    Vm = G\F';
    
    vo(i) = Vm(6);
    v3(i) = Vm(4);
    v = v + 1;
end


figure(1)
plot(vin, vo);
title('Vo (V) vs Vin (V)');
xlabel('Vin (V)')
ylabel('Vo (V)')

figure(2)
plot(vin, v3)
title('V3 (V) vs Vin (V)')
xlabel('Vin (V)')
ylabel('V3 (V)')



F(1) = 1;
vo2 = zeros(1, 1000); 
freq = linspace(0, 1000, 1000); % note: in radians
Av = zeros(1, 1000);
Avlog = zeros(1, 1000);

for i = 1:1000
    Vm2 = (G+1i*freq(i)*C)\F';
    vo2(i) = Vm2(6);
    Av(i) = vo2(i)/F(1);
    Avlog(i) = log10(Av(i));
end 
    
figure(3)
semilogx(freq, Avlog)
xlim([0 1000])
title('Av (dB) vs w (rad)')
xlabel('w (rad)')
ylabel('Av (dB)')
    
w = pi;
Av2 = zeros(15, 1);
Cper = zeros(15, 1);
vo3 = zeros(1, 15);

for i = 1:1000
    C(2, 1) = normrnd(-cap, 0.05); 
    C(2, 2) = normrnd(cap, 0.05);
    C(3, 3) = normrnd(L, 0.05);
    Vm3 = (G+1i*w*C)\F';
    vo3(i) = Vm3(6);
    Av2(i) = vo3(i)/F(1);
end

figure(4)
hist(real(Av2), 25)
title('Gain Distribution')
xlabel('Gain at w = pi')