//
//  VideoVC.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/11/3.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa
import VersaPlayer
import  Alamofire
import  SwiftyJSON
import Starscream
import SwiftJWT
import  CryptoSwift



class VideoVC: NSViewController {
     var aEngine = JHDanmakuEngine();
    @IBOutlet weak var menuitems: NSPopUpButton!
    @IBOutlet var control: VersaPlayerControls!
    var lists:[myitemclass] = []
    @IBOutlet weak var videoplay: VersaPlayerView!
    var timer:Timer!
    var tid:String? = ""
    var sid:String? = ""
    var socket:WebSocket!
    override func viewDidLoad() {
        super.viewDidLoad()
       videoplay.wantsLayer = true       
        videoplay.layer?.backgroundColor = .black
        
        videoplay.use(controls: control)
        control.behaviour.show()
        
        getdata()
        self.view.addSubview(self.aEngine.canvas);
        self.aEngine.canvas.frame = self.view.bounds
        self.aEngine.canvas.layoutStyle =  JHDanmakuCanvasLayoutStyle.whenSizeChanged;
        self.aEngine.globalEffectStyle = JHDanmakuEffectStyle.glow;
       
        
        
    }
     func base64Encoding(plainString:String)->String{let plainData = plainString.data(using: String.Encoding.utf8)
        var base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        base64String = base64String!.replacingOccurrences(of: "+", with: "-")
        base64String = base64String?.replacingOccurrences(of: "/", with: "_")
        base64String = base64String?.replacingOccurrences(of: "=", with: "")
        return base64String!
    }
   
    
    
    func getdanmu(roomid:String)
    {
        
               
        self.aEngine.start();
        let header = "{\"alg\":\"HS256\",\"typ\":\"JWT\"}"
       let hsign = base64Encoding(plainString: header)
       let timeInterval:TimeInterval = NSDate().timeIntervalSince1970
       let timeStamp = Int(timeInterval)
       print("sign\(timeStamp)")
       let payload = "{\"iat\":\(timeStamp),\"exp\":\(timeStamp+600),\"appId\":\"6f30d4022885a0d4\"}"
        print("==\(payload)")
       let psign = base64Encoding(plainString: payload)
       let  appSecret = "f0b0e6aaa64d1eb70fe712c4e15c1a96"
       var sign = try? (HMAC(key: appSecret, variant: .sha256).authenticate("\(hsign).\(psign)".bytes).toBase64()!)
       sign = sign!.replacingOccurrences(of: "+", with: "-")
       sign = sign!.replacingOccurrences(of: "/", with: "_")
       sign = sign!.replacingOccurrences(of: "=", with: "")
       sign = "\(hsign).\(psign).\(sign!)"
       self.socket = WebSocket(url: URL(string: "ws://ws-apiext.huya.com/index.html?do=comm&roomId=\(roomid)&appId=6f30d4022885a0d4&iat=\(timeStamp)&exp=\(timeStamp+600)&sToken=\(sign!)")!)
       self.socket?.delegate = self
       self.socket!.connect()
 
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(VideoVC.getdamu), userInfo: nil, repeats: true)
        
    }
    func getdata()
    {
        
        Alamofire.request("https://mp.huya.com/cache.php?m=Live&do=profileRoom&pid="+selitem!.t3, method: HTTPMethod.post)
        .responseJSON { response in
            if response.data != nil {
                do{
                    let json = try JSON(data: response.data!)
                    self.lists = []
                    self.menuitems.removeAllItems()
                    let menu = NSMenu()
                    self.getdanmu(roomid: json["data"]["liveData"]["profileRoom"].stringValue )
                    
                    for ja in  json["data"]["stream"]["baseSteamInfoList"]{
                        let  a1 = ja.1["sHlsUrl"].stringValue
                        
                        let a2 = ja.1["sStreamName"].stringValue
                        if(ja.1["sCdnType"].stringValue == "WS")
                        {
                            continue;
                        }
                        for ja2 in json["data"]["stream"]["hls"]["rateArray"]
                        {
                            let type = "\(ja2.1["sDisplayName"].stringValue)-\(ja.1["sCdnType"].stringValue)"
                            let iBitRate = ja2.1["iBitRate"].stringValue
                            
                            let m3u8 = "\(a1)\(iBitRate)/\(a2).m3u8"
                            print(m3u8)
                            self.lists.append( myitemclass(t1:m3u8, t2: type, t3: "", list: []))
                            let menuitem = NSMenuItem(title: type, action: Selector(("onclick:")), keyEquivalent: "")
                            menu.addItem(menuitem)
                            
                        }
                         
                       
                        
                    
                    }
                    self.menuitems.menu = menu
                    if(self.lists.count == 0 )
                    {
                         print("主播不在家")
                    }
                    
                    else{
                        if let url = URL.init(string: self.lists[0].t1) {
                               let item = VersaPlayerItem(url: url)

                        self.videoplay.set(item: item)
                           }
                    }
                    
                     
                }
                catch{
                    
                }
            }
        }
        
        
    }
    @objc func onclick(_ sender: NSMenuItem)
    {
        let a = self.menuitems.indexOfSelectedItem
        
            if let url = URL.init(string: self.lists[a].t1) {
           let item = VersaPlayerItem(url: url)

    self.videoplay.set(item: item)
       }
        
    }
    @objc func getdamu()
       {
        self.socket.write(ping: Data())
//        Alamofire.request("http://www.huya.com/cache1min.php?m=chatMessage&tid=\(self.tid!)&sid=\(self.sid!)", method: HTTPMethod.get)
//        .responseJSON { response in
//            if response.data != nil {
//                do{
//                    let json = try JSON(data: response.data!)
//
//
//                    for ja in  json["result"]["chats"]{
//                        let msg = ja.1["chat"].stringValue
//
//                        let sc2 = JHScrollDanmaku(font:NSFont.menuFont(ofSize:CGFloat(22)), text: msg, textColor: .green, effectStyle: JHDanmakuEffectStyle.undefine, speed: CGFloat(150), direction:
//                                   JHScrollDanmakuDirection.R2L  )
//                        self.aEngine.send(sc2!)
//
//                    }
//
//
//
//                }
//                catch{
//
//                }
//            }
//        }
//
       }
    
    override func mouseDown(with event: NSEvent) {
         if control.behaviour.showingControls {
                   control.behaviour.hide()
               }else {
                   control.behaviour.show()
               }
    }
    
}

extension VideoVC:WebSocketDelegate
{
    func websocketDidConnect(socket: WebSocketClient) {
       self.socket.write(string: "{\"command\":\"subscribeNotice\",\"data\":[\"getMessageNotice\"],\"reqId\":\"\"}")
        socket.write(ping: Data())
       }
       
       func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
            
       }
       
       func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
            
        do{
            let json = JSON(parseJSON: text)
                       let msg = json["data"]["content"].stringValue
 
                 let sc2 = JHScrollDanmaku(font:NSFont.menuFont(ofSize:CGFloat(22)), text: msg, textColor: .red, effectStyle: JHDanmakuEffectStyle.undefine, speed: CGFloat(150), direction:
                            JHScrollDanmakuDirection.R2L  )
            print(msg)
     DispatchQueue.main.async {self.aEngine.send(sc2!)}
            
                 //
        }
        catch{
        
        }
       }
       
       func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
            
       }
       
}


