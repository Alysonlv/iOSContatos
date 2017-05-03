//
//  GerenciadorDeAcoes.swift
//  ContatosIP67
//
//  Created by ios7061 on 5/2/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class GerenciadorDeAcoes: NSObject {
    
    let contato:Contato;
    var controller:UIViewController!
    
    let device:UIDevice;
    
    init(do contato:Contato) {
        self.contato = contato;
        self.device = UIDevice.current;
    }
    
    func exibirAcoes(em controller:UIViewController) {
        self.controller = controller;
        
        let alertView = UIAlertController(title: self.contato.name, message: nil, preferredStyle: .actionSheet);
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil);
        
        let ligarParaContato = UIAlertAction(title: "Ligar", style: .default) {
            action in self.ligar();
        }
        
        let exibirContatoNoMapa = UIAlertAction(title: "Visualizar No Mapa", style: .default) {
            action in self.abrirMapa();
        }
        
        let exibirSiteDoContato = UIAlertAction(title: "Visualizar Site", style: .default) {
            action in self.abrirNavegador();
        }
        
        alertView.addAction(cancelar);
        alertView.addAction(ligarParaContato);
        alertView.addAction(exibirContatoNoMapa);
        alertView.addAction(exibirSiteDoContato);
        
        self.controller.present(alertView, animated: true, completion: nil);
    }
    
    private func ligar() {
        print("Ligando... \(self.contato.phone)");
        
        if (device.model == "iPhone") {
            abrirAplicativo(com: "tel:" + self.contato.phone!);
            print("UUID \(device.identifierForVendor!)");
        } else {
            print("Este dispositivo nao faz ligacoes!");
            let alert = UIAlertController(title: "Dispositivo nao Suporta Ligacoes", message: nil, preferredStyle: .alert);
            self.controller.present(alert, animated: true, completion: nil);
        }
    }
    
    private func abrirMapa() {
        print("abrirMapa...");
        
        let url = ("http://maps.google.com/maps?q=" + self.contato.addres!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!;
        
        abrirAplicativo(com: url);
    }
    
    private func abrirNavegador() {
        print("abrirNavegador...");
        
        var url = contato.urlSite!;
        
        if (!url.hasPrefix("http://")) {
            url = "http://" + url;
        }
        
        abrirAplicativo(com: url);
        
    }
    
    private func abrirAplicativo(com url:String) {
        UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: nil);
    }

}
