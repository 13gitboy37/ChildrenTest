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
    private var numbOfRows = 0
    
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
            let indexPath = IndexPath(row: numbOfRows, section: 0)
            childrenTableView.insertRows(at: [indexPath], with: .automatic)
            numbOfRows += 1
            childrenTableView.endUpdates()
        if numbOfRows == 5 {
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
        for i in 0..<numbOfRows {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        childrenTableView.beginUpdates()
        childrenTableView.deleteRows(at: indexPaths, with: .fade)
        numbOfRows = 0
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
        numbOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let childrenCell = childrenTableView.dequeueReusableCell(withIdentifier: "childrenCell", for: indexPath)
        guard let cell = childrenCell as? ChildrenCell else { return UITableViewCell() }
        cell.delegate = self
        cell.getIndexPath(indexPath: indexPath)
        cell.nameChildTextFields.text = ""
        cell.ageChildTextField.text = ""
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
    func deleteRow(indexPath: IndexPath) {
        childrenTableView.beginUpdates()
        childrenTableView.deleteRows(at: [indexPath], with: .automatic)
        if numbOfRows != 1 {
            numbOfRows -= 1
        } else {
            numbOfRows = 0
        }
        childrenTableView.endUpdates()
        addChildrenButton.isHidden = false
    }
}

