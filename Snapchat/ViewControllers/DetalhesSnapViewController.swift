//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 10/08/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class DetalhesSnapViewController: UIViewController {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var detalhes: UILabel!
    @IBOutlet weak var contador: UILabel!
    
    var snap = Snap()
    var tempo = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detalhes.text = "Carregando..."
        let url = URL(string: snap.urlImagem)
        
        imagem.sd_setImage(with: url) { (imagem, erro, cache, url) in
            
            //a imagem ja esta carregada e com cache pelo pod SDWebImage
            //aqui é para comecar a contar o delete da imagem depois que ela ta carregada
            if erro == nil{
                
                self.detalhes.text = self.snap.descricao
                
                //iniciar o timer
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    
                    //decrementar o timer
                    self.tempo = self.tempo - 1
                    //exibir o timer na tela
                    self.contador.text = String(self.tempo)
                    //parar o timer no tempo 0 e fechar a tela
                    if(self.tempo == 0){
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        //recuperar o id do usuario logado para remover o nó
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid{
            
            //remover nó do database
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            
            snaps.child(snap.identificador).removeValue()
            
            //remover imagem do Snap
            let storage = Storage.storage().reference()
            let imagens = storage.child("imagens")
            
            imagens.child("\(snap.idImagem).jpg").delete { (erro) in
                
                if erro == nil{
                    print("sucesso ao excluir a imagem")
                }else{
                    print("erro ao excluir a imagem")
                }
            }
            
            
        }
        
    }

}
