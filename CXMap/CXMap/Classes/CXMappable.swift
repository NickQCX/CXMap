//
//  CXMappable.swift
//  CXMap
//
//  Created by Nick on 2018/8/22.
//

import Foundation


enum CXMapError: Error {
    case jsonToModelFail    //json转model失败
    case jsonToDataFail     //json转data失败
    case dictToJsonFail     //字典转json失败
    case jsonToArrFail      //json转数组失败
    case modelToJsonFail    //model转json失败
}

public protocol CXMappable: Codable {
    func cx_modelMapFinished()
    mutating func cx_structMapFinished()
}


extension CXMappable {
    
    public func cx_modelMapFinished() {
        //外部自己实现
    }
    public mutating func cx_structMapFinished() {
        //外部自己实现
    }
    
    ///字典转模型
    public static func cx_mapFromDict<T : CXMappable>(_ dict : [String:Any], _ type:T.Type) throws -> T {
        guard let JSONString = dict.cx_toJSONString() else {
            print(CXMapError.dictToJsonFail)
            throw CXMapError.dictToJsonFail
        }
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(CXMapError.jsonToDataFail)
            throw CXMapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        
        do {
            let obj = try decoder.decode(type, from: jsonData)
            var vobj = obj
            let mirro = Mirror(reflecting: vobj)
            if mirro.displayStyle == Mirror.DisplayStyle.struct {
                vobj.cx_structMapFinished()
            }
            if mirro.displayStyle == Mirror.DisplayStyle.class {
                vobj.cx_modelMapFinished()
            }
            return vobj
        }catch {
            print(error)
        }
        throw CXMapError.jsonToModelFail
    }
    
    ///JSON转模型
    static func mapFromJson<T : CXMappable>(_ JSONString : String, _ type:T.Type) throws -> T {
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(CXMapError.jsonToDataFail)
            throw CXMapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        do {
            let obj = try decoder.decode(type, from: jsonData)
            var vobj = obj
            let mirro = Mirror(reflecting: vobj)
            if mirro.displayStyle == Mirror.DisplayStyle.struct {
                vobj.cx_structMapFinished()
            }
            if mirro.displayStyle == Mirror.DisplayStyle.class {
                vobj.cx_modelMapFinished()
            }
            return vobj
        }catch {
            print(error)
        }
        print(CXMapError.jsonToModelFail)
        throw CXMapError.jsonToModelFail
    }
    
    
    ///模型转字典
    public func cx_reflectToDict() -> [String:Any] {
        let mirro = Mirror(reflecting: self)
        var dict = [String:Any]()
        for case let (key?, value) in mirro.children {
            dict[key] = value
        }
        return dict
    }
    
    
    ///模型转json字符串
    public func cx_reflectToJSON() throws -> String {
        if let str = self.cx_reflectToDict().cx_toJSONString() {
            return str
        }
        print(CXMapError.modelToJsonFail)
        throw CXMapError.modelToJsonFail
    }
}
