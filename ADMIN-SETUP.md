# راه‌اندازی پنل مدیریت فیت‌مارکت

آدرس پنل پس از انتشار سایت: `https://anoushakb.github.io/anoush/admin.html`

پنل برای امنیت به پروژه Supabase متصل می‌شود. تا وقتی این مراحل انجام نشده، ورود فعال نیست.

1. در Supabase یک پروژه بسازید و در SQL Editor محتوای `supabase-setup.sql` را اجرا کنید.
2. از بخش Authentication یک کاربر مدیر با ایمیل و رمز دلخواه خودتان بسازید.
3. UUID کاربر را از فهرست کاربران بردارید و در SQL Editor اجرا کنید (UUID را جایگزین کنید):
   `insert into public.store_admins (user_id) values ('UUID-کاربر');`
4. نشانی پروژه و کلید عمومی **Publishable** را از تنظیمات API پروژه در `backend-config.js` قرار دهید؛ نمونه:
   `url: 'https://PROJECT.supabase.co',`
   `publishableKey: 'sb_publishable_…'`
5. فایل‌های تغییرکرده را commit و push کنید تا Pages به‌روزرسانی شود؛ سپس نشانی پنل بالا را باز کنید.

کلید Publishable برای استفاده در مرورگر ساخته شده و دسترسی نوشتن را سیاست‌های RLS در SQL محدود می‌کنند. هرگز `service_role` یا کلید secret را در فایل‌های سایت قرار ندهید. ایمیل و رمز مدیر را فقط خودتان در Supabase تنظیم کنید؛ آن‌ها را اینجا نفرستید.
