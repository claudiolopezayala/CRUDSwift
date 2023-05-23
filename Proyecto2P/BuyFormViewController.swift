import Cocoa

class BuyFormViewController: BaseForm {
    var buyToDisplay: Buy! = nil;

    @IBOutlet weak var txtProductName: NSTextField!
    @IBOutlet weak var txtDescription: NSTextField!
    @IBOutlet weak var txtAmount: NSTextField!
    @IBOutlet weak var txtPrice: NSTextField!
    @IBOutlet weak var txtTotal: NSTextField!
    @IBOutlet weak var txtCategory: NSTextField!
    @IBOutlet weak var btnDone: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        txtTotal.isEditable = false;
        if (modifyId != nil){
            handleLoadViewModify();
        }
    }
    @IBAction func txtProductNameTriggered(_ sender: Any) {
        do{
            let productToDisplay = try Inventory.getOneByName(txtProductName.stringValue)
            txtDescription.stringValue = productToDisplay.productDescription;
            txtPrice.doubleValue = productToDisplay.buyPrice;
            txtCategory.stringValue = productToDisplay.category;
        }catch InventoryErrors.productNotFound{
            
        }catch{
            let alert = NSAlert();
            alert.messageText = "Error";
            alert.runModal();
            self.dismiss(self)
        }
    }
    
    @IBAction func txtAmountTriggered(_ sender: Any) {
        handleTotalChange();
    }
    @IBAction func txtPriceTriggered(_ sender: Any) {
        handleTotalChange();
    }
    @IBAction func btnDoneClicked(_ sender: Any) {
        let alert = NSAlert();
        if (modifyId != nil){
            handleModifyBuy();
            self.dismiss(self);
        }else{
            handleCreateNewBuy();
            self.dismiss(self);
        }
    }
    
    private func handleLoadViewModify(){
        let alert = NSAlert();
        btnDone.title = "Modificar";
        do{
            self.buyToDisplay = try Buys.getOneById(modifyId);
            
            txtPrice.doubleValue = buyToDisplay.price;
            txtTotal.doubleValue = Double(buyToDisplay.amount) * buyToDisplay.price;
            txtAmount.integerValue = buyToDisplay.amount;
            txtCategory.stringValue = buyToDisplay.category;
            txtDescription.stringValue = buyToDisplay.productDescription;
            txtProductName.stringValue = buyToDisplay.productName;
            
        }catch BuysErrors.buyNotFound {
            alert.messageText = "Compra no encontrada."
            alert.runModal();
            self.dismiss(self);
        }catch{
            alert.messageText = "Se produjo un error."
            alert.runModal();
            self.dismiss(self);
        }
    }
    
    private func handleCreateNewBuy() {
        var productId : Int = -2;
        do{
            productId = try Inventory.getOneByName(txtProductName.stringValue).id;
        }catch InventoryErrors.productNotFound{
        }catch{
            let alert = NSAlert();
            alert.messageText = "Error";
            alert.runModal();
            self.dismiss(self);
        }
        let productName = txtProductName.stringValue;
        let productDescription = txtDescription.stringValue;
        let amount = txtAmount.integerValue;
        let price = txtPrice.doubleValue;
        let category = txtCategory.stringValue;
        
        let newBuy = Buy(productId: productId, productName: productName, productDescription: productDescription, amount: amount, price: price, category: category)
        
        Buys.addBuy(newBuy);
        
    }
    
    private func handleModifyBuy(){
        let alert = NSAlert();
        
        let productName = txtProductName.stringValue;
        let productDescription = txtDescription.stringValue;
        let amount = txtAmount.integerValue;
        let price = txtPrice.doubleValue;
        let category = txtCategory.stringValue;
        
        let newBuy = Buy(productId: modifyId, productName: productName, productDescription: productDescription, amount: amount, price: price, category: category)
        alert.messageText = "Compra modificada"
        do{
            try Buys.replaceOneById(buy: newBuy, id: modifyId);
        }catch BuysErrors.buyNotFound{
            alert.messageText = "Compra inexistente"
        }catch{
            alert.messageText = "Error";
        }
        alert.runModal();
        self.dismiss(self);
    }
    
    private func handleTotalChange(){
        let total = Double(txtAmount.integerValue) * txtPrice.doubleValue
        txtTotal.doubleValue = total;
    }
}
