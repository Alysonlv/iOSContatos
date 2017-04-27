//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios7061 on 4/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import Foundation

class ContatoDao: NSObject {

    static private var defaultDAO: ContatoDao!;
    var contacts: Array<Contato>!
    
    static func ContatoDaoInstance() -> ContatoDao {
        if (defaultDAO == nil) {
            defaultDAO = ContatoDao();
        }
        return defaultDAO;
    }
    
    override private init() {
        self.contacts = Array();
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
    
    func removeContact(index:Int) {
        self.contacts.remove(at: index);
    }
}
