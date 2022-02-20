//
//  ViewController.swift
//  App20200306NetImage
//
//  Created by grace on 2022/2/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgPath = "https://warrant.tssco.com.tw/warrantweb/assets/img/mainPageNew/pick-warrants-h-img.png"

        let url = URL(string: imgPath)!
        print("start \(Date().timeIntervalSince1970)")
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.myImage.image = UIImage(data: imageData)
                    print("show myImage \(Date().timeIntervalSince1970)")
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }

        print("end \(Date().timeIntervalSince1970)")
    }


}

