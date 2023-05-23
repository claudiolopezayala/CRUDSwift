
import Cocoa

class Sale: NSObject {
    
    @objc dynamic var id: Int;
    @objc dynamic var clientId: Int;
    @objc dynamic var productId: Int;
    @objc dynamic var amount: Int;
    @objc dynamic var price: Double;
    @objc dynamic var subtotal: Double;
    @objc dynamic var iva: Double;
    @objc dynamic var total: Double;
    
    init(clientId: Int, productId: Int, amount: Int, price: Double, iva: Double) throws{
        let user = try Users.getOneById(clientId);
        if(user.role != "client"){
            throw SaleErrors.userIdNotClientId;
        }
        
        self.id = -1;
        self.clientId = clientId
        self.productId = productId
        self.amount = amount
        self.price = price
        self.subtotal = Double(self.amount) * self.price;
        self.iva = iva
        self.total = self.subtotal * self.iva

        let oldProduct = try Inventory.getOneById(productId);
        
        let newStock = oldProduct.stock - self.amount;
        if (newStock < 0){
            throw SaleErrors.notEnoughStock;
        }
        let updatedProduct = Product(name: oldProduct.name, productDescription: oldProduct.productDescription, buyPrice: oldProduct.buyPrice, sellPrice: self.price, category: oldProduct.category, stock: newStock);
        
        try Inventory.replaceOneById(product: updatedProduct, id: productId);
        
    }
    
    private init(id: Int, clientId: Int, productId: Int, amount: Int, price: Double, subtotal: Double, iva: Double, total: Double) {
        self.id = id
        self.clientId = clientId
        self.productId = productId
        self.amount = amount
        self.price = price
        self.subtotal = subtotal
        self.iva = iva
        self.total = total
    }
    
    public func setId(_ id: Int){
        self.id = id
    }
    
    public func copy() -> Sale {
        let copy = Sale(id: self.id, clientId: self.clientId, productId: self.productId, amount: self.amount, price: self.price, subtotal: self.subtotal, iva: self.iva, total: self.total);
        return copy;
        
    }
}

enum SaleErrors: Error{
    case notEnoughStock;
    case userIdNotClientId
}
