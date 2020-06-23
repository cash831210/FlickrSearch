FlickrSearch
============

使用的API
- 使用的API: flickr.photos.search
- API文件: https://www.flickr.com/services/api/flickr.photos.search.html
- API 測試頁 : https://www.flickr.com/services/api/explore/flickr.photos.search

第一頁 (搜尋輸入頁)
-----
- 有兩個輸入框
- 第一個是搜尋文字的輸入匡(Text)
- 第二個是每頁要呈現的數量的輸入匡(Per Page)
- 此兩個輸入匡都要填寫,button 才可以點擊
- 不可點擊的 button 和可點擊的 button 用不同顏色區別
- 點擊button會轉跳(push)到第二頁(搜尋結果頁)

第二頁 (搜尋結果頁)
-----
- 顯示Flickr回傳的API結果,並且固定一行兩個 cell
- 此頁可下拉重新更新
- 此列表可上拉看到下一頁內容(可無限上拉)
- Cell 會顯示圖片(photo),與標題,Cell為正方形

MVC架構
-----
### Model(設定搜尋資料型別、抓圖功能)
- NetworkUtility(downloadImage)
- SearchData(Photo: struct)
### View(設定UI元件、頁面切換)
- Main.storyboard
### Controller(設定控制器)
- ViewController(設定第一頁：搜尋輸入頁)
- FlickrSearchCollectionViewController（設定第二頁：搜尋結果頁）
- PhotoCollectionViewCell（設定Cell）
