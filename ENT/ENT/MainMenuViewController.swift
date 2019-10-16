//
//  ViewController.swift
//  ENT
//
//  Created by Dinmukhammed on 14.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    
    let defaults:UserDefaults = UserDefaults.standard
    static var isKazakhGlobal = false
    
    
    let menu = ["Сменить язык", "Пройти тест", "Игра на запоминание",
                "Поиск по базе","Закладки"]
    let desc = ["Қазақ тіліне өзгерту",
                "Тест из 25 случайно отобранных вопросов из базы",
                "Карточки с вопросом и ответом",
                "Поиск по ключевому слову и ответам",
                "Сохраненные вопросы"]
    
    
    let menuKaz = ["Тілін ауыстыру", "Сынақтаманы өту", "Есте сақтау ойыны",
                   "Қордың ішінде іздеу","Менің белгілерім"]
    
    let descKaz = ["Сменить на русский язык",
                "25 кездейсоқ сұрақтан тұратын сынақтаманы өту",
                "Сұрақ пен жауап карточкалар",
                "Негізгі сөзбен Іздеу",
                "Сақталған сұрақтар"]
                
    let icons = [#imageLiteral(resourceName: "open-book"),#imageLiteral(resourceName: "list"),#imageLiteral(resourceName: "network"),#imageLiteral(resourceName: "search"), #imageLiteral(resourceName: "star")]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.addBackground()
       
    }
    


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BetaCell
        
        
            if ViewController.isKazakhGlobal == false {
                cell.nameLabel.text = menu[indexPath.row]
                cell.descLabel.text = desc[indexPath.row]
            }else{
                cell.nameLabel.text = menuKaz[indexPath.row]
                cell.descLabel.text = descKaz[indexPath.row]
            }
       
        cell.imageLabel.image = icons[indexPath.row]
      
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        
        let selectedCellColor = UIView()
        selectedCellColor.backgroundColor = .clear
        cell.selectedBackgroundView = selectedCellColor
        tableView.separatorStyle = .none
        return cell
    }
  
}
extension ViewController: UITableViewDelegate{
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            if let isKazakh = defaults.object(forKey: "isKazakh" ) as? Bool {
                if isKazakh == false {
                    defaults.set(true, forKey: "isKazakh")
                    ViewController.isKazakhGlobal = true
                     tableView.reloadData()
                }else{
                    defaults.set(false, forKey: "isKazakh")
                    ViewController.isKazakhGlobal = false
                     tableView.reloadData()
                }
            
            }else{
                ViewController.isKazakhGlobal = true
                defaults.set(true, forKey: "isKazakh")
                tableView.reloadData()
            }
        }
        
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "tryTest", sender: nil)
        }
        if indexPath.row == 2 {
            self.performSegue(withIdentifier: "toGame", sender: nil)
        }
        if indexPath.row == 3 {
            self.performSegue(withIdentifier: "trySearch", sender: nil)
        }
        if indexPath.row == 4 {
            self.performSegue(withIdentifier: "toFav", sender: nil)
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
extension ViewController: UINavigationControllerDelegate{
    
}
