import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    
    @IBAction func Verify(_ sender: Any) {
       authenticateUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func authenticateUser() {
        let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "User Verification"

                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                    [weak self] success, authenticationError in

                    DispatchQueue.main.async {
                        if success {
                            self?.performSegue(withIdentifier: "Passcodesegue", sender: self)
                        } else {
                            let ac = UIAlertController(title: "Authentication failed", message: "Please try again.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self?.present(ac, animated: true)
                        }
                    }
                }
            } 
    }
}
