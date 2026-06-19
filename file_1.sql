with raw as ( select distinct "formId", fl.email, flm.response as Profession
from "formsLeadUUIDs" flu
left join "formsLeads" fl on flu."formsLeadId" = fl.id
left join "formsLeadsMetadatas" flm on flu."formsLeadId" = flm."formsLeadId"
where "formId" in ('13587','14081','18437','18939','15302','18438','16754','16755')
and flm."questionId" = 1
AND DATE(flu."createdAt" AT TIME ZONE 'Asia/Kolkata') BETWEEN '2026-03-20 18:15:00' AND '2026-03-25 12:25:00 '
-- and fl.email = '1javaroshan@gmail.com'
),
orders as (select
distinct o."userEmail" ,
case
when o."paymentLinkId" in ('8812bb88-e028-4e09-850f-7134e315e4d1','abb2697d-0bfd-4c3c-aabe-fcc696cc4a7e') then 'Eng_perf'
else 'others'
end as Segment
from orders o
left join "orderPayments" op on o.id = op."orderId"
where "paymentLinkId" in ('8812bb88-e028-4e09-850f-7134e315e4d1','abb2697d-0bfd-4c3c-aabe-fcc696cc4a7e')
and "gatewayPaymentStatus" in ('captured','succeeded','SUCCESS')
AND DATE(o."createdAt" AT TIME ZONE 'Asia/Kolkata') BETWEEN '2026-03-20 18:15:00' AND '2026-03-25 12:25:00 '),
finals as (
select distinct
case
when "formId" = '13587' then 'Ref(Eng)'
when "formId" in('14081','18437') then 'Engineering Mastermind - Coders'
when "formId" = '18939' then 'Influencer_Eng'
--when "formId" = '15270' then 'Influencer_Eng_IND_student'
when "formId" in( '15302','18438') then 'Enginnering Mastermind Non-Coders'
when "formId" in ( '16754','16755') then 'Engineering Website'
else 'others'
end as Segment,
email ,
case
when max(Profession) = 'Student' then 'Student'
when max(Profession) in ('Self-Employed', 'Salaried Professional','Founder') then 'Working Professional'
else 'Others'
end as profession
--max(Profession) as profession
from raw
group by 1,2),
combined as (
select f.segment , f.profession, f.email from finals f
union all
select o.segment, NULL as profession, o."userEmail" as email from orders o )
select distinct segment, profession, count(distinct email) from combined
group by 1,2;
