//
//  NetworkService.swift
//  testSoftline
//
//  Created by Vladimir on 29.11.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Foundation

class NetworkService{
   
    
    
//    var pageSize = 20 {
//        didSet{
//            urlString = urlString.replacingOccurrences(of: "pagesize=\(oldValue)", with: "pagesize=\(pageSize)")
//        }
//    }

    func load20Qiestions(about: Tags, page: Int, completion: @escaping ([Question]) -> Void){
        
           var urlString = "https://api.stackexchange.com/2.2/search/advanced?page=\(String(page))&pagesize=20&order=desc&sort=activity&tagged=Objective-C&site=stackoverflow"
        
        switch about {
        case .ObjectiveC:
            urlString = urlString.replacingOccurrences(of: "tagged=Objective-C", with: "tagged=Objective-C")
//            urlString = "https://api.stackexchange.com/2.2/search/advanced?pagesize=20&order=desc&sort=activity&tagged=Objective-C&site=stackoverflow"
        case .iOS:
             urlString = urlString.replacingOccurrences(of: "tagged=Objective-C", with: "tagged=iOS")
//            urlString = "https://api.stackexchange.com/2.2/search/advanced?pagesize=20&order=desc&sort=activity&tagged=iOS&site=stackoverflow"
        case .Xcode:
             urlString = urlString.replacingOccurrences(of: "tagged=Objective-C", with: "Xcode")
//            urlString = "https://api.stackexchange.com/2.2/search/advanced?pagesize=20&order=desc&sort=activity&tagged=Xcode&site=stackoverflow"
        case .CocoaTouch:
             urlString = urlString.replacingOccurrences(of: "tagged=Objective-C", with: "tagged=CocoaTouch")
//            urlString = "https://api.stackexchange.com/2.2/search/advanced?pagesize=20&order=desc&sort=activity&tagged=CocoaTouch&site=stackoverflow"
        case .iPhone:
             urlString = urlString.replacingOccurrences(of: "tagged=Objective-C", with: "tagged=iPhone")
//            urlString = "https://api.stackexchange.com/2.2/search/advanced?pagesize=20&order=desc&sort=activity&tagged=iPhone&site=stackoverflow"
        }
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            var questions: [Question] = []
            if data == nil{
                completion(questions)
            }
            guard let data = data else {return}
            guard error ==  nil else {return}
          
            do{
                try questions.append(JSONDecoder().decode(Question.self, from: data))
                completion(questions)
            }catch{
                print(error)
            }
        }
        .resume()
    }

    
    func loadAnswers(from id: Int, completion: @escaping ([Answer]) -> Void){
        let urlString = "https://api.stackexchange.com/2.2/questions/\(String(id))/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody"
        

        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            var answers: [Answer] = []
            if data == nil{
                completion(answers)
            }
            guard let data = data else {return}
            guard error ==  nil else {return}
          
            do{
                try answers.append(JSONDecoder().decode(Answer.self, from: data))
                completion(answers)
            }catch{
                print(error)
            }
        }
        .resume()
    }
    
    
    
    
}

