//
//  Anime.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class Anime {
    var id: Int
    var seriesType: String
    var titleRomaji: String
    var titleEnglish: String
    var titleJapanese: String
    var type: String
    var startDate: String
    var endDate: String
    var startDateFuzzy: Int
    var endDateFuzzy: Int
    var season: Int
    var description: String
    var synonyms: [String]
    var genres: [String]
    var adult: Bool
    var averageScore: Double
    var popularity: Int
    var favourite: Bool
    var imageUrlSmall: String
    var imageUrlMed: String
    var imageUrlLarge: String
    var imageUrlBanner: String
    var updatedAt: Int
    var totalEP: Int
    var duration: Int
    var airingStatus: String
    var youtubeId: String
    var hashtag: String
    var source: String
    var airing = Airing()
    var characters = [CharacterStaff]()
    var staff = [CharacterStaff]()
    var studio = [Studio]()
    var externalLinks = [ExternalLink]()
    
    init(response: AnimeResponse) {
        self.id = response.id ?? 0
        self.seriesType = AnidesuConverter.checkNilString(str: response.series_type)
        self.titleRomaji = AnidesuConverter.checkNilString(str: response.title_romaji)
        self.titleEnglish = AnidesuConverter.checkNilString(str: response.title_english)
        self.titleJapanese = AnidesuConverter.checkNilString(str: response.title_japanese)
        self.type = AnidesuConverter.checkNilString(str: response.type)
        self.startDate = AnidesuConverter.checkNilString(str: response.start_date)
        self.endDate = AnidesuConverter.checkNilString(str: response.end_date)
        self.startDateFuzzy = response.start_date_fuzzy ?? 0
        self.endDateFuzzy = response.end_date_fuzzy ?? 0
        self.season = response.season ?? 0
        self.description = AnidesuConverter.checkNilString(str: response.description)
        self.synonyms = response.synonyms ?? [String]()
        self.genres = response.genres ?? [String]()
        self.adult = response.adult ?? false
        self.averageScore = response.average_score ?? 0
        self.popularity = response.popularity ?? 0
        self.favourite = response.favourite ?? false
        self.imageUrlSmall = AnidesuConverter.checkNilString(str: response.image_url_sml)
        self.imageUrlMed = AnidesuConverter.checkNilString(str: response.image_url_med)
        self.imageUrlLarge = AnidesuConverter.checkNilString(str: response.image_url_lge)
        self.imageUrlBanner = response.image_url_banner ?? response.image_url_lge!
        self.updatedAt = response.updated_at ?? 0
        self.totalEP = response.total_episodes ?? 0
        self.duration = response.duration ?? 0
        self.airingStatus = AnidesuConverter.checkNilString(str: response.airing_status)
        self.youtubeId = AnidesuConverter.checkNilString(str: response.youtube_id)
        self.hashtag = AnidesuConverter.checkNilString(str: response.hashtag)
        self.source = AnidesuConverter.checkNilString(str: response.source)
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
