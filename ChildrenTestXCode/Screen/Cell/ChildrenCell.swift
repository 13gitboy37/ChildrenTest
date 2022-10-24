//
//  ChildrenCell.swift
//  ChildrenTestXCode
//
//  Created by Никита Мошенцев on 24.10.2022.
//

import UIKit

class ChildrenCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var nameChildTextFields: UITextField!
    @IBOutlet weak var ageChildTextField: UITextField!
    
    //MARK: Private properties
    private var indexPath = IndexPath()
    
    //MARK: Properties
    var delegate: MainCellDelegate?
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ageChildTextField.delegate = self
    }
    
    //MARK: IBActions
    @IBAction func tapDeleteChildren(_ sender: Any) {
        delegate?.deleteRow(indexPath: indexPath)
        nameChildTextFields.text = ""
        ageChildTextField.text = ""
    }
    
    //MARK: Methods
    func getIndexPath(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func configure() {
        
    }
}

//MARK: Delegate
extension ChildrenCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == ageChildTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
