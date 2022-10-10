//
//  MemoListVC.swift
//  MyMemo
//
//  Created by 한규철 on 9/22/R4.
//

import UIKit

// 1. Write
// 2. UITableViewController -> UIViewController + UITableView = 완
// 3. 제약조건
class MemoListVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    @IBOutlet var listTableView: UITableView!
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var memoList = [MemoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setData()
        
    }

    
    func setData() {
        self.memoList = DBManager.shared.readMemo()
    }
    
    //memoWrite로 넘어가는 버튼
    @IBAction func abbButton(_ sender: UIBarButtonItem) {
        let writeVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoWrite") as? MemoWriteVC
        writeVC?.delegate = self
        self.navigationController?.pushViewController(writeVC!, animated: true)
    }
    
    // MARK : 테이블뷰 메소드들
    //number Of Rows Insection - 테이블 행의갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //앱델리게이트의 memolist 의 데이터량 만큼 테이블 행의 길이를 정한다.
        let count = self.memoList.count
        return count
        
        print("numberOfRowsInsection 앱 델리게이트 메모리스트 \(self.memoList)")
    }
    
    //테이블 행을 구성하는 메소드 - 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.memoList[indexPath.row]
        let celled = "MemoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: celled) as! MemoCell
        
        //memoCell 의 값
        cell.mymemoTitle?.text = row.title
        cell.mymemoContents?.text = row.contents
        
//        //Date 타입의 날짜를 yyyy-mm-dd HH:mm:ss  포맷에 맞게 변경한다.
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
//        cell.regDate?.text = formatter.string(from: row.regdata!)
//        
        return cell
    }
    //테이블에 특정행이 선택되었을때 실행되는 메소드, 선택된 행의 정보는 indexPath 에 담겨 전달
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //memoList 배열에서 선택된 행에 맞는 데이터를 꺼냄
        let row = self.memoList[indexPath.row]
       
        //MemoReadVC 화면의 인스턴스 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else { //instantiateViewController 지정된 식별자로 뷰컨트롤러를 만들고 스토리보드 데이터로 초기화 한다.
            return
        }
        
        //값 전달후 MemoReadVC로 이동한다
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension MemoListVC: MemoWriteVCDelegate {
    func updateMemo() {
        self.tableView.reloadData()
    }
}
