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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        var total = 0.0

        cartTextView.text = ""

        var foodPrices = [String: Double]()
        for (index, food) in AppData.foods.enumerated() {
            if index < AppData.prices.count {
                foodPrices[food] = AppData.prices[index]
            }
        }

        for (name, quantity) in AppData.cart {
            if let price = foodPrices[name] {
                let itemTotal = price * Double(quantity)
                total += itemTotal
                cartTextView.text += "\(name) - x\(quantity)\n"
            }
        }

        cartTextView.text += "\nTotal: \(String(format: "$%.02f", total))"
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
            
            nameTextField.text = ""
            quantityTextField.text = ""
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

