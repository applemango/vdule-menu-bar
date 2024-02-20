//
//  struct.swift
//  vdule
//
//  Created by apple on 2024/02/10.
//

import Foundation

struct Channel: Codable {
    var id: String
    var name: String
    var description: String
    var handle: String
    var publish_at: String
    var icon_image: String
    var uploads_playlist: String
    var view_count: Int
    var subscriber_count: Int
    var video_count: Int
    var trailer: String
    var banner_image: String
}

struct ScheduleDate: Codable {
    var year: Int
    var month: Int
    var day: Int
    var hour: Int? = 0
    var minute: Int? = 0
}

struct Schedule: Codable {
    var id: String
    var title: String
    var thumbnail: String? = ""
    var date: ScheduleDate
    var channel: Channel
    var is_now_on_air: Bool? = false
}

struct RawResponseSchedule: Codable {
    var videos: [Schedule]
}


struct VtuberTag: Codable {
    var id: Int
    var name: String
}
struct VtuberOrganization: Codable {
    var id: Int
    var name: String
    var description: String? = ""
}
struct Vtuber: Codable {
    var id: Int
    var channel: Channel
    var handle: String
    var tags: [VtuberTag]
    var name: String
    var organization: VtuberOrganization? = nil
}
