//
//  TableViewController.swift
//  ContatosIP67
//
//  Created by ios7061 on 4/26/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ListContactsTableViewController: UITableViewController, FormularioContatoViewControllerDelegation {
    
    var dao:ContatoDao!
    static let cellIdentifier:String = "Cell";
    var contacts:[Contato]!
    var contato:Contato!
    var linhaDestaque: IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        self.dao = ContatoDao.ContatoDaoInstance();
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactSelected = dao.getContact(index: indexPath.row);
        
        print("editando...");
        
        print("editando: \(contactSelected.name)")
        self.showForm(contactSelected);
    }
    
    func showForm(_ contato:Contato) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let form = storyBoard.instantiateViewController(withIdentifier: "Form-Contato") as! FormContactViewController;
        
        form.delegate = self;
        
        form.contato = contato;
        
        self.navigationController?.pushViewController(form, animated: true);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(exibirMaisAcoes(gesture:)))
        
        self.tableView.addGestureRecognizer(longPress);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData();
        self.dao.carregaContatos();
        self.contacts = self.dao.getAllContacts();
        
        if let linha = self.linhaDestaque {
            self.tableView.selectRow(at: linha, animated: true, scrollPosition: .middle);
            self.linhaDestaque = Optional.none;
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.getAllContacts().count;
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contato:Contato = self.getContact(index: indexPath.row);
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ListContactsTableViewController.cellIdentifier);

        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: ListContactsTableViewController.cellIdentifier);
        }
        
        cell!.textLabel?.text = contato.name;

        return cell!
    }
    
    private func getContact(index:Int) -> Contato {
        return self.dao.getAllContacts()[index];
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dao.removeContact(index: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "FormSegue") {
            if let form = segue.destination as? FormContactViewController {
                form.delegate = self;
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func contatoAtualizado(_ contato: Contato) {
        print("DELEGATE - contato atualizado: \(contato.name)");
        //self.linhaDestaque = IndexPath(row: dao.buscaPosicaoDoContato(contato), inSection: 0);
    }
    
    func contatoAdicionado(_ contato: Contato) {
        print("DELEGATE - contato adicionado... \(contato.name)");
        //self.linhaDestaque = IndexPath(row: dao.buscaPosicaoDoContato(contato), inSection: 0);
    }
    
    func exibirMaisAcoes(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            let ponto = gesture.location(in: self.tableView);
            
            if let indexPath:IndexPath? = self.tableView.indexPathForRow(at:ponto) {
                
                let c = self.dao.getContact(index: (indexPath?.row)!);
                
                let acoes = GerenciadorDeAcoes(do: c);
                
                acoes.exibirAcoes(em: self);
            }
        }
    }

}
