; *********************************************************************************
;	Projeto : Jogo Beyond Mars 
; *********************************************************************************

;Identificação dos autores:

;		- Cristiano Pantea IST-106324
;		- Mariana Isabel Marçal Santana IST-106992
;		- João Lucas Morais Cardoso Tavares Rodrigues IST-106221

;Grupo de trabalho: 	19

; *********************************************************************************
; * Constantes
; *********************************************************************************

; COMANDOS MEDIA CENTER
COMANDOS			EQU	6000H				; endereço de base dos comandos do MediaCenter
DEFINE_LINHA    	EQU COMANDOS + 0AH		; endereço do comando para definir a linha
DEFINE_COLUNA   	EQU COMANDOS + 0CH		; endereço do comando para definir a coluna
DEFINE_PIXEL    	EQU COMANDOS + 12H		; endereço do comando para escrever um pixel
APAGA_AVISO     	EQU COMANDOS + 40H		; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	 	    EQU COMANDOS + 02H		; endereço do comando para apagar todos os pixels já desenhados
DEFINE_FUNDO        EQU COMANDOS + 42H		; endereço do comando para definir a cor de fundo
TOCA_SOM		 	EQU COMANDOS + 5AH		; endereço do comando para tocar um som


; POSIÇÕES OBJETOS
LINHA_INCIAL_ASTEROIDE  		  EQU 0			; linha inicial do ecrã
COLUNA_INCIAL_ASTEROIDE_ESQUERDA  EQU 0			; linha inicial do ecrã
COLUNA_INCIAL_ASTEROIDES_MEIO     EQU 30			; linha inicial do ecrã
COLUNA_INCIAL_ASTEROIDE_DIREITA   EQU 59			; linha inicial do ecrã

LINHA_INCIAL_NAVE   EQU  27							; linha inicial da nave
COLUNA_INCIAL_NAVE  EQU  25							; coluna inicial da nave

COLUNA_DIREITA_NAVE EQU  45							; coluna da direita da nave para comparação nas colisões
COLUNA_ESQUERDA_NAVE EQU 20							; coluna da esquerda da nave para comparação nas colisões

LINHA_INCIAL_SONDA      				EQU  26		; linha inicial da sonda
COLUNA_INCIAL_SONDA_VERTICAL     		EQU  32		; coluna inicial da sonda
COLUNA_INCIAL_SONDA_DIAGONAL_ESQUERDA   EQU  26		; coluna inicial da sonda DIAGONAL ESQUERDA
COLUNA_INCIAL_SONDA_DIAGONAL_DIREITA    EQU  37		; coluna inicial da sonda DIAGONAL DIREITA

; DIMENSÕES OBJETOS
LARGURA_ASTEROIDE 	EQU 5           ; largura do asteroide
ALTURA_ASTEROIDE 	EQU 5           ; altura do asteroide
LARGURA_NAVE    	EQU  15			; largura da nave
ALTURA_NAVE      	EQU  5			; altura da nave

; DIMENSÕES DA TELA
N_LINHAS   EQU  32			; número de linhas do ecrã (altura)
N_COLUNAS  EQU  64			; número de colunas do ecrã (largura)


; CONSTANTES RELACIONADAS COM O TECLADO
LINHA 	EQU 8		 ; linha default para o ciclo das linhas
MASCARA EQU 0FH

; TELCAS
SOBE_SONDA_MEIO EQU 2   		; tecla que faz a sonda do meio subir
SOBE_SONDA_ESQUERDA EQU 1		; tecla que faz a sonda da esquerda subir
SOBE_SONDA_DIREITA EQU 3		; tecla que faz a sonda da direita subir
TECLA_COMEÇA  EQU 0CH			; tecla que faz o jogo começar
TECLA_PAUSA   EQU 0DH			; tecla que faz o pause/unpause
TECLA_TERMINA EQU 0EH			; tecla que termina o jogo

; ENDEREÇOS DO PEPE
DISPLAYS   EQU 0A000H  ; endereço do porto dos displays hexadecimais
TEC_LIN    EQU 0C000H  ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL    EQU 0E000H  ; endereço das colunas do teclado (periférico PIN)

; CORES
TURQUOISE1  EQU 0F0ECH            ; cor do pixel: turquesa em ARGB
TURQUOISE2   EQU 0F0DBH           ; cor do pixel: turquesa escuro em ARGB
TURQUOISE3   EQU 0F0CAH           ; cor do pixel: turquesa escuro em ARGB
TURQUOISE4   EQU 0F0B9H           ; cor do pixel: turquesa escuro em ARGB

;YELLOW       EQU 0FFF0H          ; cor do pixel: amarelo em ARGB
YELLOW1      EQU 0FFF0H           ; cor do pixel: amarelo em ARGB
YELLOW2      EQU 0FEE0H           ; cor do pixel: amarelo escuro em ARGB
YELLOW3      EQU 0FDD0H           ; cor do pixel: amarelo escuro em ARGB
YELLOW4      EQU 0FCC0H           ; cor do pixel: amarelo escuro em ARGB

PURPLE1      EQU 0FF0FH           ; cor do pixel: roxo escuro em ARGB
PURPLE2      EQU 0FC0CH           ; cor do pixel: roxo em ARGB
PURPLE3      EQU 0FA0AH           ; cor do pixel: roxo em ARGB
PURPLE4      EQU 0F808H           ; cor do pixel: roxo escuro em ARGB

DGREY         EQU 0F888H          ; cor do pixel: cinzento escuro em ARGB
GREY         EQU 0FCCCH           ; cor do pixel: cinzento em ARGB
BLACK        EQU 0H               ; cor do pixel: preto em ARGB

; CONSTANTES UTEIS
FIM_SONDA EQU 12				; linha máxima a que a sonda chega
DEFAULT_DISPLAY EQU 64H			; valor do display default
ENERGIA_TEMPO EQU 03H			; valor de energia que é perdida de 3 em 3 segundos
FIM_ASTEROIDE EQU 32			; linha máxima a que o asteroide pode chegar
N_SONDAS EQU 03H				; número de sondas
N_ASTEROIDES EQU 04H			; número de asteroides
MAX_ENDE_AST EQU 8				; endereço máximo possível na tabela de flags dos asteroides
ATRASO EQU 0F000H				; atraso na animação de destruição dos asteroides
PROXIMO_ENDEREÇO EQU 2			; valor a incrementar para aceder ao próximo endereço
LINHA_COLISAO_NAVE EQU 22		; linha na qual o asteroide pode colidir com a nave
GANHA_ENERGIA EQU 25			; valor a ser incrementado quando um asteroide mineravel é destruido
DISPARO EQU 5					; valor a retirar do display após o disparo

; FLAGS
FLAG_1 EQU 1
FLAG_0 EQU 0

; ESTADOS DE JOGO
ESTADO_COMEÇA EQU 0
ESTADO_JOGAVEL EQU 1
ESTADO_PAUSA EQU 2
ESTADO_TERMINADO EQU 3
ESTADO_PERDIDO_COLISAO EQU 4
ESTADO_PERDIDO_ENERGIA EQU 5


; TABELAS: DEFINIÇÕES DOS OBJETOS
    PLACE		1000H	; coloca a tabela de definições de objetos na posição 1000H	

;TABELA DO ASTEROIDE MINERÁVEL
ASTEROIDE_MINERAVEL:
    WORD    LARGURA_ASTEROIDE, ALTURA_ASTEROIDE
    WORD    0, YELLOW2, YELLOW2, YELLOW1, 0
    WORD    YELLOW3, YELLOW2, YELLOW2, YELLOW1, YELLOW1
    WORD    YELLOW4, YELLOW3, YELLOW2, YELLOW2, YELLOW2
    WORD    YELLOW4, YELLOW3, YELLOW3, YELLOW2, YELLOW2
    WORD    0, YELLOW4, YELLOW4, YELLOW3, 0

; TABELA DO ASTEROIDE NÃO MINERÁVEL
ASTEROIDE_NAO_MINERAVEL:
    WORD    LARGURA_ASTEROIDE, ALTURA_ASTEROIDE
    WORD    TURQUOISE2, 0, TURQUOISE1, 0, TURQUOISE1
    WORD    0, TURQUOISE2, TURQUOISE2, TURQUOISE1, 0
    WORD    TURQUOISE4, TURQUOISE3, 0, TURQUOISE2, TURQUOISE1
    WORD    0, TURQUOISE4, TURQUOISE4, TURQUOISE3, 0
    WORD    TURQUOISE4, 0, TURQUOISE4, 0, TURQUOISE3

;TABELA DO ASTEROIDE NÃO MINERÁVEL DESTRUÍDO
ASTEROIDE_NAO_MINERAVEL_DESTRUIDO: 
    WORD    LARGURA_ASTEROIDE, ALTURA_ASTEROIDE
    WORD    0, TURQUOISE2, 0, TURQUOISE2, 0
    WORD    TURQUOISE2, 0, TURQUOISE2, 0, TURQUOISE2
    WORD    0, TURQUOISE2, 0, TURQUOISE2, 0
    WORD    TURQUOISE2, 0, TURQUOISE2, 0, TURQUOISE2
    WORD    0, TURQUOISE2, 0, TURQUOISE2, 0

; TABELA DO ASTEROIDE MINERÁVEL DESTRUIDO - 1º FASE
ASTEROIDE_MINERAVEL_DESTRUIDO1:
    WORD    LARGURA_ASTEROIDE, ALTURA_ASTEROIDE
    WORD    0, 0, 0, 0, 0
    WORD    0, YELLOW2, YELLOW2, YELLOW2, 0
    WORD    0, YELLOW2, YELLOW2, YELLOW2, 0 
    WORD    0, YELLOW2, YELLOW2, YELLOW2, 0
    WORD    0, 0, 0, 0, 0

; TABELA DO ASTEROIDE MINERÁVEL DESTRUIDO - 2º FASE
ASTEROIDE_MINERAVEL_DESTRUIDO2:
    WORD    LARGURA_ASTEROIDE, ALTURA_ASTEROIDE
    WORD    0, 0, 0, 0, 0
    WORD    0, 0, 0, 0, 0
    WORD    0, 0, YELLOW3, 0, 0 
    WORD    0, 0, 0, 0, 0
    WORD    0, 0, 0, 0, 0



	PLACE 1200H			; coloca a tabela de definições das várias naves na posição 1200H
	
; TABELAS DOS LAYOUTS DOS LEDS NA NAVE (8 LAYOUTS)
NAVES_INFOS:
    WORD    LARGURA_NAVE, ALTURA_NAVE

NAVES_DESENHOS:
	WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, BLACK, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY,BLACK , DGREY
    WORD    DGREY, BLACK, DGREY, GREY, BLACK, PURPLE1, TURQUOISE2, YELLOW1, PURPLE1, PURPLE2, PURPLE1, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, BLACK, DGREY, GREY, YELLOW1, TURQUOISE2, PURPLE1, BLACK, PURPLE1, YELLOW1, PURPLE2, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY

    WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, BLACK, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, BLACK, DGREY, GREY, BLACK, PURPLE1, TURQUOISE2, PURPLE1, PURPLE2, YELLOW1, PURPLE2, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, PURPLE3, DGREY, GREY, PURPLE2, TURQUOISE2, BLACK, PURPLE1, YELLOW1, PURPLE2, PURPLE1, GREY, DGREY, PURPLE3, DGREY 
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY

    WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, BLACK, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, PURPLE2, DGREY, GREY, PURPLE1, TURQUOISE2, PURPLE1, PURPLE2, TURQUOISE2, YELLOW1, PURPLE1, GREY, DGREY, PURPLE2, DGREY 
    WORD    DGREY, PURPLE3, DGREY, GREY, PURPLE1, BLACK, BLACK, PURPLE1, YELLOW1, PURPLE1, PURPLE2, GREY, DGREY, PURPLE3, DGREY 
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY

    WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, PURPLE1, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE1, DGREY
    WORD    DGREY, PURPLE2, DGREY, GREY, PURPLE1, YELLOW1, PURPLE1, PURPLE2, BLACK, PURPLE1, PURPLE2, GREY, DGREY, PURPLE2, DGREY
    WORD    DGREY, PURPLE3, DGREY, GREY, TURQUOISE2, PURPLE2, BLACK, YELLOW1, TURQUOISE2, PURPLE2, PURPLE1, GREY, DGREY, PURPLE3, DGREY
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY

    WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, BLACK, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, BLACK, DGREY, GREY, PURPLE1, PURPLE2, YELLOW1, BLACK, PURPLE1, TURQUOISE2, PURPLE2, GREY, DGREY, BLACK, DGREY 
    WORD    DGREY, BLACK, DGREY, GREY, YELLOW1, TURQUOISE2, BLACK, PURPLE2, PURPLE1, PURPLE1, YELLOW1, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY

    WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, BLACK, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, BLACK, DGREY, GREY, PURPLE1, PURPLE2, PURPLE1, TURQUOISE2, BLACK, PURPLE2, YELLOW1, GREY, DGREY, BLACK, DGREY 
    WORD    DGREY, PURPLE3, DGREY, GREY, PURPLE1, BLACK, PURPLE2, PURPLE1, YELLOW1, PURPLE1, TURQUOISE2, GREY, DGREY, PURPLE3, DGREY 
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY

    WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, BLACK, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, BLACK, DGREY
    WORD    DGREY, PURPLE2, DGREY, GREY, PURPLE1, YELLOW1, PURPLE2, BLACK, BLACK, PURPLE1, PURPLE2, GREY, DGREY, PURPLE2, DGREY 
    WORD    DGREY, PURPLE3, DGREY, GREY, TURQUOISE2, TURQUOISE2, PURPLE1, YELLOW1, PURPLE1, PURPLE1, PURPLE2, GREY, DGREY, PURPLE3, DGREY
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY

    WORD    0, DGREY, 0, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, DGREY, 0, DGREY, 0
    WORD    DGREY, PURPLE1, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE1, DGREY
    WORD    DGREY, PURPLE2, DGREY, GREY, PURPLE2, TURQUOISE2, YELLOW1, BLACK, PURPLE1, TURQUOISE2, YELLOW1, GREY, DGREY, PURPLE2, DGREY
    WORD    DGREY, PURPLE3, DGREY, GREY, YELLOW1, PURPLE2, BLACK, PURPLE2, PURPLE1, PURPLE1, BLACK, GREY, DGREY, PURPLE3, DGREY 
    WORD    DGREY, PURPLE4, DGREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, GREY, DGREY, PURPLE4, DGREY
	
SONDA:
    WORD PURPLE1
	

	PLACE 2000H		 ; coloca a tabela de definições das várias naves na posição 1200H


; TABELAS PARA GUARDAR VALORES ÚTEIS À JOGABILIDADE


; GUARDA O VALOR DO DISPLAY
VALOR_DISPLAY:
	WORD DEFAULT_DISPLAY
	
; GUARDA O ESTADO O JOGO
ESTADO_JOGO:
	WORD 0
	
; GUARDA O ESTADO DO FUNDO QUANDO PAUSADO
FUNDO_PAUSADO:
	WORD 0
	
; TABELA COM AS POSIÇÕES DEFAULT DE CADA TRAJETÓRIA
TABELA_TRAJETORIAS_DEFAULT:
	WORD LINHA_INCIAL_ASTEROIDE, COLUNA_INCIAL_ASTEROIDE_ESQUERDA, 1
	WORD LINHA_INCIAL_ASTEROIDE, COLUNA_INCIAL_ASTEROIDES_MEIO, -1
	WORD LINHA_INCIAL_ASTEROIDE, COLUNA_INCIAL_ASTEROIDES_MEIO, 0
	WORD LINHA_INCIAL_ASTEROIDE, COLUNA_INCIAL_ASTEROIDES_MEIO, 1
	WORD LINHA_INCIAL_ASTEROIDE, COLUNA_INCIAL_ASTEROIDE_DIREITA, -1
	
; TABELA QUE NOS DIZ SE O ASTEROIDE ESTÁ NO ECRÃ OU NÃO
TABELA_TRAJETORIA:		; (0 = não está no ecrã, 1 = está no ecrã)
	WORD 0
	WORD 0
	WORD 0
	WORD 0
	WORD 0
	
; TABELA QUE NOS DIZ SE A SONDA ATINGIU UM ASTEROIDE OU NÃO
TABELA_SONDAS:		  ; (0 = não atingiu, 1 = atingiu)
	WORD 0
	WORD 0
	WORD 0
	
; TABELAS COM AS POSIÇÕES DAS SONDAS E DOS ASTEROIDES
TABELA_POSICOES_AST:	; (linha, coluna, tipo do asteroide, detruído ou não destruído)
	WORD 0, 0, 0, 0
	WORD 0, 0, 0, 0
	WORD 0, 0, 0, 0
	WORD 0, 0, 0, 0
	WORD 0, 0, 0, 0
	
; *********************************************************************************
; * Dados 
; *********************************************************************************
; Reserva do espaço para as pilhas dos processos
	STACK 100H			; espaço reservado para a pilha do processo "programa principal"
SP_inicial:				; este é o endereço com que o SP deste processo deve ser inicializado
							
	STACK 100H			; espaço reservado para a pilha do processo "teclado"
SP_inicial_teclado:		; este é o endereço com que o SP deste processo deve ser inicializado
							
	STACK 100H			; espaço reservado para a pilha do processo "sonda"
SP_inicial_sonda:		; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			; espaço reservado para a pilha do processo "energia"
SP_inicial_energia:		; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			; espaço reservado para a pilha do processo "nave"
SP_inicial_nave:		; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			; espaço reservado para a pilha do processo "asteroide"
SP_inicial_asteroide:	; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			; espaço reservado para a pilha do processo "colisoes"
SP_inicial_colisoes:	; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			; espaço reservado para a pilha do processo "controlo"
SP_inicial_controlo:	; este é o endereço com que o SP deste processo deve ser inicializado


; LOCK para o teclado comunicar aos restantes processos que detetou uma tecla
tecla_carregada:
	LOCK 0
	
; LOCKS para as diferentes teclas
qual_tecla:
	LOCK 0				; LOCK para a sonda da esquerda
	LOCK 0				; LOCK para a sonda do meio
	LOCK 0				; LOCK para a sonda da esquerda

; Rotinas de interrupção
tab:
	WORD rot_int_0		; rotina de atendimento da interrupção 0
	WORD rot_int_1		; rotina de atendimento da interrupção 1
	WORD rot_int_2		; rotina de atendimento da interrupção 2
	WORD rot_int_3		; rotina de atendimento da interrupção 3

; LOCKs para cada rotina de interrupção comunicar ao processo
evento_ints:
	LOCK 0				; LOCK para a rotina de interrupção 0
	LOCK 0				; LOCK para a rotina de interrupção 1
	LOCK 0				; LOCK para a rotina de interrupção 2
	LOCK 0				; LOCK para a rotina de interrupção 3
	
; VALOR A UTILIZAR PARA ACEDER AOS RESPETIVOS FUNDOS/SONS
; FUNDOS:
; 0 - COMEÇO DO JOGO
; 1 - JOGO PAUSADO
; 2 - JOGO A JOGAR
; 3 - JOGO TERMINADO
; 4 - JOGO PERDIDO POR COLISAO
; 5 - JOGO PERDIDO POR PERDA DE ENERGIA

; SONS:
; 0 - SONDA
; 1 - NAVE SEM ENERGIA
; 2 - COLISAO COM A NAVE
; 3 - ASTEROIDE NAO MINERAVEL
; 4 - ASTEROIDE MINERAVEL
; 5 - INICIO JOGO
; 6 - TERMINADO PELO UTILIZADOR

; *********************************************************************************
; * INICIALIZAÇÕES DOS OBJETOS
; *********************************************************************************

	PLACE       0	 ; coloca o programa no endereço 0 (início da EPROM)

inicializacoes:
	MOV  SP, SP_inicial			; inicializa SP para a palavra a seguir
	MOV BTE, tab				; inicializa a tabela de interrupções
    MOV [APAGA_ECRÃ], R0		; apaga o ecrã
    MOV [APAGA_AVISO], R0		; apaga o aviso
	MOV R0, 0					; registro usado para colocar o primeiro fundo
    MOV [DEFINE_FUNDO], R0		; define o fundo
	MOV R8, 0					; registro usado para colocar o display a 0
	MOV R1, DISPLAYS			; R1 toma o endereço do display
	MOV [R1], R8				; é colocado no display o valor 0
	EI0
	EI1
	EI2
	EI3
	EI
	
	CALL teclado
	CALL corpo_nave
	CALL corpo_energia

; -----------------------------------
	MOV	R9, N_ASTEROIDES; número de asteroides a usar (até N_ASTEROIDES)
loop_asteroides:
	SUB	R9, 1			; próximo asteroide
	CALL corpo_asteroide; cria uma nova instância do processo asteroide (o valor de R9 distingue-as)
						; cada processo fica com uma cópia independente dos registos
	CMP  R9, 0			; já criou as instâncias todas?
    JNZ	loop_asteroides	; se não, continua
; ------------------------------------
; ------------------------------------
	MOV	R11, N_SONDAS	; número de bonecos a usar (até N_SONDAS)
loop_sondas:
	SUB	R11, 1			; próxima sonda
	CALL corpo_sonda	; cria uma nova instância do processo sonda (o valor de R11 distingue-as)
						; Cada processo fica com uma cópia independente dos registos
	CMP  R11, 0			; já criou as instâncias todas?
    JNZ	loop_sondas		; se não, continua
; ------------------------------------
	CALL corpo_controlo
	
; *********************************************************************************
; PROCESSO PRINCIPAL
; --------------------------------------------------------------------------------
; Neste processo são feitas as respetivas ações consoante a tecla premida e o estado
; em que o jogo se encontra.
; --------------------------------------------------------------------------------
; R1 - estado atual do jogo
; R0 - tecla premida
; *********************************************************************************

; Faz a distinção das ações consoante o estado de jogo
obtem_tecla:
	MOV R0, [tecla_carregada]			; espera que uma tecla seja premida
	MOV R1, [ESTADO_JOGO]				; obtem o estado atual do jogo
	CMP R1, ESTADO_COMEÇA				; verifica se o jogo está para ser começado
	JZ verifica_comeca					; se sim, verifica se foi a tecla correta para o começo
	MOV R2, ESTADO_JOGAVEL
	CMP R1, R2							; caso o estado não seja o de começar verifica se é o estado jogável
	JZ verifica_teclas					; se for, verifica se a tecla premida executa alguma ação no Jogo
	MOV R2, ESTADO_PAUSA
	CMP R1, R2							; caso o estado não seja, nem o de começar nem o jogável verifica se é o de pausa
	JZ verifica_unpause					; se estiver pausado, verifica se a tecla premida foi a tecla pra despausar
	JMP obtem_tecla						; volta a pedir tecla
	
; Caso o estado de jogo seja o estado "começa", começa o jogo apenas se a tecla certa for premida.
verifica_comeca:
	MOV R2, TECLA_COMEÇA
	CMP R0, R2							; compara a tecla premida com a tecla para começar o jogo
	JNZ obtem_tecla						; caso não seja a tecla correta, espera a tecla correta
	MOV R2, ESTADO_JOGAVEL
	MOV [ESTADO_JOGO], R2				; caso seja, muda o estado do jogo para jogável
	MOV R2, 2							
	MOV [DEFINE_FUNDO], R2				; muda o fundo para o fundo de jogo
	MOV R10, DEFAULT_DISPLAY			
	CALL hexa_to_decimal				; converte o valor para colocar no display
	MOV [DISPLAYS], R8					; coloca o valor convertido no display
	MOV [VALOR_DISPLAY], R10			; atualiza o valor na memória
	MOV R2, 5
	MOV [TOCA_SOM], R2
	JMP obtem_tecla						; volta a pedir tecla, mas desta vez num estado jogável
	
; Caso o estado de jogo seja "jogável", verifica se a tecla premida executa alguma ação
verifica_teclas:
	MOV R2, TECLA_PAUSA
	CMP R0, R2							; verifica se a tecla clicada foi a de pausar o jogo
	JZ foi_pausado						; se sim faz as alterações necessárias
	JMP tecla_termina_jogavel			; caso não tenha sido a de pausar verificar se foi a de terminar o jogo
continua_teclas:
	JMP teclas_sondas					; caso não tenha sido verifica se foi uma das teclas para ativar as sondas
foi_pausado:
	MOV R2, ESTADO_PAUSA
	MOV [ESTADO_JOGO], R2				; se foi a tecla para pausar, muda o estado de jogo para pausado
	MOV R2, 1							; muda o fundo para o fundo de pausa
	MOV [DEFINE_FUNDO], R2					
	JMP obtem_tecla						; volta a pedir um tecla
	
; Verifica se foi premida a tecla de acabar o jogo enquanto o estado está jogável
tecla_termina_jogavel:
	MOV R2, TECLA_TERMINA
	CMP R0, R2							; compara a tecla premida com a tecla de terminar
	JNZ continua_teclas					; se não foi premida a tecla correta, continuar a verificar se a tecla premida tem algum efeito no jogo
	MOV R2, ESTADO_COMEÇA				; caso tenha sido a tecla de terminar, atribui o novo estado de jogo
	MOV [ESTADO_JOGO], R2				; muda o estado de jogo para começo
	MOV R2, 3
	MOV [DEFINE_FUNDO], R2				; define o fundo do começo
	MOV R2, DEFAULT_DISPLAY				
	MOV [VALOR_DISPLAY], R2				; reseta o valor que posteriormente vai ser mostrado no display
	MOV R2, 6
	MOV [TOCA_SOM], R2
	JMP obtem_tecla
	
; Verifica se foi premida uma tecla corresponde a uma das sondas durante o estado jogável
teclas_sondas:
	CMP R0, SOBE_SONDA_MEIO				; verifica se a tecla clicada foi a de fazer aparecer a sonda do meio
	JNZ verifica_esquerda				; se não foi, verifica se foi a tecla correta para a sonda da esquerda
	MOV [qual_tecla + 2], R0			; se for dá unlock à sonda certa
	JMP obtem_tecla						; e depois volta a pedir tecla
verifica_esquerda:					
	CMP R0, SOBE_SONDA_ESQUERDA			; verifica se a tecla clicada foi a de fazer aparecer a sonda da esquerda
	JNZ verifica_direita				; se não foi, verifica se foi a tecla correta para a sonda da direita
	MOV [qual_tecla], R0				; se for dá unlock à sonda certa
	JMP obtem_tecla						; e depois volta a pedir tecla
verifica_direita:
	CMP R0, SOBE_SONDA_DIREITA			; verifica se a tecla clicada foi a de fazer aparecer a sonda da direita
	JNZ obtem_tecla						; se não foi nenhuma das teclas da sonda verifica se foi a tecla para dar pause
	MOV [qual_tecla + 4], R0			; se for a tecla certa dá unlock à sonda correta
	JMP obtem_tecla						; e depois volta a pedir uma nova tecla
	
; Caso o jogo esteja pausado, verifica se a tecla premida é a tecla que dá unpause ao jogo
verifica_unpause:
	MOV R2, TECLA_PAUSA
	CMP R0, R2							; verifica se a tecla premida foi a tecla para fazer o jogo voltar ao estado jogável
	JNZ tecla_termina_pausado			; caso não seja verifica se foi premida a tecla para terminar o jogo
	MOV R2, ESTADO_JOGAVEL				
	MOV [ESTADO_JOGO], R2				; caso seja, muda o estado para jogável
	MOV R2, 2
	MOV [DEFINE_FUNDO], R2				; muda o fundo para o fundo de jogo
	MOV R2, 0
	MOV [FUNDO_PAUSADO], R2				; reseta a flag do fundo pausado
	JMP obtem_tecla						; e em seguida pede nova tecla
	
; Caso o jogo esteja pausado, verifica se a tecla premida foi a tecla que faz o jogo acabar
tecla_termina_pausado:
	MOV R2, TECLA_TERMINA
	CMP R0, R2							; caso a tecla premida não tenha sido a tecla de terminar o jogo, volta a pedir uma nova tecla
	JNZ obtem_tecla						; pede nova tecla
	MOV R2, ESTADO_COMEÇA
	MOV [ESTADO_JOGO], R2				; caso tenha sido premida a tecla de terminar o jogo, muda o estado de jogo
	MOV R2, 0							
	MOV [DEFINE_FUNDO], R2				; define o fundo do começo
	MOV R2, DEFAULT_DISPLAY
	MOV [VALOR_DISPLAY], R2				; reseta o valor do display guardada na memória
	MOV R2, 6
	MOV [TOCA_SOM], R2
	JMP obtem_tecla

; *********************************************************************************
; PROCESSO controlo
; --------------------------------------------------------------------------------
; Neste processo são feitas as atualizações necessárias consoante a mudança de
; estado.
; --------------------------------------------------------------------------------
; R0 - estado do Jogo
; *********************************************************************************
PROCESS SP_inicial_controlo

; Verifica o estado do jogo e executa uma ação consoante esse estado
corpo_controlo:
	YIELD								; compasso de espera
	MOV R0, [ESTADO_JOGO]				; obtém o estado do jogo
	CMP R0, ESTADO_COMEÇA				; verifica se é o estado para começar o jogo
	JZ corpo_controlo					; se sim, volta ao inicio e espera pela tecla para começar
	CMP R0, ESTADO_JOGAVEL				; verifica se o estado está jogável
	JZ corpo_controlo					; se sim, volta ao inicio e continua o funcionamento do jogo
	CMP R0, ESTADO_PAUSA				; verifica se o estado é o de pausa
	JZ chama_verifica_fundo				; se sim, chama a função para verificar se o fundo é o de pausa

	CMP R0, ESTADO_TERMINADO			; verifica se o jogo foi terminado
	JZ jogo_terminado					; se sim, chama a função para acabar o jogo, se não, verifica se e como o jogo foi perdido
	CMP R0, ESTADO_PERDIDO_COLISAO		; verifica se o jogo foi perdido por colisão
	JZ jogo_perdido_colisao				; chama a função para definir o fundo e acabar o jogo
	CMP R0, ESTADO_PERDIDO_ENERGIA		; verifica se o jogo foi perdido por energia
	JZ jogo_perdido_energia				; chama a função para definir o fundo e acabar o jogo

; Consoante a forma como o jogo foi perdido/terminado atribui um som e um fundo diferente
jogo_terminado:
	MOV R1, 3							; muda o registo para o fundo de jogo terminado
	JMP fim_jogo
jogo_perdido_colisao:
	MOV R10, 2
	MOV R1, 4							; muda o registo para o fundo de jogo perdido por colisão
	JMP fim_jogo					
jogo_perdido_energia:
	MOV R10, 1
	MOV R1, 5							; muda o registo para o fundo de jogo perdido por energia
	JMP fim_jogo					

; Coloca o som, fundo e atualiza o display da energia quando o jogo é terminado/perdido
fim_jogo:
	MOV [TOCA_SOM], R10
	MOV [DEFINE_FUNDO], R1				; muda para o fundo correto (determinado previamente)
	MOV R1, [evento_ints + 4]			; compasso de espera
	MOV R1, 0							; registo para dar reset ao display
	MOV [DISPLAYS], R1					; reseta o display para 0
	MOV R2, ESTADO_COMEÇA				; registo com o próximo estado do jogo
	MOV [ESTADO_JOGO], R2				; define o modo de jogo para o modo começo
	MOV [APAGA_ECRÃ], R2				; apaga o ecrã
	JMP corpo_controlo					; volta para o corpo_controlo

chama_verifica_fundo:
	CALL verifica_fundo					; chama a rotina para verificar se o fundo já foi colocado
	JMP corpo_controlo					; volta para o corpo_controlo

; Verifica se o fundo de jogo "pausado" já foi colocado
verifica_fundo:
	PUSH R0
	PUSH R2
	MOV R2, [FUNDO_PAUSADO]				; obtém o estado do fundo pausado
	CMP R2, FLAG_1						; se estiver a 1 é porque o fundo já foi colocado, não tem de o recolocar
	JZ saida_fundo						
	MOV R1, 1							; registo para alterar o fundo
	MOV [DEFINE_FUNDO], R1				; caso o fundo ainda não tenha sido colocado atribui o fundo da pausa
	MOV R2, FLAG_1
	MOV [FUNDO_PAUSADO], R2				; muda a flag para fundo colocado
saida_fundo:
	POP R2
	POP R0
	RET

; *********************************************************************************
; PROCESSO teclado
; --------------------------------------------------------------------------------
; Neste processo são detetadas as teclas premidas fazendo com que o processo 
; principal consiga fazer a distinção das ações.
; --------------------------------------------------------------------------------
; R6 - contém a linha que está a ser testada
; *********************************************************************************
PROCESS SP_inicial_teclado

teclado:
	MOV R2, TEC_LIN				; endereço do periférico das linhas
	MOV R3, TEC_COL				; endereço do periférico das colunas
	MOV R5, MASCARA
	MOV	R6, LINHA 				; linha inicial
	
; Muda a linha
mudar_linha:
	CMP R6, 1		   			; vai verificar se já está a um
	JZ reiniciar_linha			; Se for true, ou seja, se o valor tiver a 1, reinicia no reiniciar_linha
	SHR R6, 1					; Caso não esteja a um, continua a diminuir
	JMP espera_tecla			; Vai para o espera_tecla
	
; Caso tenha chegado à última linha, volta a colocá-la no seu valor inicial
reiniciar_linha:
	MOV R6, LINHA		    	; "reinicia" o valor de R6 que atualmente contem a linha, para o valor 8
	JMP espera_tecla

; Neste ciclo espera-se até uma tecla ser premida
espera_tecla:
	WAIT
	MOVB [R2], R6				; escrever no periférico de saída (linhas)
	MOVB R0, [R3]				; ler do periférico de entrada (colunas)
	AND  R0, R5					; elimina bits para além dos bits 0-3
	CMP  R0, 0					; há tecla premida?
	JZ   mudar_linha			; se nenhuma tecla premida, repete	
	CALL obtem_valor			; caso uma tecla tenha sido premida, obtém o valor exato da tecla premida
	MOV	[tecla_carregada], R0	; informa quem estiver bloqueado neste LOCK que uma tecla foi carregada
								; (o valor escrito é a tecla exata que foi premida)
; Neste ciclo espera-se até NENHUMA tecla estar premida
ha_tecla:
	YIELD
    MOVB [R2], R6				; escrever no periférico de saída (linhas)
    MOVB R0, [R3]				; ler do periférico de entrada (colunas)
	AND  R0, R5					; elimina bits para além dos bits 0-3
    CMP  R0, 0					; há tecla premida?
    JNZ  ha_tecla				; se ainda houver uma tecla premida, espera até não haver
	JMP	espera_tecla
	
; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO TECLADO:
; (geral)
; --------------------------------------------------------------------------------

; Obtém o valor exato da tecla premida
; R0 - valor exato da tecla premida
obtem_valor:
	PUSH R6
	PUSH R5
	PUSH R1
	MOV R5, 0						; contador usado para converter os valores
	MOV R1, R6						; atribui a R1 o valor da linha
	CALL converte_valores			; converte o valor da linha para numeros de 0-3
	MOV R6, R5						; R6 vai mantendo o resultado
	SHL R6, 2						; multiplica por 4
	MOV R5, 0						; reseta o contador R5				
	MOV R1, R0						; atribui a R1 o valor da coluna
	CALL converte_valores			; obtém o valor da coluna para numeros de 0-3
	ADD R6, R5						; faz a adição do valor da coluna ao resultado obtido previamente
	MOV R0, R6						; R0 vai sair com o valor correto da tecla premida
	POP R1
	POP R5
	POP R6
	RET
	
; Converte os da linhas e das colunas para valores de 0 a 3
; R1 - valor a converter
converte_valores:
	SHR R1, 1
	CMP R1, 0
	JZ saida_teclado
	ADD R5, 1
	JMP converte_valores
saida_teclado:
	RET
	
; *********************************************************************************	
; PROCESSO energia
; --------------------------------------------------------------------------------
; Neste processo é tratada a perda de energia ao longo do tempo (3 em 3 segundos).
;--------------------------------------------------------------------------------
; *********************************************************************************
PROCESS SP_inicial_energia

corpo_energia:
	MOV R1, evento_ints
	MOV R0, [R1+4]				; dá lock até a interrupção dar UNLOCK
	
	MOV R0, [ESTADO_JOGO]
	CMP R0, ESTADO_JOGAVEL		; verifica se o estado de jogo está no estado jogável
	JNZ corpo_energia			; caso não esteja não decresce a energia, volta ao corpo_energia
	
	MOV R10, [VALOR_DISPLAY]	; R0 toma o valor que está no display
	SUB R10, ENERGIA_TEMPO		; é subtraido o valor a perder pela passagem do tempo
	CALL hexa_to_decimal		; conversão do valor obtido para decimal
	CMP R10, 0					; faz a comparação do valor no display com 0
	JLE jogo_perdido			; caso o valor do display seja menor o jogo foi perdido e executa os comandos para o jogo perdido
	MOV R0, DISPLAYS			; caso contrário atualiza o display onde R0 toma o seu endereço
	MOV [R0], R8				; é escrito no display o valor da conversão
	MOV R0, VALOR_DISPLAY		; R0 toma o valor da tabela que guarda o valor do display
	MOV [R0], R10				; é guardado o novo valor na tabela
	JMP corpo_energia
jogo_perdido:
	MOV R2, ESTADO_PERDIDO_ENERGIA
	MOV [ESTADO_JOGO], R2		; altera o estado de jogo para perdido
	JMP corpo_energia
	
; *********************************************************************************	
; PROCESSO asteroides
; --------------------------------------------------------------------------------
; Neste processo são tratadas as atribuições dos tipos de asteroides, trajetórias,
; colisões com a nave e deteções de colisões com as sondas.
; --------------------------------------------------------------------------------
; R10 - contém a linha do asteroide
; R11 - contém a coluna do asteroide
; R6 - incremento na coluna de cada asteroide
; R2 - contém a identificação de qual o asteroide
; R0 - contém o incremento necessário ao endereço da tabela das flags dos ASTEROIDES
; (usado muitas vezes multiplicado por 3x, 4x para conseguir o incremento certo
; para aceder aos dados do mesmo indice noutra tabela)
; *********************************************************************************
PROCESS SP_inicial_asteroide

corpo_asteroide:
; Verifica se o jogo está no estado jogável
	YIELD
	MOV R5, [ESTADO_JOGO]			; obtém o estado de jogo
	MOV R7, ESTADO_JOGAVEL
	CMP R5, R7						; compara com o estado jogável
	JNZ corpo_asteroide				; se não for o estado jogável, volta para o inicio
	
; Estando no estado correto, atribui as caracteristicas ao asteroide
	CALL tipo_asteroide				; atribui o tipo de asteroide
	CALL numero_aleatorio			; gera um número aleatório de 0 a 4
	CALL atribui_infos				; atribui o incremento, linha inicial e coluna inicial do asteroide
	CALL desenha_asteroide			; desenha o asteroide
	CALL atualiza_posicoes_ast		; atualiza as posições dos asteroides na tabela das posições
	CALL flag_colisao_atualizada	; coloca as flags de colisão do asteroide para 0
	
; Verifica novamente se o jogo está jogável (como tem um ciclo no vai_desenhando é necessário fazer essa verificação dentro do ciclo)
vai_desenhando:
	MOV R7, [evento_ints + 0]
	
	MOV R5, [ESTADO_JOGO]			; obtém o estado de jogo
	MOV R7, ESTADO_JOGAVEL			
	CMP R5, R7						; verifica se ainda está jogável
	JZ continua_desenho				; se estiver jogável continua o jogo
	MOV R7, ESTADO_PAUSA			; caso contrário verifica se está em pausa
	CMP R5, R7						
	JZ vai_desenhando				; se estiver em pausa volta para um ponto onde não reseta mas fica à espera que estado de jogo mude
	MOV R7, ESTADO_COMEÇA			; verifica se o estado de jogo está no começa que requer que a tecla de começo seja premida
	CMP R5, R7
	JZ reset_geral_ast				; se estiver no estado começa, dar reset ao estados dos asteroides
	MOV R7, ESTADO_TERMINADO		
	CMP R5, R7						; verifica também se está no estado terminado
	JZ reset_geral_ast				; caso esteja faz também o reset das flags
	MOV R7, ESTADO_PERDIDO_ENERGIA 	
	CMP R5, R7						; verifica também se está no estado perdido por falta de energia
	JZ reset_geral_ast				; caso esteja faz também o reset das flags
	MOV R7, ESTADO_PERDIDO_COLISAO	
	CMP R5, R7						; verifica se está no estado perdido por colisão com a nave
	JZ reset_geral_ast				; caso esteja faz o reset das flags

; Estando no estado correto, faz o movimento do asteroide
continua_desenho:
	JMP verifica_aingiu_nave		; verifica se o asteroide atingiu a nave
nao_atingiu_nave:
	JMP verifica_se_atingido		; verifica se o asteroide foi atingido
nao_atingido:
	CALL apaga_asteroide			; apaga o asteroide
	CALL desce_asteroide			; desce o asteroide (utiliza o incremento)
	CALL desenha_asteroide			; desenha o asteroide nas novas "coordenadas"
	CALL atualiza_posicoes_ast		; atualiza as posições dos asteroides na tabela das posições
	
; Verifica se chegou ao limite
verifica_asteroide:					; verifica se o asteroide chegou ao fim
	MOV R4, FIM_ASTEROIDE			; R4 toma o valor da ultima linha a que o asteroide pode chegar
	CMP R4, R10						; compara o valor da ultima linha com a linha atual do asteroide
	JNZ vai_desenhando				; se não estiver na ultima linha, continua a redesenhá-lo
	CALL apaga_asteroide			; caso contrário apaga o asteróide						;
	MOV R4, TABELA_TRAJETORIA		; obtém o endereço da tabela de flags dos asteroides
	ADD R4, R0						; adiciona o incremento para ter o indice correto
	MOV R5, FLAG_0					
	MOV [R4], R5					; colocar a flag a 0, ou seja, o asteroide desapareceu do ecrã
	JMP corpo_asteroide
	
; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO DOS ASTEROIDES
; (relacionadas com as colisões)
; --------------------------------------------------------------------------------

; Faz as comparações necessárias para ver se o asteroide colidiu com a nave
; R3 - Linha que a parte superior do asteroide não pode chegar
; R4 - Coluna comparação da esquerda da nave
; R5 - Coluna comparação da direita da nave
verifica_aingiu_nave:
	MOV R3, LINHA_COLISAO_NAVE		; linha a que o pixel de referência do asteroide não pode chegar
	MOV R4, COLUNA_ESQUERDA_NAVE	; coluna comparação da esquerda da nave
	MOV R5, COLUNA_DIREITA_NAVE		; coluna comparação da direita da nave
	CMP R3, R10						; compara a coluna do asteroide com a coluna da nave
	JNZ nao_atingiu_nave			; se não for a mesma, não atingiu
	CMP R11, R4						; compara a coluna da esquerda da nave com a coluna da sonda
	JLT nao_atingiu_nave			; caso seja menor, não atingiu
	CMP R11, R5						; compara a coluna da direita da nave com coluna da sonda
	JGT nao_atingiu_nave			; caso seja maior, não atingiu
	MOV R3, ESTADO_PERDIDO_COLISAO	; caso tenha passado por todas as restrições, atingiu
	MOV [ESTADO_JOGO], R3			; muda o estado de jogo para perdido por colisão
	MOV [APAGA_ECRÃ], R3			; apaga tudo o que está no escrã
	JMP corpo_asteroide
	
	
; Atualiza as flags de colisão do asteroide para sem colisão
; R0 - indice na tabela das flags dos asteroides
flag_colisao_atualizada:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, TABELA_POSICOES_AST		; R1 tem o endereço da tabela das posições
	MOV R2, 4						; valor pelo qual vai ser multiplicado para obter o incremento correto
	MUL R0, R2	
	ADD R1, R0						; R1 tem agora o endereço no indice correto da tabela das posições
	ADD R1, 6						; Incremento correto para aceder ao endereço correspondente à flag de colisão
	MOV R4, 0						; Valor a colocar na tabela das posições
	MOV [R1], R4					; mete a flag a 0
	POP R4
	POP R2
	POP R1
	POP R0
	RET
	
; Apaga o ecrã e reseta a tabela das flags dos asteroides
reset_geral_ast:
	MOV R5, 0
	MOV [APAGA_ECRÃ], R5		; apaga o ecrã
	CALL reset_trajetorias		; reseta as flags das trajetórias dos asteroides
	JMP corpo_asteroide
	
	
; Reseta as flags das trajetórias dos asteroides
; R1 - registro que serve de "indice" na tabela das trajetórias
; R0 - "indice" comparação (valor máx)
reset_trajetorias:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R3, FLAG_0					; R3 obtém o valor da FLAG_0
	MOV R0, MAX_ENDE_AST			; valor máximo a que R1 pode chegar
	MOV R1, -2						; atribui o valor -2 a R1 (-2 para quando entrar no ciclo começar a 0)
	MOV R2, TABELA_TRAJETORIA		; R2 obtém o endereço da tabela das flags dos asteroides
continua:
	CMP R1, R0						; compara o indice comparação com o indice atual
	JZ resetado						; caso sejam iguais, retorna
	ADD R1, 2						; caso contrário incrementa
	MOV R2, TABELA_TRAJETORIA
	ADD R2, R1
	MOV [R2], R3					; e depois reseta o valor no indice correto
	JMP continua
resetado:
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
	
; Verifica se o asteroide foi atingido (se o quarto valor da tabela num dos indices estiver
; a 1, colidiu). NOTA: é necessário que não seja uma rotina para que, caso o jogo acabe,
; consigamos dar JMP para o inicio do processo
verifica_se_atingido:
	MOV R4, TABELA_POSICOES_AST		; R4 obtém o valor da tabela das posições dos asteroides
	MOV R5, 4						; valor a multiplicar para a "conversão" do indice correto para a tabela das posições
	MOV R7, R0						; transfere o valor de R0 ("indíce" na tabela das flags) para R7, de forma a não alterar R0
	MUL R7, R5						; faz a multiplicação
	ADD R4, R7						; adiciona o valor para obter o "indice" correto
	ADD R4, 6						; adiciona 6 para coneguir o quarto valor nesse indice
	MOV R5, [R4]					; obtém o valor guardado nesse endereço
	MOV R7, FLAG_1					; valor comparação
	CMP R5, R7						; compara o valor com a flag_1
	JNZ nao_atingido				; se não forem iguais, significa que o asteroide não foi atingido
	CALL apaga_asteroide			; caso tenha sido atingido, apaga o asteroide
	CALL flag_colisao_atualizada	; atualiza a flag de volta para zero
	CALL atualiza_estado_ast		; atualiza a flag a zero na tabela das trajetórias
	CALL energia_e_animacao			; faz as animações e os incrementos de energia necessários
	JMP corpo_asteroide
	
; Atualiza o estado do asteroide na tabela das trajetórias dos asteroides
; R0 - "indice" na tabela das trajetórias dos asteroides
atualiza_estado_ast:
	PUSH R0
	PUSH R1
	PUSH R2
	MOV R1, TABELA_TRAJETORIA		; obtém o endereço da tabela dos asteroides
	ADD R1, R0						; R1 toma o valor correto do endereço da flag desse asteroide
	MOV R2, FLAG_0					; flag a ser atribuida, 0 (asteroide desapareceu pois foi destruido)
	MOV [R1], R2					; altera o valor na tabela em si
	POP R2
	POP R1
	POP R0
	RET

; Faz as animações respetivas e os incrementos respetivo se necessários
; R2 - contém a identificação do tipo de asteroide
energia_e_animacao:	
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R8
    PUSH R10
	PUSH R4
	PUSH R5
	PUSH R7
	MOV R4, ASTEROIDE_MINERAVEL		; R4 toma o valor do asteroide mineravel
    CMP R2, R4						; faz a comparação com o asteroide que foi destruido
    JNZ animacao_nao_min			; caso não seja minerável, foi não minerável
animacao_min_e_energia:				; caso contrário faz as animações do asteroide minerável e incrementa a energia
    MOV R1, GANHA_ENERGIA			; valor a incrementar na energia
    MOV R3, [VALOR_DISPLAY]			; obtém o valor atual da energia
    ADD R3, R1						; adiciona a energia obtida
    MOV [VALOR_DISPLAY], R3			; guarda na memória o novo valor
	MOV R5, R10						; faz uma cópia da linha do asteroide em R10 (R10 é o registro utilizado para converter os números na função hexa_to_decimal)
    MOV R10, R3						; R10 toma o valor a converter
    CALL hexa_to_decimal			; converte o valor
    MOV [DISPLAYS], R8				; é colocado o resultado no display (R8 tem o resultado)
	MOV R10, R5						; volta a colocar o valor da linha do asteroide em R10
	MOV R2, 4						; valor para colocar o som correto
	MOV [TOCA_SOM], R2				; toca o soma do asteroide minerável destruido
    MOV R2, ASTEROIDE_MINERAVEL_DESTRUIDO1
    CALL desenha_asteroide			; desenha o primeiro fram do asteroide minerável destruído
	CALL ciclo_atraso				; ciclo de atraso para fazer com que a animação dure mais tempo e seja visivel
	MOV R2, ASTEROIDE_MINERAVEL_DESTRUIDO2
	CALL desenha_asteroide			; desenha o segundo frame do asteroide minerável destruido
	CALL ciclo_atraso				; ciclo de atraso para fazer com que a animação dure mais tempo e seja visivel
    CALL apaga_asteroide			; apaga o último frame
    JMP fim_energia_e_animacao		; após fazer as animações e adicionar o incremento na energia retorna
animacao_nao_min:					; caso o asteroide seja não minerável
	MOV R2, 3						; valor para o som do asteroide não minerável destruido
	MOV [TOCA_SOM], R2				; toca o som
    MOV R2, ASTEROIDE_NAO_MINERAVEL_DESTRUIDO
    CALL desenha_asteroide			; desenha o o frame do asteroide não minerável destruido
	CALL ciclo_atraso				; ciclo de atraso para fazer com que a animação dure mais tempo e seja visivel
    CALL apaga_asteroide			; apaga o último frame
fim_energia_e_animacao:				; faz os pops e retorna
	POP R7
	POP R5
	POP R4
    POP R10
    POP R8
    POP R3
    POP R2
    POP R1
    POP R0
    RET

; Ciclo de atraso para que as "animações" sejam visíveis
ciclo_atraso:
    PUSH R0
    PUSH R1
    MOV R0, 0
    MOV R1, ATRASO		; R1 obtém o valor do atraso
ciclo:
    SUB R1, 1			; subtrai um
    CMP R1, R0			; já chegou ao fim?
    JNZ ciclo			; se não volta a fazer o ciclo
saida_atraso:			; caso tenha chegado ao fim, faz os pops e retorna
    POP R1
    POP R0
    RET

; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO DOS ASTEROIDES
; (funções úteis ao processo)
; --------------------------------------------------------------------------------

; Atribui o tipo de asteroide, este fica guardado em R2
tipo_asteroide:
	CALL numero_aleatorio		; retorna em R0 um número aleatório entre 0 e 4
	CMP R0, 0					; compara o valor com o 0 (25%)
	JNZ nao_mineravel			; se o número for o 0 é minerável, caso contrário é não minerável
	MOV R2, ASTEROIDE_MINERAVEL ; atribuição do tipo minerável 
	JMP saida_tipo_ast			; após a atribuição sai da rotina		
nao_mineravel:
	MOV R2, ASTEROIDE_NAO_MINERAVEL	; faz a atribuição do tipo não minerável
saida_tipo_ast:
	RET

; Retorna em R0 um número de 0 a 4
numero_aleatorio:
	PUSH R1
	PUSH R2
	PUSH R3
	MOV  R2, TEC_LIN    ; endereço do periférico das linhas
    MOV  R3, TEC_COL    ; endereço do periférico das colunas
	MOV  R1, LINHA      ; testar a linha
    MOVB [R2], R1       ; escrever no periférico de saída (linhas)
    MOVB R0, [R3]       ; ler do periférico de entrada (colunas)
	SHR R0, 4			; R0 passa a conter um número de 0 a 15
	MOV R1, 5
	MOD R0, R1			; Faz o resto da divisão por 5
	POP R3
	POP R2
	POP R1
	RET
	
; Atribui as informações de cada asteroide de acordo com os espaços livres possiveis
; R10 - linha do asteroide, R11 - coluna do asteroide, R6 - incremento nas colunas
atribui_infos:
	PUSH R5
	PUSH R4
	PUSH R7
	MOV R7, R0
	SHL R7, 1						; duplica o valor para poder ser utilizado como salto nas tabelas
	MOV R4, TABELA_TRAJETORIA		; R4 toma o endereço inicial da tabela
	ADD R4, R7						; R4 toma o valor do endereço na tabela correspondente ao indice R0
	MOV R5, [R4]					; obtém o valor nesse endereço (1 ou 0)
	CMP R5, FLAG_1					; compara valor com a flag (1 = ocupado, 0 = vazio)
	JNZ posso_atribuir				; se não for = 1 então está vazio, posso atribuir
	CALL escolhe_prox_livre			; caso contrário resolve a "colisão" por procura linear
posso_atribuir:
	MOV R5, FLAG_1					; atribui o valor da FLAG_1 (ocupado) a R5
	MOV [R4], R5					; muda o valor da flag no endereço corresponde ao indice R0 da tabela de flags
	CALL atribui_coords				; tendo já o indice correto, atribui os valores da tabela das trajetórias ao asteroide
	MOV R0, R7
	POP R7
	POP R4
	POP R5
	RET
	
; Função que atribui as informações já da trajetória correta (livre)
atribui_coords:	
	PUSH R1
	PUSH R4
	PUSH R7
	MOV R1, 3
	MUL R7, R1									; multiplica por 3 para conseguir o incremento certo para aceder ao endereço correspondente
												; ao indice correto na tabela
	MOV R4, TABELA_TRAJETORIAS_DEFAULT			; endereço da tabela das trajetórias
	ADD R4, R7									; obtém o endereço corresponde ao indice correto
	MOV R5, [R4]								; R5 toma o primeiro valor da tabela no indice certo (linha inicial)
	MOV R10, R5									; atribui o valor da linha a R10
	ADD R4, 2									; proximo endereço
	MOV R5, [R4]								; R5 toma o segundo valor da tabela no indice certo (coluna inicial)
	MOV R11, R5									; atribui o valor da coluna
	ADD R4, 2									; proximo endereço
	MOV R5, [R4]								; R5 toma o terceiro valor da tabela no indice certo (incremento das colunas)
	MOV R6,	R5									; atribui o valor do incremento das colunas
	POP R7
	POP R4
	POP R1
	RET
	
; Retorna uma posição livre da tabela das flags
; R7 - obtém o "indice" correto
escolhe_prox_livre:
	CALL verifica_limite						; verifica se o valor já é 8	
	ADD R7, 2									; faz o incremento para o próximo indice
	MOV R4, TABELA_TRAJETORIA					; obtém o endereço da tabela de trajetórias
	ADD R4, R7									; obtém o endereço correto correspondente ao indice certo
	MOV R5, [R4]								; obtém o valor nesse indice
	CMP R5, FLAG_1								; compara o valor com a FLAG_1 (ocupado)
	JZ escolhe_prox_livre						; se não tiver livre, passar pro proximo endereço, repetindo o algoritmo
	RET
	
; Verifica se chegou ao limite da tabela, para poder ser resetado
verifica_limite:
	PUSH R8
	MOV R8, MAX_ENDE_AST		; valor comparação (8)
	CMP R7, R8					; verifica se já chegou ao fim
	JNZ saida_verifica_limite	; caso não tenha chegado, continua
	MOV R7, -2					; tem de ser colocado a -2 para que depois da adição R0, fique a 0
saida_verifica_limite:
	POP R8
	RET

; Altera os valores na tabela de posições dos asteroides
; R0 - "indice" na tabela das flags dos asteroides (2 em 2)
; R10 - linha do asteroide, R11 - coluna do asteroide, R6 - incremento nas colunas
atualiza_posicoes_ast:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R1, TABELA_POSICOES_AST		; R1 toma o endereço da tabela
	MOV R3, 4						; valor a multiplicar para obter o incremento correto
	MUL R0, R3						; obtém o incremento correto para o obter o indice correto na tabela das posições
	ADD R1, R0						; obtém o endereço correto
	MOV [R1], R10					; atualiza o valor da linha
	ADD R1, 2						; próximo endereço
	MOV [R1], R11					; atualiza o valor da coluna
	ADD R1, 2						; próximo endereço
	MOV [R1], R2					; atualiza o tipo do asteroide
	ADD R1, 2						; próximo endereço
	MOV R3, 0
	MOV [R1], R3					; reseta o flag de colisão
	POP R3
	POP R2
	POP R1
	POP R0
	RET

; Faz os incrementos necessários às coordenadas dos asteroides
desce_asteroide:
	ADD R11, R6
	ADD R10, 1
	RET
	
; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO DOS ASTEROIDES
; (apaga asteroide)

;	R2 - utilizado para conseguir a posição relativa dos itens da tabela
;		 correspondente ao asteroide
;	R3 - valor da largura do asteroide
;	R4 - valor da altura do asteroide
;	R10 - corresponde à linha do asteroide
;	R11 - corresponde à coluna do asteroide
; --------------------------------------------------------------------------------

; Apaga o asteroide
apaga_asteroide:
	PUSH R11
	PUSH R10
	PUSH R2
	PUSH R0
	CALL info_apaga_asteroide			; atribui as informações necessárias para o começo da rotina
	POP R0
	POP R2
	POP R10
	POP R11
	RET
	
; Atribui as informações necessárias
info_apaga_asteroide:
    MOV R3, [R2]    					; obtem largura do asteroide
    ADD R2, PROXIMO_ENDEREÇO			; avança uma Word na definição do asteroide
    MOV R4, [R2]    					; obtem altura do asteroide
    ADD R2, PROXIMO_ENDEREÇO			; obtem informação para a primeira cor do pixel do asteroide
	CALL verifica_apagado				; apaga asteroide
	RET
	
; Verifica se o asteroide já foi todo apagado
verifica_apagado:
    CMP R4, 0                 			; verificar se se apagou todo o asteroide
    JZ saida_asteroide					; se o asteroide foi apagado retorna para o passo seguinte
    JMP apaga_linha_asteroide    		; se ainda falta apagar, apaga próxima linha

; Apaga a próxima linha do asteroide
apaga_proxima_linha_asteroide:
    ADD R10, 1       					; proxima linha
    SUB R11, LARGURA_ASTEROIDE   		; reinicia coluna
    SUB R4, 1       					; decrementa linha (valor comparação para o fim)
    MOV R3, LARGURA_ASTEROIDE			; reinicia largura
    JMP verifica_apagado

; Apaga a linha do asteroide
apaga_linha_asteroide:
    CMP R3, 0   						; verifica se a linha foi toda apagada
    JZ apaga_proxima_linha_asteroide  	; se sim, passa para proxima linha
    MOV R5, 0       					; determina pixel transparente
    MOV [DEFINE_LINHA], R10  			; determina linha
    MOV [DEFINE_COLUNA], R11			; determina coluna
    MOV [DEFINE_PIXEL], R5  			; apaga pixel
    ADD R11, 1   						; avança uma coluna
    SUB R3, 1   						; decrementa largura
    JMP apaga_linha_asteroide			; apaga proxima linha
	
saida_asteroide:
	RET

; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO DOS ASTEROIDES
; (desenha asteroide)

;	R2 - utilizado para conseguir a posição relativa dos itens da tabela
;		 correspondente ao asteroide
;	R3 - valor da largura do asteroide
;	R4 - valor da altura do asteroide
;	R10 - corresponde à linha do asteroide
;	R11 - corresponde à coluna do asteroide
; --------------------------------------------------------------------------------
	
; Desenha o asteroide
desenha_asteroide:
	PUSH R11
	PUSH R10
	PUSH R2
	PUSH R0
	CALL info_desenha_asteroide			; atribui as informações necessárias para o começo da rotina
	POP R0
	POP R2
	POP R10
	POP R11
	RET
	
; Atribui as informações necessárias
info_desenha_asteroide:
    MOV R3, [R2]    					; obtem largura do asteroide
    ADD R2, PROXIMO_ENDEREÇO			; avança uma Word na definição do asteroide
    MOV R4, [R2]    					; obtem altura do asteroide
    ADD R2, PROXIMO_ENDEREÇO			; obtem informação para a primeira cor do pixel do asteroide
	CALL verifica_desenhado				; desenha asteroide depois de apagado
	RET

; Verifica se o asteroide já foi desenhado
verifica_desenhado:
    CMP R4, 0           	   	    	; verificar se o asteroide ja foi todo desenhado
    JZ saida_asteroide                	; se asteroide completo, retorna para o próximo passo
    JMP desenha_linha_asteroide    		; desenha linha asteroide

; Incrementa nos valores necessários
proxima_linha_asteroide:
    ADD R10, 1   						; proxima linha
    SUB R11, LARGURA_ASTEROIDE 			; reinicia coluna
    SUB R4, 1   						; decrementa linha (valor comparação para o fim)
    MOV R3, LARGURA_ASTEROIDE			; reinicia largura
    JMP verifica_desenhado	

; Desenha a linha do asteroide
desenha_linha_asteroide:
    CMP R3, 0   						; verifica se a linha ja foi toda desenhada
    JZ proxima_linha_asteroide  		; se sim, passa para proxima linha
    MOV R5, [R2]    					; obtem cor do pixel
    MOV [DEFINE_LINHA], R10 			; determina linha
    MOV [DEFINE_COLUNA], R11			; determina coluna
    MOV [DEFINE_PIXEL], R5  			; pinta pixel
    ADD R2, PROXIMO_ENDEREÇO  			; proxima cor de pixel
    ADD R11, 1   						; proxima coluna
    SUB R3, 1   						; decrementa largura
    JMP desenha_linha_asteroide
	
	
; *********************************************************************************	
; PROCESSO sonda
; --------------------------------------------------------------------------------
; Neste processo são tratadas as atribuições das trajetórias das sondas
; correspondentes a cada tecla e verificadas as colisões com os asteroides
; --------------------------------------------------------------------------------
; R11 - Identificador de 0 a 2 que distingue as sondas
; R0 - Contém a linha da sonda
; R1 - Contém a coluna da sonda
; R3 - Incremento na coluna de cada sonda 
; R9 - Indíce na tabela das flags das sondas
; *********************************************************************************
PROCESS SP_inicial_sonda
	
	
corpo_sonda:
; Verifica se o jogo está no estado jogável
	YIELD
	MOV R5, [ESTADO_JOGO]			; obtém o estado de jogo
	MOV R7, ESTADO_JOGAVEL
	CMP R5, R7						; compara com o estado jogável
	JNZ corpo_sonda					; se não for o estado jogável, volta para o inicio
	
; Se estiver no estado certo, continua
	MOV R3, R11							; astribui o valor de R11 a R3
	SHL R3, 1							; multiplica o valor por 2
	MOV R4, qual_tecla					; atribui o endereço dos locks em "qual_tecla"
	ADD R4, R3							; soma os registros para obter valores espaçados em 2 (salto de endereço para endereço)
	MOV R1, [R4]						; lock próprio para cada sonda
	MOV R10, 0
	MOV [TOCA_SOM], R10
	CALL diminui_energia_tiro			; faz a diminuição da energia corresponde ao disparo
	CALL verifica_energia_perdida		; verifica se a energia chegou a zero após o disparo
	CALL atribui_posicaoEincremento_s	; atribui as posicoes inicias e o incremento na coluna de cada sonda
	CALL desenha_sonda					; desenha a sonda
	CALL flag_sonda_ativa				; coloca a 0 a flag da sonda, ou seja, não colidiu

; Verifica novamente se o jogo está jogável (como tem um ciclo no sonda_existe é necessário fazer essa verificação dentro do ciclo)
sonda_existe:
	MOV R2, [evento_ints + 2]	; lock da interrupção
	
	MOV R5, [ESTADO_JOGO]		; obtém o estado de jogo
	MOV R7, ESTADO_JOGAVEL			
	CMP R5, R7					; verifica se ainda está jogável
	JZ continua_desenho_sonda	; se estiver jogável continua o jogo
	MOV R7, ESTADO_PAUSA		; caso contrário verifica se está em pausa
	CMP R5, R7						
	JZ sonda_existe				; se estiver em pausa volta para um ponto onde não reseta mas fica à espera que estado de jogo mude
	MOV R7, ESTADO_COMEÇA		; verifica se o estado de jogo está no começa que requer que a tecla de começo seja premida
	CMP R5, R7
	JZ reset_flags_sonda			; se estiver no estado começa, dar reset ao estados dos asteroides
	MOV R7, ESTADO_TERMINADO		
	CMP R5, R7						; verifica também se está no estado terminado
	JZ reset_flags_sonda			; caso esteja faz também o reset das flags
	MOV R7, ESTADO_PERDIDO_ENERGIA 	
	CMP R5, R7						; verifica também se está no estado perdido por falta de energia
	JZ reset_geral_sonda			; caso esteja faz também o reset das flags
	MOV R7, ESTADO_PERDIDO_COLISAO	
	CMP R5, R7						; verifica se está no estado perdido por colisão com a nave
	JZ reset_geral_sonda			; caso esteja faz o reset das flags
	
; Estando no estado correto continua a fazer as movimentações das sondas
continua_desenho_sonda:
	CALL verifica_colisao_ast			; verifica se houve colisão com um asteroide
	JMP deteta_flag						; verifica se a flag da tabela das sondas está a um (se estiver houve colisão e apaga sonda)
sonda_nao_colidiu:
	CALL apaga_sonda					; apaga a sonda
	CALL sobe_sonda						; muda a posição da sonda
	CALL desenha_sonda					; desenha a sonda na nova posição
	
; Verifica se a sonda chegou ao seu valor máximo
verifica_fim:
	MOV R4, FIM_SONDA					; valor a comparar
	CMP R0, R4							; compara a linha da sonda com a linha final
	JNZ sonda_existe					; se ainda não tiver chegado à linha final, volta para descer mais
	CALL apaga_sonda					; caso contrário apagar a sonda e voltar a pedir uma tecla para mandar mais uma sonda
	JMP corpo_sonda
	
; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO DAS SONDAS
; (colisões)
; --------------------------------------------------------------------------------

; Diminui a energia referente ao disparo
diminui_energia_tiro:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R10
    PUSH R8
    MOV R0, DISPARO					; valor a retirar após o disparo
    MOV R1, [VALOR_DISPLAY]			; retira o valor guardado na memória
    SUB R1, R0						; retira o valor referente ao disparo
    MOV [VALOR_DISPLAY], R1			; atualiza o novo valor na memória
    MOV R10, R1						; move o valor para R10 para este poder ser convertido na função hexa_to_decimal
    CALL hexa_to_decimal			; converte o valor dispondo-o no registro R8
    MOV [DISPLAYS], R8				; coloca o resultado no display
    POP R8
    POP R10
    POP R3
    POP R2
    POP R1
    POP R0
    RET

; Verifica se após o tiro, o jogo foi perdido
verifica_energia_perdida:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    MOV R0, [VALOR_DISPLAY]				; retira o valor mostrado no display
    MOV R1, 0							; valor comparação
    CMP R0, R1							; compara o valor comparação (0) e o valor que estava na memória
    JLE perdeu_tiro						; se o valor for menor, o jogo foi perdido
    JMP saida_perdeu_energia_tiro		; caso o valor não seja menor ou igual 0, sai
perdeu_tiro:							; caso o valor seja menor ou igual muda o estado de jogo
    MOV R0, 0							; colocar o valor do display a 0
    MOV [DISPLAYS], R0
    MOV R0, ESTADO_PERDIDO_ENERGIA		; estado a ser colocado
    MOV [ESTADO_JOGO], R0				; altera o estado na memória
saida_perdeu_energia_tiro:
    POP R3
    POP R2
    POP R1
    POP R0
    RET

; Verifica se a flag está a 1, se não tiver não a deixa continuar a desenhar
deteta_flag:
	MOV R7, TABELA_SONDAS				; tabela das flags das sondas
	ADD R7, R9							; adiciona R9 (R9 contém o "indice" da sonda atual na tabela das flags)
	MOV R8, [R7]						; retira o valor nesse endereço
	CMP R8, 0							; compara com o valor 0
	JZ sonda_nao_colidiu				; caso os valores sejam iguais, não colidiu
	CALL apaga_sonda					; caso contrário colidiu e apaga a sonda
	JMP corpo_sonda


; Coloca a 0 a flag da sonda no indice correto
flag_sonda_ativa:
	PUSH R0
	PUSH R1
	MOV R0, FLAG_0				; move o valor da flag_0 para R0
	MOV R1, TABELA_SONDAS		; R1 tem o endereço da tabela das sondas
	ADD R1, R9					; é somado o valor correto a R1 para colocar a 0 na tabela
	MOV [R1], R0				; escreve o valor 0 na tabela
	POP R1
	POP R0
	RET
	
; Se o jogo for terminado ou perdido reseta o ecrã e reseta as flags da tabela de flags
reset_geral_sonda:
	MOV R5, 0
	MOV [APAGA_ECRÃ], R5
	CALL reset_flags_sonda
	JMP corpo_sonda
	
; Reseta todas as flags da tabela de flags das sondas
reset_flags_sonda:
	PUSH R0
	PUSH R1
	MOV R0, TABELA_SONDAS
	MOV R1, FLAG_0
	MOV [R0], R1			; reseta a flag da primeira sonda
	ADD R0, 2
	MOV [R0], R1			; reseta a flag da segunda sonda
	ADD R0, 2
	MOV [R0], R1			; reseta a flag da terceira sonda
	POP R1
	POP R0
	RET

; verifica_colisao_ast: verifica se a sonda colidiu com algum asteroide
; R0 - Linha da sonda, R1 - Coluna da sonda, R2 - Indíce na tabela de flags dos asteroides
verifica_colisao_ast:
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R2, -2					; valor começa a -2 para quando entrar no ciclo, começar a 0
	MOV R3, 10					; valor comparação para que este consiga passar por todas as trajetórias (0, 2, 4, 6 e 8)
incrementa_endereço:
	ADD R2, 2					; próximo endereço
	CMP R2, R3					; compara o novo endereço com o valor comparação
	JZ todos_verificados		; caso tenha chegado ao valor comparação, todos os asteroides foram verificados
	MOV R4, TABELA_TRAJETORIA	; obtém o endereço da tabela de flags dos asteroides
	ADD R4, R2					; adiciona R2 que contém os vários "indices" da tabela
	MOV R5, [R4]				; retira o valor guardado no endereço resultante
	CMP R5, 1					; compara com a FLAG_1
	JNZ incrementa_endereço		; caso não sejam iguais, ou seja, o asteroide não está na tela, passa para o próximo endereço
	CALL verifica_se_colidiu	; caso sejam iguais, ou seja, o asteroide está na tela, verifica se houve colisão com a sonda
	JMP incrementa_endereço		; em seguida verifica se a mesma sonda colidiu com outra sonda
todos_verificados:
	POP R5
	POP R4
	POP R3
	POP R2
	RET
	
;  Vai verificar se a sonda colidiu com um asteroide especifico
; R0 - Linha da sonda, R1 - Coluna da sonda, R2 - Indíce na tabela de flags dos asteroides
; R5 - Linha superior do asteroide, R6 - Linha inferior do asteroide
; R7 - Coluna da esquerda do asteroide, ; R8 - Colunda da diretia do asteroide
; R10 - Tipo do asteroide
verifica_se_colidiu:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R9
	PUSH R11
	MOV R3, R2			; move para R3 o "indice" do asteroide a verificar
	MOV R4, 4			; valor a multiplicar para conseguir o "salto" correspondente à tabela das posições
	MUL R3, R4			; R3 possui oincremento para o primeiro endereço da tabela das posições no indice correto
	MOV R11, TABELA_POSICOES_AST
	ADD R11, R3			; consegue o endreço correto correspondente ao primeiro valor da tabela no "indice" correto
	MOV R5, [R11]		; R5 - Linha superior do asteroide
	MOV R6, R5			; move o mesmo valor obtido acima para poder adicionar o comprimento do asteroide e obter a outra linha
	ADD R6, 5			; R6 - Linha inferior do asteroide
	ADD R11, 2			; incrementa no endereço para conseguir aceder ao valor da coluna
	MOV R7, [R11]		; R7 - Coluna da esquerda do asteroide
	MOV R8, R7			; move o mesmo valor obtido acima para poder adiconar a largura do asteroide e obter a outra linhas
	ADD R8, 5			; R8 - Colunda da diretia do asteroide
	ADD R11, 2			; incrementa no endereço para conseguir obter o tipo do asteroide
	MOV R10, [R11]		; R10 - Tipo do asteroide
	CALL verifica_limites ; são verificados os limites
	POP R11
	POP R9
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET

; Verifica se a sonda está dentro dos limites do asteroide
verifica_limites:
	CMP R0, R6							; verifica se a sonda está abaixo da linha superior
	JGT nao_colidiu_sonda				; caso não esteja, sai
	CMP R0, R5							; verifica se a sonda está acima da linha inferior
	JLT nao_colidiu_sonda				; caso não esteja, sai
	CMP R1, R7							; verifica se a sonda está à direita da coluna da esquerda do asteroide
	JLT nao_colidiu_sonda				; caso não esteja, sai
	CMP R1, R8							; verifica se a sonda está à esquerda da coluna da direta do asteroide
	JGT nao_colidiu_sonda				; caso não esteja, sai
	CALL colidiu
nao_colidiu_sonda:
	RET
	
; Se o asteroide colidiu, atualiza a flag na tabela das sondas para 1 e atualiza também
; o valor na tabela das posições correspondete à colisão dos asteroides para 1, ou seja, colidiu
; R2 - Indíce na tabela de flags dos asteroides
; R9 - Indice na tabela de flags das sondas
colidiu:
	PUSH R0
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R9
	MOV R0, 4						; valor usado para multiplicar
	MUL R2, R0						; x4 para bater certo com o indice na tabela com 4 valores
	MOV R3, TABELA_POSICOES_AST		; R3 tem o endereço da tabela das posições
	ADD R3, R2						; R3 tem o endereço na tabela das posições no indice certo
	ADD R3, 6						; incrementa 6 para alterar a flag corresponde à colisão com o asteroide
	MOV R4, FLAG_1
	MOV [R3], R4					; colocou a flag da colisão na tabela dos asteroides do asteroide especifico
	MOV R3, TABELA_SONDAS			; R3 toma o endereço da tabela das flags das sondas
	ADD R3, R9						; é incrementado R9 para conseguir o indice certo				
	MOV [R3], R4					; é mudada a flag para 1, ou seja, colidiu
	CALL apaga_sonda				; apaga a sonda
	POP R9
	POP R4
	POP R2
	POP R3
	POP R0
	RET
	
; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO DAS SONDAS
; (geral)
; --------------------------------------------------------------------------------

; Atribui as posições iniciais e os incrementos nas colunas consoante qual a sonda foi disparada 
; R1 - tecla premida
atribui_posicaoEincremento_s:							
	MOV R3, SOBE_SONDA_ESQUERDA
	CMP R1, R3										; verifica se é a tecla premida foi a tecla para subir a sonda da esquerda
	JNZ verifica_vertical							; se não for verifica se foi para a sonda do meio
posicao_sonda_esquerda:								; faz as atribuições iniciais para a sonda da esquerda
    MOV R1, COLUNA_INCIAL_SONDA_DIAGONAL_ESQUERDA 	; obtem a coluna inicial da sonda
	MOV R3, -1										; incremento na coluna da sonda da esquerda
	MOV R9, 0
	JMP saida_sonda									; após fazer as atribuções, sai
verifica_vertical:										
	MOV R3, SOBE_SONDA_MEIO					
	CMP R1, R3										; verifica se é a tecla premida foi a tecla para subir a sonda do meio
	JNZ verifica_sonda_direita						; se não for verifica se foi para a sonda da direita
posicao_inicial_sonda_vertical:						; faz as atribuições iniciais para a sonda da direita
    MOV R1, COLUNA_INCIAL_SONDA_VERTICAL 			; obtem a coluna inicial da sonda
	MOV R3, 0										; incremento na coluna da sonda vertical
	MOV R9, 2
	JMP saida_sonda									; após fazer as atribuções, sai
verifica_sonda_direita:								; se não tiver saído ainda é porque é a sonda da direita, portanto faz as respetivas atribuições
    MOV R1, COLUNA_INCIAL_SONDA_DIAGONAL_DIREITA	;obtem a coluna inicial da sonda
	MOV R3, 1										; incremento na coluna da sonda da direita
	MOV R9, 4
saida_sonda:
	MOV R0, LINHA_INCIAL_SONDA 						; obtem a linha inicial da sonda 
	RET


; --------------------------------------------------------------------------------
; FUNÇÕES AUXILIARES AO PROCESSO DAS SONDAS
; (movimento sonda)
; --------------------------------------------------------------------------------

; Apaga a sonda
; R0 - linha do pixel a apagar
; R1 - coluna do pixel a apagar
apaga_sonda:
    MOV R2, 0
    MOV [DEFINE_LINHA], R0				 	; determina linha
    MOV [DEFINE_COLUNA], R1					; determina coluna
    MOV [DEFINE_PIXEL], R2  			 	; apaga pixel
	RET

; Sobe a sonda 
; R1 - coluna a alterar
; R3 - incremento na coluna de cada sonda
sobe_sonda:
	ADD R1, R3
    SUB R0, 1								; decrementa linha para uma acima no ecrã
	RET
	
; desenha a sonda
; R0 - linha do pixel a desenhar
; R1 - coluna do pixel a desenhar
; R2 - cor do pixel
desenha_sonda:
    MOV R2, [SONDA]     					;obtem cor sonda
    MOV [DEFINE_LINHA], R0					;determina linha atual da sonda
    MOV [DEFINE_COLUNA], R1					;determina coluna
    MOV [DEFINE_PIXEL], R2  				;pinta pixel
	RET
	
; *********************************************************************************	
; PROCESSO nave
; --------------------------------------------------------------------------------
; Neste processo são tratadas as mudanças de cores do painel da nave
; --------------------------------------------------------------------------------
; R7 - define a linha do pixel a ser pintado
; R8 - define a coluna do pixel a ser pintado
; *********************************************************************************
PROCESS SP_inicial_nave

corpo_nave:
    MOV R1, evento_ints         
    MOV R0, [R1+6]						; Dá lock até a interrupção dar UNLOCK
	MOV R9, [ESTADO_JOGO]				; obtém o estado de jogo
	MOV R10, ESTADO_JOGAVEL			
	CMP R10, R9							; verifica se ainda está jogável
	JNZ corpo_nave						; caso não esteja jogável, volta ao inicio e não desenha
	
; Começa o processo de desenho
continua_nave:
    MOV R4, 16B4H
    MOV R2, NAVES_INFOS       	; endereço para encontrar o comprimento e a altura do layout
    CMP R3, R4                  ; se o endereço do layout for igual ao endereço da ultima word da tabela de layouts
    JZ inicio_layout            ; volta a desenhar o primeiro layout
    CMP R3, 0                   ; se o endereço do registo for 0 (primeira passagem do processo)
    JZ inicio_layout            ; desenha o primeiro layout
    JMP desenha_layout          ; caso contrário, desenha o layout seguinte

; Obtém as informações do inicio dos layouts
inicio_layout:
    MOV R3, NAVES_DESENHOS           ; endereço da primeira word da tabela de layouts
    MOV R5, [R2]                     ; comprimento do layout
    MOV R6, [R2+2]                   ; altura do layout
    MOV R7, LINHA_INCIAL_NAVE        ; linha inicial do layout
    MOV R8, COLUNA_INCIAL_NAVE       ; coluna inicial do layout
    JMP desenha_layout

; Desenha o layout
desenha_layout:
    CMP R6, 0                       ; se a altura a desenhar for 0
    JZ proximo_layout               ; passa para o próximo layout
    JMP desenha_linha_layout        ; caso contrário, desenha a linha

; Desenha uma das linhas do layout atual
desenha_linha_layout:
    CMP R5, 0                   ; se o comprimento a desenhar for 0 (fim da linha)
    JZ proxima_linha_layout     ; passa para a próxima linha
    MOV R9, [R3]                ; cor do pixel
    MOV [DEFINE_LINHA], R7      ; define a linha
    MOV [DEFINE_COLUNA], R8     ; define a coluna
    MOV [DEFINE_PIXEL], R9      ; pinta o pixel
    ADD R3, 2                   ; incrementa para a próxima cor de pixel
    ADD R8, 1                   ; incrementa para a próxima coluna
    SUB R5, 1                   ; decrementa o comprimento
    JMP desenha_linha_layout    ; desenha o próximo pixel

; Desenha a próxima linha do layout atual
proxima_linha_layout:
    ADD R7, 1                        ; incrementa para a próxima linha
    SUB R6, 1                        ; decrementa a altura
    MOV R5, LARGURA_NAVE             ; reinicia o comprimento
    MOV R8, COLUNA_INCIAL_NAVE       ; coluna inicial do layout
    JMP desenha_layout

; Define o próximo layout
proximo_layout:
    MOV R7, LINHA_INCIAL_NAVE         ; linha inicial do layout
    MOV R8, COLUNA_INCIAL_NAVE        ; coluna inicial do layout
    MOV R6, ALTURA_NAVE               ; reinicia a altura
    MOV R5, LARGURA_NAVE              ; reinicia o comprimento
    JMP corpo_nave                    ; volta ao corpo do processo
	
; *********************************************************************************
; --------------------------------------------------------------------------------
; ROTINAS AUXILIARES
; --------------------------------------------------------------------------------
; *********************************************************************************
; Converte o valor que está em R10 para o valor correto a colocar no display
; R10 - Valor a converter, R8 - Valor convertido
hexa_to_decimal:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R10
	MOV R1, 1000
	MOV R2, 10
	MOV R8, 0
hexa_to_decimal_loop:
	MOD R10, R1 ; número = número MOD fator; número é o valor a converter
    DIV R1, R2  ; fator = fator DIV 10; fator de divisão (começar em 1000 decimal)
    CMP R1, 0   ; se fator for 0, termina o loop
    JZ saida_hexa_to_decimal
    MOV R3, R10 ; dígito = número DIV fator; mais um dígito do valor decimal
    DIV R3, R1
    SHL R8, 4   ; resultado = resultado SHL 4; desloca, para dar espaço ao novo dígito
    OR R8, R3   ; resultado = resultado OR dígito; vai compondo o resultado
    JMP hexa_to_decimal_loop
 saida_hexa_to_decimal:
    POP R10
    POP R3
    POP R2
    POP R1
    RET
	
; *********************************************************************************
; INTERRUPÇÕES
; Rotinas de interrupção: dão unlock 
; *********************************************************************************

rot_int_0:
    PUSH R1
    MOV R1, evento_ints ; endereço da tabela de locks
    MOV [R1+0], R0         ; dá unlock
    POP R1
    RFE

rot_int_1:
    PUSH R1
    MOV R1, evento_ints
    MOV [R1+2], R0         ; dá unlock
    POP R1
    RFE

rot_int_2:
    PUSH R1
    MOV R1, evento_ints
    MOV [R1+4], R0         ; dá unlock
    POP R1
    RFE

rot_int_3:
    PUSH R1
    MOV R1, evento_ints
    MOV [R1+6], R0         ; dá unlock
    POP R1
    RFE
; *********************************************************************************