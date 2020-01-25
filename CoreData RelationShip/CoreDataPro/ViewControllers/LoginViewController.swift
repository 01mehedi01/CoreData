//
//  LoginViewController.swift
//  CoreDataPro
//
//  Created by Ariful on 30/12/19.
//  Copyright © 2019 Mehedi Hasan. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var errormessageLabel: UILabel!
    @IBOutlet weak var emailTextView: UITextField!
    
    @IBOutlet weak var passwordTextView: UITextField!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var registerData = [Login]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errormessageLabel.alpha = 0
        LoadItem()
    }
    

    @IBAction func LoginPress(_ sender: UIButton) {
        
        let email = emailTextView.text!.trimmingCharacters(in: .whitespaces)
        let password = passwordTextView.text!.trimmingCharacters(in: .whitespaces)
        
        
        let error = validTextFild()
        
       // self.TransitionToMyItemVC()
          self.TransitionToNavigationVC()
        
//        if error == nil{
//            print("fild")
//
//            for i in 0..<(registerData.count){
//
//                if  email == registerData[i].email && password == registerData[i].password{
//
//                    print("Success")
//                    self.TransitionToMyItemVC()
//                    ErrorMessage(message: "Success")
//
//                }else{
//
//                    print("Fail not Match ")
//                    ErrorMessage(message: "Fail not Match")
//                }
//            }
//
//
//
//        }else{
//
//            ErrorMessage(message: "Please Fill up all field ")
//
//        }
        
    }
    
//********************     Load Item     ******************************
    
    func LoadItem() {
        
        let requests : NSFetchRequest<Login> = Login.fetchRequest()
        
        do{
            
            registerData =   try context.fetch(requests)
            
        }catch{
            
            print("Error occure in decode \(error)")
            
        }
        
        
        
    }
    
    
// ******************** Varify All Field Empty or Not ********************
    
    func validTextFild() -> String? {
        if  (emailTextView.text?.trimmingCharacters(in: .whitespaces)) == "" ||
            (passwordTextView.text?.trimmingCharacters(in: .whitespaces)) == "" {
            return "Please feel All field"
        }
        
        return nil
        
        
        
    }
    
    
///*********************** Transition To Main Page ***********************
    func TransitionToMyItemVC() {
        
        let homeViewControll =   storyboard?.instantiateViewController(withIdentifier: Constant.StoryBord.LoginSuccessVC) as? LoginSuccessVC
        
        view.window?.rootViewController = homeViewControll
        view.window?.makeKeyAndVisible()
    }
    
    func TransitionToNavigationVC() {
    
//        let NavigationViewControll =   storyboard?.instantiateViewController(withIdentifier: Constant.StoryBord.LoginSuccessNVC) as? LoginSeccessNVC
//
//        view.window?.rootViewController = NavigationViewControll
//        view.window?.makeKeyAndVisible()
        
        performSegue(withIdentifier: "LoginSeccessNVC", sender: nil)
        

}
    

    
//********************     Error Message     ***********************
    
    func ErrorMessage(message: String){
        
        if errormessageLabel.alpha == 0 {
            
            errormessageLabel.alpha = 1
            errormessageLabel.text = message
            
        }else{
            errormessageLabel.text = message
        }
    }
    

}
