//
//  KMWebSocket.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/15.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import Starscream


@objc public protocol KMWebSocketDelegate: NSObjectProtocol{
    
    /**websocket 连接成功*/
    @objc optional func websocketDidConnect(sock: KMWebSocket)
    /**websocket 连接失败*/
    @objc optional  func websocketDidDisconnect(socket: KMWebSocket, error: Error?)
    /**websocket 接受文字信息*/
    @objc optional func websocketDidReceiveMessage(socket: KMWebSocket, text: String)
    /**websocket 接受二进制信息*/
    @objc optional  func  websocketDidReceiveData(socket: KMWebSocket, data: Data)
    
    
}


public class KMWebSocket:NSObject,WebSocketDelegate{
   
    
    var socket:WebSocket!
    
    weak var webSocketDelegate:KMWebSocketDelegate?
    
    //单例
    class func sharedInstance() -> KMWebSocket
    {
        return manger
    }
    static let manger: KMWebSocket = {
        return KMWebSocket()
    }()
    
    
    
    //MARK:- 链接服务器
    func connectSever(){
        
        if let token = UserSettings.shareInstance.getStringValue(key: UserSettings.TOKEN){
            
          let urlStr = WB_URL + "?token=\(token)"
          if let url = URL.init(string: urlStr){
            
              socket = WebSocket.init(url:url)
              socket.delegate = self
              socket.connect()
            }
        }
    
       
    }
    //发送文字消息
    func sendBrandStr(brandID:String){
        
        socket.write(string: brandID)
    }
    //MARK:- 关闭消息
    func disconnect(){
        socket.disconnect()
    }
    
    
    
    
    
    public func websocketDidConnect(socket: WebSocketClient) {
        
        print("连接成功了")
        webSocketDelegate?.websocketDidConnect!(sock: self)
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
        print("连接失败了")
        webSocketDelegate?.websocketDidDisconnect!(socket: self, error:error )
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
        print("接受到消息了")
        webSocketDelegate?.websocketDidReceiveMessage!(socket: self, text: text)
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("data数据")
        webSocketDelegate?.websocketDidReceiveData!(socket: self, data: data)
    }
    
    
    

}
    
    
