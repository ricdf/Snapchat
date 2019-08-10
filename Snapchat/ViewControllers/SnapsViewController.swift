//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 02/08/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var snaps: [Snap] = []
    
    @IBOutlet weak var tableview: UITableView!
    
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

        let autenticacao = Auth.auth()
    
        if let idUsuarioLogado = autenticacao.currentUser?.uid{
            
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child( idUsuarioLogado ).child("snaps")
            
            //criar ouvinte para os snaps
            snaps.observe(DataEventType.childAdded, with: { (snapshots) in
                
                let dados = snapshots.value as? NSDictionary
                
                let snap = Snap()
                snap.identificador = snapshots.key
                snap.nome = dados?["nome"] as! String
                snap.descricao = dados?["descricao"] as! String
                snap.urlImagem = dados?["urlImagem"] as! String
                snap.idImagem = dados?["idImagem"] as! String
                
                self.snaps.append( snap )
                self.tableview.reloadData()
            })
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let totalSnaps = snaps.count
        if totalSnaps == 0{
            return 1
        }
        return totalSnaps
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        let totalSnaps = snaps.count
        if totalSnaps == 0{
            celula.textLabel?.text = "Nenhum Snap para vc! :)"
        }else{
            
            let snap = self.snaps [ indexPath.row ]
            celula.textLabel?.text = snap.nome
        }
        return celula
    }
    
}
