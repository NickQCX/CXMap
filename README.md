# CXMap


## Use
NSObject, swift class, struct of swift, just follow Mappable and you can map reflection directly
```
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
            
            
            
let g = try? GuideModel.cx_mapFromDict(dict, GuideModel.self)
print(g?.amount)
```
