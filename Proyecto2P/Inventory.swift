import Cocoa

class Inventory {
    private var inventory: [Product] = [];
    
    private static var instance: Inventory = {
        let inventory = Inventory();
        inventory.addDefaultProduct();
        return inventory;
    }();
    
    private init() {}
    
    private func addDefaultProduct () {
        let A4Paper = Product(name: "Papel A4", productDescription: "Papel bond tamaño A4", buyPrice: 0.60, sellPrice: 1.5, category: "Papel", stock: 200);
        
        let A4Opaline = Product(name: "Opalina A4", productDescription: "Papel opalina tamaño A4", buyPrice: 2.05, sellPrice: 4.5, category: "Papel", stock: 200)
        
        A4Paper.id = calculateIdPreInstance()
        self.inventory.append(A4Paper);
        
        A4Opaline.id = calculateIdPreInstance();
        self.inventory.append(A4Opaline);
        
        func calculateIdPreInstance() -> Int{
            let lastProduct = self.inventory.last;
            var lastId: Int;
            if let unwrapedProduct = lastProduct{
                lastId = unwrapedProduct.id;
            }else{
                lastId = 0;
            }
            return (lastId + 1);
        }
    }
    
    public static func addProduct (_ product: Product) {
        product.id = calculateId();
        instance.inventory.append(product)
    }
    
    public static func getInventory () -> [Product] {
        return instance.inventory.map {
            $0.copy();
        }
    }
    private static func calculateId() -> Int{
        let lastProduct = instance.inventory.last;
        var lastId: Int;
        if let unwrapedProduct = lastProduct{
            lastId = unwrapedProduct.id;
        }else{ 
            lastId = 0;
        }
        return (lastId + 1);
    }
    
    public static func replaceOneById (product: Product, id: Int) throws{
        for (index, eProduct) in instance.inventory.enumerated(){
            if(eProduct.id == id){
                instance.inventory[index] = product;
                instance.inventory[index].id = id;
                return
            }
        }
        throw InventoryErrors.productNotFound
    }
    
    public static func deleteOneById(_ id: Int) throws {
        for (index, product) in instance.inventory.enumerated(){
            if(product.id == id){
                instance.inventory.remove(at: index);
                return
            }
        }
        throw InventoryErrors.productNotFound;
    }
    
    public static func getOneById(_ id: Int) throws -> Product{
        for (index, product) in instance.inventory.enumerated(){
            if(product.id == id){
                return instance.inventory[index].copy();
            }
        }
        throw InventoryErrors.productNotFound;
    }
    
    public static func changeSellPriceById(_ newSellPrice:Double,_ id:Int){
        instance.inventory[id].sellPrice = newSellPrice;
    }
    
    public static func getOneByName (_ name: String) throws -> Product{
        for product in instance.inventory{
            if (product.name == name){
                return product
            }
        }
        throw InventoryErrors.productNotFound
    }
}

enum InventoryErrors: Error{
    case productNotFound;
}
