//
//  HomeMapper.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//
import Foundation

protocol ProductMapper {
    func map(dto: ProductResponseDTO) -> Product
}

struct ProductMapperImpl: ProductMapper {
    func map(dto: ProductResponseDTO) -> Product {
       
        Product(
            id: dto.id,
            title: dto.title,
            price: dto.price,
            image: dto.image
        )
    }
}
