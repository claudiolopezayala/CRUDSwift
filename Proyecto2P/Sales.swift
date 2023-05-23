
import Cocoa

class Sales {
    private var sales: [Sale] = [];
    
    private static var instance: Sales = {
        let sales = Sales();
        try! sales.addDefaultSale();
        return sales;
    }();
    
    private init() {}
    
    private func addDefaultSale() throws{
        var defaultClientSold: User;
        var defaultProductSold: Product;
        defaultClientSold = try Users.getOneByEmail("Defaultclient");
        defaultProductSold = try Inventory.getOneById(1);
        
        let sale = try Sale(clientId: defaultClientSold.id, productId: defaultProductSold.id, amount: 50, price: defaultProductSold.sellPrice, iva: 1.16);
        sale.id = 1;
        self.sales.append(sale);
    }
    
    public static func addSale(_ sale: Sale) {
        sale.id = calculateId();
        instance.sales.append(sale);
    }
    
    public static func getSales() -> [Sale] {
        return instance.sales.map{
            $0.copy();
        }
        
    }
    
    private static func calculateId() -> Int{
        let lastSale = instance.sales.last;
        var lastId: Int;
        
        if let unwrapedSale = lastSale{
            lastId = unwrapedSale.id;
        }else{
            lastId = 0;
        }
        return (lastId + 1);
    }
    
    public static func replaceOneById (sale: Sale, id: Int) throws{
        for (index, esale) in instance.sales.enumerated(){
            if(esale.id == id){
                instance.sales[index] = sale;
                instance.sales[index].id = id;
                return
            }
        }
        throw SalesErrors.saleNotFound;
    }
    
    public static func getOneById(_ id: Int) throws -> Sale{
        for (index, sale)  in instance.sales.enumerated(){
            if(sale.id == id){
                return instance.sales[index].copy();
            }
        }
        throw SalesErrors.saleNotFound;
    }
    
    public static func deleteOneById(_ id: Int) throws {
        for (index, sale) in instance.sales.enumerated(){
            if(sale.id == id){
                instance.sales.remove(at: index);
                return
            }
        }
        throw SalesErrors.saleNotFound;
    }
    
    public static func getSalesByClientId(_ clientId: Int) -> [Sale]{
        var salesToReturn: [Sale] = [];
        for sale in instance.sales{
            if (sale.clientId == clientId){
                salesToReturn.append(sale);
            }
        }
        return salesToReturn;
    }
    

}

enum SalesErrors: Error{
    case saleNotFound
}
