SELECT * FROM cohort_users_raw 
LIMIT 10;

SELECT * FROM cohort_events_raw 
LIMIT 10;

--step1 створюємо першу CTE для users
--очищаємо дані відпробвлів та прибираємо дані часу
--за допомогою regex одночасно замінюємо деліметри ./ на -
-- за допомогою case визначаємо де в році дві цифри та додаємо пропущені, щоб було 2025
--перетворюємо очищені дані на timestamp

select u.user_id,  
       u.signup_datetime,
       u.promo_signup_flag,
       to_timestamp((case
       when length((split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',3)))=2
       then split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',1)||'-'||
       split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',2)||'-20'||
       split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',3)
       else regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')
       end), 'DD-MM-YYYY') as signup_ts
from cohort_users_raw u;

--step2 створюємо другу CTE2 для events
--очищаємо дані відпробвлів та прибираємо дані часу
--за допомогою regex одночасно замінюємо деліметри ./ на -
--за допомогою case визначаємо де в році дві цифри та додаємо пропущені, щоб було 2025
--перетворюємо очищені дані на timestamp


 select e.user_id,   
        e.event_type,
        to_timestamp((case
       when length((split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',3)))=2
       then split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',1)||'-'||
       split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',2)||'-20'||
       split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',3)
       else regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')
       end), 'DD-MM-YYYY') as event_ts
from cohort_events_raw e;

--step 4 об'єднуємо таблиці, формуємо когорти

with users_parsed as (
select u.user_id,  
       u.signup_datetime,
       u.promo_signup_flag,
       to_timestamp((case
       when length((split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',3)))=2
       then split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',1)||'-'||
       split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',2)||'-20'||
       split_part((regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')),'-',3)
       else regexp_replace((split_part(trim(signup_datetime),' ',1)), '[./]', '-', 'g')
       end), 'DD-MM-YYYY') as signup_ts
from cohort_users_raw u),
events_parsed as (
select e.user_id,  
        e.event_type,
        to_timestamp((case
       when length((split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',3)))=2
       then split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',1)||'-'||
       split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',2)||'-20'||
       split_part((regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')),'-',3)
       else regexp_replace((split_part(trim(event_datetime),' ',1)), '[./]', '-', 'g')
       end), 'DD-MM-YYYY') as event_ts
from cohort_events_raw e
),
user_activity as (
--створюємо третю CTE для створення когорт, об'єднавши дві перші
--для визначення місяця когорти обрізаємо місяць в очищеній даті реєстрацї користувача з СТЕ1
--для визначення місяця активності обрізаємо місяць в очищеній даті активності користувача з СТЕ2
--для визначення стажу клієнта в місяцях за домомогою функції extract визначаємо різницю датою активноста та датою реєстрації
--де прибираємо користувачів з вісутньою датою реєстрації, події з відсутньою датою, події без зазначеного типу і тестові події
select u.user_id,
       date_trunc('month', signup_ts)::date as cohort_month,
       u.promo_signup_flag,
       date_trunc('month', event_ts)::date as activity_month,
       extract('month' from age((date_trunc('month', event_ts)), (date_trunc('month', signup_ts)))) as month_offset
from users_parsed u
join events_parsed e on u.user_id=e.user_id
where signup_ts is not null
and event_ts is not null
and event_type is not null
and event_type!='test_event'
)
--формуємо фінальний запит, де виводимо походження користувача (promo, organic), місяць залучення клієнта, стаж клієнта в користуванні продуктом
--виводимо загальну кількість кнікальних користувачів для вищезазначеною комбінації полів
--обмежуємо часовий проміжок з 01.01.2025 по 02.06.2025
select promo_signup_flag,
       cohort_month,
       month_offset,
       count(distinct user_id) as users_total
from user_activity
where activity_month between '2025-01-01' and '2025-06-01'
group by 1, 2, 3
order by 1, 2, 3;