//
//  CXExtension.swift
//  CXMap
//
//  Created by Nick on 2018/8/22.
//

import Foundation



extension Array {
    
    public func cx_toJSONString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("dict转json失败")
            return nil
        }
        if let newData : Data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let JSONString = NSString(data:newData as Data,encoding: String.Encoding.utf8.rawValue)
            return JSONString as String? ?? nil
        }
        print("dict转json失败")
        return nil
    }
    
    public func cx_mapFromJson<T : Decodable>(_ type:[T].Type) throws -> Array<T> {
        guard let JSONString = self.cx_toJSONString() else {
            print(CXMapError.dictToJsonFail)
            throw CXMapError.dictToJsonFail
        }
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(CXMapError.jsonToDataFail)
            throw CXMapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        print(CXMapError.jsonToArrFail)
        throw CXMapError.jsonToArrFail
    }
}


extension Dictionary {
    public func cx_toJSONString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("dict转json失败")
            return nil
        }
        if let newData : Data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let JSONString = NSString(data:newData as Data,encoding: String.Encoding.utf8.rawValue)
            return JSONString as String? ?? nil
        }
        print("dict转json失败")
        return nil
    }
}


extension String {
    public func cx_toDict() -> [String:Any]? {
        guard let jsonData:Data = self.data(using: .utf8) else {
            print("json转dict失败")
            return nil
        }
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
            return dict as? [String : Any] ?? ["":""]
        }
        print("json转dict失败")
        return nil
    }
}
