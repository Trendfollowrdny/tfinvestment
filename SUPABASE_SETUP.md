# 나의 일기 — Supabase(무료 저장소) 연결 방법

일기 주소: https://trendfollowrdny.github.io/tfinvestment/diary.html

Supabase를 연결하면 어느 기기에서든 로그인해서 같은 일기를 볼 수 있어요.
연결하기 전에는 일기가 그 기기의 브라우저에만 저장돼요.

일기와 사진은 브라우저에서 비밀번호로 암호화한 뒤 보내요. 그래서 Supabase에는 암호문만 저장되고,
로그인할 때도 진짜 비밀번호가 아니라 비밀번호에서 만든 다른 값을 보내요.

## 1. 프로젝트 만들기 (무료, 카드 필요 없음)

1. https://supabase.com 에 GitHub 계정으로 가입해요.
2. **New project**를 눌러요.
   - Name: 아무거나 (예: `diary`)
   - Database Password: 자동 생성 그대로 둬도 돼요 (일기 비밀번호와는 상관없어요)
   - Region: **Northeast Asia (Seoul)**
3. 프로젝트가 만들어질 때까지 1~2분 기다려요.

## 2. 테이블 만들기

1. 왼쪽 메뉴의 **SQL Editor** → **New query**를 눌러요.
2. 이 저장소의 [`supabase/schema.sql`](supabase/schema.sql) 내용을 전부 붙여 넣고 **Run**을 눌러요.
3. "Success"가 나오면 끝이에요.

## 3. 이메일 확인 끄기 (권장)

**Authentication** → **Sign In / Providers** → **Email**에서 **Confirm email**을 꺼요.
켜 두면 가입한 뒤 메일함에서 확인 링크를 한 번 눌러야 해요.

## 4. 주소와 키 알려 주기

**Project Settings** → **API**(또는 **Data API**)에서 아래 두 값을 복사해 Claude에게 알려 주세요.

- **Project URL** (예: `https://abcdefgh.supabase.co`)
- **anon public** 키 (`eyJ...`로 시작하는 긴 문자열)

둘 다 웹페이지에 들어가도 괜찮은 공개용 값이에요.
**`service_role` 키는 절대 알려 주거나 어디에 붙여 넣지 마세요.**

직접 넣으려면 `diary.html` 위쪽의 아래 두 줄을 채우면 돼요.

```js
const SUPABASE_URL = 'https://abcdefgh.supabase.co';
const SUPABASE_KEY = 'eyJ...';
```

## 5. 가입한 뒤 다른 사람 가입 막기 (권장)

일기 주소에서 **처음이신가요? 일기장 만들기**로 본인 계정을 만든 다음,
**Authentication** → **Sign In / Providers**에서 **Allow new users to sign up**을 꺼요.
남이 내 Supabase 무료 용량을 쓰지 못하게 막는 설정이에요.
다른 사람이 가입하더라도 내 일기는 볼 수 없어요.

## 참고

- 무료 한도: DB 500MB, 사진 1GB. 사진은 자동으로 줄여서 올리기 때문에 한 장에 200KB 안팎이에요.
- 무료 프로젝트는 **1주일 동안 접속이 없으면 일시 정지**돼요. 이때 Supabase 대시보드에서 **Restore**를 누르면
  데이터 그대로 다시 켜져요. 일기를 자주 쓰면 신경 쓸 일이 없어요.
- 비밀번호를 잊어버리면 일기를 복구할 수 없어요. 가끔 메뉴의 **백업 파일 저장**을 해 두세요.
