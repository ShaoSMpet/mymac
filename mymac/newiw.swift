//
//  newiw.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/11/2.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa

class newiw: NSWindowController,NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
        
       window?.titlebarAppearsTransparent = true
       //window?.titleVisibility = .hidden
        self.contentViewController = VideoVC()
        self.window?.title = selitem!.t1
        
    }
     func windowWillClose(_ notification: Notification) {
        let aa = self.contentViewController as! VideoVC
        if(aa.timer != nil)
        {
            aa.timer.invalidate()
        }
        if(aa.socket != nil)
        {
            aa.socket.disconnect()
            
        }
        
        self.contentViewController = nil
    }
     
    
    
}

