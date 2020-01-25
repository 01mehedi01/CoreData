//
//  ViewController.swift
//  CoreDataPro
//
//  Created by Mehedi Hasan on 18/12/19.
//  Copyright © 2019 Mehedi Hasan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    
    @IBOutlet weak var coretableview: UITableView!
    
    @IBOutlet weak var mySearchbar: UISearchBar!
    

    var SelectedCategory : CreatePlan? {
        
        didSet{
            LoadItem()
        }
    }
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [MyItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    //********************          Bar Button      **********************************************
    // Create a alart view
    
    @IBAction func BarButton(_ sender: Any) {
        
        
       // self.performSegue(withIdentifier: "Create", sender: nil)
        
        var titletextField = UITextField()
        var costtextField = UITextField()
        let item = MyItem(context: context)
        
        let alart = UIAlertController(title: "Add a New item", message: "", preferredStyle: .alert)
        
        alart.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a item"
            titletextField = alertTextField
        }
        
        alart.addTextField { (alertTextField1) in
            alertTextField1.placeholder = "Create a cost"
            costtextField = alertTextField1
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("success \(titletextField.text!)")
            
            item.title = titletextField.text!
            item.cost  = Double(costtextField.text!)!
            item.done = false
            item.costDetails = self.SelectedCategory
            self.itemArray.append(item)
            
            self.SaveItem()
            
            self.coretableview.reloadData()
        }
        alart.addAction(action)
        present(alart, animated: true, completion: nil)
    }
    
    
    
    
    //********************            Save Item      **********************************************
    func SaveItem() {
        
       
        do{
            try context.save()
            print("Successfully Save : ")
        }catch{
            
            print("Error occure in decode \(error)")
            
        }
        
        
    }
    
    //********************            Load Item      **********************************************
 func LoadItem(with requests : NSFetchRequest<MyItem> = MyItem.fetchRequest(),predicate :NSPredicate? = nil) {
    
  let Filterpredicate = NSPredicate(format: "costDetails.placename MATCHES %@", SelectedCategory!.placename!)
    
    if let additionalPredicate = predicate {
        requests.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [Filterpredicate,additionalPredicate])
    }else{
        requests.predicate = Filterpredicate
    }
        

        
        do{
         
            itemArray =   try context.fetch(requests)
            
        }catch{
            
            print("Error occure in decode \(error)")
            
        }
        
    
        
        
    }
    

}

//********************       Search Bar      **********************************************
extension ViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(" Cool Man \(searchBar.text!)")
        
        let  requests : NSFetchRequest<MyItem> = MyItem.fetchRequest()
        
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        requests.predicate = predicate
        
        requests.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        LoadItem(with: requests,predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            LoadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

//********************       Table view   **********************************************

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coretableview.dequeueReusableCell(withIdentifier: "corecell", for: indexPath) as! CoreDataCell
        
        
        cell.mylabel?.text = itemArray[indexPath.row].title
        cell.costLabel?.text = String(itemArray[indexPath.row].cost)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
    }
    
    
}

