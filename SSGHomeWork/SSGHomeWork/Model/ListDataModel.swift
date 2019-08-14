//
//  ListDataModel.swift
//  SSGHomeWork
//
//  Created by YoungD on 2019. 8. 14..
//  Copyright © 2019년 YoungD. All rights reserved.
//

import Foundation

struct ListDataMainModel{
    var listItem  = Array<ListDataModel>()
    var itemTitle  : String = ""
}

struct ListDataModel {
    var itemId  : String = ""
    var itemNm : String = ""
    var displayPrc : String = ""
    var itemLnkd : String = ""
    var itemImgUrl : String = ""
    
    public func dicToListDataModel(dataDic : Dictionary<String, String>) -> ListDataModel{
        let dataModel = ListDataModel(itemId: dataDic["itemId"]!, itemNm: dataDic["itemNm"]!, displayPrc: dataDic["displayPrc"]!, itemLnkd: dataDic["itemLnkd"]!, itemImgUrl: dataDic["itemImgUrl"]!)
        return dataModel
    }
}
