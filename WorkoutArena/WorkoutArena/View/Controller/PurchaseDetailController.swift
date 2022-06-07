//
//  PurchaseDetailController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 06/06/22.
//

import Foundation
import UIKit
import StoreKit

class PurchaseDetailController: UITableViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver{
   
    private let reuseID = "cellReuseID"
    
    let monthlyProductID = "com.navaneethan.g.WorkoutArena.monthlyPlan"
    
    enum Product: String, CaseIterable{
        case monthly = "com.navaneethan.g.WorkoutArena.monthlyPlan"
        case yearly = "com.navaneethan.g.WorkoutArena.yearlyPlan"
    }
    
    var products = [SKProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SKPaymentQueue.default().add(self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        fetchProducts()
    }
    
    private func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({
            $0.rawValue
        })))
        request.delegate = self
        request.start()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseID)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.productIdentifier
        cell.detailTextLabel?.text = product.price.stringValue
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let payment = SKPayment(product: products[indexPath.row])
        
        SKPaymentQueue.default().add(payment)
    }
   
    //MARK: - StoreKit request Delegate
    
    /// Function to get the Available products from the Storekit configuration file
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        
        DispatchQueue.main.async {
            self.products = response.products
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: - Payment delegate
    
    ///function called during transaction
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            
            switch transaction.transactionState{
                
            case .purchasing:
                print("Purchasing")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("purchased")
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Purchasing failed")
            case .restored:
                print("Purchasing restored")
            case .deferred:
                print("Purchasing deferred")
            @unknown default:
                print("Purchasing")
            }
        }
    }
}
