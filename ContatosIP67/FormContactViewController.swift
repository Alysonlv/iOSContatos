//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7061 on 4/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class FormContactViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var addres: UITextField!
    @IBOutlet var urlSite: UITextField!
    
    var dao:ContatoDao!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.dao = ContatoDao.ContatoDaoInstance();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFormData() -> Contato {
        let contato: Contato = Contato();
        contato.name = self.name.text!
        contato.phone = self.phone.text!
        contato.addres = self.addres.text!
        contato.urlSite = self.urlSite.text!
        
        return contato;
    }
    
    @IBAction func createContact() {
        print("Button ADD clicked!");
        
        dao.addContact(contact: self.readFormData());
        
        self.navigationController?.popViewController(animated: true);
    }


}

