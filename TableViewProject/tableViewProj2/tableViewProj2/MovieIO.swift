//
//  MovieIO.swift
//  tableViewProj2
//
//  Created by 양승현 on 2022/02/04.
//

import Foundation
import UIKit

/**
 *섬네일
 *제목
 *설명
 *상세 정보
 *개봉일
 *평점
 *UIImage썸네일
 *  그러니까 
 */
class MovieVO{
    var thumbnail: String?
    var title: String?
    var description: String?
    var detail : String?
    var opendate: String?
    var rating: Double?
    var thumbnailImage: UIImage?
}
