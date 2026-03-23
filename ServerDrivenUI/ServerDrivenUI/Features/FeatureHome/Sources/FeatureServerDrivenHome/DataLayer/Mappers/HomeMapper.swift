//
//  HomeMapper.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//
import Foundation
import ServerDrivenModelsKit

// For ServerDriven Development use DTO, no need for Entity
protocol HomeMapper {
    func map(dto: ComponentConfigDTO) -> HomeComponentEntity
}

struct HomeMapperImpl: HomeMapper {
    func map(dto: ComponentConfigDTO) -> HomeComponentEntity {
        let components = HomeComponentEntity(
            id: dto.id,
            type: dto.type,
            payload: dto.payload
        )
        
        return components
    }
}
