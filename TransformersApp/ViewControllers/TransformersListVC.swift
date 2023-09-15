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
        let array = transformersManager.getTransformersList()
        
        var autobotsArray:[Transformer] = []
        var decepticonsArray:[Transformer] = []
        
        for i in 0..<array.count{
            if(array[i].team == "A"){
                autobotsArray.append(array[i])
            }else if(array[i].team == "D"){
                decepticonsArray.append(array[i])
            }
        }
        
        autobotsArray.sort(by: {$0.rank > $1.rank})
        decepticonsArray.sort(by: {$0.rank > $1.rank})
        
        
        var matchStarted = true
        var autobotsEliminated = 0
        var decepticonsEliminated = 0
        
        while matchStarted{
            if(autobotsArray.count == 0 || decepticonsArray.count == 0){
                matchStarted = false
            }else{
            
            resultOfFight(autobot: autobotsArray[0], decepticon: decepticonsArray[0]){
                winner in
                if(winner == "autobot"){
                    decepticonsArray.remove(at: 0)
                    decepticonsEliminated = decepticonsEliminated + 1
                }else if(winner == "decepticon"){
                    autobotsArray.remove(at: 0)
                    autobotsEliminated = autobotsEliminated + 1
                }else if(winner == "none"){
                    autobotsArray.removeAll()
                    decepticonsArray.removeAll()
                    self.showAlertWithOkButton(message: "Everything is destroyed")
                    matchStarted = false
                }else if(winner == "draw"){
                    autobotsArray.remove(at: 0)
                    decepticonsArray.remove(at: 0)
                    
                    decepticonsEliminated = decepticonsEliminated + 1
                    autobotsEliminated = autobotsEliminated + 1
                }
            }
            }
        }
        
        if(autobotsEliminated > decepticonsEliminated){
            self.showAlertWithOkButton(message: "Decepticons Won")
        }else{
            self.showAlertWithOkButton(message:"Autobots Won")
        }
    }
    
    
    
    private func resultOfFight(autobot:Transformer, decepticon: Transformer, winner: @escaping (String) -> Void){
        
        //Special Rules
        if(autobot.name == "Optimus Prime" || autobot.name == "Predaking" ){
            if(decepticon.name == "Optimus Prime" || decepticon.name == "Predaking" ){
                print("all competitors destroyed")
                winner("none")
                return
            
            }else{
                print("Autobot Domination")
                winner("autobot")
                return
            }
        }else if(decepticon.name == "Optimus Prime" || decepticon.name == "Predaking" ){
            if(autobot.name == "Optimus Prime" || autobot.name == "Predaking" ){
                print("all competitors destroyed")
                winner("none")
                return
            }else{
                print("Decepticon Domination")
                winner("decepticon")
                return
            }
        }
        
        
        //Points Difference of courage, skill or strength
        if((abs(autobot.courage - decepticon.courage)) >= 4){
            if(autobot.courage > decepticon.courage){
                print("Decepticon Ran away")
                winner("autobot")
                return
            }else{
                print("Autobot Ran away")
                winner("decepticon")
                return
            }
        }else if((abs(autobot.strength - decepticon.strength)) >= 3){
            if(autobot.strength > decepticon.strength){
                print("Decepticon Ran away")
                winner("autobot")
                return
            }else{
                print("Autobot Ran away")
                winner("decepticon")
                return
            }
        }else if((abs(autobot.skill - decepticon.skill)) >= 3){
            if(autobot.skill > decepticon.skill){
                print("Decepticon Ran away")
                winner("autobot")
                return
            }else{
                print("Autobot Ran away")
                winner("decepticon")
                return
            }
        }else{
            //based on rating
            
            if(autobot.overallRating ?? 0 > decepticon.overallRating ?? 0){
                print("Autobot Won the battle")
                winner("autobot")
                return
            }else if(autobot.overallRating ?? 0 == decepticon.overallRating ?? 0){
                print("its a tie")
                winner("draw")
                return
            }else{
                print("Decepticon won the battle")
                winner("decepticon")
                return
            }
        }
        
        winner("empty")
        
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
