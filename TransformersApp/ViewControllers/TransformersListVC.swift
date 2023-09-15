//
//  TransformersListVC.swift
//  TransformersApp
//
//  Created by capregsoft on 15/09/2023.
//

import Foundation
import UIKit

class TransformersListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let transformersManager = TransformersManager()
    var listOfTransformers:[Transformer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchData()
        self.tableView.reloadData()
    }
    
    
    func fetchData(){
        self.listOfTransformers = transformersManager.getTransformersList()
        self.tableView.reloadData()
    }
    
    @IBAction func addTransformer(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TransformersDetailsVC") as? TransformersDetailsVC
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc ?? UIViewController(),animated: true)
    }
    
    
    @IBAction func startBattle(_ sender: Any) {
        print("battle commenced")
    }
    
    
}






extension TransformersListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTransformers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerListCell", for: indexPath) as? TransformerListCell{
            cell.UIActions(data: listOfTransformers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TransformersDetailsVC") as? TransformersDetailsVC
        vc?.transformerObject = listOfTransformers[indexPath.row]
        vc?.isEditScreen = true
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc ?? UIViewController(),animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            tableView.isEditing = false
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TransformersDetailsVC") as? TransformersDetailsVC
            vc?.transformerObject = self.listOfTransformers[indexPath.row]
            vc?.isEditScreen = true
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc ?? UIViewController(),animated: true)
            
            
        }
        
        editAction.backgroundColor = .gray
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            tableView.isEditing = false
            
            self.transformersManager.deleteTransformer(id: self.listOfTransformers[indexPath.row].id){
                success in
                
                if(!success){
                    self.showAlertWithOkButton()
                }else{
                    self.fetchData()
                    self.tableView.reloadData()
                }
            }
        }
        
        return [deleteAction]
    }
    
}
