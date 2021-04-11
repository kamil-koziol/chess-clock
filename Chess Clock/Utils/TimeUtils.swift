//
//  TimeUtils.swift
//  Chess Clock
//
//  Created by Kamil Kozioł on 05/04/2021.
//

import Foundation

struct TimeUtils {
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    static func secondsAsTime (seconds:Int) -> String {
        let (h, m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        if(h == 0) {
            return String(format: "%02d:%02d", m, s)
        } else {
            return String(format: "%02d:%02d:%02d", h, m, s)
        }
    }
}

