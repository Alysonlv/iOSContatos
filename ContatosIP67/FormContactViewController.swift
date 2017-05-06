//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7061 on 4/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit;
import CoreLocation;

class FormContactViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var addres: UITextField!
    @IBOutlet var urlSite: UITextField!
    @IBOutlet var imagemView: UIImageView!
    @IBOutlet var latitude: UITextField!
    @IBOutlet var longitude: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
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
                self.imagemView.image = foto;
            }
            self.name.text = contato.name;
            self.phone.text = contato.phone;
            self.addres.text = contato.addres;
            self.urlSite.text = contato.urlSite;
            
            self.latitude.text = contato.latitude?.description;
            self.longitude.text = contato.longitude?.description;
            
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
    
    func readFormData() {
        
        if (contato == nil) {
            self.contato = dao.novoContato();
        }
        
        contato.photo = self.imagemView.image
        contato.name = self.name.text!
        contato.phone = self.phone.text!
        contato.addres = self.addres.text!
        contato.urlSite = self.urlSite.text!
        
        if let lat = Double(self.latitude.text!) {
            contato.latitude = lat as NSNumber;
        }
        
        if let longi = Double(self.longitude.text!) {
            contato.longitude = longi as NSNumber;
        }
    }
    
    @IBAction func createContact() {
        self.readFormData();
        dao.addContact(contact: contato);
        self.delegate?.contatoAdicionado(contato);
        
        _ = self.navigationController?.popViewController(animated: true);
        dao.saveContext();
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
    
    @IBAction func buscarCoordenadas(sender: UIButton) {
        self.loading.startAnimating();
        sender.isEnabled = false;
        
        self.readFormData();
        
        if (self.addres.text != "") {
            let geocoder = CLGeocoder();
            geocoder.geocodeAddressString(self.contato.addres!) { (resultado, error) in
                if error == nil && (resultado?.count)! > 0 {
                    let placemark = resultado![0];
                    let coordenada = placemark.location!.coordinate;
                    self.latitude.text = coordenada.latitude.description;
                    self.longitude.text = coordenada.longitude.description;
                    
                    self.loading.stopAnimating();
                    sender.isEnabled = true;
                }
                
            }
            
        } else {
            self.loading.stopAnimating();
            
            let alertView = UIAlertController(title: "Por favor, digite o endereco!", message: nil, preferredStyle: .alert);
            
            let msg = UIAlertAction(title: "OK!", style: .cancel);
            alertView.addAction(msg);
            
            present(alertView, animated: true, completion: nil);
            sender.isEnabled = true;
        }
        
        
        
        
        
        
    }

}

