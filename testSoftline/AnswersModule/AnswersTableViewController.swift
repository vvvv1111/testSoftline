//
//  AnswersTableViewController.swift
//  testSoftline
//
//  Created by Vladimir on 02.12.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class AnswersTableViewController: UITableViewController {

    var question: Item?
    let ns = NetworkService()
    var answers: [AnswerItem] = []
    fileprivate var firstLoadActivityIndicator = UIActivityIndicatorView(style: .large)


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AnswersTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswersTableViewCell")
         tableView.register(UINib(nibName: "QuestionsTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionsTableViewCell")
        
        firstLoadActivityIndicator.center = self.view!.center
        firstLoadActivityIndicator.startAnimating()
        tableView.addSubview(firstLoadActivityIndicator)
        
        
        ns.loadAnswers(from: question!.questionID) { answers in
            for i in 0..<self.question!.answerCount{
                let stringWithouTags = answers[0].items[i].body.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                var answer = answers[0].items[i]
                answer.body = stringWithouTags
                self.answers.append(answer)

                
            }
            DispatchQueue.main.async{
                self.firstLoadActivityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
            
            cell.author.text = "author:\(question!.owner.displayName)"
            cell.numberOfAnswers.text = String(question!.answerCount)
            cell.question.text = question?.title
            cell.backgroundColor = .darkGray
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswersTableViewCell", for: indexPath) as! AnswersTableViewCell
            
            cell.author.text = "author:\(answers[indexPath.row-1].owner.displayName)"
            cell.numberOfVotes.text = String(answers[indexPath.row-1].score)
            cell.answerBody.text = answers[indexPath.row-1].body
            return cell
        }
        
    }
    

}
