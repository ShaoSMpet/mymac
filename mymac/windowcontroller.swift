//
//  windowcontroller.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/11/2.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa

class windowcontroller: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        let customToolbar = NSToolbar()
        customToolbar.showsBaselineSeparator = false
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.toolbar = customToolbar
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
