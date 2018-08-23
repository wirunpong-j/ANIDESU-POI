//
//  Anime.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class Anime {
    var id: Int?
    var seriesType: String?
    var titleRomaji: String?
    var titleEnglish: String?
    var titleJapanese: String?
    var type: String?
    var startDate: String?
    var endDate: String?
    var startDateFuzzy: Int?
    var endDateFuzzy: Int?
    var season: Int?
    var description: String?
    var synonyms: [String]?
    var genres: [String]?
    var adult: Bool?
    var averageScore: Double?
    var popularity: Int?
    var favourite: Bool?
    var imageUrlSmall: String?
    var imageUrlMed: String?
    var imageUrlLarge: String?
    var imageUrlBanner: String?
    var updatedAt: Int?
    var totalEP: Int?
    var duration: Int?
    var airingStatus: String?
    var youtubeId: String?
    var hashtag: String?
    var source: String?
    var airing: Airing?
    var characters: [CharacterStaff]?
    var staff: [CharacterStaff]?
    var studio: [Studio]?
    var externalLinks: [ExternalLink]?
    
    init(response: AnimeResponse) {
        self.id = response.id
        self.seriesType = response.series_type
        self.titleRomaji = response.title_romaji
        self.titleEnglish = response.title_english
        self.titleJapanese = response.title_japanese
        self.type = response.type
        self.startDate = response.start_date
        self.endDate = response.end_date
        self.startDateFuzzy = response.start_date_fuzzy
        self.endDateFuzzy = response.end_date_fuzzy
        self.season = response.season
        self.description = response.description
        self.synonyms = response.synonyms
        self.genres = response.genres
        self.adult = response.adult
        self.averageScore = response.average_score
        self.popularity = response.popularity
        self.favourite = response.favourite
        self.imageUrlSmall = response.image_url_sml
        self.imageUrlMed = response.image_url_med
        self.imageUrlLarge = response.image_url_lge
        self.imageUrlBanner = response.image_url_banner
        self.updatedAt = response.updated_at
        self.totalEP = response.total_episodes
        self.duration = response.duration
        self.airingStatus = response.airing_status
        self.youtubeId = response.youtube_id
        self.hashtag = response.hashtag
        self.source = response.source
        self.airing = response.airing == nil ? Airing() : Airing(response: response.airing!)
        self.characters = self.getCharacters(allResponse: response.characters)
        self.staff = self.getCharacters(allResponse: response.staff)
        self.studio = self.getStudios(allResponse: response.studio)
        self.externalLinks = self.getExternalLinks(allResponse: response.external_links)
    }
    
    private func getCharacters(allResponse: [CharacterStaffResponse]?) -> [CharacterStaff] {
        var allCharacter = [CharacterStaff]()
        if let allResponse = allResponse {
            for response in allResponse {
                let character = CharacterStaff(response: response)
                allCharacter.append(character)
            }
        }
        
        return allCharacter
    }
    
    private func getExternalLinks(allResponse: [ExternalLinkResponse]?) -> [ExternalLink] {
        var allExternalLink = [ExternalLink]()
        if let allResponse = allResponse {
            for response in allResponse {
                let externalLink = ExternalLink(response: response)
                allExternalLink.append(externalLink)
            }
        }
        
        return allExternalLink
    }
    
    private func getStudios(allResponse: [StudioResponse]?) -> [Studio] {
        var allStudio = [Studio]()
        if let allResponse = allResponse {
            for response in allResponse {
                let studio = Studio(response: response)
                allStudio.append(studio)
            }
        }
        
        return allStudio
    }
    
}
