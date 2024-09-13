//
//  ViewController.swift
//  CafeMiniApp
//
//  Created by BRENNAN REINHARD on 9/11/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var itemsTextView: UITextView!
    @IBOutlet weak var cartTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildMenuTextView()
        buildCartTextView()
    }
    
    func buildMenuTextView() {
        // clear out for new items
        itemsTextView.text = ""
        
        for i in 0..<AppData.foods.count {
            itemsTextView.text += "\(AppData.foods[i]) - \(String(format: "$%.02f", AppData.prices[i]))\n"
        }
    }
    
    func buildCartTextView() {
        // clear out for new items
        cartTextView.text = ""
        
        for (name, quantity) in AppData.cart {
            cartTextView.text += "\(name) - x\(quantity)\n"
        }
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        var validName = false
        var validQuantity = false
        
        var name: String?
        var quantity: Int?

        if let iname = nameTextField.text {
            for food in AppData.foods {
                if !(iname.lowercased() != food.lowercased()) {
                    validName = true
                    name = iname
                    break
                }
            }
        }
        
        if validName && (AppData.cart[name!] != nil) {
            validName = false
        }
        
        if let iquantity = quantityTextField.text, let quantityInt = Int(iquantity) {
            validQuantity = true
            quantity = quantityInt
        }
        
        if validName && validQuantity {
            AppData.cart.updateValue(quantity!, forKey: name!)
            buildCartTextView()
        } else {
            if !validName {
                let alert = UIAlertController(title: "Error", message: "Enter a valid name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Enter a valid quantity", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func dismissKeyboardAction(_ sender: UIButton) {
        self.view.endEditing(true)
    }
}

