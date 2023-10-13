//
//  CollectionTVC.swift
//  Sprout
//
//  Created by Deniz Dilbilir on 23/10/2023.
//

import UIKit
import RealmSwift




class CollectionTVC: SwipeTVC {
    
    let realm = try! Realm()
    
    var collections: Results<Collection>?
    
      
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCollections()
     
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        cell.textLabel?.text = collections?[indexPath.row].name ?? "No Collection added"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toTheItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SproutTVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCollection = collections?[indexPath.row]
        }
        
    }
    
    
    func save(collection: Collection) {
        do {
            try realm.write {
                realm.add(collection)
            }
        } catch {
            print("Saving collection error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCollections() {
        
        collections = realm.objects(Collection.self)

        tableView.reloadData()
    }
    
    override func update(at indexPath: IndexPath) {
        
   
        
        if let collectionToDelete = self.collections?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(collectionToDelete)
                }
            } catch {
                print("collection deleting error \(error)")
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new collection", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCollection = Collection()
            newCollection.name = textField.text!
            
            self.save(collection: newCollection)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new collection"
        }
        present(alert, animated: true, completion: nil)
    }
    
}

