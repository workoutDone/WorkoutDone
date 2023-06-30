//
//  WorkOutData.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/30.
//

import Foundation

class WorkOut {
    let bodyPart: String
    let weightTraining: [String]
    
    init(bodyPart: String, weightTraining: [String]) {
        self.bodyPart = bodyPart
        self.weightTraining = weightTraining
    }
}

class WorkOutData {
    static let workOutData: [WorkOut] = [
        WorkOut(bodyPart: "등", weightTraining: [
            "굿모닝 (등)",
            "덤벨로우",
            "덤벨로우 (원암)",
            "인클라인 덤벨로우",
            "랙풀 데드리프트",
            "루마니안 데드리프트",
            "머신 로우로우 (원암)",
            "머신 로우로우",
            "머신 벤트오버 로우로우",
            "머신 미들로우",
            "머신 미들로우 (원암)",
            "머신 하이로우",
            "머신 하이로우 (원암)",
            "바벨로우",
            "펜들레이 로우",
            "케이블 로우",
            "케이블 로우 (원암)",
            "케이블 시티드 로우",
            "케이블 시티드 로우 (원암)",
            "티바로우",
            "랫풀다운",
            "암풀다운",
            "와이드 풀다운",
            "와이드 풀다운 (원암)",
            "내로우그립 풀업",
            "내로우그립 풀업 (어시스티드)",
            "친업",
            "친업 (어시스티드)",
            "풀업",
            "풀업 (어시스티드)",
            "덤벨 풀오버 (등)",
            "머신 풀오버 (등)"
        ]),
        WorkOut(bodyPart: "가슴", weightTraining: [
            "덤벨 해머 프레스",
            "덤벨 프레스",
            "디클라인 덤벨 프레스",
            "인클라인 덤벨 해머 프레스",
            "인클라인 덤벨 프레스",
            "덤벨 로우 플라이",
            "덤벨 플라이",
            "인클라인 덤벨 플라이",
            "디클라인 체스트 프레스",
            "딥스 (어시스티드)",
            "머신 딥스",
            "머신 인클라인 체스트 플라이",
            "버터플라이",
            "펙 덱 플라이",
            "디클라인 벤치 프레스",
            "벤치 프레스",
            "인클라인 벤치 프레스",
            "디클라인 벤치 프레스 (스미스 머신)",
            "벤치 프레스 (스미스 머신)",
            "인클라인 벤치 프레스 (스미스 머신)",
            "인클라인 체스트 해머 프레스",
            "인클라인 체스트 프레스",
            "라잉 체스트 프레스",
            "체스트 프레스",
            "체스트 프레스 (원암)",
            "체스트 해머 프레스",
            "케이블 디클라인 벤치 프레스",
            "케이블 벤치 프레스",
            "케이브 시티드 프레스",
            "케이블 인클라인 벤치 프레스",
            "인클라인 케이블 플라이",
            "케이블 크로스 오버",
            "케이블 크로스 오버 (원암)",
            "덤벨 풀오버 (가슴)",
            "머신 풀오버 (가슴)",
            "프레이트 프세스 (가슴)"
        ]),
        WorkOut(bodyPart: "어깨", weightTraining: [
            "덤벨 레터럴 라이즈",
            "덤벨 레터럴 라이즈 (원암)",
            "T-레이즈",
            "Y-레이즈",
            "덤벨 벤트오버 레이즈",
            "덤벨 벤트오버 레이즈 (원암)",
            "덤벨 숄더 프레스",
            "덤벨 숄더 해머 프레스",
            "아놀드 프레스",
            "프론트 레이즈",
            "프론트 레이즈 (원암)",
            "머신 레터럴 레이즈",
            "펙덱 리어델트 레이즈",
            "머신 숄더 프레스",
            "바벨 프론트 레이즈",
            "밀리터리 프레스",
            "비하인드 넥 프레스",
            "시티드 바벨 숄더 프레스",
            "스미스 밀리터리 프레스",
            "스미스 비하인드 넥 프레스",
            "스미스 숄더 프레스",
            "덤벨 업 라잇 로우",
            "바벨 업 라잇 로우",
            "스미스 업 라잇 로우",
            "케이블 업 라잇 로우",
            "케이블 레터럴 레이즈",
            "케이블 레터럴 레이즈 (원암)",
            "케이블 벤트오버 레이즈",
            "케이브 벤트로버 레이즈 (원암)",
            "케이블 프론트 레이즈",
            "케이블 프론테 레이즈 (원암)",
            "크로스 페이스풀",
            "페이스풀",
            "플레이트 레이즈 (어깨)",
            "플레이트 프레스 (어깨)"
        ]),
        WorkOut(bodyPart: "하체", weightTraining: [
            "고블릿 스쿼트",
            "덤벨 스쿼트",
            "불가리안 스플릿 스쿼트",
            "덤벨 데드리프트",
            "머신 데드리프트",
            "스모 데드리프트",
            "스티프 데드리프트",
            "컨벤셔널 데드리프트",
            "트랩바 데드리프트",
            "덤벨 런지",
            "덤벨 리어 런지",
            "덤벨 워킹 런지",
            "바벨 런지",
            "바벨 리어 런지",
            "바벨 워킹 런지",
            "스미스 런지",
            "레그 익스텐션",
            "원 레그 익스텐션",
            "라잉 레그 컬",
            "스탠딩 레그 컬",
            "시티드 레그 컬",
            "레그 프레스",
            "머신 레그 프레스",
            "원 레그 프레스",
            "벨트 스쿼트",
            "브이 스쿼트",
            "핵 스쿼트",
            "로우바 스쿼트",
            "와이드 스쿼트",
            "저쳐 스쿼트",
            "프런트 스쿼트",
            "하이바 스쿼트",
            "스미스 머신 스쿼트",
            "스미스 머신 체어 스쿼트",
            "바벨 스플릿 스쿼트",
            "스미스 스플릿 스쿼트",
            "아웃 싸이 (하체)",
            "이너 싸이",
            "점프 스쿼트",
            "머신 카프레이즈",
            "바벨 카프레이즈",
            "스미스 카프레이즈",
            "카프레이즈",
            "카프레이즈 레그 프레스"
        ]),
        WorkOut(bodyPart: "이두", weightTraining: [
            "덤벨 컬",
            "덤벨 컬 (원암)",
            "덤벨 프리처컬",
            "덤벨 프리처컬 (원암)",
            "켄센트레이션 컬",
            "해머 컬",
            "해머 컬 (원암)",
            "리스트 컬",
            "머신 바이셉스 컬",
            "머신 바이셉스 컬 (원암)",
            "프리처 컬",
            "프리처 철 (원암)",
            "프리처 해머 컬",
            "바벨 컬",
            "바벨 컬 (리버스 그립)",
            "바벨 컬 (클로즈 그립)",
            "바벨 프리처컬",
            "케이블 컬"
        ]),
        WorkOut(bodyPart: "삼두", weightTraining: [
            "덤벨 오버헤드 원암 익스텐션",
            "덤벨 오버헤드 익스텐션",
            "덤벨 킥백",
            "딥스 (삼두)",
            "머신 딥스 (삼두)",
            "어시스티드 딥스 (삼두)",
            "머신 트라이셉스 익스텐션",
            "라잉 트라이셉스 익스텐션",
            "시티드 트라이셉스 익스텐션",
            "클로즈 그립 벤치프레스",
            "케이블 킥백",
            "케이블 트라이셉스 익스텐션",
            "케이블 푸시 다운 (V-바)",
            "케이블 푸시 다운 (로프)",
            "케이블 푸시 다운 (리버스 그립)",
             "케이블 푸시 다운 (스트레이트 바)",
            "케이블 푸시 다운 (원암)",
        ]),
        WorkOut(bodyPart: "엉덩이", weightTraining: [
            "굿모닝 (엉덩이)",
            "머신 클루트 킥백",
            "케틀벨 스윙",
            "머신 힙 쓰러스트",
            "바벨 힙 쓰러스트",
            "스미스 힙 쓰러스트",
            "스탠딩 아웃싸이",
            "아웃 싸이 (엉덩이)",
        ]),
        WorkOut(bodyPart: "승모근", weightTraining: [
            "덤벨 슈러그",
            "머신 슈러그",
            "바벨 슈러그"
        ]),
        WorkOut(bodyPart: "복근", weightTraining: [
            "사이드 밴드",
            "케이블 크런치"
        ]),
    ]
}