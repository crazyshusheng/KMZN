//
//  SettingUserViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/13.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class SettingUserViewController: ThemeViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    

    private let titles = [["用户名"],["手机号","密码修改"]]
    
    private let  imagePickerController = UIImagePickerController()
    
    private let viewModel = UserInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
       
         NotificationCenter.default.addObserver(self, selector: #selector(refreshUserSettingVC), name: NOTIFY_SETTING_DEVICE, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        
        
        let alert = UIAlertController.init(title:
            "退出登录", message: "你确定?", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let firstAction = UIAlertAction.init(title: "确定", style: .default) { (nil) in
            
            
            UserSettings.shareInstance.clearUserInfo()
            
            UserSettings.shareInstance.setValue(key: UserSettings.IS_LOGIN, value: false)
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let startvc = storyBoard.instantiateViewController(withIdentifier: "startNVC")
            self.present(startvc, animated: false)
            
            }

        alert.addAction(cancelAction)
        alert.addAction(firstAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func getUserPhoto(_ sender: Any) {
        
        openSystemPhoto()
    }
    

}


extension SettingUserViewController{
    
    
    func setupUI(){
        
        
        navigationItem.title = "个人信息"
        
        if let photo =  UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHOTO){
            
            self.photoImageView.kf.setImage(with: URL.init(string: photo))
        }else{
            self.photoImageView.image = #imageLiteral(resourceName: "头像")
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        imagePickerController.delegate = self
       
    }
    

    @objc func refreshUserSettingVC(){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func openSystemPhoto(){
        
        self.imagePickerController.allowsEditing=true
        let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction: UIAlertAction = UIAlertAction(title: "拍照", style: .default) { (action: UIAlertAction!) -> Void in
            // 设置类型
            // 是否进行图片编辑
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: "从相册中选择", style: .default) { (action: UIAlertAction!) -> Void in
            // 设置类型
            self.imagePickerController.sourceType = .photoLibrary
            // 是否进行图片编辑
            self.imagePickerController.allowsEditing = true
            
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        alertController.addAction(photoLibraryAction)
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion:nil)
        
    }
    
    
    
    func showKWAlertView(){
        
        let pswAlertView = KWAlertView.init(frame: self.view.bounds)
        let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
        label.text = "修改用户名"
        pswAlertView.delegate = self
        self.view.addSubview(pswAlertView)
        
    }
    
}


extension SettingUserViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: false, completion: nil)
        
        let alert = UIAlertController.init(title:
            "上传头像", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let firstAction = UIAlertAction.init(title: "确定", style: .default) { (nil) in
            print(info)
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            
            let imageData = UIImageJPEGRepresentation(image, 0.1)
            
            self.viewModel.setUserAvatar(imageData: imageData!, finishedCallback: {
                
                let url = self.viewModel.photoUrl
                
                print(url)
                
                UserSettings.shareInstance.setValue(key: UserSettings.USER_PHOTO, value: url)
                
                self.photoImageView.kf.setImage(with: URL.init(string: url))
                
                
                
                NotificationCenter.default.post(name: NOTIFY_USERVC_DEVICE, object: nil)
            })
            
        }
        alert.addAction(cancelAction)
        alert.addAction(firstAction)
        self.present(alert, animated: true, completion: nil)
        
    }
}






extension SettingUserViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_info_cell")
        
        cell?.selectionStyle = .none
        
        (cell?.viewWithTag(10) as! UILabel).text = titles[indexPath.section][indexPath.row]
        let detailLabel = cell?.viewWithTag(11) as! UILabel
        
        var detail = ""
        
        switch (indexPath.section,indexPath.row) {
            
        case (0,0):
            if let nickname = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_NICK_NAME){
                print(nickname)
                detail = nickname
            }else{
                detail = ""
            }
        case (1,0):
            detail = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHONE)!
        case (1,1):
            detail = ""
        default:
            break
        }
        
        
        detailLabel.text = detail
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
       
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     
        switch (indexPath.section,indexPath.row) {
            
        case (0,0):
            showKWAlertView()
        case (1,0):
            break
        case (1,1):
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ResetPwdVC") as! ResetPwdViewController
            vc.type = 1
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
        
        
    }
    
    
}

extension SettingUserViewController:KWAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: KWAlertView, name: String) {
        
        alertView.removeFromSuperview()
        
        self.viewModel.updateUserNickname(name: name) {
            
            self.tableView.reloadData()
            NotificationCenter.default.post(name: NOTIFY_USERVC_DEVICE, object: nil)
            NotificationCenter.default.post(name: NOTIFY_HOMEVC_REFRESH, object: nil)
        }
    }
}


