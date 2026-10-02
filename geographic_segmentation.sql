-- =================================================================
-- ЖОБА: Географиялық сегментация және аймақтық аналитика
-- База: geographic_segmentation
-- Кесте: e_commerce_customer_segmentation
-- =================================================================


-- 1. Елдер мен қалалар бойынша клиенттер саны, кіріс (revenue) және орташа чек
-- Мақсаты: Қай ел/қала ең көп кіріс әкелетінін анықтау.
SELECT 
    country,
    city,
    COUNT(customer_id) AS total_customers,
    SUM(total_spent_usd) AS total_revenue_usd,
    ROUND(AVG(avg_order_value_usd)::numeric, 2) AS avg_order_value
FROM public.e_commerce_customer_segmentation
GROUP BY country, city
ORDER BY total_revenue_usd DESC;


-- 2. Елдер мен қалалар бойынша ең өтімді өнім категориялары (Preferred Categories)
-- Мақсаты: Әр аймақта қай тауар түрі белсенді өтетінін біліп, соған сәйкес акция ұсыну.
SELECT 
    country,
    city,
    preferred_category_1,
    COUNT(customer_id) AS customer_count,
    SUM(total_spent_usd) AS category_revenue
FROM public.e_commerce_customer_segmentation
GROUP BY country, city, preferred_category_1
ORDER BY country, city, customer_count DESC;


-- 3. Аймақтық сатып алу арналары мен құрылғылар (Shopping Channel & Device Preference)
-- Мақсаты: Қай аймақта қандай маркетингтік арналар мен құрылғыларды (Mobile/Desktop) нысанаға алу керектігін білу.
SELECT 
    country,
    shopping_channel,
    device_preference,
    COUNT(customer_id) AS total_users,
    SUM(total_spent_usd) AS total_spent
FROM public.e_commerce_customer_segmentation
GROUP BY country, shopping_channel, device_preference
ORDER BY country, total_users DESC;


-- 4. Елдер бойынша клиенттердің қауіп-қатері мен лояльдылығы (Loyalty Tier & Churn Risk)
-- Мақсаты: Қай елде клиенттерді жоғалту қаупі (Churn Risk) жоғары екенін анықтап, арнайы жеңілдіктер беру.
SELECT 
    country,
    loyalty_tier,
    churn_risk_category,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(satisfaction_score)::numeric, 2) AS avg_satisfaction
FROM public.e_commerce_customer_segmentation
GROUP BY country, loyalty_tier, churn_risk_category
ORDER BY country, customer_count DESC;


-- 5. Ең жоғары пайда әкелетін (TOP Revenue) аймақтар мен олардың сипаттамасы
-- Мақсаты: Ағайға жобаның қорытынды ұсыныстарын (Recommendations) беру.
SELECT 
    country,
    customer_segment,
    COUNT(customer_id) AS total_customers,
    SUM(total_spent_usd) AS total_revenue,
    ROUND(AVG(customer_lifetime_value_usd)::numeric, 2) AS avg_clv
FROM public.e_commerce_customer_segmentation
GROUP BY country, customer_segment
ORDER BY total_revenue DESC;