//
//  SearchViewController.swift
//  ENT
//
//  Created by Dinmukhammed on 25.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit
import SQLite

class SearchViewController: UIViewController, UITextFieldDelegate{

  
    @IBOutlet weak var searchTextField: UITextField!
    
    
     @IBOutlet weak var tableView: UITableView!
     var searchRes: [SearchModel] = []
     var filteredResult: [SearchModel] = []

    
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
            if ViewController.isKazakhGlobal == false {
                searchTextField.placeholder = "Поиск"
            }else{
              
                searchTextField.placeholder = "Іздеу"
            }
        
       
        load_questions()

        let navBackgroundImage:UIImage! = #imageLiteral(resourceName: "canvasBack")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage,
                                                                    for: .default)
        
        self.tableView.backgroundView?.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
      
        searchTextField.frame = CGRect(x: 8, y: 5, width: self.view.frame.width - 80, height: 34)
        searchTextField.addTarget(self, action: #selector(self.textIsChanging(textField:)), for: .editingChanged)

        view.addBackground()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textIsChanging(textField: UITextField) {
        
        if searchTextField.text! == "" {
            filteredResult = []
        } else {
           
            filteredResult = searchRes.filter { $0.quest.lowercased().contains(searchTextField.text!.lowercased()) }
        }
        
        tableView.reloadData()
        
    }
    
    func load_questions(){
        
        let path = Bundle.main.path(forResource: "ent", ofType: "db")!
        let db = try? Connection(path, readonly: true)
        
        let queries: [String] = ["SELECT _id, v, a FROM IstKazTest", "SELECT _id, v, a FROM IstRusTest"]
        
        var query = queries[1]
        
        if (ViewController.isKazakhGlobal == false){
            query = queries[1]
        }else{
            query = queries[0]
            
        }
        
            for row in try! db!.prepare(query) {
                
                let result = SearchModel(id: row[0] as! Int64,
                                        quest: row[1] as! String,
                                        ans: row[2] as! String)
                searchRes.append(result)
            }

    }


}



extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredResult.count > 10{
            return 10
        }
        
        return filteredResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        cell.questLabel.text = filteredResult[indexPath.row].quest
        cell.ansLabel.text = filteredResult[indexPath.row].ans
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 184
    }
}
