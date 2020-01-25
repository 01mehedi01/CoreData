//
//  LoginSuccessVC.swift
//  CoreDataPro
//
//  Created by Mehedi Hasan on 6/1/20.
//  Copyright © 2020 Mehedi Hasan. All rights reserved.
//

import UIKit
import CoreData

class LoginSuccessVC: UIViewController {

    @IBOutlet var createTableView: UITableView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let date = NSDate()
//    var dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd/MM/yyyy"
//    var dateString = dateFormatter.string(from: date as Date)
    
    
    var itemArray = [CreatePlan]()
    var dateFormatter: DateFormatter!
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setBackground()
        
        LoadItem()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func NavigationBar(_ sender: Any) {
        
        var textplacename = UITextField()
        var textbudget = UITextField()
        
        
        
        let item = CreatePlan(context: context)
        
        let alart = UIAlertController(title: "Add a New item", message: "", preferredStyle: .alert)
        
        alart.addTextField { (alertTextField) in
            alertTextField.placeholder = "place name"
            textplacename = alertTextField
        }
        
        alart.addTextField { (alertTextField) in
            alertTextField.placeholder = "Budget"
            textbudget = alertTextField
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
          
            
            item.placename = textplacename.text!
            item.budget = Double(textbudget.text!) ?? 0.0
            item.date = Date()
            
            self.itemArray.append(item)
            
            self.SaveItem()
            
            self.createTableView.reloadData()
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
    
    func LoadItem(with requests : NSFetchRequest<CreatePlan> = CreatePlan.fetchRequest()) {
        
        
        do{
            
            itemArray =   try context.fetch(requests)
            
        }catch{
            
            print("Error occure in decode \(error)")
            
        }
        
        self.createTableView.reloadData()
        
        
    }
    
//    func setBackground() {
//        createTableView.addSubview(backgroundImageView)
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        backgroundImageView.image = UIImage(named: "download")
//        view.sendSubviewToBack(backgroundImageView)
//    }
    
}

//********************       Table view   **********************************************

extension LoginSuccessVC : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = createTableView.dequeueReusableCell(withIdentifier: "createplan", for: indexPath) as! CreatePlanDataCell
       
      
        cell.PlaceName?.text = itemArray[indexPath.row].placename
        cell.Budget?.text = String(itemArray[indexPath.row].budget)
        
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
      //  Date(timeIntervalSince1970: itemArray[indexPath.row].date)
      //  let getdate = NSDate(timeIntervalSince1970: itemArray[indexPath.row].date)
          print("DAte \(itemArray[indexPath.row].date)")
        
        cell.date?.text = dateFormatter.string(from: itemArray[indexPath.row].date!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToitem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        
        if let indexPath = createTableView.indexPathForSelectedRow {
            destinationVC.SelectedCategory = itemArray[indexPath.row]
            
        }
        
    }
    
    
}


