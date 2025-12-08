INSERT INTO placement.company_summary (year, company_name, total_offers, ctc_lpa, raw_source_table)
SELECT 2019,
       name_of_company,
       no_of_offers::int,
       ctc_lpa::numeric,
       'company_2019'
FROM public."company_2019";

INSERT INTO placement.company_summary (year, company_name, total_offers, ctc_lpa, raw_source_table)
SELECT 2020,
       name_of_company,
       no_of_offers::int,
       ctc_lpa::numeric,
       'company_2020'
FROM public."company_2020";

INSERT INTO placement.company_summary (year, company_name, total_offers, ctc_lpa, raw_source_table)
SELECT 2021,
       name_of_company,
       no_of_offers::int,
       ctc_lpa::numeric,
       'company_2021'
FROM public."company_2021";

INSERT INTO placement.company_summary (year, company_name, total_offers, ctc_lpa, raw_source_table)
SELECT 2022,
       name_of_company,
       no_of_offers::int,
       ctc_lpa::numeric,
       'company_2022'
FROM public."company_2022";

INSERT INTO placement.company_summary (year, company_name, total_offers, ctc_lpa, raw_source_table)
SELECT 2023,
       name_of_company,
       no_of_offers::int,
       ctc_lpa::numeric,
       'company_2023'
FROM public."company_2023";







