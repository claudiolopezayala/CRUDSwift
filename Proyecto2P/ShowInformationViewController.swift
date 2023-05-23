import Cocoa

class ShowInformationViewController: NSViewController {
    
    
    @IBOutlet weak var txtId: NSTextField!
    
    
    var modify: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.modify = false;
    }
    
    @IBAction func addClicked(_ sender: Any) {
        performSegue(withIdentifier: "form", sender: self);
    }
    @IBAction func modifyClicked(_ sender: Any) {
        self.modify = true;
        performSegue(withIdentifier: "form", sender: self);
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if(segue.identifier == "form" && modify){
            self.modify = false;
            (segue.destinationController as! BaseForm).modifyId = txtId.integerValue;
        }
    }
    @IBAction func deleteClicked(_ sender: Any) {
        
        
    }
}
