//
//  myTableViewCell.swift
//  OneLock
//
//  Created by Maria Casillas on 4/21/21.
//

import UIKit

protocol myTableViewCellDelegate: AnyObject {
    func didtapbutton(with title: String)
}

class myTableViewCell: UITableViewCell {
    weak var delegate: myTableViewCellDelegate?
    
    static let identifier = "myTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "myTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    
    
    
    private var title: String = ""
    
    @IBAction func didTapButton(){
        delegate?.didtapbutton(with: title)
    }
    
    func configure (with title: String){
        self.title = title
        button.setTitle(title, for: .normal)
        
    }
    
    func configure2 (with title: String){
        self.title = title
        button2.setTitle(title, for: .normal)

    }
    
    func configure3 (with title: String){
        self.title = title
        button3.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.setTitleColor(.label, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
