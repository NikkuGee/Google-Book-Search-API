//
//  NotificationName+Extension.swift
//  GBooksTry
//
//  Created by Consultant on 7/23/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let SearchedNotification = Notification.Name.init("Searched")
    static let RecentNotification = Notification.Name("RecentNotification")
    static let FavoritesNotification = Notification.Name("Favorite")
    static let ClearedNotification = Notification.Name("Cleared")
}
