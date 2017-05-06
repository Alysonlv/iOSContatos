//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios7061 on 4/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import Foundation

class ContatoDao: CoreDataUtil {

    static private var defaultDAO: ContatoDao!;
    var contacts: Array<Contato>!
    
    static func ContatoDaoInstance() -> ContatoDao {
        if (defaultDAO == nil) {
            defaultDAO = ContatoDao();
        }
        return defaultDAO;
    }
    
    override private init() {
        super.init();
        self.contacts = Array();
        
        self.inserirDadosIniciais();
        self.carregaContatos();
        
        print("Caminho BD: \(NSHomeDirectory())")
    }
    
    func addContact(contact:Contato) {
        contacts.append(contact);
    }
    
    func getAllContacts() -> [Contato] {
        return self.contacts;
    }
    
    func getContact(index:Int) -> Contato {
        return self.contacts[index];
    }
    
    func carregaContatos() {
        let busca = NSFetchRequest<Contato>(entityName: "Contato");
        let orderPorNome = NSSortDescriptor(key: "name", ascending: true);
        
        busca.sortDescriptors = [orderPorNome];
        
        do {
            self.contacts = try self.persistentContainer.viewContext.fetch(busca);
        } catch let error as NSError {
            print("Fetch Falhou: \(error.localizedDescription)");
        }
    }
    
    func removeContact(index:Int) {
        self.contacts.remove(at: index);
    }
    
    func buscaPosicaoDoContato(_ contato:Contato) -> Int {
        return contacts.index(of: contato)!
    }
    
    func inserirDadosIniciais() {
        let configuracoes = UserDefaults.standard;
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos");
        
        if !dadosInseridos {
            let caelumSP = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato;
            caelumSP.name = "Caelum SP";
            caelumSP.phone = "01155712751";
            caelumSP.addres = "Sao Paulo, SP, Rua Vergueiro, 3185";
            caelumSP.urlSite = "www.caelum.com.br";
            caelumSP.latitude = -23.5883;
            caelumSP.longitude = -46.632329;
            
            self.saveContext();
            
            configuracoes.set(true, forKey: "dados_inseridos");
            configuracoes.synchronize();
            
        }
    }
    
    func novoContato() -> Contato {
        return NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato;
    }
}
