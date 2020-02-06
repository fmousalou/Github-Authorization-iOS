//
//  MultiSectionGenericEnumModel.swift
//  SmartFix
//
//  Created by ABS_narjes on 4/17/19.
//  Copyright © 2019 Sepandar Co. All rights reserved.
//

import RxDataSources
import ObjectMapper


protocol EnumProtocol {}

 struct MultiSectionGenericEnumType <E:EnumProtocol>{
    var type: E
}

 struct MultiSectionGenericEnumItem<E:EnumProtocol>{
    var type : MultiSectionGenericEnumType<E>
}
/**
Generic MultiSection For Diffrent Sections
 
 ### Usage ###
 ````
 
enum MySections:EnumProtocol{
    case navigationSecsion(_ value:String)
    case infoSecsion(_ value:String)
}
 
func test(){

  var instans = MultiSectionGenericEnumModel.init(header: "",
                                                     items: [MultiSectionGenericEnumItem<MySections>
                                                     (type:MultiSectionGenericEnumType<MySections>
                                                     (type: MySections.navigationSecsion("test")))])
        }
````
 
  - Author: Narjes Abbaspour
*/
struct MultiSectionGenericEnumModel<E:EnumProtocol>  {
    
    var header: String
    public var items:[Item]
    
}


extension MultiSectionGenericEnumModel:SectionModelType{
    
    public typealias Item = MultiSectionGenericEnumItem<E>
    
    init(original: MultiSectionGenericEnumModel, items: [Item]) {
        self = original
        self.items = items
    }
    
}

