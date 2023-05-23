import Cocoa

class UserFormViewController: BaseForm {
    let alert = NSAlert();
    
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtFirstLastname: NSTextField!
    @IBOutlet weak var txtSecondLastname: NSTextField!
    @IBOutlet weak var dateBirthDay: NSDatePicker!
    @IBOutlet weak var txtMail: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtRol: NSTextField!
    
    @IBOutlet weak var btnDone: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if (modifyId != nil){
            handleLoadViewModify();
        }
    }
    
    @IBAction func btnDoneClicked(_ sender: NSButton) {
        if (modifyId != nil){
            handleModifyUser();
        }else{
            handleCreateNewUser();
        }
        self.dismiss(self);
    }
    
    private func handleLoadViewModify(){
        btnDone.title = "Modificar";
        
        do{
            let userToDisplay = try Users.getOneById(modifyId);
            
            txtName.stringValue = userToDisplay.name;
            txtFirstLastname.stringValue = userToDisplay.lastname;
            txtSecondLastname.stringValue = userToDisplay.secondLastname;
            dateBirthDay.dateValue = userToDisplay.birthday;
            txtMail.stringValue = userToDisplay.email;
            txtPassword.stringValue = userToDisplay.password;
            txtRol.stringValue = userToDisplay.role;
            
        }catch UsersErrors.userNotFound{
            alert.messageText = "No se ha encontrado el usuario."
            alert.runModal();
            self.dismiss(self);
        }catch{
            alert.messageText = "Se produjo un error."
            alert.runModal();
            self.dismiss(self);
        }
    }
    
    private func handleCreateNewUser() {
        let name = txtName.stringValue;
        let lastName = txtFirstLastname.stringValue;
        let secondLastName = txtSecondLastname.stringValue;
        let email = txtMail.stringValue;
        let password = txtPassword.stringValue;
        let birthday = dateBirthDay.dateValue;
        let rol = txtRol.stringValue;
        
        let newUser = User(name: name, lastname: lastName, secondLastname: secondLastName, email: email, password: password, birthday: birthday, role: rol);
        
        Users.addUser(newUser);
    }
    
    private func handleModifyUser(){
        let name = txtName.stringValue;
        let lastName = txtFirstLastname.stringValue;
        let secondLastName = txtSecondLastname.stringValue;
        let email = txtMail.stringValue;
        let password = txtPassword.stringValue;
        let birthday = dateBirthDay.dateValue;
        let rol = txtRol.stringValue;
        
        let user = User(name: name, lastname: lastName, secondLastname: secondLastName, email: email, password: password, birthday: birthday, role: rol);
        
        do{
            try Users.replaceOneById(user: user, id: modifyId);
        }
        catch UsersErrors.userNotFound{
            alert.messageText = "No se ha encontrado el usuario."
        }catch{
            alert.messageText = "Se produjo un error."
        }
    }
}


