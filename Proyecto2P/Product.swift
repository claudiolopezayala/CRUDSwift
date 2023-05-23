import Cocoa

class Product: NSObject {
    @objc dynamic var id: Int;
    @objc dynamic var name: String;
    @objc dynamic var productDescription: String;
    @objc dynamic var buyPrice: Double;
    @objc dynamic var sellPrice: Double;
    @objc dynamic var category: String;
    @objc dynamic var stock: Int;
    
    init(name: String, productDescription: String, buyPrice: Double, sellPrice: Double, category: String, stock: Int) {
        self.id = -1;
        self.name = name;
        self.productDescription = productDescription;
        self.buyPrice = buyPrice;
        self.sellPrice = sellPrice;
        self.category = category;
        self.stock = stock;
    }
    
    public func setId(_ id: Int){
        self.id = id;
    }
    
    private convenience init(id:Int, name: String, productDescription: String, buyPrice: Double, sellPrice: Double, category: String, stock: Int) {
        self.init(name: name, productDescription: productDescription, buyPrice: buyPrice, sellPrice: sellPrice, category: category, stock: stock)
        self.id = id;
    }
    
    public func copy() -> Product {
        let copy = Product(id:self.id, name: self.name, productDescription: self.productDescription, buyPrice: self.buyPrice, sellPrice: self.sellPrice, category: self.category, stock: self.stock);
        return copy;
    }
}
