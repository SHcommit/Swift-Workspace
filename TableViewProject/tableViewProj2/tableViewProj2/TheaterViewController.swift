//
//  TheaterViewController.swift
//  tableViewProj2
//
//  Created by 양승현 on 2022/02/10.
//

import UIKit
import Foundation
import MapKit
/**
 *TheaterListController에서 (영화관 정보 VC, 이전 VC) prepare(for:sender:)를 통해 TheaterViewController와 연결된 특정한 segue를 ID값에 대한 기능을 실행한다.
 *이때 이전VC에서 tableView의 특정 cell의 row에 대해서 indexPath.row를 통해 특정 행 정보를 알아낸다.
 *이후 이 정보를 prepare의 첫번째 매개변수 for segue를 통해 segue.destination을 이 클래스 이름으로 캐스팅하여,
 *NSDictionary 타입인 param에 특정 행정보의 list값을 대입한다.
 *그렇다면 param은 위도, 경도, 상영관명등 특정 영화관 정보의 정보를 NSDictionary타입으로 갖고있다.
 */
class TheaterViewController : UIViewController{
    var param: NSDictionary!
    @IBOutlet var map: MKMapView!
    /**
     * - CLLocationCoordinate2D는 맵의 중심 좌표를 정한다.
     *      Coord ( Coordinates = 좌표)
     *      latitude : 위도. longitude : 경도 를 뜻한다. // 위도, 경도 즉 위치 정보를 저장한다.
     * - CLLocationDistance 맵에 표현될 지역의 너비를 설정할 수 있다.
     *      단위 = m(미터).
     *      클수록 더 넓은 범위가 맵에 표현된다.
     * - MKCoordinateRegion
     *      첫번째 인자값(center)을 중심값으로, 두번째, 세번째 인자값( 위도미터, 경도미터)에 대한 중심값과
     *      가로,세로 거리 값regionRadius을 기준으로 하는 지도 데이터를 생성한다.
     * - self.map.setRegion(coordinateRegion,animated: true)
     *      map 변수와 연결된 Map Kit View컨트롤에 위에서 설정한 지도 표현 데이터를 전달하여 ,
     *      화면에 setRegion(_:) . 보여지는 지역을 위에서 설정한 특정한 좌표 지역으로 보이도록 정한다.
     **여기까지는 화면에 보여질 특정 좌표를 기준으로 가로, 세로 주변에 몇미터까지 보여질 것인지를 정한 것이다.
     *아직 화면상에서 어느 위치를 가리키는지는 나오지 않는다.
     * - MKPointAnnotation( )
     *      위치 표시해줄 객체<point>를 생성하고, 이 객체의 .coordinate의 좌표값을 location으로 설정한다.
     *      그 후 map.addAnnotation(point) 추가한다.
     */
    override func viewDidLoad(){
        self.navigationItem.title = self.param["상영관명"] as? String
        
        let lat = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let regionRadius: CLLocationDistance = 100
        
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                                        
        self.map.setRegion(coordinateRegion, animated: true)
        /*     화면에 보여질 정확한 위치     */
        let point = MKPointAnnotation()
        point.coordinate = location
        
        self.map.addAnnotation(point)
    }
}
