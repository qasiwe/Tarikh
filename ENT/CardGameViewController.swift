//
//  CardGameViewController.swift
//  ENT
//
//  Created by Dimash on 8/1/17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit
import SQLite

class CardGameViewController: UIViewController {

    let titleNav = "Карточка: "
    
    @IBOutlet weak var cardView: UIView!
    var showingBack = true
  
    var curQuestion = 0
    var log: [CardModel] = []
    
    var backLabel = UILabel(frame: CGRect(x: 8, y: 8, width: 200, height: 300))
    var frontLabel = UILabel(frame: CGRect(x: 8, y: 8, width: 200, height: 300))
   
    
    @IBAction func prevQuest(_ sender: UIButton) {
        if curQuestion > 0{
            curQuestion -= 1
            reverseAnimateView()
        }
    }
    @IBAction func nextQuest(_ sender: UIButton) {
        
        curQuestion += 1
        
        if (log.count - 1 <= curQuestion){
            loadQuestion()
        }
        
        animateView()
        
    }


    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        let navBackgroundImage:UIImage! = #imageLiteral(resourceName: "canvasBack")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage,
                                                                    for: .default)
        frontLabel.numberOfLines = 0
        frontLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        backLabel.numberOfLines = 0
        backLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
      
        frontLabel.font = UIFont(name: "OpenSans", size: frontLabel.font.pointSize)
        backLabel.font = UIFont(name: "OpenSans", size: backLabel.font.pointSize)
        
        loadQuestion()
        
   
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(CardGameViewController.tapped))
        singleTap.numberOfTapsRequired = 1
        
        cardView.addGestureRecognizer(singleTap)
        cardView.isUserInteractionEnabled = true
        cardView.addSubview(backLabel)
        view.addSubview(cardView)
        
        view.addBackground()
        cardView.layer.masksToBounds = false
   
        cardView.layer.cornerRadius = 4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.15
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowRadius = 5
        showQuestion()
      
    }
    
    
    func loadQuestion(){
        
        let path = Bundle.main.path(forResource: "ent", ofType: "db")!
        let db = try? Connection(path, readonly: true)
        
        let queries: [String] = ["SELECT _id, v, a FROM IstKazTest ORDER BY RANDOM() LIMIT 1", "SELECT _id, v, a FROM IstRusTest ORDER BY RANDOM() LIMIT 1"]
        
        var query = queries[1]
        
        if (ViewController.isKazakhGlobal == false){
            query = queries[1]
        }else{
            query = queries[0]
            
        }
        
        for row in try! db!.prepare(query) {
            
            let result = CardModel(id: row[0] as! Int64,
                                     quest: row[1] as! String,
                                     ans: row[2] as! String)
            log.append(result)
        }
    }
    
    
    func showQuestion(){
        self.title = titleNav + String(curQuestion + 1)
        
        backLabel.text = log[curQuestion].quest
        frontLabel.text = log[curQuestion].ans
    }
    
    func animateView(){
        if(!showingBack){
            UIView.transition(from: frontLabel, to: backLabel, duration: 0.4, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
        }
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.cardView.frame.origin.x -= 400
        }, completion: { complete in
            
            self.cardView.frame.origin.x += 800
            self.showQuestion()
            UIView.animate(withDuration: 0.3, animations: {
                self.cardView.frame.origin.x -= 400
            }, completion: nil)
            
        })
        
        
    }
    
    func reverseAnimateView(){
        if(!showingBack){
            UIView.transition(from: frontLabel, to: backLabel, duration: 0.4, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.cardView.frame.origin.x += 400
        }, completion: { complete in
            
            self.cardView.frame.origin.x -= 800
            self.showQuestion()
            UIView.animate(withDuration: 0.3, animations: {
                self.cardView.frame.origin.x += 400
            }, completion: nil)
            
        })
    }
    
    
    func tapped() {
        if (showingBack) {
            UIView.transition(from: backLabel, to: frontLabel, duration: 0.4, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
            showingBack = false
        } else {
            UIView.transition(from: frontLabel, to: backLabel, duration: 0.4, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
            showingBack = true
        }
    }
}
