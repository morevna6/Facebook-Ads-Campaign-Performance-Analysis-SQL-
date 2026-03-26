select
    ad_date,
    campaign_id,
    sum(spend) as total_spend,
    sum(impressions) as total_impressions,
    sum(clicks) as total_clicks,
    sum(value) as total_value,
    (sum(spend)::numeric) / nullif(sum(clicks)::numeric, 0) as cpc,
    (sum(spend)::numeric * 1000) / nullif(sum(impressions)::numeric, 0) as cpm,
    (sum(clicks)::numeric * 100) / nullif(sum(impressions)::numeric, 0) as ctr,
    ((sum(value)::numeric - sum(spend)::numeric) * 100) / nullif(sum(spend)::numeric, 0) as romi
from facebook_ads_basic_daily
group by ad_date, campaign_id;

select
    campaign_id,
    sum(spend) AS total_spend,
    sum(value) AS total_value,
    ((sum(value)::numeric - sum(spend)::numeric) * 100)
      / nullif(sum(spend)::numeric, 0) as romi
from facebook_ads_basic_daily
group by campaign_id
having sum(spend) > 500000
order by romi DESC
limit 1;