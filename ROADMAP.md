# C 에게해 핸드팬 — 로드맵

진행 상황을 확인하실 수 있도록 단계별 체크리스트로 정리했습니다. 세부 설계 배경은 `.claude/plans`(세션 플랜) 참고.

- [x] **Phase 0 — 프로젝트 스캐폴딩**
  - `flutter create` (iOS + Android), 기존 `README.md`/`.git` 보존
  - `pubspec.yaml` 의존성: `flutter_localizations`, `intl`, `provider`, `shared_preferences`, `flutter_soloud`, `video_player`
- [x] **Phase 1 — 오디오**
  - `tool/generate_audio.py`: 웹 프로토타입과 동일한 배음 합성 레시피로 9개 톤필드 WAV 렌더링 (`assets/audio/`)
  - `HandpanAudioEngine` (`lib/core/audio/handpan_audio_engine.dart`): `flutter_soloud` 기반 폴리포니 재생, 마스터 볼륨, Freeverb 필터로 "공명" 토글
- [x] **Phase 2 — 공용 위젯**
  - `HandpanBoard` (`lib/widgets/handpan_board.dart`): Ding + 8 톤필드 원형 배치, 탭 리플 애니메이션, 가이드 큐/오답 표시
- [x] **Phase 3 — 자유 연주**
  - `FreePlayScreen`: 자유 터치 연주, 음이름 표시/리버브/음량 컨트롤
- [x] **Phase 4 — 따라 연주하기**
  - `tune_catalog.dart` (오리지널 연습곡 3종: 잔물결 아르페지오/저녁 노래/즉흥 씨앗) — 항목 추가만으로 확장 가능한 구조
  - `GuidedPracticeController` + `GuidedPracticeScreen`: 먼저 듣기(자동 재생) / 따라 연주하기(1음씩 검증) / 중지
- [x] **Phase 5 — 설정 & 다국어**
  - 테마: 시스템/라이트/다크
  - 언어: Babgap과 동일한 11개 로케일(ko 템플릿 + en/de/es/fr/hi/ja/pt/pt_BR/ru/zh), 자체 UI 문구 번역
- [x] **Phase 6 — 배경 영상**
  - 설정 화면을 제외한 모든 화면에 첨부된 숲 영상(`assets/video/forest_ambience.mp4`)을 배경으로 반복 재생
  - 영상 자체의 새소리를 톤다운된 볼륨(22%)으로 재생, 탭 전환 시 설정 화면에서는 일시정지
- [x] **Phase 7 — 루트 내비게이션**
  - 3탭 구성(자유 연주 / 따라 연주 / 설정), `IndexedStack`으로 상태 유지
- [~] **Phase 8 — 실기기 검증** (부분 완료)
  - [x] `flutter analyze` 클린, iOS 시뮬레이터 빌드/실행 성공 (Xcode 배포 타겟 13.0→15.0 수정 필요했음, `ios/Podfile` 참고)
  - [x] 자유 연주 화면 스크린샷 확인 — 영상 배경, 핸드팬 렌더링, 음이름 표시, 하단 3탭 내비게이션 정상
  - [ ] 이 개발 환경은 시뮬레이터 화면 탭 입력이 지원되지 않아(IO 클라이언트 초기화 실패) 따라 연주/설정 화면은 직접 탭으로 확인하지 못함 — 실제 Mac/시뮬레이터에서 `flutter run` 후 눌러서 확인 필요
  - [ ] Android 실기기/에뮬레이터 확인
- [ ] **다음 후보 (미착수)**
  - 가이드 연습곡 추가 (구조는 이미 확장 가능하게 되어 있음 — `tune_catalog.dart`에 항목 추가)
  - 앱 아이콘 / 스플래시 화면 디자인
  - 앱스토어/플레이스토어 등록 준비 (스크린샷, 설명 문구 등)
