//
//  PostViewController.swift
//  Instagram
//
//  Created by 小島 彬 on 2018/06/09.
//  Copyright © 2018年 小島 彬. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class PostViewController: UIViewController {
    var image: UIImage!
    
    // MARK: - アウトレット
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 受け取った画像をImageViewに設定する
        self.imageView.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - アクション
    
    /// 投稿ボタン押下
    ///
    /// - Parameter sender: 投稿ボタン
    @IBAction func handlePostButton(_ sender: UIButton) {
        // ImageViewから画像を取得する
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
        
        // postDataに必要な情報を取得しておく
        let time = Date.timeIntervalSinceReferenceDate
        let name = Auth.auth().currentUser?.displayName
        
        // 辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath)
        let postDic = ["caption": textField.text!, "image": imageString, "time": String(time), "name": name!]
        postRef.childByAutoId().setValue(postDic)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    /// キャンセルボタン押下
    ///
    /// - Parameter sender: キャンセルボタン
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
