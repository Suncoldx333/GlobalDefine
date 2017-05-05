//
//  GlobalDefineSwift.swift
//  SWCampus
//
//  Created by WangZhaoyun on 16/10/9.
//  Copyright © 2016年 WanHang. All rights reserved.
//

import UIKit

let ScreenWidth : CGFloat = UIScreen .main .bounds .size .width
let ScreenHeight : CGFloat = UIScreen .main .bounds .size .height
typealias cellConfigurationBlock = (UITableViewCell) ->Void


//颜色，Eg:ColorMethodho(0x00c18b)
func ColorMethodho(hexValue : Int) -> UIColor {
    let red   = ((hexValue & 0xFF0000) >> 16)
    let green = ((hexValue & 0xFF00) >> 8)
    let blue  = (hexValue & 0xFF)
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(1))
}

//获取View的frame相关信息
func ViewX(v : UIView) -> CGFloat{
    let x : CGFloat = v.frame.origin.x
    return x
}

func ViewY(v : UIView) -> CGFloat{
    let y : CGFloat = v.frame.origin.y
    return y
}

func ViewWidh(v : UIView) -> CGFloat{
    let width : CGFloat = v.frame.size.width
    return width
}

func ViewHeight(v : UIView) -> CGFloat{
    let height : CGFloat = v.frame.size.height
    return height
}

//富文本参数
let font_13_global = [NSFontAttributeName : UIFont.systemFont(ofSize: 13)]
let font_10_global = [NSFontAttributeName : UIFont.systemFont(ofSize: 10)]
let font_09_global = [NSFontAttributeName : UIFont.systemFont(ofSize: 9)]
let font_12_global = [NSFontAttributeName : UIFont.systemFont(ofSize: 12)]
let font_12_bold_global = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 12)]
let font_13_bold_global = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 13)]
let font_18_bold_global = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
let font_10_bold_global = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 10)]
let font_25_bold_global = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 25)]

let color_66_global = [NSForegroundColorAttributeName : ColorMethodho(hexValue: 0x666666)]
let color_33_global = [NSForegroundColorAttributeName : ColorMethodho(hexValue: 0x333333)]
let color_b2_global = [NSForegroundColorAttributeName : ColorMethodho(hexValue: 0xb2b2b2)]
let color_e6_global = [NSForegroundColorAttributeName : ColorMethodho(hexValue: 0xe6e6e6)]
let color_8b_global = [NSForegroundColorAttributeName : ColorMethodho(hexValue: 0x00c18b)]
let color_80_global = [NSForegroundColorAttributeName : ColorMethodho(hexValue: 0x808080)]
let color_ff_global = [NSForegroundColorAttributeName : ColorMethodho(hexValue: 0xffffff)]

//修改时间展示格式1
func compareTime(givenTime : Double) -> String {
    let now = NSDate.init().timeIntervalSince1970 * 1000
    let differ = now - givenTime
    
    var result : String!
    if differ < 60000 {
        result = "刚刚"
    }else if differ < 3600000{
        result = NSNumber.init(value: Int.init(differ/60000)).stringValue + "分钟前"
    }else if differ < 3600000 * 3{
        result = NSNumber.init(value: Int.init(differ/3600000)).stringValue + "小时前"
    }else{
        let form = DateFormatter.init()
        form.dateFormat = "yyyy.MM.dd HH:mm"
        let curTime = form.string(from: Date.init(timeIntervalSince1970: givenTime/1000))
        result = curTime
    }
    return result
}

//修改时间展示格式2
func compareEnterTime(givenTime : Double) -> String {
    let now = NSDate.init().timeIntervalSince1970 * 1000
    let differ = now - givenTime
    
    var result : String!
    if differ < 15000 {
        result = "刚刚"
    }else if differ < 60000{
        result = NSNumber.init(value: Int.init(differ/1000)).stringValue + "秒钟前"
    }else{
        result = NSNumber.init(value: Int.init(differ/60000)).stringValue + "分钟前"
    }
//    else{
//        let form = DateFormatter.init()
//        form.dateFormat = "yyyy.MM.dd HH:mm"
//        let curTime = form.string(from: Date.init(timeIntervalSince1970: givenTime/1000))
//        result = curTime
//    }
    return result
}

//字符串截取
func cutString(title : String,atIndex : Int,beforeIndex : Int) -> String {
    
    if title.characters.count < (beforeIndex - 1) {
        return "rangError!"
    }
    
    let startIndex = title.index(title.startIndex, offsetBy: atIndex)
    let endIndex = title.index(title.startIndex, offsetBy: beforeIndex)
    let cutRang : Range = startIndex..<endIndex
    let cuttedStr = title.substring(with: cutRang)
    return cuttedStr
}

//转化时间格式
func changeTime(time : String,inFormatter : String) -> String {
    let dateFor = DateFormatter.init()
    dateFor.dateFormat = inFormatter
    let timeDouble : Double = Double.init(time)!/1000
    let newDate : Date = Date.init(timeIntervalSince1970: timeDouble)
    let timeStr : String = dateFor.string(from: newDate)
    return timeStr
}

//底部弹框专用文字格式设置
func makeSheetTitleDic(title : String,titleFont : String,titleColor : String) -> NSMutableDictionary {
    let titleDic = NSMutableDictionary.init()
    titleDic.setObject(title, forKey: "text" as NSCopying)
    titleDic.setObject(titleFont, forKey: "font" as NSCopying)
    titleDic.setObject(titleColor, forKey: "textcolor" as NSCopying)
    return titleDic
}

//tableviewCellHeight,未完善
extension UITableView{
    
    var heightCache : cellHeightCache? {
        set{
            objc_setAssociatedObject(self, cellHeightKey.cellHeightCacheKey, heightCache, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, cellHeightKey.cellHeightCacheKey) as? cellHeightCache
        }
    }
    
    
    func cellHeightCacheWith(identifier : String?,cacheKey : String?,configuration : cellConfigurationBlock) -> CGFloat {
        
        var height : CGFloat = 0
        
        if identifier == nil || cacheKey == nil {
            return height
        }
        
        height = cellHeightWith(identifier: identifier, configuration: configuration)
        
        return height
    }
    
    private func cellHeightWith(identifier : String?,configuration : cellConfigurationBlock) -> CGFloat {
        var height : CGFloat = 0
        
        if identifier == nil {
            return height
        }
        
        let preLayoutCell : UITableViewCell = cellForReuse(identifier: identifier)
        preLayoutCell.prepareForReuse()
        configuration(preLayoutCell)
        
        height = fittingHeightFor(cell: preLayoutCell)
        return height
    }
    
    private func cellForReuse(identifier : String?) -> UITableViewCell{
        var preLayoutCellByIdentifiers : [String : UITableViewCell]? = objc_getAssociatedObject(self, objcKey) as? [String : UITableViewCell]
        if preLayoutCellByIdentifiers == nil {
            preLayoutCellByIdentifiers = [:]
            objc_setAssociatedObject(self, objcKey, preLayoutCellByIdentifiers, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        var preLayoutCell : UITableViewCell? = preLayoutCellByIdentifiers?[identifier!]
        if preLayoutCell == nil {
            preLayoutCell = self.dequeueReusableCell(withIdentifier: identifier!)
            preLayoutCell?.contentView.translatesAutoresizingMaskIntoConstraints = false
            preLayoutCellByIdentifiers?.updateValue(preLayoutCell!, forKey: identifier!)
        }
        
        return preLayoutCell!
    }
    
    private func fittingHeightFor(cell : UITableViewCell) -> CGFloat {
        var height : CGFloat = 0
        
        height = cell.contentView.frame.size.height
        
        return height
    }
}

class GlobalDefineSwift: NSObject {

}
