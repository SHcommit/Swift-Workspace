//
//  ViewController.swift
//  ImagePicherDelegate
//
//  Created by 양승현 on 2022/01/24.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var imgView: UIImageView!;
    /**
     *UIImagePickerController( ) *
     *카메라, 엘범 등을 통해 이미지를 선택할 때 사용하는 컨트롤러.
     *단순하게 이미지를 선택해서 가져온다. (엘범, 카메라 찍은 후 사진 가져올 수도있고. ..)
     *카메라로 사진 짝어서 가져오는 과정, 엘범에서 이미지를 불러오는 과정 (뭐 저장주소를 직접 설정해줘야 한다느니..)이런거
     *컨트롤 내에서 구현 되어있데,, 대박 좋다.
     *
     *이미지 피커 Controller는 '화면 전체' 를 덮는다.
     * UIViewController를 상속 받았기에 화면 전환방식을 통해 이미지 화면을 보여주는게 best!
     */
    @IBAction func imgPick(_ sender: Any){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary; //이미지 소스 사진라이브러리
        picker.allowsEditing = true;
        
        //현재 상황 : 이미지 피커로 사진 선택하고!! choose눌렀다. 그럼이제 이미지피커는 델리게이트로 지정된 객체에 델리게이트 메서드 호출시킨다.
        picker.delegate = self //이미지 picker의 delegate지정 = 현재 VC
        self.present(picker, animated: false); //이미지 피커 컨트롤러 화면에 호출
    
    
    //그리고 delegate프로토콜에 선언된 메서드들을 추가 구현해준다.
    
    let num = "YES"
    
    switch num{
    case "POTENTIAL ERROR":
        //이미지 피커에서 이미지 선택하지 않고 cancel할 경우.
        func imagePickerControllerDidCancel(_ picker : UIImagePickerController){
            //취소를 눌렀으니까 이미지 피커 컨트롤러 창 닫기!
            //picker.dismiss(animated: false)
            self.presentingViewController?.dismiss(animated: false)
            
            let alert = UIAlertController(title: "", message: "이미지 선택 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    case "YES":
        /**알림창과 , 이미지 피커 둘다 ViewController이므로 이미지 피커가 늦게 닫힐 때 알람창이 실행되지 못할 수 있다.
         *따라서
         *이미지 창을 완전히 닫은 이후에 실행할 수 있도록
         *dismiss 두번째 매개변수 completion에  클로저로 알림을 구현한다.
         */
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            self.presentingViewController?.dismiss(animated: false, completion: {() in
            let alert = UIAlertController(title: "", message: "이미지 선택 취소되었습니다.", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "확인", style: .cancel));
            self.present(alert, animated: false);
            })
        }
        
        default:
            print("Unexpected case")
        }
    }
    /**이미지 피커에서 이미지 선택했을 때 호출되는 메서드
     *이 경우에는 이미지를 VC에 지정한. Image View 컨트롤에 출력해주면 된다.
     *그 전에!
     *원래 VC에서 이미지 피커로 화면 전환을 (덮어씌기)를 했기에 원래 VC로 되돌아 와야한다. self.presentingViewController?.dismiss
     *위의 case와 같이 이미지 피커가 늦게 닫힐 경우 를 대비해
     *창이 완저히 닫힌 이후에 그림을 불러오자!
     *UIImagePickerController에는 내가 뭘 선택했는지, editedImage. 편집은 했지만 원본데이터를 가져오고 싶을 때 originalImage 등
     *UIIMagePickerController.InfoKey에서 구조체로 정의된 InfoKey의 요소들을 호출하면 된다.
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.presentingViewController?.dismiss(animated: false, completion: {() in
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage // info는 Any타입이다. 따라서 UIImage타입으로 다운 캐스팅 해야한다.
            
            self.imgView.image = img
        })
    }
}

