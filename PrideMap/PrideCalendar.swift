//
//  PrideCalendar.swift
//  PrideMap
//
//  Created by Felix Hedlund on 2017-07-18.
//  Copyright © 2017 Felix Hedlund. All rights reserved.
//

import Foundation

protocol PrideCalendarDelegate{
    func updateMessageLabel(with message: String)
}

class PrideCalendar{
    var startDate: Date!
    var finishDate: Date!
    
    var delegate: PrideCalendarDelegate
    var loopTimer: Timer?
    var finishTimer: Timer?
    init(delegate: PrideCalendarDelegate){
        self.delegate = delegate
        finishDate = Date()
        setStartDate()
        setEndDate()
        startTimerAndSendMessages()
        
        NotificationCenter.default.addObserver(self, selector: #selector(startTimerAndSendMessages), name: NSNotification.Name(rawValue: TargetConstants.RestartAnimationWhenAppEntersForeground), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(invalidateTimers), name: NSNotification.Name(rawValue: TargetConstants.ApplicationDidEnterBackground), object: nil)
    }
    
    
    private func setStartDate(){
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "sv")
        let timeZone = TimeZone(identifier: "Europe/Stockholm")
        let components = DateComponents(calendar: calendar, timeZone: timeZone, era: nil, year: 2017, month: 7, day: 18, hour: 14, minute: 34, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let date = calendar.date(from: components)
        if let date = date{
            startDate = date
        }
    }
    
    private func setEndDate(){
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "sv")
        let timeZone = TimeZone(identifier: "Europe/Stockholm")
        let components = DateComponents(calendar: calendar, timeZone: timeZone, era: nil, year: 2017, month: 7, day: 18, hour: 14, minute: 35, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let date = calendar.date(from: components)
        if let date = date{
            finishDate = date
        }
    }
    
    @objc func invalidateTimers(){
        self.loopTimer?.invalidate()
        self.finishTimer?.invalidate()
    }
    
    @objc func startTimerAndSendMessages(){
        let _ = self.sendMessages()
        self.loopTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            let shouldContinue = self.sendMessages()
            if shouldContinue{
                    
            }else{
                timer.invalidate()
            }
        })
        self.finishTimer = Timer(fire: finishDate, interval: 1, repeats: false) { (timer) in
            let _ = self.sendMessages()
        }
        RunLoop.current.add(finishTimer!, forMode: .defaultRunLoopMode)
    }
    
    private func sendMessages() -> Bool{
        let now = Date()
        let compareDate = now.compare(self.startDate)
        
        if compareDate == .orderedAscending{
            //now is before
            let message = self.getTimeLeftUntilStartDateMessage(now: now, start: self.startDate)
            self.delegate.updateMessageLabel(with: message)
            return true
        }else{
            //now is after
            let compareFinish = now.compare(self.finishDate)
            if compareFinish == .orderedAscending{
                let message = self.getPrideEventStartedMessage(now: now, finish: self.finishDate)
                self.delegate.updateMessageLabel(with: message)
            }else{
                let message = self.getPrideEventFinishedMessage()
                self.delegate.updateMessageLabel(with: message)
            }
        }
        return false
    }
    
    private func getTimeLeftUntilStartDateMessage(now: Date, start: Date) -> String{
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.current
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: now, to: start)
        var returnString = NSLocalizedString("The parade starts in: ", comment: "parade starts in string")
        if let months = components.month{
            if months != 0{
                var monthString = ""
                if months == 1{
                    monthString = NSLocalizedString("month", comment: "monthString")
                }else{
                    monthString = NSLocalizedString("months", comment: "monthsString")
                }
                returnString.append("\(months) \(monthString), ")
            }
        }
        
        if let days = components.day{
            if days != 0{
                var dayString = ""
                if days == 1{
                    dayString = NSLocalizedString("day", comment: "dayString")
                }else{
                    dayString = NSLocalizedString("days", comment: "daysString")
                }
                returnString.append("\(days) \(dayString), ")
            }
        }
        
        if let hours = components.hour{
            if hours != 0{
                var dayString = ""
                if hours == 1{
                    dayString = NSLocalizedString("hour", comment: "hourString")
                }else{
                    dayString = NSLocalizedString("hours", comment: "hoursString")
                }
                returnString.append("\(hours) \(dayString), ")
            }
        }
        
        if let minutes = components.minute{
            if minutes != 0{
                var minuteString = ""
                if minutes == 1{
                    minuteString = NSLocalizedString("minute", comment: "minuteString")
                }else{
                    minuteString = NSLocalizedString("minutes", comment: "minutesString")
                }
                returnString.append("\(minutes) \(minuteString), ")
            }
        }
        
        if let seconds = components.second{
            if seconds != 0{
                var secondString = ""
                if seconds == 1{
                    secondString = NSLocalizedString("second", comment: "secondString")
                }else{
                    secondString = NSLocalizedString("seconds", comment: "secondsString")
                }
                returnString.append("\(seconds) \(secondString)")
            }
        }
        return returnString
    }
    
    private func getPrideEventStartedMessage(now: Date, finish: Date) -> String{
        return NSLocalizedString("parade_started_string", comment: "parade started string")
    }
    
    private func getPrideEventFinishedMessage() -> String{
        return NSLocalizedString("parade_finished_string", comment: "parade finished string")
    }
    
    
    
    
    
}
