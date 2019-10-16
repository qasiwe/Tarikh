//
//  FavoritesViewController.swift
//  ENT
//
//  Created by Dinmukhammed on 27.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit
import SQLite
class FavoritesViewController: UIViewController {

    
    
    var signs:[String] = ["Закладки: ", "Белгілер: "]
    
    var NavTitle = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    let defaults:UserDefaults = UserDefaults.standard
    var favArray: [FavModel] = []
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
        view.addBackground()
        self.tableView.backgroundView?.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        if ViewController.isKazakhGlobal == true{
            NavTitle = signs[1]
        }else{
            NavTitle = signs[0]
        }
        
        
        let navBackgroundImage:UIImage! = #imageLiteral(resourceName: "canvasBack")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage,
                                                                    for: .default)
        self.title = NavTitle + String(favArray.count)
    }
    
    
    
    
    //govnokod
    func loadQuestions(){
        
        let path = Bundle.main.path(forResource: "ent", ofType: "db")!
        let db = try? Connection(path, readonly: true)
        
        let queries: [String] = ["SELECT COUNT(*) FROM IstKazTest ",
                                 "SELECT COUNT(*) FROM IstRusTest "]
        
        var size: [Int64] = [0,0]
      
            for row in try! db!.prepare(queries[1]){
                size[0] = row[0] as! Int64
            }
            
        
            for row in try! db!.prepare(queries[0]){
                size[1] = row[0] as! Int64
            }
            
        let questQueries = ["SELECT _id, v, a FROM IstKazTest WHERE _id = ",
                            "SELECT _id, v, a FROM IstRusTest WHERE _id = "]

        for i in  -size[1]...size[0]{
            
            if( i < 0){
                if let isIdExists = defaults.object(forKey: String(i)) as? Bool {
                    if isIdExists == true {
                      //  defaults.set(true, forKey: keyDefaults)
                        for row in try! db!.prepare(questQueries[0] + String(-i)){
                            let result = FavModel(id: row[0] as! Int64,
                                                     quest: row[1] as! String,
                                                     ans: row[2] as! String,
                                                     isKaz: true)
                            print(result.id)
                            favArray.append(result)
                        }
                    }
                }
                
                
            } else{
                if let isIdExists = defaults.object(forKey: String(i)) as? Bool {
                    if isIdExists == true {
                        for row in try! db!.prepare(questQueries[1] + String(i)){
                            let result = FavModel(id: row[0] as! Int64,
                                                     quest: row[1] as! String,
                                                     ans: row[2] as! String,
                                                     isKaz: false)
                             print(result.id)
                            favArray.append(result)
                        }
                    }
                }
            }
        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (favArray.count)
        return favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoritesTableViewCell
        
        cell.questLabel.text = favArray[indexPath.row].quest
        cell.ansLabel.text = favArray[indexPath.row].ans
        
        //
        
        var keyDefaults:String = String(favArray[indexPath.row].id)
        if favArray[indexPath.row].isKaz{
            print("HERE")
            keyDefaults = String(-favArray[indexPath.row].id)
        }
        if let isFavorite = defaults.object(forKey: keyDefaults ) as? Bool {
            if isFavorite == true {
              
                cell.favIcon.setImage(#imageLiteral(resourceName: "star-3"), for: .normal)
            }else{
            
                cell.favIcon.setImage(#imageLiteral(resourceName: "star-1"), for: .normal)
            }
        }

        
        //
        
        cell.curId = favArray[indexPath.row].id
        cell.isKaz = favArray[indexPath.row].isKaz
        let selectedCellColor = UIView()
        selectedCellColor.backgroundColor = .clear
        cell.selectedBackgroundView = selectedCellColor
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 184
    }
}
