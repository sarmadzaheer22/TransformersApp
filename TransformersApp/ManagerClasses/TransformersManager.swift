//
//  TransformersManager.swift
//  TransformersApp
//
//  Created by capregsoft on 14/09/2023.
//

import Foundation


class TransformersManager{
    
    func addTransformer(transformerObject:Transformer,completionHandler: @escaping (Bool) -> Void){
         
        var myObject = transformerObject
        
        myObject.overallRating = transformerObject.strength + transformerObject.speed + transformerObject.intelligence + transformerObject.endurance + transformerObject.firepower
        
        var transformersList = getTransformersList()
        transformersList.append(myObject)
        do{
            let encodedData = try JSONEncoder().encode(transformersList)
            UserDefaults.standard.set(encodedData, forKey: "transArray")
            completionHandler(true)
        }catch{
            completionHandler(false)
        }
    }
    
    func getTransformer(id:String,completionHandler: @escaping (Transformer?,Bool) -> Void){
        let transformerList = getTransformersList()
        
        for i in 0..<transformerList.count{
            if(transformerList[i].id == id){
                completionHandler(transformerList[i], true)
            }
        }
        completionHandler(nil, false)
    }
    
    func editTransformer(transformer:Transformer,completionHandler: @escaping (Bool) -> Void){
        var transformerList = getTransformersList()
        
        var myObject = transformer
        
        myObject.overallRating = transformer.strength + transformer.speed + transformer.intelligence + transformer.endurance + transformer.firepower
        
        
        for i in 0..<transformerList.count{
            if(transformerList[i].id == transformer.id){
                transformerList[i] = myObject
                do{
                    let encodedData = try JSONEncoder().encode(transformerList)
                    UserDefaults.standard.set(encodedData, forKey: "transArray")
                    completionHandler(true)
                }catch{
                    completionHandler(false)
                }
            }
        }
        completionHandler(false)

    }
    
    func deleteTransformer(id:String,completionHandler: @escaping (Bool) -> Void){
        var transformerList = getTransformersList()
        
        for i in 0..<transformerList.count{
            if(transformerList[i].id == id){
                transformerList.remove(at: i)
                do{
                    let encodedData = try JSONEncoder().encode(transformerList)
                    UserDefaults.standard.set(encodedData, forKey: "transArray")
                    completionHandler(true)
                }catch{
                    completionHandler(false)
                }
            }
        }
        completionHandler(false)

    }
    
    
    func getTransformersList()->[Transformer]{
        if let savedData = UserDefaults.standard.object(forKey: "transArray") as? Data {
            do{
                let savedTransformers = try JSONDecoder().decode([Transformer].self, from: savedData)
                    return savedTransformers
            } catch {
                return []
            }
        }else{
            return []
        }
    }
    
    
    func checkIdIsFree(id:String)->Bool{
        var transformerList = getTransformersList()
        
        for i in 0..<transformerList.count{
            if(transformerList[i].id == id){
                return false
            }
        }
        return true
    }
}
