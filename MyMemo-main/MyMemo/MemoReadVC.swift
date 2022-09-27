//
//  MemoReadVC.swift
//  MyMemo
//
//  Created by 한규철 on 9/22/R4.
//

import UIKit

class MemoReadVC : UIViewController {
    
    
    
    @IBOutlet weak var titleLable : UILabel!
    @IBOutlet weak var contentsLable: UILabel!
    
    //콘텐츠 데이터를 저장하는 변수
    var param: MemoData?
    
    override func viewDidLoad() {
        //제목과 내용 이미지를 출력
        
        self.titleLable.text = param?.title
        self.contentsLable.text = param?.contents
        
       
    }
    
    //메모 편집버튼
    @IBAction func editButton(_ sender: Any) {
        
        // ToDo : 해당메모의 자료는 유지하면서 작성폼으로 이동할 것
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoWrite") as? MemoWriteVC {
            vc.editTarget = param
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
