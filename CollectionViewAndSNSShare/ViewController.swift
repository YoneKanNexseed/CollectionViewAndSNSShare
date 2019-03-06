//
//  ViewController.swift
//  CollectionViewAndSNSShare
//
//  Created by yonekan on 2019/03/06.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 写真のデータを保存する配列
    var items: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "customCell")
        
        for _ in 1...2 {
            let url = URL(string: "https://picsum.photos/200/200/?random")
            
            do {
                // 写真のデータを取得
                let data = try Data(contentsOf: url!)
                
                // 配列に写真のデータを追加
                items.append(data)
            } catch let err {
                print("エラーが発生しました")
                print(err)
            }
        }
        
        
    }

    // セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
        
        cell.label.text = "\(indexPath.row)"
        
        // 写真のデータを取得
        let data = items[indexPath.row]
        
        // セルのImageViewに写真を設定
        cell.imageView.image = UIImage(data: data)
        
        return cell
    }
    
    // セルの大きさを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 画面サイズ / 3 - 5
        // self.view.bounds.width : 画面サイズ
        let cellSize: CGFloat = self.view.bounds.width / 3 - 5
        
        return CGSize(width: cellSize, height: cellSize)
        
    }
    
    // セル同士の横の幅を設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // セル同士の縦の幅を設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // セルがクリックされたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // シェア機能を持つ画面を作成
        let controller = UIActivityViewController(activityItems: [items[indexPath.row]], applicationActivities: nil)
        
//        ["選択された写真", ]
        // モーダルでシェア画面を表示
        present(controller, animated: true, completion: nil)
    }
    
}

