//
//  ResultViewController.swift
//  ENT
//
//  Created by Dinmukhammed on 21.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit



class ResultViewController: UIViewController {

    var signs:[String] = ["Резултат: ", "Нәтиже: ", "Сіз жауапты таңдаңдабадыңыз", "Вы не выбрали ответ"]
    
    var NavTitle = ""
    var cellTitle = ""
    
    @IBOutlet weak var tableView: UITableView!
    
     var ansByUser: [Question] = []
     var total = 0
     override func viewDidLoad() {
        super.viewDidLoad()
        
        if ViewController.isKazakhGlobal == true{
            NavTitle = signs[1]
            cellTitle = signs[2]
        }else{
            NavTitle = signs[0]
            cellTitle = signs[3]
        }
        
        for i in 0...24{
            let correctAnswer = ansByUser[i].sequenceOfNumbers.index(of: 0)
            if  correctAnswer == ansByUser[i].choosenAnswer {
                total += 1
            }
        }
        
        view.addBackground()
        let navBackgroundImage:UIImage! = #imageLiteral(resourceName: "canvasBack")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage,
                                                                    for: .default)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        self.title = NavTitle + String(total) + "/25"

        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    @IBAction func toMainMenu(_ sender: UIBarButtonItem) {
        self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: {})
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ansByUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resCell", for: indexPath) as! ResultCell
        
        
        cell.questionTextLabel.text = ansByUser[indexPath.row].quest
        cell.curQuestonNumber.text = String(indexPath.row + 1)
        
        let answer = ansByUser[indexPath.row].choosenAnswer
        
        
        
        cell.wrongAnswerText.isHidden = false
        cell.wrongImage.isHidden = false
        
        
        
        let correctAnswer = ansByUser[indexPath.row].sequenceOfNumbers.index(of: 0)
        
        if (answer < 0){
            
            cell.wrongAnswerText.text = cellTitle
            cell.wrongImage.image = #imageLiteral(resourceName: "error")
            cell.rightAnswerText.text = ansByUser[indexPath.row].ans[0]
            cell.rightImage.image = #imageLiteral(resourceName: "success")
            
        } else {
            let userAnsText = ansByUser[indexPath.row].sequenceOfNumbers[answer]
       
            
            if  correctAnswer == answer{
                
                cell.wrongAnswerText.isHidden = true
                cell.wrongImage.isHidden = true
                cell.rightAnswerText.text = ansByUser[indexPath.row].ans[0]
                cell.rightImage.image = #imageLiteral(resourceName: "success")
                
            } else{
               
                cell.wrongAnswerText.text = ansByUser[indexPath.row].ans[userAnsText]
                cell.wrongImage.image = #imageLiteral(resourceName: "error")
                cell.rightImage.image = #imageLiteral(resourceName: "success")
                cell.rightAnswerText.text = ansByUser[indexPath.row].ans[0]
            }
        }

        
        return cell
    }
    
}
extension ResultViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

