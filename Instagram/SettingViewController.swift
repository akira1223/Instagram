//
//  SettingViewController.swift
//  Instagram
//
//  Created by 小島 彬 on 2018/06/09.
//  Copyright © 2018年 小島 彬. All rights reserved.
//

import UIKit
import ESTabBarController
import SVProgressHUD
import Firebase
import FirebaseAuth

class SettingViewController: UIViewController {

    // MARK: - アウトレット
    @IBOutlet weak var displayNameTextField: UITextField!
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            self.displayNameTextField.text = user.displayName
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - アクション
    
    /// 表示名を変更ボタン押下
    ///
    /// - Parameter sender: 表示名を変更ボタン
    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName = self.displayNameTextField.text {
            // 表示名が入力されていない時はHUDを出して何もしない
            if (displayName.isEmpty) {
                SVProgressHUD.showError(withStatus: "表示名を入力してください。")
                return
            }
            
            // 表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました。")
                        return
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                    
                    // HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました。")
                }
            }
        }
        
        // キーボードを閉じる
        self.view.endEditing(true)
    }
    
    
    /// ログアウトボタン押下
    ///
    /// - Parameter sender: ログアウトボタン
    @IBAction func handleLogoutButton(_ sender: Any) {
        
        // ログアウトする
        try! Auth.auth().signOut()
        
        // ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        // ログイン画面から戻ってきた時のためにホーム画面 (index = 0) を選択している状態にしておく
        let tabBarController = parent as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: -
}
