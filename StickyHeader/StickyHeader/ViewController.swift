//
//  ViewController.swift
//  CustomTableView
//
//  Created by Ramazan Memişoğlu on 20.04.2020.
//  Copyright © 2020 Ramazan Memişoğlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    var post = "imply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    var commentArray = ["it to make a type specimen book","software like Aldus PageMaker including versions of Lorem Ipsum.","nice!","Letraset sheets containing","Lorem Ipsum has been the industry's standard dummy","it to make a type specimen book.","It has survived not only five centuries","It was popularised in the 1960s"]
    
    var replyArray = ["essentially unchanged.","type and scrambled it to make a type specimen book.","It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","including versions of"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let postNib = UINib.init(nibName: "PostHeaderView", bundle: Bundle.main)
        let commentNib = UINib(nibName: "PostCommentView", bundle: Bundle.main)
        let replyNib = UINib(nibName: "PostReplyView", bundle: Bundle.main)
        
        tableView.register(postNib, forHeaderFooterViewReuseIdentifier: "PostHeaderView")
        tableView.register(commentNib, forHeaderFooterViewReuseIdentifier: "PostCommentView")
        tableView.register(replyNib, forCellReuseIdentifier: "PostReplyView")
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func animateHeader() {
        self.headerHeightConstraint.constant = 150
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PostHeaderView") as! PostHeaderView
            headerView.labelUsername.text = "username"
            headerView.labelPost.text = post
                return headerView
        } else {
            let commentView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PostCommentView") as! PostCommentView
            let item = commentArray[section-1]
            commentView.labelPost.text = item
            commentView.labelUsername.text = "comment user"
            commentView.sectionIndex = section
            commentView.tableView = tableView
            return commentView
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        } else {
            return replyArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = replyArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostReplyView", for: indexPath) as! PostReplyView
        cell.selectionStyle = .none
        
        cell.labelUsername.text = "reply user"
        cell.labelPost.text = item
        if tableView.hidingSections.contains(indexPath.section){
            cell.isHidden = true
        } else {
            cell.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.hidingSections.contains(indexPath.section){
            return 0
        }
        return UITableView.automaticDimension
    }
}

extension UITableView {
    private static var hideCell = [Int]()
    
    var hidingSections:[Int] {
        get {
            return UITableView.hideCell
        }
        set(newValue) {
            UITableView.hideCell = newValue
        }
    }
}
extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)

        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 10 {
            self.headerHeightConstraint.constant -= scrollView.contentOffset.y/100

            if self.headerHeightConstraint.constant < 10 {
                self.headerHeightConstraint.constant = 0
            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > 150 {
            animateHeader()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > 150 {
            animateHeader()
        }
    }
}
