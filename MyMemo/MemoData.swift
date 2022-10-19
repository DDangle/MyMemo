//
//  MemoData.swift
//  MyMemo
//
//  Created by 한규철 on 9/22/R4.
//

import UIKit
import FMDB

class MemoData: NSObject {
    // 이 놈아 id 값이 널 허용이면 어떻게 하니.
    // 국가에서 주민번호가 없는 사람이 생기면 어떻게 되겠어.
    var memoId: Int = 0   //데이터 식별값
    var title: String?      //메모 제목
    var contents: String?   //메모 내용
//    var image : UIImage?    //이미지
    var regDate: Date?      //작성일
    
    override init() {
        super.init()
    }
    
    init(rs: FMResultSet) {
        super.init()
        self.memoId = Int(rs.int(forColumn: "id"))
        self.title = rs.string(forColumn: "title")
        self.contents = rs.string(forColumn: "contents")
        self.regDate = Date(timeIntervalSince1970: TimeInterval(rs.int(forColumn: "reg_date")))
        
    }
}
