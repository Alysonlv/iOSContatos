//
//  GerenciarEscolhaCamera.swift
//  ContatosIP67
//
//  Created by ios7061 on 5/2/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class GerenciarEscolhaCamera: NSObject {

    var controller:UIViewController!
    
    
    override init() {

    }
    
    func exibirAcoesFotos(em controller:UIViewController) {
        self.controller = controller;
        
        let imageController = UIAlertController(title: "Escolha a foto para o Contato", message: nil, preferredStyle: .actionSheet);
        
        let usarBiblioteca = UIAlertAction(title: "Usar Biblioteca", style: .default) {
            action in self.useLibrary();
        }
        
        let usarCamera = UIAlertAction(title: "Usar Camera", style: .default) {
            action in self.useCamera();
        }
        
        
        imageController.addAction(usarBiblioteca);
        imageController.addAction(usarCamera);
        
        self.controller.present(imageController, animated: true, completion: nil);
        
    }
    
    func useLibrary() {
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imagemView.image = imagemSelecionada;
        }
        
        picker.dismiss(animated: true, completion: nil);
    }
    
    func useCamera() {
        
    }
    
    
}
