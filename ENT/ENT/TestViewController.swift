//
//  Test.swift
//  ENT
//
//  Created by Dinmukhammed on 17.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit
import SQLite
import PMAlertController

class Test: UIViewController {


    var questions: [Question] = []
    var curQuestion = 0
    let defaults:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var ansLabelText: [UIButton]!
    @IBOutlet weak var favLabel: UIButton!
    @IBOutlet weak var curQuestNumberLabel: UILabel!
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var forwardButtonLabel: UIButton!
    @IBOutlet weak var subFrame: UIView!
    @IBOutlet var ansLabelTick: [UIButton]!
    

    @IBAction func favFunc(_ sender: UIButton) {
        var keyDefaults:String = String(questions[curQuestion].id)
        if ViewController.isKazakhGlobal == true{
            keyDefaults = String(-questions[curQuestion].id)
        }
            if let isFavorite = defaults.object(forKey: keyDefaults ) as? Bool {
                if isFavorite == false {
                    defaults.set(true, forKey: keyDefaults)
                    favLabel.setImage(#imageLiteral(resourceName: "star-3"), for: .normal)
                    
                }else{
                    defaults.set(false, forKey: keyDefaults)
                    favLabel.setImage(#imageLiteral(resourceName: "star-1"), for: .normal)
                }
                
            }else{
                defaults.set(true, forKey: keyDefaults)
                favLabel.setImage(#imageLiteral(resourceName: "star-3"), for: .normal)
            }
    }
    
    @IBAction func exitToMain(_ sender: UIButton) {
        
        if (ViewController.isKazakhGlobal == false){
            
            let alertVC = PMAlertController(title: "Выйти в главное меню?", description: "Результат не будет сохранен", image: nil, style: .alert)
            alertVC.addAction(PMAlertAction(title: "Нет", style: .cancel, action: { () -> Void in
                
            }))
            
            alertVC.addAction(PMAlertAction(title: "Да", style: .default, action: { () in
                
                
                DispatchQueue.main.async {
                    
                    UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
            }))
            self.present(alertVC, animated: false, completion: nil)
        }else{
            
            let alertVC = PMAlertController(title: "Басты мәзірге шығу?", description: "Сіздің нәтижесі сақталмайды", image: nil, style: .alert)
            alertVC.addAction(PMAlertAction(title: "Жоқ", style: .cancel, action: { () -> Void in
                
            }))
            
            alertVC.addAction(PMAlertAction(title: "Йә", style: .default, action: { () in
                
                
                DispatchQueue.main.async {
                    
                    UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
            }))
            self.present(alertVC, animated: false, completion: nil)
        }
    }

    
    
    @IBAction func prevQuest(_ sender: UIButton) {
        if curQuestion > 0{
            curQuestion -= 1
        }
        showQuestion()
        
    }
    @IBAction func nextQuest(_ sender: UIButton) {
        if curQuestion >= 24 {
            performSegue(withIdentifier: "toResult", sender: self)
            return
        }
        
        if curQuestion < 24{
            curQuestion += 1
        }
        
        
        showQuestion()
        
    }
    
    func hideStatusBar() {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load_questions()
        showQuestion()
     
        subFrame.layer.cornerRadius = 4
        subFrame.layer.shadowColor = UIColor.black.cgColor
        subFrame.layer.shadowOpacity = 0.15
        subFrame.layer.shadowOffset = CGSize.zero
        subFrame.layer.shadowRadius = 10
        
        for i in 0...4{
            ansLabelTick[i].setImage(#imageLiteral(resourceName: "stillThinking"), for: .highlighted)
            ansLabelText[i].titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        
        view.addBackground()
        hideStatusBar()
        
      
        
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    @IBAction func choose(_ sender: UIButton) {
        questions[curQuestion].choosenAnswer = sender.tag
        
        if curQuestion >= 24 {
            performSegue(withIdentifier: "toResult", sender: self)
            return
        }
 
     
        
        curQuestion += 1
        
        showQuestion()
        
        
    }
    
    func load_questions(){

        let path = Bundle.main.path(forResource: "ent", ofType: "db")!
        let db = try? Connection(path, readonly: true)
        
        let queries: [String] = ["SELECT _id, v, a, b,c,d,e FROM IstKazTest ORDER BY RANDOM() LIMIT 25", "SELECT _id, v, a, b,c,d,e FROM IstRusTest ORDER BY RANDOM() LIMIT 25"]
        
        var query = queries[1]
        
        if (ViewController.isKazakhGlobal == false){
            query = queries[1]
        }else{
            query = queries[0]
            
        }
        
        for row in try! db!.prepare(query) {
            
            var sequence:[Int] = []
            
            while sequence.count != 5 {
                
                let randomNum:Int = Int(arc4random_uniform(5))
        
                if sequence.contains(randomNum){
                    continue
                }
                
                sequence.append(randomNum)
            }
            print(sequence)
    
                var answers: [String] = []
                
                answers.append(row[2] as! String)
                answers.append(row[3] as! String)
                answers.append(row[4] as! String)
                answers.append(row[5] as! String)
                answers.append(row[6] as! String)
                
                let question = Question(id: row[0] as! Int64,
                                        quest: row[1] as! String,
                                        ans: answers as [String],
                                        seq: sequence as [Int])
                
                questions.append(question)
                
            }
        
    }
    
    func showQuestion(){
   
        curQuestNumberLabel.text = String(curQuestion + 1)
        questionLabel.text = questions[curQuestion].quest
        let curSequence = questions[curQuestion].sequenceOfNumbers
        
        var keyDefaults:String = String(questions[curQuestion].id)
        if (ViewController.isKazakhGlobal == false){
            keyDefaults = String(questions[curQuestion].id)
        }else{
            keyDefaults = String(-questions[curQuestion].id)
        }
        
        
        if let isFavorite = defaults.object(forKey: keyDefaults ) as? Bool {
            if isFavorite == true {
          
                favLabel.setImage(#imageLiteral(resourceName: "star-3"), for: .normal)
            }else{
            
                favLabel.setImage(#imageLiteral(resourceName: "star-1"), for: .normal)
            }
            
        }else{
          
            favLabel.setImage(#imageLiteral(resourceName: "star-1"), for: .normal)
        }
        
        
        let index = questions[curQuestion].choosenAnswer
        if index >= 0 {
            for i in 0...4{
                ansLabelTick[i].setImage(#imageLiteral(resourceName: "success_unchecked"), for: .normal)
            }
            ansLabelTick[index].setImage(#imageLiteral(resourceName: "success"), for: .normal)
            
        } else{
            for i in 0...4{
                ansLabelTick[i].setImage(#imageLiteral(resourceName: "success_unchecked"), for: .normal)
            }
        }
        
        for i in 0...4{
            ansLabelText[i].setTitle(questions[curQuestion].ans[curSequence[i]], for: .normal)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult"{
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
            let nc = segue.destination as! UINavigationController
            let dvc: ResultViewController = nc.topViewController as! ResultViewController
            dvc.ansByUser = questions
        }
    }
    
}
