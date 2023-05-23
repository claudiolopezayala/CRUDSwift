//
//  ShowInventoryViewController.swift
//  Proyecto2P
//
//  Created by José Antonio Gonzalez Ruiz on 21/05/23.
//

import Cocoa

class ShowInventoryViewController: ShowInformationViewController {
    @objc dynamic var sales: [Sale] = Sales.getSales();
    @objc dynamic var inventory: [Product] = Inventory.getInventory();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
