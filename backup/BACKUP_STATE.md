# 모의고사 문제 추출기 백업 상태

**백업 일시:** 2026년 3월 10일  
**버전:** v6.8

---

## 현재 프로젝트 상태 요약

### 1. 메인 파일
- `mock-exam-extractor.html` (프로젝트 루트)
- 백업본: `backup/mock-exam-extractor-v6.8-backup.html` (최신)
- 백업본: `backup/mock-exam-extractor-v6.1-backup.html`
- 백업본: `backup/mock-exam-extractor-v5.9-backup.html`
- 백업본: `backup/mock-exam-extractor-v5.6-backup.html`
- 백업본: `backup/mock-exam-extractor-v5.3-backup.html`
- 백업본: `backup/mock-exam-extractor-v5.0-backup.html`
- 백업본: `backup/mock-exam-extractor-v4.9-backup.html`
- 백업본: `backup/mock-exam-extractor-v4.3-backup.html`
- 백업본: `backup/mock-exam-extractor-v4.2.1-backup.html`
- 백업본: `backup/mock-exam-extractor-v4.2-backup.html`
- 백업본: `backup/mock-exam-extractor-v3.5-backup.html`

### 2. 핵심 기능
| 기능 | 설명 |
|------|------|
| PDF 업로드 | 드래그 앤 드롭 또는 클릭으로 PDF 선택 |
| 텍스트 추출 | PDF.js로 PDF 내 텍스트 추출 |
| 출력 형식 | TXT, Word(HTML), Excel(CSV) 다운로드 |
| 전체 미리보기 | 추출 결과 전체 표시 + 전체 복사 버튼 |
| 문제별 미리보기 | 아코디언 형태, 각 문제별 복사 버튼 |

### 3. 적용된 파싱·후처리 로직
- **mergeRangeQuestions**: [16~17], [36~37], [38~39], [41~42]를 하나로 통합
- **splitMergedQuestions**: 다른 연속 문항은 분리 (RANGES_TO_KEEP_AS_ONE 제외)
- **reassignMisplacedPassages**: Dear 편지 → 18번, FatherDaughter Sock Hop → 27번 배치
- **clearMisplacedListeningContent**: 듣기 문항의 잘못된 지문 제거
- **fixContentWithNextQuestionPrefix**: 27번에 섞인 28번 지문 분리
- **fixInstructionAndContent**: 지시문에서 문제번호 제거, 지문 중복 제거
- **splitMultiChoicesInLine / expandMultiChoicesForQuestions**: 한 줄에 여러 선택지 파싱 (19번, 31번 등)
- **processMisplacedChoiceToPassage**: 35번 선택지 ④ → 지문에 삽입
- **inheritSharedPassage**: 36·37 등 이어질 순서 유형 지문 공유
- **removeConfirmBlockFromContent**: 45번 확인 사항 문구 제거
- **blankRe 예외**: 말줄임(...) 앞에는 밑줄 표기 안 함

### 4. 제외 패턴
- `EXCLUDE_PATTERN`: 이제 듣기 문제가~ 답을 하시기 바랍니다
- `CONFIRM_PATTERN`: * 확인 사항 ... 답안지의 해당란에 ... 하시오

---

## 디렉터리 구조
```
English_mock_exam_paper/
├── mock-exam-extractor.html   ← 메인 (편집용)
├── backup/
│   ├── mock-exam-extractor-v6.8-backup.html  ← v6.8 백업본 (최신)
│   ├── mock-exam-extractor-v6.1-backup.html
│   ├── mock-exam-extractor-v5.9-backup.html
│   ├── mock-exam-extractor-v5.6-backup.html
│   ├── mock-exam-extractor-v5.3-backup.html
│   ├── mock-exam-extractor-v5.0-backup.html
│   ├── mock-exam-extractor-v4.9-backup.html
│   ├── mock-exam-extractor-v4.3-backup.html
│   ├── mock-exam-extractor-v4.2.1-backup.html
│   ├── mock-exam-extractor-v4.2-backup.html
│   ├── mock-exam-extractor-v3.5-backup.html
│   └── BACKUP_STATE.md        ← 이 파일
├── README.md
├── start-server.bat
└── start-server.ps1
```

---

## 복원 방법
1. `backup/mock-exam-extractor-v6.8-backup.html` 복사
2. 프로젝트 루트의 `mock-exam-extractor.html`을 덮어쓰기

PowerShell 예시:
```powershell
Copy-Item "backup\mock-exam-extractor-v6.8-backup.html" -Destination "mock-exam-extractor.html" -Force
```

---

## 버전 이력 (최근)
- v6.8: debugRaw/복원 패턴화(대화 지문·일치하지 않는), 29번 추출순서 유지, 30번 [31~34] 지문 제거
- v6.1: processMisplacedChoiceToPassage 한글 선택지 요약 예외 (koreanChoiceSummary), 26번 ④ 유지
- v6.0: 버전 형식 v#.# 변경, 문제 26 디버그 미리보기
- v5.9: 문제 25 [지문/선택지] ⑤ 누락 복구 (recoverMissingFifthChoiceInEmbedded)
- v5.8: 문제 21 지시문/지문 분리, [지문/선택지] 표기, 29번 ①~⑤ 순서 복원
- v5.6: fixDialogueSpeakerLabel 패턴화 (하드코딩 제거, 수정만 적용)
- v5.3: 지시문 [3점] 비노출, 대화 듣기 Man:/Woman: 화자 수정
- v5.0: 지시문 줄바꿈 처리 (고+르시오 → 고르시오 한 문장 인식)
- v4.9: (백업 보관)
- v4.3: 범위 문항 [##~##]만 표기(문제 삭제), Excel CSV 복귀, 파일명_YYMMDD_hhmm
- v4.2.1: 38·39 지문 복구 패턴 강화 (다중 정규식 fallback)
- v4.2: 36·37·38·39 지문 복구(recover), 16~17·36~37·38~39·41~42 분리 출력, 43~45 구조 정리
- v4.0: 범위 문항 분리(expandRangeQuestionsForOutput), inheritSharedPassage 개선
- v3.5: [16~17][36~37][38~39][41~42] 통합, 18·27 지문 정리, 19·31 다중 선택지, 28번 지시문/지문 수정, 35번 선택지→지문 이동
- v3.4: 복사 버튼, 16번 지문 제거, 45번 확인 사항 히든 등
- v3.3: 전체/문제별 복사 버튼 추가
- v3.2: 좌우 5:5 레이아웃, 아코디언 미리보기
