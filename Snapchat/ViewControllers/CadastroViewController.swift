//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 06/07/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class CadastroViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nomeCompleto: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var senhaConfirmacao: UITextField!
    
    @IBAction func criarConta(_ sender: Any) {
        
        //recuperar dados digitados
        if let emailR = self.email.text {
            if let nomeCompletoR = self.nomeCompleto.text{
                if let senhaR = self.senha.text{
                    if let senhaConfirmacaoR = self.senhaConfirmacao.text{
                        
                        //validar senha - INICIO
                        if senhaR == senhaConfirmacaoR{
                            //temq que ter o nome do usuario para poder salvar
                            if(nomeCompletoR != ""){
                                //criar conta no firebase - INICIO
                                let autenticacao = Auth.auth()
                                autenticacao.createUser(withEmail: emailR, password: senhaR) { (usuario, erro) in
                                    
                                    if erro == nil{ // testar os erros no cadastro
                                        
                                        if usuario == nil{ //usuario nao identificado
                                            let alerta = Alerta(titulo: "Erro ao autenticar! " , mensagem: "Problema ao realizar a autenticação, tente novamente.")
                                            self.present(alerta.getAlerta(),animated: true, completion: nil)
                                        }else{
                                            
                                            //adicionar as informacoes do usuario no database
                                            let dataBase = Database.database().reference()
                                            let usuarios = dataBase.child("usuarios")
                                            
                                            let usuarioDados = ["nome": nomeCompletoR, "email": emailR]
                                            usuarios.child( usuario!.user.uid).setValue(usuarioDados)
                                            
                                            // tela principal do app
                                            self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                        }
                                        
                                    }else{
                                        
                                        //validar erro do cadastro do firebase - INICO
                                        if let error = erro, (error as NSError).code == 17008 {
                                            let alerta = Alerta(titulo: "Email mal formulado!", mensagem: "Digite um email válido.")
                                            self.present(alerta.getAlerta(),animated: true, completion: nil)
                                        }else
                                            if let error = erro, (error as NSError).code == 17026 {
                                                let alerta = Alerta(titulo: "Senha fraca! ", mensagem:"Digite uma senha válida.")
                                                self.present(alerta.getAlerta(),animated: true, completion: nil)
                                            }else
                                                if let error = erro, (error as NSError).code == 17007 {
                                                    let alerta = Alerta(titulo: "Email em uso! ", mensagem: "Digite um email diferente.")
                                                    self.present(alerta.getAlerta(),animated: true, completion: nil)
                                                }else{
                                                    let alerta = Alerta(titulo: "Dados incorreto! ", mensagem: "Confira os dados Novamente.")
                                                    self.present(alerta.getAlerta(),animated: true, completion: nil)
                                        }
                                        
                                    }
                                    //validar erro do cadastro do firebase - FIM
                                }
                                //criar conta no firebase - FIM
                            }else{
                                let alerta = Alerta(titulo: "Dados Incorretos!", mensagem:"Digite o seu nome para prosseguir.")
                                self.present(alerta.getAlerta(),animated: true, completion: nil)
                            }
                        }else{
                            let alerta = Alerta(titulo: "Dados Incorretos!", mensagem:"As senhas não estão iguais , digite novamente.")
                            self.present(alerta.getAlerta(),animated: true, completion: nil)
                        }//validar senha - FIM
                        
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
