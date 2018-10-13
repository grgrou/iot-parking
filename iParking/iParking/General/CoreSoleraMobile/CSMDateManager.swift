//
//  CSMDateManager.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 14/03/18.
//

import UIKit

public struct DifferenceDates{
    
    public var year    = 0
    public var month   = 0
    public var day     = 0
    public var hour    = 0
    public var minute  = 0
    public var second  = 0
}

public class CSMDateManager: NSObject{
    
    public class func convertTimestampInDate(_ timestamp: String) -> Date {
        
        if let interval = TimeInterval(timestamp) {
            return Date(timeIntervalSince1970: interval)
        }
        
        return Date()
    }
    
    public class func convertDateText(_ dateText: String, inDateWithFormat format: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: dateText) ?? Date()
    }
    
    public class func convertDate(_ date : Date, inTextWithFormat format : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    public class func convertDate(_ date: Date, inDateWithFormat format: String, withLocale locale: Locale) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    public class func getYearsDifferenceBetweenDate(_ initialDate: Date, andDate finalDate: Date) -> TimeInterval{
        
        let components = Calendar.current.dateComponents([.year], from: initialDate, to: finalDate)
        return TimeInterval(components.year ?? 0)
    }
    
    public class func getMonthDifferenceBetweenDate(_ initialDate: Date, andDate finalDate: Date) -> TimeInterval{
        
        let components = Calendar.current.dateComponents([.month], from: initialDate, to: finalDate)
        return TimeInterval(components.month ?? 0)
    }
    
    public class func getDayDifferenceBetweenDate(_ initialDate: Date, andDate finalDate: Date) -> TimeInterval{
        
        let components = Calendar.current.dateComponents([.day], from: initialDate, to: finalDate)
        return TimeInterval(components.day ?? 0)
    }
    
    public class func getHourDifferenceBetweenDate(_ initialDate: Date, andDate finalDate: Date) -> TimeInterval{
        
        let components = Calendar.current.dateComponents([.hour], from: initialDate, to: finalDate)
        return TimeInterval(components.hour ?? 0)
    }
    
    public class func getMinuteDifferenceBetweenDate(_ initialDate: Date, andDate finalDate: Date) -> TimeInterval{
        
        let components = Calendar.current.dateComponents([.minute], from: initialDate, to: finalDate)
        return TimeInterval(components.minute ?? 0)
    }
    
    public class func getSecondDifferenceBetweenDate(_ initialDate: Date, andDate finalDate: Date) -> TimeInterval{
        
        let components = Calendar.current.dateComponents([.second], from: initialDate, to: finalDate)
        return TimeInterval(components.second ?? 0)
    }
    
    public class func getDifferenceBetweenDate(_ initialDate: Date, andDate finalDate: Date) -> DifferenceDates{
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: initialDate, to: finalDate)
        
        var difference = DifferenceDates()
        
        difference.year     = components.year ?? 0
        difference.month    = components.month ?? 0
        difference.year     = components.day ?? 0
        difference.hour     = components.hour ?? 0
        difference.minute   = components.minute ?? 0
        difference.second   = components.second ?? 0
        
        return difference
    }
}
