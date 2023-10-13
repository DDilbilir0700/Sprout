//
//  SwipeTVC.swift
//  Sprout
//
//  Created by Deniz Dilbilir on 26/10/2023.
//

import UIKit
import SwipeCellKit

class SwipeTVC: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 75.0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.layer.borderWidth = 10.0
        cell.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
//        cell.contentView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
           cell.layer.borderColor = UIColor.systemBackground.cgColor
             cell.delegate = self
        let randomColor = UIColor(
               red: CGFloat(drand48()),
               green: CGFloat(drand48()),
               blue: CGFloat(drand48()),
               alpha: 0.3
           )

          
           cell.contentView.backgroundColor = randomColor

                return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        
        
        guard orientation == .right else { return nil }
        
        

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.update(at: indexPath)
        
            }
         
        


        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
       
        return options
    }
    func update(at indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10  // Adjust the value to increase or decrease the space between cells
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
