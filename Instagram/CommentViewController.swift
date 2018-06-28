//
//  CommentViewController.swift
//  Instagram
//
//  Created by 小島 彬 on 2018/06/24.
//  Copyright © 2018年 小島 彬. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - プロパティ
    var postData: PostData?
    
    // MARK: - アウトレット
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        guard let postData = self.postData else {
            return
        }
        
        self.imageView.image = postData.image
        self.captionLabel.text = postData.caption
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - アクション
    @IBAction func onComment(_ sender: UIButton) {
        
        guard let postData = self.postData else {
            return
        }
        
        guard let name = Auth.auth().currentUser?.displayName else {
            SVProgressHUD.showError(withStatus: "表示名を設定してください。")
            return
        }
        
        guard let comment = self.commentTextField.text else {
            return
        }
        
        if (comment.isEmpty) {
            SVProgressHUD.showError(withStatus: "コメントを書いてあげてください")
            return
        }
        
//        let comment = CommentData()
//        comment.name = Auth.auth().currentUser?.displayName
//        comment.comment = self.commentTextField.text
        postData.comments.append(name + " : " + comment)
        
        // DB更新
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        let comments = ["comments": postData.comments]
        postRef.updateChildValues(comments)
        
        // 画面の更新
        self.commentTextField.text = nil
        self.postData = postData
        self.tableView.reloadData()
    }
    
    
    /// 戻るボタン押下
    ///
    /// - Parameter sender: 戻るボタン
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let postData = self.postData else {
            return 0
        }
        return postData.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let comment = postData!.comments[indexPath.row]
        cell.textLabel?.text = comment
        
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
