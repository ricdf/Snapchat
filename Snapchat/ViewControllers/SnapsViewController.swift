//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 02/08/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    @IBAction func sair(_ sender: Any) {
        
        let autenticacao = Auth.auth()
        
        do {

            try autenticacao.signOut() //deslogar o usuario
            
            dismiss(animated: true, completion: nil) // fechar a tela snaps
            
        } catch {
            
            print("Erro ao deslogar usuário!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
