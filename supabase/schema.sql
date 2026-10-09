-- 나의 일기 (diary.html) Supabase 설정
-- Supabase 대시보드 → SQL Editor → New query 에 전체를 붙여넣고 Run.
-- 일기와 사진은 브라우저에서 암호화된 뒤 저장되므로, 이 DB에는 암호문만 들어갑니다.

-- 1) 일기장 열쇠(비밀번호로 감싼 데이터 키) — 사용자당 1행
create table if not exists public.diary_auth (
  user_id    uuid primary key default auth.uid() references auth.users on delete cascade,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

-- 2) 일기 (암호문)
create table if not exists public.diary_entries (
  user_id    uuid not null default auth.uid() references auth.users on delete cascade,
  id         text not null,
  data       text not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

-- 3) 본인 데이터만 읽고 쓸 수 있게 (Row Level Security)
alter table public.diary_auth    enable row level security;
alter table public.diary_entries enable row level security;

drop policy if exists "own auth" on public.diary_auth;
create policy "own auth" on public.diary_auth
  for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "own entries" on public.diary_entries;
create policy "own entries" on public.diary_entries
  for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- 4) 사진 저장소 (비공개 버킷, 본인 폴더만 접근)
insert into storage.buckets (id, name, public)
values ('diary-images', 'diary-images', false)
on conflict (id) do nothing;

drop policy if exists "own diary images" on storage.objects;
create policy "own diary images" on storage.objects
  for all to authenticated
  using (bucket_id = 'diary-images' and (storage.foldername(name))[1] = auth.uid()::text)
  with check (bucket_id = 'diary-images' and (storage.foldername(name))[1] = auth.uid()::text);
