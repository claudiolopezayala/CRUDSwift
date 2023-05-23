
import Cocoa

class ShowInventoryViewController: ShowInformationViewController {
    @objc dynamic var buys: [Buy] = Buys.getBuys();
    @objc dynamic var sales: [Sale] = Sales.getSales();
    @objc dynamic var inventory: [Product] = Inventory.getInventory();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
