import Cocoa

class LogInViewController: NSViewController {

    @IBOutlet weak var btnLogIn: NSButton!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtPassword: NSSecureTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        var authorized: Bool = false;
        let users = Users.getUsers();
        
        for user in users {
            if (txtEmail.stringValue == user.email && txtPassword.stringValue == user.password) {
                authorized = true
                performSegue(withIdentifier: user.role, sender: self);
            }
        
        }
        if (!authorized){
            let alert = NSAlert();
            alert.messageText  = "No coincide el correo y contraseña.";
            alert.runModal();
        }
        
        
        
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "client"){
            let client = try! Users.getOneByEmail(txtEmail.stringValue)
            (segue.destinationController as! ShowFilteredSalesViewController).salesToDisplay = Sales.getSalesByClientId(client.id);
        }
    }
}
