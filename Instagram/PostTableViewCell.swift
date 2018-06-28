//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 小島 彬 on 2018/06/10.
//  Copyright © 2018年 小島 彬. All rights reserved.
//

import UIKit

protocol PostTableViewCellProtocol: class {
    func toComment(postDate: PostData)
}

class PostTableViewCell: UITableViewCell {

    // MARK: - プロパティ
    var postData: PostData?
    
    // MARK: - アウトレット
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    weak var delegate: PostTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// コメントボタン押下
    ///
    /// - Parameter sender: コメントボタン
    @IBAction func onComment(_ sender: UIButton) {
        delegate?.toComment(postDate: self.postData!)
    }
    
    func setPostData(_ postData: PostData) {
        
        self.postData = postData
        
        self.postImageView.image = postData.image
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        self.likeLabel.text = "\(likeNumber)"
        
        let commentNumber = postData.comments.count
        var label = "コメント"
        if (commentNumber > 0) {
            label = label + " \(commentNumber)"
        }
        self.commentButton.setTitle(label, for: .normal)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
}
