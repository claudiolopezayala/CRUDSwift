import Cocoa

class ShowSalesViewController: ShowInformationViewController {
    @objc dynamic var sales: [Sale] = Sales.getSales();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func deleteClicked(_ sender: Any) {
        let selectedId = txtId.integerValue;
        let alert = NSAlert();
        do{
            try Sales.deleteOneById(selectedId)
            alert.messageText = "Se ha borrado con exito."
        }catch SalesErrors.saleNotFound{
            alert.messageText = "No se ha encontrado la compra."
        }catch{
            alert.messageText = "Se produjo un error."
        }
        alert.runModal();
        self.dismiss(self)
    }
    
}
