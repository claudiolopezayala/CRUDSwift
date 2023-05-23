import Cocoa

class Buys {
    private var buys: [Buy] = [];
    
    private static var instance: Buys = {
        let buys = Buys();
        try! buys.addDefaultBuys();
        return buys;
    }();
    
    private init() {}
    
    private func addDefaultBuys () throws{
        var defaultProductBought: Product = try Inventory.getOneById(1)
        let buy = Buy(productId: defaultProductBought.id, productName: defaultProductBought.name, productDescription: defaultProductBought.productDescription, amount: 50, price: defaultProductBought.buyPrice, category: defaultProductBought.category);
        buy.id = 1;
        self.buys.append(buy);
    }
    
    public static func addBuy(_ buy: Buy){
        buy.id = calculateId();
        instance.buys.append(buy);
    }
    
    public static func getBuys() -> [Buy] {
        return instance.buys.map {
            $0.copy();
        }
    }
    
    private static func calculateId() -> Int{
        let lastBuy = instance.buys.last;
        var lastId:Int;
        
        if let unwrapedBuy = lastBuy{
            lastId = unwrapedBuy.id;
        }else{
            lastId = 0;
        }
        return (lastId + 1);
    }
    public static func replaceOneById (buy: Buy, id: Int) throws{
        for (index, ebuy) in instance.buys.enumerated(){
            if(ebuy.id == id){
                instance.buys[index] = buy;
                instance.buys[index].id = id;
                return
            }
        }
        throw BuysErrors.buyNotFound;
    }
    
    public static func getOneById(_ id: Int) throws -> Buy{
        for (index, buy)  in instance.buys.enumerated(){
            if(buy.id == id){
                return instance.buys[index].copy();
            }
        }
        throw BuysErrors.buyNotFound;
    }
    
    public static func deleteOneById(_ id: Int) throws {
        for (index, buy) in instance.buys.enumerated(){
            if(buy.id == id){
                instance.buys.remove(at: index);
                return
            }
        }
        throw BuysErrors.buyNotFound;
    }
}

enum BuysErrors : Error {
    case buyNotFound;
}
