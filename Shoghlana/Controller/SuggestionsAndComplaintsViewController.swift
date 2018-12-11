
import UIKit

class SuggestionsAndComplaintsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var complaintTitleTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedHandler.sideMenus(ViewController: self)
        
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
        
        
    }
    

}
