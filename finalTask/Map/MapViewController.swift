//
//  MapViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/19.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import CoreLocation     // 地図に必要なキット
import MapKit           // 地図に必要
import FirebaseFirestore

// クラスを追加
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIPopoverControllerDelegate {

    // 地図を紐付け
    @IBOutlet var mapView: MKMapView!

    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!
    // firestoreのインスタンス化
    let db = Firestore.firestore()
    // データベースから取ってくる情報をすべて格納
    var items = [NSDictionary]()
    // 表示させているものが何番目のドキュメントか判断する変数
    var num = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        myLocationManager.requestWhenInUseAuthorization()
        // 地図の初期設定
        initMap()
        // firebaseからデータを取得してピンを生成
        fetch()
    }


    // ピンの詳細情報を得るために書いた情報
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        // Identifier
        let myAnnotationIdentifier = "myAnnotation"

        // AnnotationViewをdequeue
        var myAnnotationView : MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: myAnnotationIdentifier)

        //アノテーションの右側につけるボタンの宣言
        let button: UIButton = UIButton(type: UIButton.ButtonType.infoLight)

        if myAnnotationView == nil {
            myAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: myAnnotationIdentifier)
            //アノテーションの右側にボタンを付ける
            myAnnotationView.rightCalloutAccessoryView = button
            myAnnotationView.canShowCallout = true
        }

        // ピンに固有のデータベース情報を持たせる
        return myAnnotationView
    }

    // ピンのボタンを押された時のメソッド
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        //アノテーションを消す
        if let annotation = view.annotation {
            mapView.deselectAnnotation(annotation, animated: true)
        }

        switch view.annotation?.title {
        case "大阪":
            num = 0
        case "新宿":
            num = 1
        case "渋谷":
            num = 2
        case "池袋":
            num = 3
        case "六本木":
            num = 4
        case "東京駅":
            num = 5
        case "品川":
            num = 6
        default:
            return
        }

        //ストーリーボードの名前を指定
        let storyboard = UIStoryboard(name: "MapStoryboard", bundle: nil)

        print("\(MKAnnotation.self)")
        //viewにつけた名前を指定
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        vc.tag = num

        present(vc, animated: true, completion: nil)
    }


    // firestoreから投稿データを取得
    func fetch() {
        // 取得データを格納する場所
        var tempItems = [NSDictionary]()
        // postドキュメントからデータをもらう
        db.collection("post").getDocuments() {(querysnapshot, err) in
            // アイテムを全部取ってくる。
            for item in querysnapshot!.documents {
                let dict = item.data()
                tempItems.append(dict as NSDictionary)      // tempItemsに追加
            }
            self.items = tempItems                          // 最初に作った配列に格納
            // 各ドキュメントの情報を取る
            for place in self.items {
                // 取った情報のplaceNameに対応するところを入手
                let placeName = place["placeName"] as? String
                // 場所によって違うピンを立てる
                switch placeName {
                case "大阪":
                    self.addAnnotation(34.7024854, 135.4937619, "大阪", "\(place["name"] ?? "")", place as! [String : Any])
                case "新宿":
                    self.addAnnotation(35.689536, 139.699636, "新宿", "\(place["name"] ?? "")", place as! [String : Any])
                case "渋谷":
                    self.addAnnotation(35.658034, 139.701636, "渋谷", "\(place["name"] ?? "")", place as! [String : Any])
                case "池袋":
                    self.addAnnotation(35.73353, 139.712118, "池袋", "\(place["name"] ?? "")", place as! [String : Any])
                case "六本木":
                    self.addAnnotation(35.663262, 139.731572, "六本木", "\(place["name"] ?? "")", place as! [String : Any])
                case "東京駅":
                    self.addAnnotation(35.680940, 139.767425, "東京駅", "\(place["name"] ?? "")", place as! [String : Any])
                case "品川":
                    self.addAnnotation(35.628628, 139.738813, "品川", "\(place["name"] ?? "")", place as! [String : Any])
                default:
                    self.addAnnotation(0, 0, "例外", "赤道", place as! [String : Any])
                }
            }
        }
    }

    // ピンを生成するメソッド
    func addAnnotation( _ latitude: CLLocationDegrees,_ longitude: CLLocationDegrees, _ title: String,_ subtitle: String, _ personalItems: [String: Any]) {

        // ピンをインスタンス化
        let addAnnotation = CustumPinAnnotation()
        // 緯度経度を指定
        addAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)

        // タイトル、サブタイトルを設定
        addAnnotation.title = title
        addAnnotation.subtitle = subtitle

        // データベースの配列を組み込む
        addAnnotation.custumItems = personalItems
        // mapViewに追加
        mapView.addAnnotation(addAnnotation)
    }


    // 位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }


    // 初期の縮尺と位置を設定
    func initMap() {
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        mapView.userTrackingMode = .follow
    }


    func updateCurrentPos(_ coordinate:CLLocationCoordinate2D) {
        var region:MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region,animated:true)
    }

    // CLLocationManagerのdelegate：現在位置取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        updateCurrentPos((locations.last?.coordinate)!)
    }


    // 現在地に飛ぶためのボタン
    @IBAction func nowPlaceButton(_ sender: Any) {
        switch mapView.userTrackingMode {
        case .none:
            // noneからfollowへ
            mapView.setUserTrackingMode(.follow, animated: true)
        case .follow:
            // followからfollowWithHeadingへ
            mapView.setUserTrackingMode(.followWithHeading, animated: true)
        case .followWithHeading:
            // followWithHeadingからnoneへ
            mapView.setUserTrackingMode(.none, animated: true)
        default:
            print("謎状態")
        }
    }

}
