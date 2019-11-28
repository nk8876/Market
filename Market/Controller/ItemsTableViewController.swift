//
//  ItemsTableViewController.swift
//  Market
//
//  Created by Dheeraj Arora on 12/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    //MARK: Vars
    var category: Category?
    var itemArray: [Item] = []
    
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.tableFooterView = UIView()
        self.title = category?.name
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = " "

        if category != nil{
            loadItems()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemListTableViewCell
        cell.generateCell(item: itemArray[indexPath.row])
        return cell
    }
    
    
    //MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(item: itemArray[indexPath.row])
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemToAddItemSeg"{
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
        }
    }
    
    func showItemView(item: Item)  {
        let itemView =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
            itemView.item = item
        self.navigationController?.pushViewController(itemView, animated: true)
    }
  
    //MARK: Load items
    func loadItems()  {
        downloadItemFromFirebase(withCategoryId: category!.id) { (allItem) in
            print("we have \(allItem.count) item for this category ")
            self.itemArray = allItem
            self.tableView.reloadData()
        }
    }

}
