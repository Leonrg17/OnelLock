import SwiftUI

class View3: UIViewController {
    
    var alphanumeric:Bool = false
    var specialChar:Bool = false
    var password:String = ""
    @IBOutlet weak var passwordLength: UITextField!
    var characters:[String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var characters2:[String] =
        ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","!","@","#","$","%","^","&","*","(",")"]
    
    @IBOutlet weak var generatedPassword: UITextView!
    
    //when user selects alphanumeric only
    @IBAction func selectAN(_ sender: Any) {
        if(alphanumeric == false){
            alphanumeric = true
        }else{
            alphanumeric = false
        }
    }
    
    @IBAction func selectSpecial(_ sender: Any) {
        if(specialChar == false){
            specialChar = true
        }else{
            specialChar = false
        }
    }
    
    //when user presses generate
    @IBAction func generate(_ sender: Any) {
        
        let length = Int(passwordLength.text!)
        
        //clear generated password if assigned already
        if(password != ""){
            password = ""
        }
        
        if(length! > 50){
            password = "Password length cannot exceed 50 characters."
            generatedPassword.text = password
        }else if(!alphanumeric && !specialChar){
            password = "Please select either 'Alphanumeric' or 'Alphanumeric + Special Characters'"
            generatedPassword.text = password
        }else if(alphanumeric && !specialChar){
            for _ in 1...length! {
                        password += characters.randomElement()!
            }
        }else if(!alphanumeric && specialChar){
            for _ in 1...length! {
                        password += characters2.randomElement()!
            }
        }else{
            password = "Please only select one of the options."
            generatedPassword.text = password
        }
        generatedPassword.text = password
    }
    
    //Transferring user inputted data to table view
    @IBOutlet var domain: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var pass: UITextField!
    
    //When pressing save
    
    @IBAction func pressedSave() {
        NotificationCenter.default.post(name: Notification.Name("domain"), object: domain.text)
        NotificationCenter.default.post(name: Notification.Name("username"), object: username.text)
        NotificationCenter.default.post(name: Notification.Name("password"), object: pass.text)
        
    }

}
