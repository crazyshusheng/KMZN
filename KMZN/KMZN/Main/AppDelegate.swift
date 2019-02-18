//
//  AppDelegate.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/23.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import SVProgressHUD
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        

        setHUD()
        setShareSDK()
        
        self.window?.backgroundColor = UIColor.white
        
        //注册极光推送
        let types: UInt = UIUserNotificationType.alert.rawValue|UIUserNotificationType.sound.rawValue|UIUserNotificationType.badge.rawValue
        
        JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        JPUSHService.setup(withOption: launchOptions, appKey: "585607901725b44433d30867", channel: nil, apsForProduction: false)
        // 获取推送RegisterID
        JPUSHService.registrationIDCompletionHandler { (code, registerID) in
            print(registerID ?? String())
        }
        
        if let userID =  UserSettings.shareInstance.getUserID() {
            
            JPUSHService.setAlias(String(userID), completion: nil, seq: 0)
            
        }
    
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        // 清除通知栏和角标
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //手机锁定竖屏
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            return UIInterfaceOrientationMask.portrait
        }else{
            return UIInterfaceOrientationMask.all
        }
    }
    
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        center.removeAllDeliveredNotifications()
        
    }
    
    
    //注册推送服务
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = String(describing: deviceToken)
        var result = token.replacingOccurrences(of: "<", with: "")
        result = token.replacingOccurrences(of: ">", with: "")
        result = token.replacingOccurrences(of: " ", with: "")
        
        if(token==""){
            
            print("invidle")
        }else{
            
            DEVICE_TOKEN = result
        }
        JPUSHService.registerDeviceToken(deviceToken)
        print(deviceToken)
        
    }
    
    //注册APNs失败回调
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error")
        
        print(error)
    }
    
    

  
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        print(userInfo)
        
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
        //应用在前台
        if application.applicationState == .active {
            
            let infoDict = userInfo["aps"] as! NSDictionary
            
            let alert = UIAlertController.init(title: "提示", message: infoDict.object(forKey: "alert") as? String, preferredStyle: .alert)
            let cancelAction = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
            let sureAction = UIAlertAction.init(title: "查看", style: .default) { (nil) in
                
                self.goToPushVC(deviceId: userInfo["deviceId"] as! String)
            }
            alert.addAction(cancelAction)
            
            if  userInfo["deviceId"] != nil{

                alert.addAction(sureAction)
            }
            
            
            window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }else if application.applicationState == .inactive || application.applicationState == .background{
            //app 后台挂起
            
            
            self.goToPushVC(deviceId: userInfo["deviceId"] as! String)
            
        }
       
    }

    
    func applicationDidFinishLaunching(_ application: UIApplication) {

        print("通知启动")
    }
    


}
extension AppDelegate {
    
    func setHUD(){
        
        if (!(UserSettings.shareInstance.userDefaults.bool(forKey: "everLaunched"))) {
            
           self.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GuideVC")
        }
        
        
    
        //设置 指示框 后面View是否可操作
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setFadeOutAnimationDuration(0.5)
        
        SVProgressHUD.setDefaultStyle(.dark)
        //仅在custom有效
        SVProgressHUD.setBackgroundColor(UIColor.darkText)
        SVProgressHUD.setForegroundColor(UIColor.white)

        SVProgressHUD.setInfoImage(#imageLiteral(resourceName: "关于我们"))

        
        HttpWrapper.shareInstance.reachability.startMonitoring()
        
        
      
    }
    
    
    func setShareSDK(){
        
        /**
         *  初始化ShareSDK应用
         
         */
        ShareSDK.registPlatforms { (register) in
            
            register?.setupWeChat(withAppId: "wxc0390ad8638685c2", appSecret: "5240a5eaa8976e9de32bd5bc4375305a")
            
        }
    }
    
    
    func goToPushVC(deviceId:String){
        
        UserSettings.shareInstance.setValue(key: UserSettings.IS_PUSH, value: true)
        
        let recordVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "UnlockRecordVC") as! UnlockRecordViewController
        recordVC.type = 2
        recordVC.deviceID = deviceId
        
        let naVC = UINavigationController.init(rootViewController: recordVC)
        
        self.window?.rootViewController?.present(naVC, animated: true, completion: nil)
        
        
    }

    
}


