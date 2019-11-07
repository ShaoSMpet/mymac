//
//  ViewController.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/10/28.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var bt1: NSButton!
    @IBOutlet weak var bt2: NSButton!
    @IBOutlet weak var bt3: NSButton!
    @IBOutlet weak var menusView: NSView!
    @IBOutlet weak var mainview: NSView!
    @IBAction func bt2_click(_ sender: Any) {
       gop2()
    }
    @IBAction func bt3_click(_ sender: Any) {
        gop3();
    }
    @IBAction func bt1_click(_ sender: Any) {
        
        gop1();
    }
    func gop1()
    {
        bt1.contentTintColor = .orange
        bt2.contentTintColor =  nil
        bt3.contentTintColor =  nil
        let vc = page1viewcontroller()
         addChild(vc)
         view.replaceSubview(mainview, with: vc.view)
        mainview = (vc.view  )
        addConstraint(with: vc.view)
        
    }
    func gop2()
    {
        bt2.contentTintColor = .orange
        bt1.contentTintColor =  nil
        bt3.contentTintColor =  nil
        let vc = p2viewcontroller()
            addChild(vc)
            view.replaceSubview(mainview, with: vc.view)
           mainview = (vc.view  )
           addConstraint(with: vc.view)
        
    }
    func gop3()
    {
        
        bt3.contentTintColor = .orange
        bt1.contentTintColor =  nil
        bt2.contentTintColor =  nil
        gametype = "undefined";
        gamename = "全部游戏"
         let vc = p3viewcontroller()
        addChild(vc)
        view.replaceSubview(mainview, with: vc.view)
       mainview = (vc.view  )
       addConstraint(with: vc.view)
    }
    func addConstraint(with tmpView: NSView) {
           tmpView.translatesAutoresizingMaskIntoConstraints = false
           tmpView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           tmpView.leftAnchor.constraint(equalTo: menusView.rightAnchor).isActive = true
           tmpView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
           tmpView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       }
    override func viewDidLoad() {
        super.viewDidLoad()
         
       
        bt1.font =  NSFont.init(name: "iconfont", size: 30)
        
        bt2.font =  NSFont.init(name: "iconfont", size: 30)
        bt3.font =  NSFont.init(name: "iconfont", size: 30)
        bt1.title  = "\u{e731}"
        bt2.title  = "\u{e733}"
        bt3.title = "\u{e779}"
        menusView.wantsLayer = true
        gop1();
        //menusView.layer?.backgroundColor = NSColor.green.cgColor
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

