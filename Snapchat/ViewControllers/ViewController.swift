//
//  ViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 05/07/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //saber se o usuario ja esta logado e ir direto para a pagina inicial
        let autenticacao = Auth.auth()
        
        //para deslogar
//        do {
//            try autenticacao.signOut()
//        } catch  {
//            print("nao foi possivel deslogar")
//        }
        
        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            
            if let usuarioLogado = usuario{
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


}

