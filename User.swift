import Cocoa

class User: NSObject {
    
    @objc dynamic var id:Int
    @objc dynamic var name:String
    @objc dynamic var lastname:String
    @objc dynamic var secondLastname:String
    @objc dynamic var email:String
    @objc dynamic var password:String
    @objc dynamic var age: Int
    @objc dynamic var birthday:Date
    @objc dynamic var role:String
    
    init(name: String, lastname: String, secondLastname: String, email: String, password: String, birthday: Date, role: String) {
        self.id = -1;
        self.name = name;
        self.lastname = lastname;
        self.secondLastname = secondLastname;
        self.email = email;
        self.password = password;
        self.age = birthday.age;
        self.birthday = birthday;
        self.role = role;
    }
    
    private convenience init(id:Int, name: String, lastname: String, secondLastname: String, email: String, password: String, birthday: Date, role: String) {
        self.init(name: name, lastname: lastname, secondLastname: secondLastname, email: email, password: password, birthday: birthday, role: role)
        self.id = id;
    }
    
    public func copy() -> User {
        let copy = User(id:self.id, name: self.name, lastname: self.lastname, secondLastname: self.secondLastname, email: self.email, password: self.password, birthday: self.birthday, role: self.role);
        return copy;
    }
    
}

extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}
