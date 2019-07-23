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
    var connectStatus = 0
    
    private static let _sharedInstance = SocketManager()
    
    class func getSharedInstance() -> SocketManager {
        return _sharedInstance
    }
    
    private override init() {
        super.init()
//        self.data()
        
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
    
    func data(){
        let version = versionCheck()
        let version_4 = version.data(using: String.Encoding.utf8)
        let str = UIDevice.current.identifierForVendor?.uuidString
        let aes_uid = NSString.aes128Encrypt(str!, key:AESKey).data(using: String.Encoding.utf8)!
        var d = Data()
        let uid = (str?.data(using: String.Encoding.utf8))!
        let content = Data.init(base64Encoded: "1234")!
        d.append(version_4!)
        d.append(uid)
        d.append(aes_uid)
        d.append(content)
        mSocket.write(d, withTimeout: -1, tag: 0)
        
//        4字节版本号  Long类型 内容长度 36字节uuid  64字节签名(使用AES对uuid进行加密
    }
    
    func connect(){
        do {
            SocketManager.getSharedInstance().mSocket = GCDAsyncSocket()
            SocketManager.getSharedInstance().mSocket.delegate = self
            SocketManager.getSharedInstance().mSocket.delegateQueue = DispatchQueue.main
            connectStatus = 0
            try mSocket.connect(toHost: "192.168.0.172", onPort: 4162, withTimeout: TimeInterval(5000))
//            try mSocket.connect(toHost: "192.168.0.157", onPort: 2222, withTimeout: TimeInterval(5000))
        } catch {
            print("conncet error")
        }
    }
    
    func parse_data(data:Data){
//        let lenByte = data.subdata(in: 0..<PACKET )
//        let contentLength = Int(UInt32(bigEndian: lenByte.withUnsafeBytes { $0.pointee }))
//        let contentByte   = data.subdata(in: PACKET..<contentLength+PACKET)
//        switch contentByte[0] {
//        case 1:
//            let flagByte = contentByte[1]
//            let uidByte  = contentByte.subdata(in: 2..<contentByte.count)
//            print(flagByte, UInt32(bigEndian: uidByte.withUnsafeBytes { $0.pointee }))
//            break;
//        case 2:
//            let flagByte = contentByte[1]
//            print(flagByte)
//            break;
//        default:
//            print("unknow cmd")
//        }
//        if contentLength+PACKET < data.count {
//            parse_data(data: data.subdata(in: contentLength+PACKET..<data.count))
//        }
    }
    
    func longConnectToSocket(){
        let str = "longConnect"
        let data = str.data(using: String.Encoding.utf8)
        SocketManager.getSharedInstance().mSocket.write(data!, withTimeout: 1, tag: 0)
        print("心跳发送")
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
        self.data()
//        sock.write(<#T##data: Data##Data#>, withTimeout: -1, tag: 0)
        _ = Timer.init(timeInterval: 1, repeats: true, block: { (time) in
            self.longConnectToSocket()
        })
        print("success")
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print(err ?? "")

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
