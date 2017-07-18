//
//  PushHelper.swift
//  PrideMap
//
//  Created by Felix Hedlund on 2017-07-17.
//  Copyright © 2017 Felix Hedlund. All rights reserved.
//
import UIKit
import UserNotifications
import CloudKit
class PushHelper: NSObject, UNUserNotificationCenterDelegate {
    
    static let sharedInstance = PushHelper()
    
    
    override init() {
        super.init()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
    
    func registerForPushNotifications(success: @escaping () -> (), failure: @escaping () -> ()){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization
            DispatchQueue.main.async {
                if granted{
                    success()
                }else{
                    failure()
                }
            }
        }
        
        (UIApplication.shared.registerForRemoteNotifications())
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification)
        let userInfo = response.notification.request.content.userInfo
        let queryNotification = CKQueryNotification(fromRemoteNotificationDictionary: userInfo)
        print("fields: \(queryNotification.recordFields ?? [String:Any]())")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func schedulePushNotification(components: DateComponents, message: String, identifier: String){
        let content = UNMutableNotificationContent()
        content.body = message
        content.categoryIdentifier = "message"
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request) { (error) in
            print("Added notification request: \(message)")
            print("with error: \(error?.localizedDescription ?? "")")
        }
    }
    
    func removeAllScheduledNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}
