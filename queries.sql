
# Query to get the ticket age in days Brand wise and Client wise which are not closed

select * from adm_store_info;
select * from adm_store_regdetails;
select * from adm_client_regdetails;
select * from adm_client_info;
select * from adm_store_regdetails;
select * from adm_brand_regdetails;
select * from adm_brand_info;
select * from adm_ticket_info order by ENTRYTIME desc;
select * from adm_ticket_status;
select * from smr_ticket_type;

select
        a.*,
        case
            when ticket_age between 0 and 7 then '0-7'
            when ticket_age between 8 and 15 then '8-15'
            when ticket_age > 15 then '15+'
        end as ticket_age_group
        from (
    select
        asr.STORE_ID,
        asi.COMPANY_NAME as store_name,
        adm_client_info.COMPANY_NAME as client,
        abi.COMPANY_NAME as brand,
        ati.TICKET_ID,
        ati.CALL_TITLE,
        ats.CAT_NAME as status,
        ati.ENTRYTIME as ticket_time,
        TIMESTAMPDIFF(DAY , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age
    from adm_ticket_info ati
        join adm_ticket_status ats on ati.STATUS = ats.CAT_ID

        join adm_store_regdetails asr on ati.STORE_ID = asr.ID
        join adm_store_info asi on asr.ID = asi.ADMIN_ID

        join adm_client_regdetails acr on asr.COMPANY_ID = acr.ID
        join adm_client_info adm_client_info on acr.ID = adm_client_info.ADMIN_ID

        join adm_brand_regdetails abr on asr.BRAND_ID = abr.ID
        join adm_brand_info abi on abr.ID = abi.ADMIN_ID

    where ats.CAT_ID not in (3)
        order by ati.ENTRYTIME desc) a;


select
    count(*),
    ticket_age_group,
    client,
    status
from (
    select
        a.*,
        case
            when ticket_age between 0 and 7 then '0-7'
            when ticket_age between 8 and 15 then '8-15'
            when ticket_age > 15 then '15+'
        end as ticket_age_group
        from (
    select
        asr.STORE_ID,
        asi.COMPANY_NAME as store_name,
        adm_client_info.COMPANY_NAME as client,
        abi.COMPANY_NAME as brand,
        ati.TICKET_ID,
        ati.CALL_TITLE,
        ats.CAT_NAME as status,
        ati.ENTRYTIME as ticket_time,
        TIMESTAMPDIFF(DAY , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age
    from adm_ticket_info ati
        join adm_ticket_status ats on ati.STATUS = ats.CAT_ID

        join adm_store_regdetails asr on ati.STORE_ID = asr.ID
        join adm_store_info asi on asr.ID = asi.ADMIN_ID

        join adm_client_regdetails acr on asr.COMPANY_ID = acr.ID
        join adm_client_info adm_client_info on acr.ID = adm_client_info.ADMIN_ID

        join adm_brand_regdetails abr on asr.BRAND_ID = abr.ID
        join adm_brand_info abi on abr.ID = abi.ADMIN_ID

    where ats.CAT_ID not in (3)
        order by ati.ENTRYTIME desc) a
) b group by ticket_age_group, client, status order by ticket_age_group, client, status;


select
    count(*),
    ticket_age_group,
    client,
    status
from (
select
        a.*,
        case
            when ticket_age between 0 and 7 then '0-7'
            when ticket_age between 8 and 15 then '8-15'
            when ticket_age > 15 then '15+'
        end as ticket_age_group
        from (
    select
        asr.STORE_ID,
        asi.COMPANY_NAME as store_name,
        adm_client_info.COMPANY_NAME as client,
        abi.COMPANY_NAME as brand,
        ati.TICKET_ID,
        ati.CALL_TITLE,
        ats.CAT_NAME as status,
        ati.ENTRYTIME as ticket_time,
        TIMESTAMPDIFF(DAY , ati.ENTRYTIME, date_add(now(), interval 330 minute)) as ticket_age
    from adm_ticket_info ati
        join adm_ticket_status ats on ati.STATUS = ats.CAT_ID

        join adm_store_regdetails asr on ati.STORE_ID = asr.ID
        join adm_store_info asi on asr.ID = asi.ADMIN_ID

        join adm_client_regdetails acr on asr.COMPANY_ID = acr.ID
        join adm_client_info adm_client_info on acr.ID = adm_client_info.ADMIN_ID

        join adm_brand_regdetails abr on asr.BRAND_ID = abr.ID
        join adm_brand_info abi on abr.ID = abi.ADMIN_ID

    where ats.CAT_ID not in (3)
        order by ati.ENTRYTIME desc) a)
        b group by ticket_age_group, client, status order by ticket_age_group, client, status;
