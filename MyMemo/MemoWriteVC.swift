//
//  MemoWriteVC.swift
//  MyMemo
//
//  Created by 한규철 on 9/22/R4.
//

import UIKit

protocol MemoWriteVCDelegate: AnyObject {
    func updateMemo()
}

class MemoWriteVC : UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var writeTitle: UITextField!
    
    var subject : String!
//    var listVC = MemoListVC()
    
    
    
    weak var delegate: MemoWriteVCDelegate?
    
    override func viewDidLoad() {
        self.detailTextView.delegate = self
    }
    
    
    
    //save 버튼 클릭시 호출
    @IBAction func saveButton(sender: UIButton) {
       
        //내용이 없을시 경고창
        guard self.detailTextView.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.present(alert, animated: true)
            return
        }
        
        
        //memoData 객체 생성후 데이터 담기
        let data = MemoData()

        //제목
        data.title = self.writeTitle.text
        //내용
        data.contents = self.detailTextView.text
        
        print("메모 리스트 \(data.title)")
        
        DBManager.shared.insertMemo(memo: data)
        
        //메모가 담겨있는곳
        var realList = DBManager.shared.readMemo()
        
        
        print("찐 메모 리스트 \(realList)")
        
        
        
        
        
        //앱델리게이트 객체를 읽어온다음, memoList배열에 memoData 객체를 추가한다.
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.memolist = DBManager.shared.readMemo()
        
        
        //글작성 화면을 종료하고 memoList로 돌아간다
        //popViewController - 탐색 스택에서 상위뷰컨트롤러를 팝하고 디스플레이를 업데이트
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //사용자가 텍스트뷰에 뭔가 입력하면 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용에 최대 15자리까지 읽어 mememoTilte 변수에 저장
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
    
    }
}
