-- Run this once in the Supabase SQL Editor for the store project.
create table if not exists public.products (
  id text primary key,
  name text not null,
  cat text not null,
  price bigint not null check (price >= 0),
  old bigint check (old is null or old >= 0),
  rate text not null default '۴.۸',
  img text not null default '',
  badge text not null default 'جدید',
  type text not null default 'new',
  sort_order integer not null default 0
);

create table if not exists public.store_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);

alter table public.products enable row level security;
alter table public.store_admins enable row level security;

grant select on public.products to anon, authenticated;
grant insert, update, delete on public.products to authenticated;
grant select on public.store_admins to authenticated;

drop policy if exists "Products are public to read" on public.products;
create policy "Products are public to read"
  on public.products for select to anon, authenticated using (true);

drop policy if exists "Store admins can add products" on public.products;
create policy "Store admins can add products"
  on public.products for insert to authenticated
  with check (exists (select 1 from public.store_admins a where a.user_id = (select auth.uid())));

drop policy if exists "Store admins can edit products" on public.products;
create policy "Store admins can edit products"
  on public.products for update to authenticated
  using (exists (select 1 from public.store_admins a where a.user_id = (select auth.uid())))
  with check (exists (select 1 from public.store_admins a where a.user_id = (select auth.uid())));

drop policy if exists "Store admins can remove products" on public.products;
create policy "Store admins can remove products"
  on public.products for delete to authenticated
  using (exists (select 1 from public.store_admins a where a.user_id = (select auth.uid())));

drop policy if exists "Admins can read their own access" on public.store_admins;
create policy "Admins can read their own access"
  on public.store_admins for select to authenticated using (user_id = (select auth.uid()));

insert into public.products (id, name, cat, price, old, rate, img, badge, type, sort_order) values
  ('shoe-run', 'کفش رانینگ نایک مدل Air Zoom', 'کفش ورزشی', 4890000, 6200000, '۴.۹', 'photo-1542291026-7eec264c27ff', 'پرفروش', 'popular sale', 1),
  ('dumbbell', 'دمبل روکش‌دار ۵ کیلوگرمی', 'تجهیزات بدنسازی', 1250000, null, '۴.۸', 'photo-1583454110551-21f2fa2afe61', 'محبوب', 'popular', 2),
  ('hoodie', 'هودی ورزشی مدل موشن', 'پوشاک ورزشی', 2190000, 2750000, '۴.۷', 'photo-1556821840-3a63f95609a7', '۱۵٪ تخفیف', 'sale', 3),
  ('bottle', 'بطری ورزشی استیل ۷۵۰ میل', 'اکسسوری', 690000, null, '۴.۶', 'photo-1602143407151-7111542de6e8', 'جدید', 'new', 4),
  ('bands', 'کش تمرینی مقاومتی ۵ تایی', 'تجهیزات بدنسازی', 540000, null, '۴.۸', 'photo-1598289431512-b97b0917affc', 'جدید', 'new popular', 5),
  ('leggings', 'لگ ورزشی زنانه مدل فیت', 'پوشاک ورزشی', 1390000, 1750000, '۴.۹', 'photo-1506629905607-d9a8d9a1b7e3', '۲۰٪ تخفیف', 'sale', 6),
  ('shaker', 'شیکر پروتئین ۶۰۰ میل', 'اکسسوری', 390000, null, '۴.۵', 'photo-1593095948071-474c5cc2989d', 'پرفروش', 'popular', 7),
  ('trainer', 'کفش تمرین مدل رانر پرو', 'کفش ورزشی', 3790000, null, '۴.۷', 'photo-1495555961986-6d4c1ecb7be3', 'جدید', 'new', 8)
on conflict (id) do nothing;
