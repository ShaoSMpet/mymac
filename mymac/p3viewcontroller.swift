//
//  p3viewcontroller.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/11/2.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa
import Alamofire
import  SwiftyJSON

class p3viewcontroller: NSViewController {
     var  videowindow : newiw?
    var lists:[myitemclass] = []
    var isload:Bool = true
    var page:Int = 1
    @IBOutlet weak var collectionview: NSCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
             
        self.collectionview.register(myitem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("myitem"))
        let nib = NSNib(nibNamed: "header", bundle: nil)
       self.collectionview.register(nib, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("header"))
        self.collectionview.isSelectable = true
        self.collectionview.dataSource = self;
        self.collectionview.delegate =  self;
        
        getdata();
    }
    func collectionView(_ collectionView: NSCollectionView, willDisplay item: NSCollectionViewItem, forRepresentedObjectAt indexPath: IndexPath) {
        if(indexPath[1] == (self.lists.count-1))
            {
                self.loadNextSection()
            }
       
    }
    func loadNextSection() {
        if(self.isload == true)
        {
            return
        }
        else{
            self.isload = true
            self.page = self.page + 1; Alamofire.request("https://mp.huya.com/cache.php?m=Game&do=gameLive&gameId=\( gametype!)&page=\(page)", method: HTTPMethod.get)
                    .responseJSON { response in
                        if response.data != nil {
                            do{
                                let json = try JSON(data: response.data!)
                                for ja in  json["data"]["lives"]{
                                    let t1 = ja.1["introduction"].stringValue
                                     let t2 = ja.1["screenshot"].stringValue
                                    let t3 = ja.1["uid"].stringValue
                                    let a4 = ja.1["nick"].stringValue
                                    self.lists.append(myitemclass(t1: t1, t2:t2,t3:t3,t4:a4,list:[]));
                                    
                                }
                                DispatchQueue.main.async {
                             self.collectionview.reloadData()
                             self.isload = false
                                }
                                 
                                  
                            }
                            catch{
                            
                            
                         
                        }
                    }
               
            }
            
    
        }

    }
    func getdata()
           {
           
            print("https://mp.huya.com/cache.php?m=Game&do=gameLive&gameId=\(gametype!)&page=\(page)")
            Alamofire.request("https://mp.huya.com/cache.php?m=Game&do=gameLive&gameId=\(gametype!)&page=\(page)",
                method: HTTPMethod.get)
                   .responseJSON { response in
                       if response.data != nil {
                           do{
                               let json = try JSON(data: response.data!)
                               for ja in  json["data"]["lives"]{
                                   let t1 = ja.1["introduction"].stringValue
                                    let t2 = ja.1["screenshot"].stringValue
                                   let t3 = ja.1["uid"].stringValue
                                   let a4 = ja.1["nick"].stringValue
                                self.lists.append(myitemclass(t1: t1, t2:t2,t3:t3,t4:a4,list:[]));
                                   
                               }
                             DispatchQueue.main.async {
                                    self.collectionview.reloadData()
                                    self.isload = false
                                       }
                                
                                 
                           }
                           catch{
                           
                           }
                        
                       }
                   }
              
           }
           
    
}
//extension p3viewcontroller : NSCollectionViewDelegate{
//
//    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
//        print("djj")
//        let data = self.lists[(indexPaths.first?[1])!] as myitemclass
//        selitem = data
//        let  videowindows = newiw(windowNibName: "newiw")
//
//        videowindows.showWindow(view)
//        self.videowindow = videowindows
//
//    }
//
//
//}




extension p3viewcontroller :NSCollectionViewDataSource,NSCollectionViewDelegate{
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return self.lists.count;
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let data = self.lists[(indexPaths.first?[1])!] as myitemclass
                selitem = data
                let  videowindows = newiw(windowNibName: "newiw")
        
                videowindows.showWindow(view)
                self.videowindow = videowindows
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
         let view = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("myitem"), for: indexPath) as! myitem
               
               view.t1.stringValue = self.lists[indexPath[1] ].t1;
               view.t2.stringValue = self.lists[indexPath[1] ].t4;
                 
               let url = URL(string: self.lists[indexPath[1] ].t2)
               view.img.kf.setImage(with: url);
               return view
    }
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
         let headerview = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("header"), for: indexPath) as! header
                   headerview.title.stringValue = gamename!
                   
                   //headerview.frame = NSMakeRect(0, 0, 1000, 12)
                   return headerview
       }
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
   
    
    
}
extension p3viewcontroller: NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 250, height: 180)
    }
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
       
            
        return NSSize(width: 0, height: 58)
        
        
    }
    
    
}




