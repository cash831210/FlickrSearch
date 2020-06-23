//
//  FlickrSearchCollectionViewController.swift
//  FlickrSearch
//
//  Created by 莊鎧旭 on 2020/6/22.
//  Copyright © 2020 Cash. All rights reserved.

//  FlickrSearch
//  key：
//  17982d474276bd60fd4ef49d7ccb91db
//
//  密鑰：
//  d69cc6341fee70a7

import UIKit

private let reuseIdentifier = "PhotoCollectionViewCell"

class FlickrSearchCollectionViewController: UICollectionViewController {
    
    var refreshControl:UIRefreshControl!
    var photos = [Photo]()
    var searchTitle: String!
    var countNumber: Int!
    var numberOfPageLoaded: Int = 0
    
    @objc func fetchNewData() { // 抓取API資料

        if let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=17982d474276bd60fd4ef49d7ccb91db&text=\( searchTitle!)&per_page=\(countNumber!)&page=\(String(numberOfPageLoaded + 1))&format=json&nojsoncallback=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let searchData = try? JSONDecoder().decode(SearchData.self, from: data) {
                    self.photos.append(contentsOf: searchData.photos.photo)
                    self.numberOfPageLoaded += 1
                    DispatchQueue.main.async() {
                        self.refreshControl.endRefreshing()
                        self.collectionView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "搜尋結果 \(searchTitle!)"
        refreshControl = UIRefreshControl()
        collectionView.addSubview(refreshControl)
        // 設定cell Item size
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = (view.bounds.width - 10) / 2
        layout?.itemSize = CGSize(width: width, height: width + 50)
        // 抓第一筆資料
        fetchNewData()
        // 下拉更新增加指定數量資料，上拉即可顯示總數資料
        refreshControl.addTarget(self, action: #selector(fetchNewData), for: UIControl.Event.valueChanged)
 
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        // Configure the cell
        let photo = photos[indexPath.item]
        cell.titleLabel.text = photo.title
        cell.imageURL = photo.imageUrl
        cell.photoImageView.image = nil
        NetworkUtility.downloadImage(url: cell.imageURL) { (image) in
            if cell.imageURL == photo.imageUrl, let image = image {
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        return cell
    }
}
