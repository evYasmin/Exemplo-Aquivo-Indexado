      $set sourceformat"free"
      *>Divisão de identificação do programa
       identification division.
       program-id. "Lista11.Exercicio3".
       author. "EVELYN YASMIN PEREIRA ".
       installation. "PC".
       date-written. 28/07/2020.
       date-compiled. 28/07/2020.

      *>Divisão para configuração do ambiente
       environment division.
       configuration section.
           special-names. decimal-point is comma.

      *>-----Declaração dos recursos externos
       input-output section.
       file-control.

                  select arqCadAluno assign to "arqCadAluno.txt"
                  organization is indexed
                  access mode is dynamic
                  lock mode is automatic
                  record key is fd-cod
                  file status is ws-fs-arqCadAluno.
       *>________________________________________________________________________________________________
        *>select adiciona nome ao arquivo > assing vai estar assossiando o arquivo fisico.               |
        *> organization é a forma de como sao organizados os dados.                                      |
        *> o access voce acessa o aquivo/dados.                                                          |
        *> o lock mode serve para travar o arquivo.                                                      |
        *> file status é utilizado uma variavel da working-storage para retorno correto do arquivo.      |
       *>________________________________________________________________________________________________|

       i-o-control.

      *>Declaração de variáveis
       data division.

      *>____Variaveis de arquivos declaradas da file section
       file section.
       fd arqCadAluno.
       01 fd-alunos.
           05  fd-cod                              pic X(03).
           05  fd-aluno                            pic X(25).
           05  fd-endereco                         pic X(35).
           05  fd-mae                              pic X(25).
           05  fd-pai                              pic X(25).
           05  fd-telefone                         pic X(15).
           05  fd-notas.
               10  fd-nota1                        pic 9(02)v99.
               10  fd-nota2                        pic 9(02)v99.
               10  fd-nota3                        pic 9(02)v99.
               10  fd-nota4                        pic 9(02)v99.

      *>____Variaveis de trabalho declaradas ai na wordkin-storage
       working-storage section.

       77 ws-fs-arqCadAluno                        pic 9(02).

       01 ws-msn-erro.
          05 ws-msn-erro-ofsset                    pic 9(04).
          05 ws-msn-erro-cod                       pic 9(02).
          05 ws-msn-erro-text                      pic X(42).

       01  ws-alunos.
           05  ws-aluno                            pic X(25).
           05  ws-cod                              pic X(03).
           05  ws-endereco                         pic X(35).
           05  ws-mae                              pic X(25).
           05  ws-pai                              pic X(25).
           05  ws-telefone                         pic X(15).
           05  ws-notas.
               10  ws-nota1                        pic 9(02)v99.
               10  ws-nota2                        pic 9(02)v99.
               10  ws-nota3                        pic 9(02)v99.
               10  ws-nota4                        pic 9(02)v99.

       77 ws-sair                                  pic X(01).
       77 ws-menu                                  pic X(02).

      *>----Variaveis para comunicação entre programas
       linkage section.


      *>----Declaração de tela
       screen section.

      *>Declaração do corpo do programa
       procedure division.

           perform inicializa.
           perform processamento.
           perform finaliza.

      *>________________________________________________________________________
      *>  Procedimentos de inicialização                                        |
      *>________________________________________________________________________|
       inicializa section.

           open i-o arqCadAluno   *> o open i-o serve para abrir o arquivo e também para leitura e escrita.
           if ws-fs-arqCadAluno  <> 00
           and ws-fs-arqCadAluno <> 05 then
               move 1                                 to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                 to ws-msn-erro-cod
               move "Erro ao abrir arq. arqCadAluno " to ws-msn-erro-text
               perform finaliza-anormal
           end-if

      *>    estamos movem space to para inicializa menu
           move  spaces      to     ws-menu
           .
       inicializa-exit.
           exit.

      *>________________________________________________________________________
      *>  Procedimentos de processamento                                        |
      *>________________________________________________________________________|
       processamento section.

           perform until ws-sair = "X"
                      or ws-sair = "x"
               *> em seguida o menu de entrada, para selecionar qual operaçao ira realizar no programa
               display erase
               display "             | _______SEJA BEM-VINDO AO PORTAL ALUNO ______|  "
               display "             |                                             |  "
               display "             | ___________________________________________ |  "
               display "Digite '1' para cadastrar aluno"
               display "Digite '2' para notas"
               display "Digite '3' para consulta indexada"
               display "Digite '4' para consulta sequencial"
               display "Dgitie '5' para deletar"
               display "Digite '6' para alterar"
               display "Digite '7' para SAIR"
               accept ws-menu

               evaluate  ws-menu
                  when = '1'
                       perform cadastrar-aluno

                   when = '2'
                       perform cadastrar-notas

                   when = '3'
                       perform consulta-indexada

                   when = '4'
                       perform consulta-sequencial

                   when = '5'
                       perform deletar-cadastro

                   when = '6'
                       perform alterar-cadastro

                   when = '7'
                       display "***VOLTE SEMPRE PARA NOSSO PORTAL***"

                   when other
                       display "Opcao invalida***"
               end-evaluate

           end-perform
           .
       processamento-exit.
           exit.

      *>________________________________________________________________________
      *>  Cadastro de Alunos ->                                                 |
      *>________________________________________________________________________|
       cadastrar-aluno section.

            perform until ws-sair = "V"
                       or ws-sair = "v"

           display erase
           display "             | _____________CADASTRO ALUNO_________________|  "
           display "             |                                             |  "
           display "             | ___________________________________________ |  "
           display "Codigo do Aluno: "
           accept ws-cod
           display "Informe o Nome do Aluno(a): "
           accept ws-aluno
           display "Informe o Endereco: "
           accept ws-endereco
           display "Informe o Nome da Mae: "
           accept ws-mae
           display "Informe o Nome do Pai: "
           accept ws-pai
           display "Telefone Para Contato: "
           accept ws-telefone

      *> _____________Salvar dados no arquivo_____________
               write fd-alunos       from ws-alunos
               if ws-fs-arqCadAluno <> 00 then
                   move 2                                    to ws-msn-erro-ofsset
                   move ws-fs-arqCadAluno                    to ws-msn-erro-cod
                   move "Erro ao gravar arq. arqCadAluno "   to ws-msn-erro-text
                   perform finaliza-anormal
               end-if
      *> _________________________________________________________________________

           display "  "
           display "Deseja cadastrar mais um Aluno? 'S'im ou 'V'oltar"
           accept ws-sair


           .
       cadastrar-aluno-exit.
           exit.

      *>________________________________________________________________________
      *>  Cadastro de Notas ->                                                  |
      *>________________________________________________________________________|
       cadastrar-notas section.

           perform until ws-sair = "V"
                      or ws-sair = "v"
      *> ______________ menu para cadastrar as notas ______
           display erase
           display "             | _____________CADASTRO NOTAS_________________|  "
           display "             |                                             |  "
           display "             | ___________________________________________ |  "
           display "Informe o cod. do aluno : "
           accept fd-cod

           display "Informe a primeira nota : "
           accept ws-nota1

           display "Informe a segunda nota  : "
           accept ws-nota2

           display "Informe a terceira nota : "
           accept ws-nota3

           display "Informe a quarta nota   : "
           accept ws-nota4

           display "  "
           display "Deseja cadastrar mais notas? 'S'im ou 'V'oltar"
           accept ws-sair


           move ws-cod       to fd-cod
           *> _____read ler as variavies de arquivo
           read arqCadAluno
           if  ws-fs-arqCadAluno <> 00
               if ws-fs-arqCadAluno <> 23 then
                   display "Cod. Aluno Inexistente!"
               else
                    move 1                                  to ws-msn-erro-ofsset
                    move ws-fs-arqCadAluno                  to ws-msn-erro-cod
                    move "Erro ao ler arq. arqAlunos "      to ws-msn-erro-text
                   perform finaliza-anormal
           else

           move ws-notas     to   fd-notas
           rewrite fd-alunos
           if ws-fs-arqCadAluno <> 00 then
                      move 1                                        to ws-msn-erro-ofsset
                      move ws-fs-arqCadAluno                        to ws-msn-erro-cod
                      move "Erro ao gravar notas arq. arqAlunos "   to ws-msn-erro-text
                      perform finaliza-anormal
           end-if

           .

       cadastrar-notas-exit.
           exit.

      *>________________________________________________________________________
      *>  Consultar cadastro indexado                                           |
      *>________________________________________________________________________|
       consulta-indexada section.


      *> ____________________ Ler os dados do arquivo
               display "informe o codigo do aluno: "
               accept fd-cod

               move ws-alunos to fd-alunos

               read arqCadAluno
               if  ws-fs-arqCadAluno <> 00
                   if ws-fs-arqCadAluno = 23 then
                       display "Codigo informado invalido!"
                   else
                       move 3                                       to ws-msn-erro-ofsset
                       move ws-fs-arqCadAluno                       to ws-msn-erro-cod
                       move "Erro ao ler arq. arqCadAluno "         to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if
               else
                   move fd-alunos       to  ws-alunos

                   display "Codigo     : " ws-cod
                   display "Aluno      : " ws-aluno
                   display "Endereco   : " ws-endereco
                   display "Nome da mae: " ws-mae
                   display "Nome do pai: " ws-pai
                   display "Telefone   : " ws-telefone
                   display "Nota 1     : " ws-nota1
                   display "Nota 2     : " ws-nota2
                   display "Nota 3     : " ws-nota3
                   display "Nota 4     : " ws-nota4

              end-if

           .
       consulta-indexada-exit.
           exit.

      *>________________________________________________________________________
      *>  Consulta de cadastro sequencial                                       |
      *>________________________________________________________________________|
       consulta-sequencial section.


           perform until ws-sair = "V"
                      or ws-sair = "v"

      *>______________________  Ler os dados do arquivo
               read arqCadAluno next
               if  ws-fs-arqCadAluno <> 00
                   if ws-fs-arqCadAluno = 10 then
                       display "Data informada invalida!"
                   else
                       move 4                                       to ws-msn-erro-ofsset
                       move ws-fs-arqCadAluno                       to ws-msn-erro-cod
                       move "Erro ao ler arq. arqCadAluno "         to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if

               else
                   move  fd-alunos       to  ws-alunos

                   display "Codigo     : " ws-cod
                   display "Aluno      : " ws-aluno
                   display "Endereco   : " ws-endereco
                   display "Nome da mae: " ws-mae
                   display "Nome do pai: " ws-pai
                   display "Telefone   : " ws-telefone
                   display "Nota 1     : " ws-nota1
                   display "Nota 2     : " ws-nota2
                   display "Nota 3     : " ws-nota3
                   display "Nota 4     : " ws-nota4

               end-if

                   display "Deseja realizar mais uma consulta sequencial? 'S'im ou 'V'oltar"
                   accept ws-sair

           end-perform

           .
       consulta-sequencial-exit.
           exit.

      *>________________________________________________________________________
      *>  Deletar Cadastro                                                      |
      *>________________________________________________________________________|
       deletar-cadastro section.

      *> __________________  Apagar os dados do registro do arquivo
               display "informe o cod a ser excluido:"
               accept ws-alunos

               move ws-aluno to fd-aluno
               delete arqCadAluno
               if  ws-fs-arqCadAluno <> 00 then
                   if ws-fs-arqCadAluno = 23 then
                       display "Cod informado invalido!"
                   else
                       move 5                                   to ws-msn-erro-ofsset
                       move ws-fs-arqCadAluno                   to ws-msn-erro-cod
                       move "Erro ao deletar arq. arqCadAluno " to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if
               end-if

           display "Deseja deletar mais um cadastro? 'S'im ou 'V'oltar"
           accept ws-sair


           .
       deletar-cadastro-exit.
           exit.

      *>________________________________________________________________________
      *>  Alterar Cadastro                                                      |
      *>________________________________________________________________________|
       alterar-cadastro section.

               perform consulta-indexada

      *> ________________ Alterar dados do registro do arquivo
               display "Informe novo aluno a ser cadastrado: "
               accept ws-aluno

               move ws-alunos to fd-alunos
               rewrite fd-alunos
               if  ws-fs-arqCadAluno = 00 then
                   display "Novo aluno  " ws-aluno " Cadastrado com sucesso!"
               else
                   move 6                                    to ws-msn-erro-ofsset
                   move ws-fs-arqCadAluno                    to ws-msn-erro-cod
                   move "Erro ao alterar arq. arqCadAluno "  to ws-msn-erro-text
                   perform finaliza-anormal
               end-if

           display "Deseja alterar mais um Aluno? 'S'im ou 'V'oltar"
           accept ws-sair


           .
       alterar-cadastro-exit.
           exit.

      *>________________________________________________________________________
      *>  Finalização anormal                                                   |
      *>________________________________________________________________________|
       finaliza-anormal section.

           display ws-msn-erro.
             accept ws-msn-erro.

           Stop run
           .
       finaliza-anormal-exit.
           exit.

      *>________________________________________________________________________
      *>  Finalização                                                           |
      *>________________________________________________________________________|
       finaliza section.

           close arqCadAluno
           if ws-fs-arqCadAluno <> 00 then
               move 7                                  to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                  to ws-msn-erro-cod
               move "Erro ao fechar arq. arqCadAluno " to ws-msn-erro-text
               perform finaliza-anormal
           end-if

           Stop run
           .
       finaliza-exit.
           exit.

