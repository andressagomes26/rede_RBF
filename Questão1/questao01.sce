/* Andressa Gomes Moreira - 402305
   Trabalho 02 - Questão 01
   Inteligência Computacional
*/

clear; 
clc;

//      1. INÍCIO (t=0)

// 1.1 - Definir valor do passo de aprendizagem (n) entre 0 e 1
n = 0.5       // Passo de aprendizagem(n)

// 1.2 - Criar o vetor de pesos e limiar com valores aleatórios.
w = rand(1,3)  // Vetor de pesos

disp('Vetor de pesos com valores aleatórios: w(1)')
disp(w)

//      2. FUNCIONAMENTO

/* 
    -> Valores de entrada para a simulação da porta lógica AND
        Funcionamento da AND para 2 bits de entrada:
            0.0 = 0
            0.1 = 0
            1.0 = 0
            1.1 = 1
    -> bias = -1
    -> Saída esperada para a simulação da função AND
*/
entrada = [-1 0 0; -1 0 1; -1 1 0; -1 1 1];  // Valores de entrada para função AND
saida = [0; 0; 0; 1]                         // Valores esperados como saída
  
// Variáveis auxiliares
aux = 1
i = 1
comp = 0
t = 1

while %t        
        /* 
            2.1 Selecionar o vetor de entrada x(t):
                Deve-se percorrer todas as linhas da entrada, 
                a fim de definir o vetor de entrada x(t).
        */

        x=entrada(i, :)                          // Vetor de entrada x(t)
        
        /* 2.2 – Calcular ativação  u(t)
            Produto escalar entre dois vetores -> u(t)= w * x'
                - W = Vetor de pesos
                - x = Vetor de entrada
        */
        
        u = w * x'      // Função de ativação u(t)
        
        /* 
            2.3 Calcular saída gerada pela rede y(t)
                Se a função de ativação maior do que 0 -> y(t) = 1
                Senão ->  y(t) = 0
        */ 
        
        if u > 0 then
            y = 1;     // saída gerada pela rede y(t) = 1
        else y = 0;    // saída gerada pela rede y(t) = 0
        end  
       
        d = saida(i) // Verificar a saída desejada para a função AND
        
        //3. Treinamento
        
        /*  
            3.1 – Calcular erro
                - Diferença entre a saída desejada(d) e a saída gerada pela rede(y)
                    e(t) = d(t) - y(t)
        */
        
        e = d - y;   // Erro
        
        /*
            3.2 – Ajustar pesos via regra de aprendizagem.
                Se o erro for diferente de 0 atualiza-se os pesos por meio da equação:
                    w(t+1) = w(t) + n * e(t) * x(t)
                Caso contrário, mantém os mesmos pesos.
        */
        
        /*
            3.3 – Verificar critério de parada.
                    Espera-se que o erro seja igual a zero durante a execução de 4 ciclos
                    (ou seja o tamanho do vetor que armazena os valores esperados como saída).
                     
                     3.3.1 – Se não for atendido:
                        Caso obtenha-se um erro diferente de 0 pelo menos uma vez (durante a
                        execução dos 4 ciclos) a contagem é zerada e retorna-se para a 
                        etapa de 2. Funcionamento
                     3.3.2 – Se for atendido deve-se finalizar o treinamento.
        */
        
        if e ~= 0 then
            w = (w + (n * e * x));   // Ajustar pesos via regra de aprendizagem.
            comp = 0            // Zera a variável que irá definir o critério de parada
        else 
            comp = comp + 1 // Atualiza a variável que irá definir o critério de parada
        end

        
        // Atualizar a linha da matriz de entrada e da posição do vetor de saída:
        i=i+1;
        if i > 4 then
            i=1;
        end
         
         wi = t+1; // Variável auxiliar
         
        // Resultados
        disp('------------------- Treinamento | t = ' +  string(t) + ' ---------------------') 
        disp('t = ' +  string(t));
        disp('Vetor de entrada: ')
        disp(x)
        disp('Função de ativação | u = ' +  string(u));
        disp("Saída gerada pela rede(y): " +  string(y))
        disp('Erro: ' + string(e))
        disp("Pesos: w(" + string(wi) + ')')   
        disp(w);
        
        // Verifica se é possível finalizar o treinamento de acordo com o critério de parada
        // Ou seja, se o erro for igual a 0 durante 4 vezes seguidas o treinamento é finalizado.
        if comp == length(saida) then
            break
        end    
        
        t = t + 1

end


// Plotagem do gráfico
clf;

/* 
    Definindo as classes: 
        -> Classe 1 = Pontos na qual y = 1
                - Entrada x1 = 1 
                - Entrada x2 = 1
        -> Classe 2 = Pontos na qual y = 0
                - Entrada x1 = [0 0 1]
                - Entrada x2 = [0 1 0]

*/

// Pontos que representam a classe 1:
plot(1, 1, 'X');                    

// Pontos que representam a classe 2:
class2_x1 = [0 0 1];
class2_x2 = [0 1 0];
plot(class2_x1, class2_x2, 'o');    

/* 
    Definindo a reta que irá separar os pontos da classe 1 e da classe 2: 
        -> A equação da reta no plano (x1, x2) é dada por:
                  x2 = -(w1/w2)x1 + teta/w2
*/

// Valores encontrados -> w = [teta w1 w2]
disp('------------------- Solução encontrada  ---------------------')
disp('w = ')
disp(w')
teta = w(1)
w1 = w(2)
w2 = w(3)

// A equação da reta:
x1 = linspace(-2, 3);
x2 = -((w1/w2)*x1) + (teta/w2);
plot(x1, x2, '--r');

//Configurações do gráfico
set(gca(), 'grid', [1,1]);
title("AND");
xlabel('x1');
ylabel('x2');
legend('Classe 1 -> y = 1', 'Classe 2 -> y = 0');
