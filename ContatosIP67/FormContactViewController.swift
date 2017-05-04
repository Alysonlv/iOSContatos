//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7061 on 4/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class FormContactViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var addres: UITextField!
    @IBOutlet var urlSite: UITextField!
    @IBOutlet var imagemView: UIImageView!
    
    var dao:ContatoDao!
    var contato:Contato!
    
    var delegate:FormularioContatoViewControllerDelegation?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.dao = ContatoDao.ContatoDaoInstance();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (contato != nil) {
            if let foto = contato.photo {
                self.imagemView.image = contato.photo;
            }
            self.name.text = contato.name;
            self.phone.text = contato.phone;
            self.addres.text = contato.addres;
            self.urlSite.text = contato.urlSite;
            
            let btnUpdate = UIBarButtonItem(title: "Confirmar", style: .plain, target:self, action: #selector(updateContact));
            self.navigationItem.rightBarButtonItem = btnUpdate;
            
            
        }
        
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(selecinaFoto(sender:)));
        self.imagemView.addGestureRecognizer(imgTap);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFormData() -> Contato {
        
        if (contato == nil) {
            self.contato = Contato();            
        }
        
        contato.photo = self.imagemView.image
        contato.name = self.name.text!
        contato.phone = self.phone.text!
        contato.addres = self.addres.text!
        contato.urlSite = self.urlSite.text!
        
        return contato;
    }
    
    @IBAction func createContact() {
        self.readFormData();
        dao.addContact(contact: contato);
        self.delegate?.contatoAdicionado(contato);
        
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    func updateContact() {
        readFormData();
        
        self.delegate?.contatoAtualizado(contato);
        
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    func selecinaFoto(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
        } else {
            let pickerController = UIImagePickerController();
            pickerController.sourceType = .photoLibrary;
            pickerController.allowsEditing = true;
            pickerController.delegate = self;
            
            self.present(pickerController, animated: true, completion: nil);
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imagemView.image = imagemSelecionada;
        }
        
        picker.dismiss(animated: true, completion: nil);
    }
    


}

