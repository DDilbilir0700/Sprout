//
//  SproutTVC.swift
//  Sprout
//
//  Created by Deniz Dilbilir on 16/10/2023.
//

import UIKit
import  RealmSwift

class SproutTVC: SwipeTVC {
    
    var sproutItems: Results<Item>?
    let realm = try! Realm()
    var selectedCollection: Collection? {
        didSet{
       retrieveItems()
        }
    }
    

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        searchBar.delegate = self
      
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sproutItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = sproutItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = .none
        } else {
            cell.textLabel?.text = "No Items added yet."
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = sproutItems?[indexPath.row] {
            do {
                try realm.write {
             item.done = !item.done
                }
                
            }catch {
                print("Done status saving problem, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
  
    @IBAction func newItemButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new note", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add note", style: .default) { (action) in
            
            if let currentCollection = self.selectedCollection {
                do {
                    try self.realm.write {
                        let item = Item()
                        item.title = textField.text!
                        item.dateCreated = Date()
                        currentCollection.items.append(item)
                    }
                    
                } catch {
                   print("Sacing items error \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
  
    func retrieveItems() {
     
        sproutItems = selectedCollection?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    override func update(at indexPath: IndexPath) {
        if let item = sproutItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("collection deleting error \(error)")
            }
        }
    }
        }
 

extension SproutTVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        sproutItems = sproutItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
           

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            retrieveItems()
            
            DispatchQueue.main.async { searchBar.resignFirstResponder() }
        
        }
    }
}
