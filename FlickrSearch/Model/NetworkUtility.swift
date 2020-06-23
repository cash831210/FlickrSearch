//
//  NetworkUtility.swift
//  FlickrSearch
//
//  Created by 莊鎧旭 on 2020/6/22.
//  Copyright © 2020 Cash. All rights reserved.
//

import UIKit

struct NetworkUtility { // 下載圖片
    static func downloadImage(url: URL, handler: @escaping (UIImage?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                handler(image)
            } else {
                handler(nil)
            }
        }
        task.resume()
    }
}
