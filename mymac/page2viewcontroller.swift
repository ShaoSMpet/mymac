//
//  page2viewcontroller.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/10/28.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa

class page2viewcontroller: NSViewController {
    var aEngine = JHDanmakuEngine();
    @IBOutlet weak var danmuview: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
       
        let sc2 = JHScrollDanmaku(font:NSFont.menuFont(ofSize:CGFloat(22)), text: "我的第一条s弹幕", textColor: .green, effectStyle: JHDanmakuEffectStyle.undefine, speed: CGFloat(150), direction:
            JHScrollDanmakuDirection.R2L  )
        self.view.addSubview(self.aEngine.canvas);
        self.aEngine.canvas.frame = self.view.bounds
        self.aEngine.canvas.layoutStyle =  JHDanmakuCanvasLayoutStyle.whenSizeChanged;
        self.aEngine.globalEffectStyle = JHDanmakuEffectStyle.glow;
        self.aEngine.start();

        self.aEngine.send(sc2!)
       
    }
    
}
