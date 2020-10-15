/* Andressa Gomes Moreira - 402305
   Trabalho 02 - Questão 02
   Inteligência Computacional
*/

clear; 
clc;

// Carregando a base de dados
data = fscanfMat("aerogerador.dat"); 

x = data(:, 1)'     // Variável de entrada x: Velocidade do vento - Todas as linhas da coluna 1
y = data(:, 2)'    // Variável de saída y: Potência gerada - Todas as linhas da coluna 2

// Normalização dos dados entre 0 e 1:
x = x/max(x);
y = y/max(y);

// Iremos definir alguns parâmetros:
amostra = length(x)    // Quantidade de elementos da amostra => amostra = length(x)
sigma = 1              

function [Z, w]=pesos(n) 
    
    // n = quantidade de neurônios ocultos
    
    // Definir o centroide
    aleat_x = grand(1,'prm', x) // Realiza uma pertubação nos valores da entrada x
    centroide = aleat_x(1:n)   // Seleciona os n (número de neurônios ocultos) primeiros valores para compor o centroide.
    
    for i = 1:amostra
        
        //Definir a norma u = ||x - centroide||
        vet = [x(i)*ones(1,n)] - centroide
        norma = abs(vet)'
        
       // Implementar a função ativação dos neurônios ocultos 
        beta = (1/(2*sigma))
        z(:, i)= exp(-(norma.^2)*beta)
    end

    //  Adicionar o bias = -1
    Z = [-1*ones(1,amostra); z]
       
    /* 
        Definir os pesos da camada de saída da rede neural de base radial:
            Pelo método dos quadrados mínimos.: W = (Z'*Z)^(-1) * (Z'* y)
            
            Adicionar a Regularização de Thikonov:
                W = (Z'*Z + lambda * I)^(-1) * (Z'* y)
                    - Lambda: Valor pequeno entre 0 e 1
                    - I: Matriz identidade de dimensão(n+1,n+1)
    */
    
    lambda = 0.000000001;
    I = eye(n+1,n+1);
    w = y*Z'*((Z*Z')+(lambda*I))^(-1); //w = y*Z'*(Z*Z')^(-1);
endfunction

/****************** COEFICIENTE DE DETERMINAÇÃO ******************/    
function [R2, y_preditor]=coef_determ(Z, w) 
    
    //Definir o modelo de regressão ajustado (preditor) y^
    y_preditor = w * Z;
    
    //Definir o Coeficiente de determinação R2
    media = mean(y);
    somat1 = sum((y - y_preditor).^2);
    somat2 = sum((y-media).^2);
    R2 = 1-(somat1/somat2);
endfunction

/***************** PLOTAGEM DOS GRÁFICOS *************************/
function []= plotar(y_preditor, R2, n)
    clf; 
    //Passo 09: Plotagem do gráfico
    plot(x,y, '.');
    plot(x,y_preditor, 'r-');
    
    title('Rede RBF com ' + string(n) + ' neurônios ocultos. R2 = ' + string(R2))
    xlabel('Velocidade do Vento x');
    ylabel('Potência Gerada y');
endfunction

/********************** RESULTADOS ****************************/

disp('--------- REDE RBF COM 2 NEURÔNIOS OCULTOS -------------')
n = 2
[Z, w] = pesos(n)
[R2, y_preditor]=coef_determ(Z, w) 
disp('Coeficiênte de determinação (R2) para ' +  string(n) + ' neurônios ocultos: ')
disp('R2 = ' + string(R2) + ' | n = ' + string(n))
plotar(y_preditor, R2, n)


disp('--------- REDE RBF COM 5 NEURÔNIOS OCULTOS -------------')
n = 5
[Z, w] = pesos(n)
[R2, y_preditor]=coef_determ(Z, w) 
disp('Coeficiênte de determinação (R2) para ' +  string(n) + ' neurônios ocultos: ')
disp('R2 = ' + string(R2) + ' | n = ' + string(n))
//plotar(y_preditor, R2, n)


disp('--------- REDE RBF COM 10 NEURÔNIOS OCULTOS -------------')
n = 10
[Z, w] = pesos(n)
[R2, y_preditor]=coef_determ(Z, w) 
disp('Coeficiênte de determinação (R2) para ' +  string(n) + ' neurônios ocultos: ')
disp('R2 = ' + string(R2) + ' | n = ' + string(n))
//plotar(y_preditor, R2, n)

disp('--------- REDE RBF COM 20 NEURÔNIOS OCULTOS -------------')
n = 20
[Z, w] = pesos(n)
[R2, y_preditor]=coef_determ(Z, w) 
disp('Coeficiênte de determinação (R2) para ' +  string(n) + ' neurônios ocultos: ')
disp('R2 = ' + string(R2) + ' | n = ' + string(n))
//plotar(y_preditor, R2, n)

disp('--------- REDE RBF COM 30 NEURÔNIOS OCULTOS -------------')
n = 30
[Z, w] = pesos(n)
[R2, y_preditor]=coef_determ(Z, w) 
disp('Coeficiênte de determinação (R2) para ' +  string(n) + ' neurônios ocultos: ')
disp('R2 = ' + string(R2) + ' | n = ' + string(n))
//plotar(y_preditor, R2, n)

disp('--------- REDE RBF COM 50 NEURÔNIOS OCULTOS -------------')
n = 50
[Z, w] = pesos(n)
[R2, y_preditor]=coef_determ(Z, w) 
disp('Coeficiênte de determinação (R2) para ' +  string(n) + ' neurônios ocultos: ')
disp('R2 = ' + string(R2) + ' | n = ' + string(n))
//plotar(y_preditor, R2, n)

disp('--------- REDE RBF COM 1000 NEURÔNIOS OCULTOS -------------')
n = 1000
[Z, w] = pesos(n)
[R2, y_preditor]=coef_determ(Z, w) 
disp('Coeficiênte de determinação (R2) para ' +  string(n) + ' neurônios ocultos: ')
disp('R2 = ' + string(R2) + ' | n = ' + string(n))
//plotar(y_preditor, R2, n)
