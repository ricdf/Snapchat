//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 06/07/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
   
    
    @IBAction func loginConta(_ sender: Any) {
        
    //recuperar dados digitados
    if let emailR = self.email.text {
        if let senhaR = self.senha.text{
                
            //login conta no firebase - INICIO
            let autenticacao = Auth.auth()
            autenticacao.signIn(withEmail: emailR, password: senhaR) { (usuario, erro) in
            
                if erro == nil{ // nao teve erro nos dados
                    
                    if usuario == nil{ // nao existe o usuario cadastrado
                        
                        let alerta = Alerta(titulo: "Erro ao autenticar!", mensagem: "Problema ao realizar a autenticação, tente novamente.")
                        self.present(alerta.getAlerta(),animated: true, completion: nil)

                    }else{
                        // tela principal do app
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    }
                    
                }else{
                    
                    let alerta = Alerta(titulo: "Dados incorreto! ", mensagem: "Confira os dados e tente novamente.")
                    self.present(alerta.getAlerta(),animated: true, completion: nil)
                }
            }//login conta no firebase - FIM
            
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
