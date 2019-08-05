//
//  SocketManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

let PACKET = 4

class SocketManager: NSObject {
    
    var mSocket:GCDAsyncSocket!
    
    var isRecive:Bool = false
    
    var time:Timer!
    
    var networkTestingTimer:Timer!
    
    var reConnectTime:TimeInterval!
    
    var isActivelyClose:Bool = false
        
    var connectStatus = 0
    
    private static let _sharedInstance = SocketManager()
    
    class func getSharedInstance() -> SocketManager {
        return _sharedInstance
    }
    
    private override init() {
        super.init()
        self.onNetWorkStartTesting()
    } // 私有化init方法
    
    func send(){
        let cmd:UInt8 = 2
        let myuid:UInt32 = 1000
        var uid = myuid.bigEndian
        let str = UIDevice.current.identifierForVendor?.uuidString
        let content = str?.data(using: String.Encoding.utf8)
        var d = Data()
        d.append(cmd)
        d.append(Data(bytes: &uid, count: MemoryLayout.size(ofValue: uid)))
        d.append(content!)
        let contentlen = UInt32(d.count)
        var len = contentlen.bigEndian
        d.insert(contentsOf: Data(bytes: &len, count: MemoryLayout.size(ofValue: len)), at: 0)
        mSocket.write(d, withTimeout: TimeInterval(1000), tag: 0)
    }
    
    //心跳链接
    func connectHeart(){
        let version = versionCheck()
        let version_4 = version.data(using: String.Encoding.utf8)
        let str = UIDevice.current.identifierForVendor?.uuidString
        let aes_uid = NSString.aes128Encrypt(str!, key:AESKey).data(using: String.Encoding.utf8)!
        var d = Data()
        let uid = (str?.data(using: String.Encoding.utf8))!
        let content = "ping".data(using: String.Encoding.utf8)!
        d.append(version_4!)
        d.append(uid)
        d.append(aes_uid)
        d.append(content)
        print("发送心跳连接")
        mSocket.write(d, withTimeout: -1, tag: 0)
//        4字节版本号  Long类型 内容长度 36字节uuid  64字节签名(使用AES对uuid进行加密
    }
    
    //取消心跳
    func destoryHeart(){
        DispatchQueue.main.async {
            if self.time != nil {
                self.time.invalidate()
                self.time = nil
            }
        }
    }
    //网络监测
    func noNetWorkStartTestingTimer(){
        DispatchQueue.main.async {
            self.networkTestingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
                RunLoop.current.add(self.networkTestingTimer, forMode: RunLoop.Mode.default)
            }
        }
    }
    //取消网络监测
    func destoryNetWorkStartTesting(){
        DispatchQueue.main.async {
            if (self.networkTestingTimer != nil) {
                self.networkTestingTimer.invalidate()
                self.networkTestingTimer = nil
            }
        }
    }
    
    //网络监测
    func onNetWorkStartTesting(){
        NetWorkListManager.getSharedInstance().netWorkList { (status) in
            switch status{
            case .notReachable:
                self.disconnect()
                print("the noework is not reachable")
            case .unknown:
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                self.reConnect()
                print("通过WiFi链接")
            case .reachable(.wwan):
                self.reConnect()
                print("通过移动网络链接")
            }
        }
    }
    
    //连接Scoket
    func connect(){
        do {
            SocketManager.getSharedInstance().mSocket = GCDAsyncSocket()
            SocketManager.getSharedInstance().mSocket.delegate = self
            SocketManager.getSharedInstance().mSocket.delegateQueue = DispatchQueue.main
            connectStatus = 0
            try mSocket.connect(toHost: RootIPAddress, onPort: 4162, withTimeout: TimeInterval(5000))
        } catch {
            print("conncet error")
        }
    }
    
    //重新连接
    func reConnect(){
        if self.mSocket.isConnected {
            return
        }
//        if self.reConnectTime > 1024 {
//            self.reConnectTime = 0
//            return
//        }
        self.connect()
    }
    
    //断开连接
    func disconnect(){
        self.isActivelyClose = true
        SocketManager.getSharedInstance().mSocket.disconnect()
        self.destoryNetWorkStartTesting()
        self.destoryHeart()
    }
    
    func parse_data(data:Data){
        let dic = BaseNetWorke.getSharedInstance().dataToDic(data)
        isRecive = true
        print("接受到数据")
    }
}

extension SocketManager : GCDAsyncSocketDelegate {
    func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        sock.readData(withTimeout: -1, tag: 0)
        print("success")
    }
    
    func socketDidSecure(_ sock: GCDAsyncSocket) {
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        parse_data(data: data)
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        sock.readData(withTimeout: -1, tag: 0)
        connectStatus = 1
        self.connectHeart()
        if time == nil {
            time = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (time) in
                if !self.isRecive {
                    self.isRecive = false
                    return
                }
                self.connectHeart()
            })
        }
        print("success")
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print(err ?? "")
        if self.isActivelyClose {
            self.destoryHeart()
            return
        }
        
        print("disconnect")
    }
    
    func socketDidCloseReadStream(_ sock: GCDAsyncSocket) {
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didWritePartialDataOfLength partialLength: UInt, tag: Int) {
        sock.readData(withTimeout: -1, tag: 0)
    }
    
}
