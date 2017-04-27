//
//  TableViewController.swift
//  ContatosIP67
//
//  Created by ios7061 on 4/26/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ListContactsTableViewController: UITableViewController {
    
    var dao:ContatoDao!
    static let cellIdentifier:String = "Cell";
    var contacts:[Contato]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        self.dao = ContatoDao.ContatoDaoInstance();
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData();
        self.contacts = self.dao.getAllContacts();
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
        return self.contacts[index];
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

}
