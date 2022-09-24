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
        
//        //날짜 포맷 변환
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
//        let dateString = formatter.string(from: (param?.regdata)!)
//
//        //네비게이션 타이틀에 날짜를 표시
//        self.navigationItem.title = dateString
    }
    
}
