import UIKit
class proj{
    var dom: String
    var usern: String
    var password: String
    var id: Int
    var ison:Bool
    
    init(dom: String,usern: String, password: String, id: Int,ison: Bool){
        self.dom = dom
        self.password = password
        self.id = id
        self.usern = usern
        self.ison = ison
    }
}

var test5 = proj(dom: "(Show/hide all)",usern: "(Show/hide all)", password: "(Show/hide all)", id: 0, ison: false)

var showall = false

var elar = [proj]()


var inputDomain = ""
var inputUsername = ""
var inputPassword = ""



class View2: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet var Storage: UITableView!
    
    
    var num = 0
    var line = "(show/hide)"
    
    @IBAction func Logout(_ sender: Any) {
        self.performSegue(withIdentifier: "LogOutsegue", sender: self)
    }
    @IBOutlet var label: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Storage.register(myTableViewCell.nib(), forCellReuseIdentifier: myTableViewCell.identifier)
        Storage.delegate = self
        Storage.dataSource = self
        
        //initial load
        label.text = "Domain:"
        label2.text = "Username:"
        label3.text = "Password:"
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveDomain(_:)), name: Notification.Name("domain"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUsername(_:)), name: Notification.Name("username"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceivePassword(_:)), name: Notification.Name("password"), object: nil)
        
        let userInput = proj(dom: inputDomain, usern: inputUsername, password: inputPassword, id: 0, ison: false)
        
        elar.append(userInput)
        for i in 0...elar.count-1{
            elar[i].id = (i+1)
        }
         
        
    }

    
    //domain
    @objc func didReceiveDomain(_ notification: Notification) {
        let text = notification.object as! String
        inputDomain = text
        Storage.reloadData()
        
    }
    
    //username
    @objc func didReceiveUsername(_ notification: Notification) {
        let text = notification.object as! String
        inputUsername = text
        Storage.reloadData()
    }
    
    //password
    @objc func didReceivePassword(_ notification: Notification) {
        let text = notification.object as! String
        inputPassword = text
        Storage.reloadData()
    }
    
    
    
    
    //table view stuff
   func tableView(_ Storage: UITableView, numberOfRowsInSection section: Int) -> Int {

        return elar.count
    }
    
    
    func tableView(_ Storage: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Storage.dequeueReusableCell(withIdentifier: myTableViewCell.identifier, for: indexPath) as! myTableViewCell
        

        cell.configure(with: elar[indexPath.row].dom)
        
        cell.configure2(with: line + String(elar[indexPath.row].id))
        cell.configure3(with: line + String(elar[indexPath.row].id))
        if elar[indexPath.row].dom == "(Show/hide all)"{
            cell.configure2(with: "(Show/hide all)")
            cell.configure3(with: "(Show/hide all)")
        }
  
            if elar[indexPath.row].ison || showall{
            cell.configure2(with: elar[indexPath.row].usern)
            cell.configure3(with: elar[indexPath.row].password)
            }
        
        cell.delegate = self
        
        
        
        return cell
    }
    
    //following code to delete rows and update database
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            tableView.beginUpdates() //start updating
            elar.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates() //end updating
        }
    }

}



extension View2: myTableViewCellDelegate {
    func didtapbutton(with title: String) {
        for i in 0...elar.count-1 {
            if title == line + String(elar[i].id) || title == elar[i].password {
                if elar[i].ison == true {elar[i].ison = false}
                else {elar[i].ison = true}
            }
            if title == "(Show/hide all)" {
                if showall == true {showall = false}
                else {showall = true}
            }
        }
        num += 1
        
        
        
    
        Storage.reloadData()

    }
}

