# 📚 모의고사 문제 추출기

PDF 모의고사/시험지에서 문제를 추출하여 TXT, Word(HTML), Excel(CSV) 형식으로 변환하는 도구입니다.

## 사용 방법

1. **로컬 서버로 실행** (필수 - `file://`로 열면 PDF.js Worker 오류 발생)

   **방법 A** - `start-server.bat` 더블클릭 (권장)

   **방법 B** - 터미널에서 직접 실행:
   ```bash
   # Python 있는 경우 (권장)
   python -m http.server 3333

   # 또는
   npx serve -l 3333
   ```

2. 브라우저에서 `http://localhost:3333/mock-exam-extractor.html` 접속
3. PDF 파일을 드래그하거나 클릭하여 업로드
4. **문제 추출하기** 버튼 클릭
5. TXT / Word / Excel 버튼으로 다운로드

## 지원 기능

- **문제번호 인식**: `1.`, `2.`, `[43~45].` 등
- **선택지 인식**: ① ② ③ ④ ⑤ 또는 1) 2) 3) 4) 5)
- **이미지/표 처리**: `[이미지]`, `[그림]`, `Figure`, `Table` 등 → `[이미지]`로 표기
- **출력 형식**:
  - **TXT**: 구조화된 텍스트 (지문 + 선택지)
  - **Word**: HTML 기반 (.doc 확장자로 Word에서 열기)
  - **Excel**: CSV (문제번호, 유형, 지문, ①~⑤)

## 기술 스택

- PDF.js 2.16.105 (jsDelivr CDN, UMD 빌드 - 브라우저 바로 실행 가능)
- Blob API (파일 다운로드)
- 순수 JavaScript (빌드 불필요)
