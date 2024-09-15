//
//  AdminViewController.swift
//  CafeMiniApp
//
//  Created by Brennan Reinhard on 9/15/24.
//

import UIKit

class AdminViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var nameRemovalTextField: UITextField!
    
    @IBOutlet weak var menuTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildMenuTextView()
        
        passwordTextField.isSecureTextEntry = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        buildMenuTextView()
    }
    
    @IBAction func addToMenuAction(_ sender: UIButton) {
        var isEmpty = (true, true)
        var isValid = (false, false)
        
        for food in AppData.foods {
            if let name = nameTextField.text {
                isEmpty.0 = false
                
                if food.lowercased() == name.lowercased() {
                    let alert = UIAlertController(title: "Error", message: "That food already exists", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                    
                    break
                    
                    isValid.0 = false
                } else {
                    isValid.0 = true
                }
            }
        }
        
        if let price = priceTextField.text {
            isEmpty.1 = false
                
            if let priceInt = Double(price) {
                isValid.1 = true
            }
            
        }
        
        if !isEmpty.0 && !isEmpty.1 && isValid.0 && isValid.1 && isAuth() {
            AppData.foods.append(nameTextField.text!)
            AppData.prices.append(Double(priceTextField.text!)!)
            buildMenuTextView()
        } else {
            let alert = UIAlertController(title: "Invalid or empty input", message: "Please make sure your input is valid and not empty", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func removeFromMenuAction(_ sender: UIButton) {
        if let name = nameRemovalTextField.text {
            for i in 0..<AppData.foods.count {
                if AppData.foods[i] == name && isAuth() {
                    AppData.foods.remove(at: i)
                    AppData.prices.remove(at: i)
                    break
                }
            }
            buildMenuTextView()
        }
    }
    
    @IBAction func dismissKeyboardActiob(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    func buildMenuTextView() {
        // clear out for new items
        menuTextView.text = ""
        
        for i in 0..<AppData.foods.count {
            menuTextView.text += "\(AppData.foods[i]) - \(String(format: "$%.02f", AppData.prices[i]))\n"
        }
    }
    
    func isAuth() -> Bool {
        if let password = passwordTextField.text {
            if password == "ProfessorGooner" {
                return true
            } else {
                
                return false
            }
            
        } else {
            let a = UIAlertController(title: "Error", message: "Please make sure the input is not empty", preferredStyle: .alert)
            
            a.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(a, animated: true)
            return false
        }
    }
}
