//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 02/08/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    
    var imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString
    
    
    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagensDir = armazenamento.child("imagens") //criou a pasta imagens para armazenamento
        
        
        if let imagemSelecionada = imagem.image{
            
            if let imageData = imagemSelecionada.jpegData(compressionQuality: 0.50){ //criou o arquivo da imagem
                
                let imagemRef = imagensDir.child("\(self.idImagem).jpg") //criou o arquivo com nome aleatorio na pasta
                
                imagemRef.putData(imageData, metadata: nil) { (metadata, error) in
                    
                    if error == nil{
                        print("sucesso ao carregar o arquivo!")
                        
                        imagemRef.downloadURL(completion: { (url, erro) in
                            
                            if erro == nil{
                                print(url?.absoluteString as Any)
                            }else{
                                print("Erro no caminho da imagem no firebase.")
                            }
                        })
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                    }else{
                        let alerta = Alerta(titulo: "Upload Falhou!", mensagem: "Erro ao salvar o arquivo, tente novamente")
                        self.present(alerta.getAlerta(),animated: true, completion: nil)
                    }
                }
            }
        }
                
    }
          
    
    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        //imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //habilitar o botao proximo pois ja tem agora uma imagem
        botaoProximo.isEnabled = true
        botaoProximo.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        
        
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        imagem.image = imagemRecuperada
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        //desabilitar o botao proximo pois nao tem nenhuma imagem carregada
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
    
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
