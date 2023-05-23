import Cocoa

class Users {
    private var users: [User] = [];
    
    private static var instance: Users = {
        let users = Users();
        users.addDefaultUsers();
        return users
    }();
    
    private init() {}
    
    private func addDefaultUsers () {
        let admin = createDefaultUser("admin");
        let sales = createDefaultUser("sales");
        let shopping = createDefaultUser("shopping");
        let client = createDefaultUser("client");
        
        admin.id = calculateIdPreInstance();
        self.users.append(admin);
        
        sales.id = calculateIdPreInstance();
        self.users.append(sales);
        
        shopping.id = calculateIdPreInstance();
        self.users.append(shopping);
        
        client.id = calculateIdPreInstance();
        self.users.append(client);
        
        func calculateIdPreInstance() -> Int{
            let lastUser = self.users.last;
            var lastId: Int;
            if let unwrapedUser = lastUser{
                lastId = unwrapedUser.id;
            }else{
                lastId = 0;
            }
            return (lastId + 1);
        }
        
    }
    
    private  func createDefaultUser (_ role: String) -> User {
        
        let currentTime = Date();
        let defaultValue = "Default\(role)";
        
        let user = User(name: defaultValue, lastname: defaultValue, secondLastname: defaultValue, email: defaultValue, password: "1234", birthday: currentTime, role: role);
        
        return user;
    }
    
    public static func addUser (_ user: User) {
        user.id = calculateId();
        instance.users.append(user);
    }
    
    public static func getUsers () -> [User] {
        return instance.users.map{
            $0.copy();
        }
    }
    
    private static func calculateId() -> Int{
        let lastUser = instance.users.last;
        var lastId: Int;
        if let unwrapedUser = lastUser{
            lastId = unwrapedUser.id;
        }else{
            lastId = 0;
        }
        return (lastId + 1);
    }
    
    public static func replaceOneById (user: User, id: Int) throws{
        for (index, euser) in instance.users.enumerated(){
            if(euser.id == id){
                instance.users[index] = user;
                instance.users[index].id = id;
                return
            }
        }
        throw UsersErrors.userNotFound
    }
    
    public static func deleteOneById(_ id: Int) throws {
        for (index, user) in instance.users.enumerated(){
            if(user.id == id){
                instance.users.remove(at: index);
                return
            }
        }
        throw UsersErrors.userNotFound
    }
    
    public static func getOneById(_ id: Int) throws -> User{
        for (index, user) in instance.users.enumerated(){
            if(user.id == id){
                return instance.users[index].copy();
            }
        }
        throw UsersErrors.userNotFound
    }
    
    public static func getOneByEmail (_ email: String) throws -> User{
        for (index, user) in instance.users.enumerated(){
            if(user.email == email){
                return instance.users[index];
            }
        }
        throw UsersErrors.userNotFound;
    }

}

enum UsersErrors: Error{
    case userNotFound;
}
