//
//  myitem.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/10/28.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa

class myitem: NSCollectionViewItem {
   
    @IBOutlet weak var t1: NSTextField!
    @IBOutlet weak var t2: NSTextField!
    @IBOutlet weak var img: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.wantsLayer = true
        self.img.wantsLayer  = true
        self.img.layer?.cornerRadius = 4 ;
        self.img.layer?.maskedCorners =  [CACornerMask.layerMinXMaxYCorner , CACornerMask.layerMaxXMaxYCorner]


        
        
        // Do view setup here.
    }
    
}
