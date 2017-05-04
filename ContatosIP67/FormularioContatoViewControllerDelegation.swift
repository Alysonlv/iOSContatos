//
//  FormularioContatoViewControllerDelegation.swift
//  ContatosIP67
//
//  Created by ios7061 on 5/2/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation

protocol FormularioContatoViewControllerDelegation {

    func contatoAdicionado(_ contato: Contato);
    func contatoAtualizado(_ contato: Contato);

}
