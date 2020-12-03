//
//  TableViewController.swift
//  testSoftline
//
//  Created by Vladimir on 29.11.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var page = 1
    var selectedTag = 0
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var questions: [Item] = []
    let ns = NetworkService()
    fileprivate var firstLoadActivityIndicator = UIActivityIndicatorView(style: .large)
    fileprivate var activityIndicator: LoadMoreActivityIndicator!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "QuestionsTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionsTableViewCell")
        
        firstLoadActivityIndicator.center = self.view!.center
        firstLoadActivityIndicator.startAnimating()
        tableView.addSubview(firstLoadActivityIndicator)
        
        activityIndicator = LoadMoreActivityIndicator(scrollView: tableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
        firstLoadActivityIndicator.center = self.view!.center
        firstLoadActivityIndicator.startAnimating()
        tableView.addSubview(firstLoadActivityIndicator)
        
        
        self.title = Tags.ObjectiveC.description
        
        ns.load20Qiestions(about: .ObjectiveC, page: self.page) { questions in
            for i in 0..<20*self.page{
                self.questions.append(questions[0].items[i])
            }
            DispatchQueue.main.async{
                self.firstLoadActivityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
           activityIndicator.start {
            self.page += 1
            self.ns.load20Qiestions(about: .ObjectiveC, page: self.page) { questions in
                for i in 0..<20{
                        self.questions.append(questions[0].items[i])
                    }
                    DispatchQueue.main.async{
                        self.firstLoadActivityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
           }
       }
    
   
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
        
        cell.author.text = "author:\(questions[indexPath.row].owner.displayName)"
        cell.numberOfAnswers.text = String(questions[indexPath.row].answerCount)
        cell.question.text = questions[indexPath.row].title
        
        return cell
    }
    
    
    // MARK: - Picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Tags.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Tags(rawValue: row)?.description
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ns.load20Qiestions(about: Tags(rawValue: row)!, page: self.page) { questions in
            DispatchQueue.main.async{
                self.firstLoadActivityIndicator.startAnimating()
            }
            self.questions = []
            for i in 0..<20*self.page{
                self.questions.append(questions[0].items[i])
            }
            DispatchQueue.main.async{
                self.title = Tags(rawValue: row)?.description
                self.firstLoadActivityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
        selectedTag = row
    }
    
  
    
    @IBAction func pickTag(_ sender: Any) {
           picker = UIPickerView.init()
           picker.delegate = self
           picker.dataSource = self
           picker.backgroundColor = UIColor.white
           picker.setValue(UIColor.black, forKey: "textColor")
           picker.autoresizingMask = .flexibleWidth
           picker.contentMode = .center
           picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        picker.selectRow(selectedTag, inComponent: 0, animated: false)
           self.view.addSubview(picker)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           toolBar.barStyle = .blackTranslucent
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
           self.view.addSubview(toolBar)
       }
       
       @objc func onDoneButtonTapped() {
           toolBar.removeFromSuperview()
           picker.removeFromSuperview()
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnswersTableViewController") as! AnswersTableViewController
        vc.question = questions[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
