import Cocoa

class ShowUsersViewController: ShowInformationViewController {
    @objc dynamic var users: [User] = Users.getUsers();
    
    override func deleteClicked(_ sender: Any) {
        let selectedId = txtId.integerValue;
        let alert = NSAlert();
        do{
            try Users.deleteOneById(selectedId)
            alert.messageText = "El usuario se ha borrado con exito."
            print("ejecuta")
        }catch UsersErrors.userNotFound{
            alert.messageText = "No se ha encontrado el usuario."
        }catch{
            alert.messageText = "Se produjo un error."
        }
        alert.runModal();
        self.dismiss(self);
    }

}
