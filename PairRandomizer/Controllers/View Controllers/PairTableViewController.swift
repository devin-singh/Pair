//
//  TableViewController.swift
//  PairRandomizer
//
//  Created by Devin Singh on 2/14/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class PairTableViewController: UITableViewController {
    
    
    // MARK: - Lifecycle Function
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PairController.shared.loadFromPersistentStorage()
        //PairController.shared.sortIntoPairs()
    }
    
    // MARK: - Actions
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        PairController.shared.sortIntoPairs()
        PairController.shared.saveToPersistantStore()
        self.tableView.reloadData()
    }
    
    @IBAction func addNewPerson(_ sender: Any) {
        presentAddAlert()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        var sectionCount: Int = 0
        
        for pair in PairController.shared.sortedPairs {
            if pair.firstPerson != nil || pair.secondPerson != nil {
                sectionCount += 1
            }
        }
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if PairController.shared.sortedPairs[section].firstPerson != nil && PairController.shared.sortedPairs[section].secondPerson != nil {
            return 2
        } else if PairController.shared.sortedPairs[section].firstPerson != nil || PairController.shared.sortedPairs[section].secondPerson != nil {
            return 1
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = PairController.shared.sortedPairs[indexPath.section].firstPerson
        }else{
            cell.textLabel?.text = PairController.shared.sortedPairs[indexPath.section].secondPerson
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            var dataToDelete: String?
            if indexPath.row == 0 {
                dataToDelete = PairController.shared.sortedPairs[indexPath.section].firstPerson
            } else {
                dataToDelete = PairController.shared.sortedPairs[indexPath.section].secondPerson
            }
            
            guard let dataToDeleteUW = dataToDelete else { return }
            
            PairController.shared.deleteData(data: dataToDeleteUW)
         
            if PairController.shared.sortedPairs[indexPath.section].firstPerson == nil && PairController.shared.sortedPairs[indexPath.section].secondPerson == nil {
                PairController.shared.deleteEmptyPairs()
                tableView.deleteSections(IndexSet(integer: indexPath.section) , with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension PairTableViewController: UITextFieldDelegate {
    func presentAddAlert() {
        let alertController = UIAlertController(title: "Add New Data", message: "Type the string for your data", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.delegate = self
            textfield.placeholder = "What is hype today?"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else { return }
            let sortedPairs = PairController.shared.sortedPairs
            
            if sortedPairs.count == 0 {
                PairController.shared.sortedPairs.append(Pair(firstPerson: text, secondPerson: nil))
            } else if  sortedPairs[sortedPairs.count - 1].secondPerson == nil {
                PairController.shared.sortedPairs[sortedPairs.count - 1].secondPerson = text
            } else {
                PairController.shared.sortedPairs.append(Pair(firstPerson: text, secondPerson: nil))
            }
            PairController.shared.dataHolder.append(text)
            PairController.shared.saveToPersistantStore()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
}
