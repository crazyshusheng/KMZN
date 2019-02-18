//
//  LoginViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2019/2/16.
//  Copyright © 2019年 czc. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result


class LoginViewModel: BaseViewModel {
    
    var userNameSignal: Signal<String?, NoError>
    
    var pwdSignal: Signal<String?, NoError>
    
    var validSignal: Signal<Bool, NoError>
    
    var tfColor:Property<UIColor>
    var loginEnable:Property<Bool>
    
    var loginAction: Action<(String,String),Bool,NoError>
    
    init(_ signal1:Signal<String?, NoError>, _ signal2:Signal<String?, NoError>) {
        
        //获取用户名输入框和密码输入框文字变化的信号
        userNameSignal = signal1
        pwdSignal = signal2
        
        let colorSignal1: Signal<Bool, NoError> = userNameSignal.map { text in
            
            return Utils.isVailedPhone(phone: text)
        }
        
        let colorSignal2: Signal<Bool,NoError> = pwdSignal.map { text in
            
            return Utils.isVailedPassword(password: text)
        }
        
        //合并信号
        validSignal = Signal.combineLatest(colorSignal1, colorSignal2).map{
            
             $0 && $1
        }
        
        //按钮颜色
        
        let colorSignal : Signal<UIColor, NoError> = validSignal.map{isValid in
            
            return isValid ? THEME_COLOR : .gray
        }
 

        tfColor = Property.init(initial: .gray, then: colorSignal)

        //根据合并的信号，创建控制登录按钮enable的属性

         loginEnable = Property.init(initial: false, then: validSignal)
        
        //Property首先接收一个初始的值，我们设置成false，之后这个property会随着signUpActiveSignal里面的值变化而变化。
        
        //Action是一个泛型为Action<Input, Output, SwiftError>，Action就是动作的意思，比如当用户点击了signInButton后应该发生的动作。Action可以有输入和输出，也可以没有。   上面的代码中，我们的输入来自username text field和password text field，输出为Bool（登录是否成功）。
        
       // enabledIf这个参数是一个bool的property，这个参数用来控制这个action的启用/禁用。后面一个参数是一个closure，它的原型为(Input) -> SignalProducer<Output, Error>)，这个closure的Input来自于我们的username text field和password text field的值。
      
       
       
        
        loginAction = Action(enabledIf: loginEnable, execute: { (username,password) -> SignalProducer<Bool, NoError> in
            

            
            return SignalProducer<Bool, NoError> { observer, disposable in
                
                
               
                //网络请求
               
                observer.send(value: true)
                observer.sendCompleted()
                
            }
        
        })
        
    }

    
}
