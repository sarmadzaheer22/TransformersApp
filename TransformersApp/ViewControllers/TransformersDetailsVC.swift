//
//  TransformersDetailsVC.swift
//  TransformersApp
//
//  Created by capregsoft on 15/09/2023.
//

import UIKit

class TransformersDetailsVC: UIViewController {
    
    @IBOutlet weak var autobotsImage: UIImageView!
    @IBOutlet weak var autobotsContainer: UIView!
    @IBOutlet weak var decepticonsContainer: UIView!
    
    @IBOutlet weak var decepticonsImage: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var strengthTF: UITextField!
    @IBOutlet weak var enduranceTF: UITextField!
    @IBOutlet weak var FirepowerTF: UITextField!
    @IBOutlet weak var intelligenceTF: UITextField!
    @IBOutlet weak var rankTF: UITextField!
    @IBOutlet weak var skillTF: UITextField!
    @IBOutlet weak var speedTF: UITextField!
    @IBOutlet weak var courageTF: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var transformerObject:Transformer?
    let transformersManager = TransformersManager()
    var isEditScreen = false
    
    var isAutobot = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        autobotsImage.applyshadowWithCorner(containerView: autobotsContainer, cornerRadious: 10)
        decepticonsImage.applyshadowWithCorner(containerView: decepticonsContainer, cornerRadious: 10)
        self.decepticonsContainer.isHidden = true
        
        let autobotTap = UITapGestureRecognizer(target: self, action: #selector(autobotTapped))
            autobotsImage.isUserInteractionEnabled = true
            autobotsImage.addGestureRecognizer(autobotTap)
        
        let decepticonTap = UITapGestureRecognizer(target: self, action: #selector(decepticonTapped))
            decepticonsImage.isUserInteractionEnabled = true
            decepticonsImage.addGestureRecognizer(decepticonTap)

        if(isEditScreen){
            if(transformerObject != nil){
                self.nameTF.text = transformerObject?.name
                self.strengthTF.text = String(transformerObject!.strength)
                self.enduranceTF.text = String(transformerObject!.endurance)
                self.FirepowerTF.text = String(transformerObject!.firepower)
                self.intelligenceTF.text = String(transformerObject!.intelligence)
                self.rankTF.text = String(transformerObject!.rank)
                self.skillTF.text = String(transformerObject!.skill)
                self.speedTF.text = String(transformerObject!.speed)
                self.courageTF.text = String(transformerObject!.courage)
                
            }
        }
    }
    
    @objc func autobotTapped(){
        
        self.decepticonsContainer.isHidden = true
        self.autobotsContainer.isHidden = false
        
        self.isAutobot = true
        
    }
    
    @objc func decepticonTapped(){
        self.decepticonsContainer.isHidden = false
        self.autobotsContainer.isHidden = true
        
        self.isAutobot = false
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if(isEditScreen){
            transformerObject?.name = nameTF.text ?? ""
            if(isAutobot){transformerObject?.team = "A"}else{transformerObject?.team = "D"}
            
            transformerObject?.strength = Int(self.strengthTF.text!) ?? 0
            transformerObject?.intelligence = Int(self.intelligenceTF.text!) ?? 0
            transformerObject?.speed = Int(self.speedTF.text!) ?? 0
            transformerObject?.endurance = Int(self.enduranceTF.text!) ?? 0
            transformerObject?.rank = Int(self.rankTF.text!) ?? 0
            transformerObject?.courage = Int(self.courageTF.text!) ?? 0
            transformerObject?.firepower = Int(self.FirepowerTF.text!) ?? 0
            transformerObject?.skill = Int(self.skillTF.text!) ?? 0
            transformerObject?.teamIcon = ""
            
            
            transformersManager.editTransformer(transformer: transformerObject!){
                success in
                
                if !success{
                    self.showAlertWithOkButton()
                }else{
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }else{
            
            transformerObject = Transformer(id: "", name: "", strength: 0, intelligence: 0, speed: 0, endurance: 0, rank: 0, courage: 0, firepower: 0, skill: 0, team: "A", teamIcon: "")
            
            transformerObject?.name = nameTF.text ?? ""
            if(isAutobot){transformerObject?.team = "A"}else{transformerObject?.team = "D"}
            
            transformerObject?.strength = Int(self.strengthTF.text!) ?? 0
            transformerObject?.intelligence = Int(self.intelligenceTF.text!) ?? 0
            transformerObject?.speed = Int(self.speedTF.text!) ?? 0
            transformerObject?.endurance = Int(self.enduranceTF.text!) ?? 0
            transformerObject?.rank = Int(self.rankTF.text!) ?? 0
            transformerObject?.courage = Int(self.courageTF.text!) ?? 0
            transformerObject?.firepower = Int(self.FirepowerTF.text!) ?? 0
            transformerObject?.skill = Int(self.skillTF.text!) ?? 0
            transformerObject?.teamIcon = ""
            transformerObject?.overallRating = 0
            
            
            var id = String(Int.random(in: 10000...99999))
            
            
            while (!transformersManager.checkIdIsFree(id: id)){
                id = String(Int.random(in: 10000...99999))
            }
            
            transformerObject?.id = id
            
            transformersManager.addTransformer(transformerObject: transformerObject!){
                success in
                
                if(success){
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.showAlertWithOkButton()
                }
            }
            
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


