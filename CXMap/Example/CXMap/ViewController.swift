//
//  ViewController.swift
//  CXMap
//
//  Created by Nick on 08/22/2018.
//  Copyright (c) 2018 Nick. All rights reserved.
//

import UIKit
import CXMap



struct GuideModel: CXMappable {
    
    var step = ""
    var text_list = GuideTextModel()
    var link_img = ""
    var amount = "0"
    var wb = "0"
    var text_number = ""
    
    struct GuideTextModel: CXMappable {
        
        var line1 = ""
        var button1 : String?
        var button2 : String?
        var button3 : String?
    }
}

let dict = [
            "step":"2",
            "text_list":["line1":"完成新手任务还可获得更多现金红包",
                         "button1":"去完成任务",
                         "button2":"去完成任务",
                         "button3":"去完成任务"],
            "link_img":"",
            "amount":"0.5",
            "wb":"5",
            "text_number":"4"
    ] as [String : Any]


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let g = try? GuideModel.cx_mapFromDict(dict, GuideModel.self)
        print(g?.amount)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

