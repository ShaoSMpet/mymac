//
//  page1viewcontroller.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/10/28.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa
import Kingfisher
import  Alamofire
import  SwiftyJSON

class page1viewcontroller: NSViewController {
    var lists:[myitemclass] = []
    var  videowindow : newiw?
    @IBOutlet weak var collectionview: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.register(myitem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("myitem"))
        let nib = NSNib(nibNamed: "header", bundle: nil)
        self.collectionview.register(nib, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("header"))
        let nib1 = NSNib(nibNamed: "bannerView", bundle: nil)
       self.collectionview.register(nib1, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("bannerView"))
        self.collectionview.dataSource = self;
        self.collectionview.delegate =  self;
        self.getdata()
    }
    func getdata()
    {
        Alamofire.request("https://mp.huya.com/cache.php?m=Home&do=liveRecommends", method: HTTPMethod.get)
            .responseJSON { response in
                if response.data != nil {
                    do{
                        let json = try JSON(data: response.data!)
                        for ja in  json["data"]{
                            let t1 = ja.1["themeTitle"].stringValue
                            var list1 = [myitemclass]()
                            for ja2 in ja.1["contents"]{
                                let a1 = ja2.1["introduction"].stringValue
                                let a2 = ja2.1["screenshot"].stringValue
                                let a3 = ja2.1["uid"].stringValue
                                let a4 = ja2.1["nick"].stringValue
                                list1.append(myitemclass(t1: a1, t2: a2, t3: a3,t4: a4, list: []));
                                 
                            }
                            self.lists.append(myitemclass(t1: t1, t2: "", t3: "", list:list1));
                            
                        }
                         DispatchQueue.main.async {
                        self.collectionview.reloadData()
                        }
                         
    //                             let name = json["data"][0]["contents"][0]["nick"].string
    //                             if name != nil {
    //                               print(name!)
    //                     }
                        
                    }
                    catch{
                    
                    }
                 
                }
            }
       
    }
    
}
class myitemclass{
    var t1:String = "";
    var t2:String = "";
    var t3:String = "";
    var t4:String = "";
    var list:[myitemclass] = []
    init(t1:String,t2:String,t3:String,list:[myitemclass])
    {
        self.t1 = t1
        self.t2 = t2
        self.t3 = t3
        self.list = list
    }
    init(t1:String,t2:String,t3:String,t4:String, list:[myitemclass])
    {
        self.t1 = t1
        self.t2 = t2
        self.t3 = t3
        self.t4 = t4
        
        self.list = list
    }
}

extension page1viewcontroller :NSCollectionViewDataSource{
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0 )
        {
            return 0
        } 
        else
        {
            return self.lists[section ].list.count;
        }
            
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let view = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("myitem"), for: indexPath) as! myitem
        
        view.t1.stringValue = self.lists[indexPath[0] ].list[indexPath[1]].t1;
        view.t2.stringValue = self.lists[indexPath[0] ].list[indexPath[1]].t4;
        
          
        let url = URL(string: self.lists[indexPath[0] ].list[indexPath[1]].t2)
//        let processor = RoundCornerImageProcessor(cornerRadius: CGFloat(20))
//        view.img.kf.setImage(with: url,options: [.processor(processor)]);
            
         view.img.kf.setImage(with: url);
        return view
    }
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        if(indexPath[0] == 0 )
        {
            let headerview = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("bannerView"), for: indexPath) as! bannerView
            headerview.setInit(ls: self.lists[0].list )
                       //headerview.frame = NSMakeRect(0, 0, 1000, 12)
                return headerview
        }
        else{
            let headerview = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("header"), for: indexPath) as! header
            headerview.title.stringValue = self.lists[indexPath[0] ].t1
            
            //headerview.frame = NSMakeRect(0, 0, 1000, 12)
            return headerview
            
        }
        
    }
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return self.lists.count
    }
    
}
extension page1viewcontroller : NSCollectionViewDelegate{
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let data = self.lists[(indexPaths.first?[0])!].list[(indexPaths.first?[1])!] as myitemclass
        selitem = data
        let  videowindows = newiw(windowNibName: "newiw")
       
        videowindows.showWindow(view)
        self.videowindow = videowindows
        
    }
     
   
}

extension page1viewcontroller: NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 250, height: 180)
    }
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        //组头header
        if(section == 0)
        {
            return NSSize(width: 0, height: 250)
        }
        else  {
            
        return NSSize(width: 0, height: 58)
        }
        
    }
    
//    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForFooterInSection section: Int) -> NSSize {
//        return NSSize(width: 0, height: 20)
//    }
    
}



