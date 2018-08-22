# CXMap

[![CI Status](https://img.shields.io/travis/Nick/CXMap.svg?style=flat)](https://travis-ci.org/Nick/CXMap)
[![Version](https://img.shields.io/cocoapods/v/CXMap.svg?style=flat)](https://cocoapods.org/pods/CXMap)
[![License](https://img.shields.io/cocoapods/l/CXMap.svg?style=flat)](https://cocoapods.org/pods/CXMap)
[![Platform](https://img.shields.io/cocoapods/p/CXMap.svg?style=flat)](https://cocoapods.org/pods/CXMap)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CXMap is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CXMap'
```

## Author

Nick, nick.qiu@cootek.cn

## License

CXMap is available under the MIT license. See the LICENSE file for more info.


## Use
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
