//
//  ViewController.swift
//  project456
//
//  Created by Eddie Jung on 8/5/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList)),
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        ]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 20)
        
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add Item", message: "Add your shopping list item.", preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        shoppingList = []
        tableView.reloadData()
    }
    
    func submit(_ item: String) {
        shoppingList.insert(item, at: 0)
        
        let index = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    
    @objc func shareList() {
        let list = shoppingList.joined(separator: ", ")
        let avc = UIActivityViewController(activityItems: ["Shopping List: \(list)."], applicationActivities: nil)
        
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }

}

