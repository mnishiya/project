 select p.payment_id, p.amount, p.fee, p.amount+p.fee as total, p.ba_name, p.added as create_date, pl.added as return_date, p.modified, p.chargeback_status_id, 
case  
 when pl.entry like 'Rejected;%' then 'Rejected'
 when pl.entry like 'Queued for Reversal%' then 'Reversal'
 when pl.entry like 'Returned;%' then 'Returned'
 else 'Unknown'
end as return_type, pl.entry
from payment p inner join payment_log pl using (payment_id)
where (pl.entry like 'Rejected;%' or pl.entry like 'Returned;%' or pl.entry like 'Queued for RPPS reversal%')
and pl.payment_id > 809371
and pl.added >= '2013-08-01'
and chargeback_status_id<>1

order by return_date