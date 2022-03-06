//
//  ViewController.swift
//  App20220306NetImage
//
//  Created by grace on 2022/2/20.
//

import UIKit
//import Kingfisher
import SDWebImage
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgPath = "https://warrant.tssco.com.tw/warrantweb/assets/img/mainPageNew/blog-h-img.png"

        //cornerRadius
        myImage.layer.borderColor = UIColor.red.cgColor
        myImage.layer.borderWidth = 2
        myImage.layer.cornerRadius = myImage.bounds.width / 2
        myImage.clipsToBounds = true
        
        //shadow
        content.clipsToBounds = false
        content.layer.shadowRadius = 20 //陰影
        content.layer.shadowOpacity = 0.6;
        content.layer.shadowColor = UIColor.yellow.cgColor
        content.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        // load image
//        let url = URL(string: imgPath)!
        updateUser()
        
//        self.myImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
//            print("end:\(Date().timeIntervalSince1970)")
//        }
        
//        self.myImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        
//        self.myImage.sd_setImage(with: url, completed: { image, error, imageCacheType, url in
//            print("end:\(Date().timeIntervalSince1970)")
//        })

//        DispatchQueue.global().async {
//            do {
//                let imageData = try Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    self.myImage.image = UIImage(data: imageData)
//                    print("show myImage \(Date().timeIntervalSince1970)")
//                }
//
//            } catch {
//                print(error.localizedDescription)
//            }
//        }

        print("end \(Date().timeIntervalSince1970)")
    }
    
    
    func updateUser() {
        print("start \(Date().timeIntervalSince1970)")
        
        let apiModel = APIModel.share
        apiModel.queryRandomUserAlamofire { data, respError in
            if respError != nil {
                print(respError?.localizedDescription ?? "")
                return
            }
            
            let respData = data as! Data
            let dataString = String(decoding: respData, as: UTF8.self)
            print(dataString)
            
            do {
                let theResult = try JSON(data: respData)
                
                let resultCount = theResult["results"].count
                if (resultCount >= 1) {
                    print(theResult["results"][resultCount-1]["login"]["username"].stringValue)
                    
                    let imageUrl = theResult["results"][resultCount-1]["picture"]["large"].stringValue
                    print("imageUrl: \(imageUrl)")
                    
                    self.myImage.sd_setImage(with: URL(string: imageUrl), completed: { image, error, imageCacheType, url in
                        print("end:\(Date().timeIntervalSince1970)")
                    })
                }
            } catch {
                print("API Error")
            }
        }
    }


}

