//
//  bannerView.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/10/29.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa
import Kingfisher

class bannerView: NSView , iCarouselDataSource,iCarouselDelegate{
    var lists:[myitemclass] = []
    var  videowindow : newiw?
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.lists.count
    }
    
    @IBOutlet weak var carousel: iCarousel!
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
       
        let data = self.lists[index] as myitemclass
                selitem = data
        let  videowindows = newiw(windowNibName: "newiw")
        
        videowindows.showWindow(videowindow?.contentViewController)
        videowindow = videowindows
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: NSView?) -> NSView {
        let itemView = NSImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 200))
        
        itemView.imageScaling = NSImageScaling.scaleAxesIndependently
        
        itemView.wantsLayer = true
        itemView.layer?.cornerRadius = 4
        
        let view = NSView(frame: CGRect(x: 0, y: 0, width: 350, height: 200))
        
        let label = NSTextField(frame: CGRect(x: 0, y: 0, width: 350, height: 18))
        label.isEditable = false
        label.backgroundColor = NSColor.init(calibratedRed: 0, green: 0, blue: 0, alpha:0.5)
        label.drawsBackground = true
        
        label.alignment = NSTextAlignment.center
        label.allowsEditingTextAttributes = false
        label.isBordered = false
        label.stringValue = lists[index].t1
        let url = URL(string: lists[index].t2)
        itemView.kf.setImage(with: url);
        view.addSubview( itemView)
        view.addSubview(label)
        view.wantsLayer = true
        view.layer!.backgroundColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.layer?.cornerRadius = 4
        
        //label.bottomAnchor.constraint(equalTo: itemView.bottomAnchor).isActive = true
        
        return view
    }
    
    func setInit(ls:[myitemclass] ) {
        self.lists = ls
        self.carousel.reloadData()
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        carousel.delegate = self
         carousel.type = .rotary
    }
   
    
    
}
