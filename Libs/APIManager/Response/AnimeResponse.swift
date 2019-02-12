//
//  AnimeResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 17/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class AnimeResponse: Decodable {
    var id: Int?
    var series_type: String?
    var title_romaji: String?
    var title_english: String?
    var title_japanese: String?
    var type: String?
    var start_date: String?
    var end_date: String?
    var start_date_fuzzy: Int?
    var end_date_fuzzy: Int?
    var season: Int?
    var description: String?
    var synonyms: [String]?
    var genres: [String]?
    var adult: Bool?
    var average_score: Double?
    var popularity: Int?
    var favourite: Bool?
    var image_url_sml: String?
    var image_url_med: String?
    var image_url_lge: String?
    var image_url_banner: String?
    var updated_at: Int?
    var total_episodes: Int?
    var duration: Int?
    var airing_status: String?
    var youtube_id: String?
    var hashtag: String?
    var source: String?
    var airing: AiringResponse?
    var characters: [CharacterStaffResponse]?
    var staff: [CharacterStaffResponse]?
    var studio: [StudioResponse]?
    var external_links: [ExternalLinkResponse]?
}
