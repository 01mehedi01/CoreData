//
//  SignUpViewController.swift
//  CoreDataPro
//
//  Created by Ariful on 30/12/19.
//  Copyright © 2019 Mehedi Hasan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var errormessageLabel: UILabel!
    @IBOutlet weak var nameTextFild: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextFild: UITextField!
    
    @IBOutlet weak var passwordTextFild: UITextField!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var loginArray = [Login]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errormessageLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignUpPress(_ sender: UIButton) {
        
        let item = Login(context: context)
        let Name = nameTextFild.text!.trimmingCharacters(in: .whitespaces)
        let phone = phoneTextField.text!.trimmingCharacters(in: .whitespaces)
        let email =     emailTextFild.text!.trimmingCharacters(in: .whitespaces)
        let password =  passwordTextFild.text!.trimmingCharacters(in: .whitespaces)
        
        let error = validTextFild()
        
        if error == nil{
          print("fild")
            
            item.name = Name
            item.phone = phone
            item.email = email
            item.password = password
            
            self.loginArray.append(item)
            
            self.SaveItem()

            
        }else{
            
            ErrorMessage(message: "Please Fill up all field ")
            
        }
    }
    
    
// ******************** Varify All Field Empty or Not ********************
    
    func validTextFild() -> String? {
        if (nameTextFild.text?.trimmingCharacters(in: .whitespaces)) == "" ||
            (phoneTextField.text?.trimmingCharacters(in: .whitespaces)) == "" ||
            (emailTextFild.text?.trimmingCharacters(in: .whitespaces)) == "" ||
            (passwordTextFild.text?.trimmingCharacters(in: .whitespaces)) == "" {
            return "Please feel All field"
        }
        
        return nil
        
        
        
    }
    
    
//********************            Save Item      **********************************************
    func SaveItem() {
        
        
        do{
            try context.save()
            print("Successfully Save : ")
            ErrorMessage(message: "Successfully Save")
            
        }catch{
            
            print("Error occure in decode \(error)")
            
        }
        
        
    }
    
    
//********************            Error Message       ***********************
    
    func ErrorMessage(message: String){
        
        if errormessageLabel.alpha == 0 {
            
            errormessageLabel.alpha = 1
            errormessageLabel.text = message
            
        }
    }
}
