//
//  TableViewCell.swift
//  testSoftline
//
//  Created by Vladimir on 29.11.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfAnswers: UILabel!
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
