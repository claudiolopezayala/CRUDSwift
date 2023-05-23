import Cocoa

class SaleFormViewController: BaseForm {
    let alert = NSAlert();
    var saleToDisplay: Sale! = nil;

    @IBOutlet weak var txtIdClient: NSTextField!
    @IBOutlet weak var txtIdProduct: NSTextField!
    @IBOutlet weak var txtPrice: NSTextField!
    @IBOutlet weak var txtAmount: NSTextField!
    @IBOutlet weak var txtSubtotal: NSTextField!
    @IBOutlet weak var txtIva: NSTextField!
    @IBOutlet weak var txtTotal: NSTextField!
    @IBOutlet weak var btnDone: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        txtSubtotal.isEditable = false;
        txtTotal.isEditable = false;
        if (modifyId != nil){
            handleLoadViewModify();
        }
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        let alert = NSAlert();
        if (modifyId != nil){
            handleModifySale();
            self.dismiss(self);
        }else{
            do {
                try handleCreateNewSale();
            } catch SaleErrors.notEnoughStock{
                alert.messageText = "No hay stock disponible.";
                alert.runModal();
            } catch{
                alert.messageText = "Hubo un error";
                alert.runModal();
            }
            self.dismiss(self);
        }
    }
    
    private func handleLoadViewModify(){
        btnDone.title = "Modificar";
        do{
            self.saleToDisplay = try Sales.getOneById(modifyId);
            
            txtIdClient.integerValue = saleToDisplay.clientId;
            txtIdProduct.integerValue = saleToDisplay.productId;
            txtPrice.doubleValue = saleToDisplay.price;
            txtAmount.integerValue = saleToDisplay.amount;
            txtSubtotal.isEditable = false;
            txtSubtotal.doubleValue = saleToDisplay.subtotal;
            txtIva.doubleValue = saleToDisplay.iva;
            txtTotal.isEditable = false;
            txtTotal.doubleValue = saleToDisplay.total;
            
            
        }catch SalesErrors.saleNotFound{
            alert.messageText = "Venta no encontrada."
            alert.runModal();
            self.dismiss(self);
        }catch{
            alert.messageText = "Se produjo un error."
            alert.runModal();
            self.dismiss(self);
        }
    }
    
    private func handleCreateNewSale() throws {
        let clientId = txtIdClient.integerValue;
        let productId = txtIdProduct.integerValue;
        let amount = txtAmount.integerValue;
        let price = txtPrice.doubleValue;
        let iva = txtIva.doubleValue;
        let newSale = try Sale(clientId: clientId, productId: productId, amount: amount, price: price, iva: iva);
        
        try Sales.addSale(newSale);
        
    }
    
    private func handleModifySale(){
        let alert = NSAlert();
        
        let clientId = txtIdClient.integerValue;
        let productId = txtIdProduct.integerValue;
        let amount = txtAmount.integerValue;
        let price = txtPrice.doubleValue;
        let iva = txtIva.doubleValue;
        
        do {
            let oldProduct = try Inventory.getOneById(productId);
            let newStock = oldProduct.stock + saleToDisplay.amount;
            
            let NewProduct = Product(name: oldProduct.name, productDescription: oldProduct.productDescription, buyPrice: oldProduct.buyPrice, sellPrice: oldProduct.sellPrice, category: oldProduct.category, stock: newStock)
            
            let sale = try Sale(clientId: clientId, productId: productId, amount: amount, price: price, iva: iva);
            try Sales.replaceOneById(sale: sale, id: modifyId);
            
            alert.messageText = "Venta modificada con exito";
            alert.runModal();
            self.dismiss(self);
        }catch SaleErrors.notEnoughStock{
            alert.messageText = "No hay suficiente producto en inventario";
            alert.runModal();
        }catch SaleErrors.userIdNotClientId{
            alert.messageText = "Id de cliente no pertenece al id de un cliente";
            alert.runModal();
        }catch UsersErrors.userNotFound{
            alert.messageText = "Cliente no encontrado";
            alert.runModal();
        }catch InventoryErrors.productNotFound{
            alert.messageText = "Producto no encontrado";
            alert.runModal();
        } catch{
            alert.messageText = "Error";
            alert.runModal();
            self.dismiss(self);
        }
    }
    
    @IBAction func amountTriggered(_ sender: Any) {
        handleTotalandSubtotalChange();
    }
    @IBAction func priceTriggered(_ sender: Any) {
        handleTotalandSubtotalChange();
    }
    @IBAction func ivaTriggered(_ sender: Any) {
        handleTotalandSubtotalChange();
    }
    
    private func handleTotalandSubtotalChange(){
        let subtotal = txtPrice.doubleValue * txtAmount.doubleValue;
        let total = subtotal * txtIva.doubleValue;
        txtSubtotal.doubleValue = subtotal;
        txtTotal.doubleValue = total;
    }
}
