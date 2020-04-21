//
//  PostHeaderView.swift
//  CustomTableView
//
//  Created by Ramazan Memişoğlu on 20.04.2020.
//  Copyright © 2020 Ramazan Memişoğlu. All rights reserved.
//

import UIKit

class PostHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelPost: UILabel!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
}

class PostReplyView: UITableViewCell {

    var hide: Bool = false
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelPost: UILabel!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
}

class PostCommentView: UITableViewHeaderFooterView {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelPost: UILabel!
    var tableView = UITableView()
    var sectionIndex:Int!
    
    @IBAction func showHideReplies(_ sender: UIButton){
        if tableView.hidingSections.contains(sectionIndex){
            if let index = tableView.hidingSections.firstIndex(of: sectionIndex){
                tableView.hidingSections.remove(at: index)
            }
        } else {
            tableView.hidingSections.append(sectionIndex)
        }
        tableView.reloadData()
    }
}
