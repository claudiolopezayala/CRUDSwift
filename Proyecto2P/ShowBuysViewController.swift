import Cocoa

class ShowBuysViewController: ShowInformationViewController {
    @objc dynamic var buys: [Buy] = Buys.getBuys();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func deleteClicked(_ sender: Any) {
        let selectedId = txtId.integerValue;
        let alert = NSAlert();
        do{
            try Buys.deleteOneById(selectedId)
            alert.messageText = "Se ha borrado con exito."
        }catch BuysErrors.buyNotFound{
            alert.messageText = "No se ha encontrado la compra."
        }catch{
            alert.messageText = "Se produjo un error."
        }
        alert.runModal();
        self.dismiss(self)
    }
    
}
