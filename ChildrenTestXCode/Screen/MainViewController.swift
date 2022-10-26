//
//  ViewController.swift
//  ChildrenTestXCode
//
//  Created by Никита Мошенцев on 24.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var parentNameTextField: UITextField!
    @IBOutlet weak var ageParentTextField: UITextField!
    @IBOutlet weak var childrenTableView: UITableView!
    @IBOutlet weak var addChildrenButton: UIButton!
    
    //MARK: Private properties
    var usersInfo = Parent(name: "", age: "", childrens: [])
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: IBActions
    @IBAction func tapAddChildren(_ sender: UIButton) {
        addChildrenRow()
    }
    
    @IBAction func tapClearChildren(_ sender: UIButton) {
        presentAlertController()
    }
    
    private func configure() {
        self.childrenTableView.isHidden = true
        ageParentTextField.delegate = self
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        childrenTableView.register(UINib(nibName: "ChildrenCell", bundle: nil),
                                   forCellReuseIdentifier: "childrenCell")
    }
    
    //MARK: Private methods
    private func addChildrenRow() {
        self.childrenTableView.isHidden = false
            childrenTableView.beginUpdates()
        let indexPath = IndexPath(row: usersInfo.childrens.count, section: 0)
            childrenTableView.insertRows(at: [indexPath], with: .automatic)
        usersInfo.childrens.append(Children(name: "", age: "", id: usersInfo.childrens.count))
            childrenTableView.endUpdates()
        if usersInfo.childrens.count == 5 {
            addChildrenButton.isHidden = true
        }
    }
    
    private func presentAlertController() {
        let alert = UIAlertController(title: "Сбросить данные",
                                      message: "Вы действительно хотите удалить данные",
                                      preferredStyle: .alert)
        let alertClearInfo = UIAlertAction(title: "Сбросить настройки", style: .default) { _ in
            self.deleteInfo()
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(alertClearInfo)
        alert.addAction(alertCancel)
        present(alert, animated: true)
    }
    
    private func deleteInfo() {
        var indexPaths = [IndexPath]()
        for i in 0..<usersInfo.childrens.count {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        childrenTableView.beginUpdates()
        childrenTableView.deleteRows(at: indexPaths, with: .fade)
        usersInfo.childrens = []
        childrenTableView.endUpdates()
        childrenTableView.isHidden = true
        parentNameTextField.text = ""
        ageParentTextField.text = ""
        addChildrenButton.isHidden = false
    }
}

//MARK: Table View Delegate
extension MainViewController: UITableViewDelegate {
 
}

//MARK: Table View Data Source
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersInfo.childrens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let childrenCell = childrenTableView.dequeueReusableCell(withIdentifier: "childrenCell", for: indexPath)
        let currentId = usersInfo.childrens[indexPath.row].id
        guard let cell = childrenCell as? ChildrenCell else { return UITableViewCell() }
        cell.delegate = self
        cell.getIndexPath(indexPath: indexPath)
        cell.idChildren = currentId
        cell.nameChildTextFields.text = usersInfo.childrens[indexPath.row].name
        cell.ageChildTextField.text = usersInfo.childrens[indexPath.row].age
        return cell
    }
}

//MARK: Text Field Delegate
extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == ageParentTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

//MARK: Table Cell Delegate
extension MainViewController: MainCellDelegate {
    
    func addNameChildren(name: String, id: Int) {
        let index = usersInfo.childrens.firstIndex { $0.id == id } ?? 0
        usersInfo.childrens[index].name = name
    }
    
    func addAgeChildren(age: String, id: Int) {
        let index = usersInfo.childrens.firstIndex { $0.id == id } ?? 0
        usersInfo.childrens[index].age = age
    }
    
    func deleteRow(id: Int) {
        let row = usersInfo.childrens.firstIndex { $0.id == id } ?? 0
        print(row)
        let indexPath = IndexPath(row: row, section: 0)
        childrenTableView.beginUpdates()
        childrenTableView.deleteRows(at: [indexPath], with: .automatic)
        usersInfo.childrens.remove(at: row)
        childrenTableView.endUpdates()
        addChildrenButton.isHidden = false
    }
}

