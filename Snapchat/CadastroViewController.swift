//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 06/07/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import FirebaseAuth


class CadastroViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var senhaConfirmacao: UITextField!
    
    func exibirMensagem(titulo : String, mensagem : String){

        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)

        alerta.addAction(acaoCancelar)
        present(alerta, animated: true, completion: nil)

    }
    
    @IBAction func criarConta(_ sender: Any) {
        
        //recuperar dados digitados
        if let emailR = self.email.text {
            if let senhaR = self.senha.text{
                if let senhaConfirmacaoR = self.senhaConfirmacao.text{
                    
                    //validar senha - INICIO
                    if senhaR == senhaConfirmacaoR{

                        //criar conta no firebase - INICIO
                        let autenticacao = Auth.auth()
                        autenticacao.createUser(withEmail: emailR, password: senhaR) { (usuario, erro) in
                            
                            if erro == nil{
                                print("Sucesso ao cadastrar o usuario")
                            }else{
                            
                                //validar erro do cadastro do firebase - INICO
                                if let error = erro, (error as NSError).code == 17008 {
                                    self.exibirMensagem(titulo: "Email mal formulado!" , mensagem:"Digite um email válido.")
                                }else
                                    if let error = erro, (error as NSError).code == 17026 {
                                        self.exibirMensagem(titulo: "Senha fraca! " , mensagem:"Digite uma senha válida.")
                                }else
                                    if let error = erro, (error as NSError).code == 17007 {
                                        self.exibirMensagem(titulo: "Email em uso! " , mensagem:"Digite um email diferente.")
                                }else{
                                    self.exibirMensagem(titulo: "Dados incorreto! " , mensagem:"Confira os dados Novamente.")
                                }
    
                            }
                                //validar erro do cadastro do firebase - FIM
                        }
                        //criar conta no firebase - FIM

                    }else{
                        self.exibirMensagem(titulo: "Dados Incorretos!" , mensagem:"As senhas não estão iguais , digite novamente.")
                    }//validar senha - FIM
                    
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
