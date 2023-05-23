import Cocoa

class Buy: NSObject {
    @objc dynamic var id: Int;
    @objc dynamic var productId: Int;
    @objc dynamic var productName: String;
    @objc dynamic var productDescription: String;
    @objc dynamic var amount: Int;
    @objc dynamic var price: Double;
    @objc dynamic var category: String;
    
    init (productId: Int,productName: String,productDescription: String, amount: Int,price: Double, category: String) {
        var product: Product;
        do{
            product = try Inventory.getOneById(productId)
            product.name = productName;
            product.productDescription = productDescription;
            product.buyPrice = price;
            product.category = category;
            product.stock += amount;
            try Inventory.replaceOneById(product: product, id: productId);
            
        }catch InventoryErrors.productNotFound{
            product = Product(name: productName, productDescription: productDescription, buyPrice: price, sellPrice: price*1.3, category: category, stock: amount)
            Inventory.addProduct(product)
        }catch {}
        self.id = -1;
        self.productId = productId;
        self.productName = productName;
        self.productDescription = productDescription;
        self.amount = amount;
        self.price = price;
        self.category = category;
    }
    
    private init(id: Int, productId: Int, productName: String, productDescription: String, amount: Int, price: Double, category: String) {
        self.id = id;
        self.productId = productId;
        self.productName = productName;
        self.productDescription = productDescription;
        self.amount = amount;
        self.price = price;
        self.category = category;
    }
    
    public func setId(_ id: Int){
        self.id = id;
    }

    public func copy() -> Buy{
        let copy = Buy(id: self.id, productId: self.productId, productName: self.productName, productDescription: self.productDescription, amount: self.amount, price: self.price, category: self.category);
        return copy;
    }
}
