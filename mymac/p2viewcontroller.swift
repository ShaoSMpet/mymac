//
//  p2viewcontroller.swift
//  mymac
//
//  Created by ShaoSMpet on 2019/11/2.
//  Copyright © 2019 ShaoSMpet. All rights reserved.
//

import Cocoa
import Alamofire
import  SwiftyJSON

class p2viewcontroller: NSViewController {
    @IBOutlet weak var collectionview: NSCollectionView!
    @IBOutlet weak var frameview: NSView!
    var vc : p3viewcontroller!
    var lists:[myitemclass] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.register(myitem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("myitem"))
        self.collectionview.isSelectable  = true
               self.collectionview.dataSource = self;
               self.collectionview.delegate =  self;
        getdata();
        // Do view setup here.
    }
    
     func getdata()
        {
            Alamofire.request("https://mp.huya.com/cache.php?m=Game&bussType=0", method: HTTPMethod.get)
                .responseJSON { response in
                    if response.data != nil {
                        do{
                            let json = try JSON(data: response.data!)
                            for ja in  json["data"]{
                                let t1 = ja.1["gameFullName"].stringValue
                                 let t2 = "https://huyaimg.msstatic.com/cdnimage/game/\(ja.1["gid"].stringValue)-L.jpg"
                                let t3 = ja.1["gid"].stringValue
                                
                                self.lists.append(myitemclass(t1: t1, t2:t2,t3:t3,list:[]));
                                
                            }
                             DispatchQueue.main.async {
                            self.collectionview.reloadData()
                            }
                             
                              
                        }
                        catch{
                        
                        }
                     
                    }
                }
           
        }
        
    }
    


extension p2viewcontroller :NSCollectionViewDataSource,NSCollectionViewDelegate{
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return self.lists.count;
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
         let data = self.lists[(indexPaths.first?[1])!] as myitemclass
        gametype = data.t3
        gamename = data.t1
        gop3();
        
    }
    func gop3()
    {
       
        self.vc = p3viewcontroller()
         addChild(vc)
        view.addSubview(vc.view)
        addConstraint(with: self.vc.view)
    }
    func addConstraint(with tmpView: NSView) {
              tmpView.translatesAutoresizingMaskIntoConstraints = false
        
              tmpView.topAnchor.constraint(equalTo: frameview.topAnchor).isActive = true
            tmpView.leftAnchor.constraint(equalTo: frameview.leftAnchor).isActive = true
              tmpView.rightAnchor.constraint(equalTo: frameview.rightAnchor).isActive = true
              tmpView.bottomAnchor.constraint(equalTo: frameview.bottomAnchor).isActive = true
        
        
          }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let view = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("myitem"), for: indexPath) as! myitem
        
        view.t1.stringValue = self.lists[indexPath[1] ].t1;
          
        let url = URL(string: self.lists[indexPath[1] ].t2)
        view.img.kf.setImage(with: url);
        return view
    }
   
    
    
}
extension p2viewcontroller: NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 100, height: 180)
    }
    
    
    
}





