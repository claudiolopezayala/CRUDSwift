import Foundation

class User{
    var username:String
    var password:String
    var id:Int
    var nombre:String
    var apellidoP:String
    var apellidoM:String
    var email:String
    var telefono:String
    var genero:String
    var role:Int
    
    init(_ username: String,_ password: String,_ id: Int,_ nombre: String,_ apellidoP: String,_ apellidoM: String,_ email: String,_ telefono: String,_ genero: String,_ role: Int) {
        self.username = username
        self.password = password
        self.id = id
        self.nombre = nombre
        self.apellidoP = apellidoP
        self.apellidoM = apellidoM
        self.email = email
        self.telefono = telefono
        self.genero = genero
        self.role = role
    }
}
