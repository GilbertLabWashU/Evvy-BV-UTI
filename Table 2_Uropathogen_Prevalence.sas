/*==============================================================
  Table 2
  Comparison of Uropathogen Prevalence

  Presence is defined as relative abundance >= 0.1% (0.001).
  Pairwise multivariable logistic regression models are adjusted
  for age, BMI, race, and menopausal status.

  Output:
  Adjusted odds ratios (OR) and 95% confidence intervals
==============================================================*/




proc import
    datafile="/home/u63947748/A_InternLab_XinyueWang/Evvy_METAdata_forMonica_042825.xlsx"
    out=table2_data
    dbms=xlsx
    replace;
    sheet="MetaData";
    getnames=yes;
run;




data table2_data;
    set table2_data;

    /* Any uropathogen */
    if "Total Uropathogens abundance"n >= 0.001 then Uropathogens_Presence = 1;
    else if not missing("Total Uropathogens abundance"n) then Uropathogens_Presence = 0;

    /* Individual uropathogens */
    if Candida_albicans >= 0.001 then Candida_Presence = 1;
    else if not missing(Candida_albicans) then Candida_Presence = 0;

    if Enterococcus_faecalis >= 0.001 then Efaecalis_Presence = 1;
    else if not missing(Enterococcus_faecalis) then Efaecalis_Presence = 0;

    if Escherichia_coli >= 0.001 then Ecoli_Presence = 1;
    else if not missing(Escherichia_coli) then Ecoli_Presence = 0;

    if Klebsiella_pneumoniae >= 0.001 then Kpneumoniae_Presence = 1;
    else if not missing(Klebsiella_pneumoniae) then Kpneumoniae_Presence = 0;

    if Proteus_mirabilis >= 0.001 then Pmirabilis_Presence = 1;
    else if not missing(Proteus_mirabilis) then Pmirabilis_Presence = 0;

    if Pseudomonas_aeruginosa >= 0.001 then Paeruginosa_Presence = 1;
    else if not missing(Pseudomonas_aeruginosa) then Paeruginosa_Presence = 0;

    if Staphylococcus_saprophyticus >= 0.001 then Ssaprophyticus_Presence = 1;
    else if not missing(Staphylococcus_saprophyticus) then Ssaprophyticus_Presence = 0;

    if Streptococcus_agalactiae >= 0.001 then Sagalactiae_Presence = 1;
    else if not missing(Streptococcus_agalactiae) then Sagalactiae_Presence = 0;

run;




%macro pairwise(group1=, group0=, label=);

data pair_data;
    set table2_data;

    where Cohort in ("&group1", "&group0");

    if Cohort = "&group1" then Group = 1;
    else if Cohort = "&group0" then Group = 0;
run;


/* Any uropathogen */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Uropathogens_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Uropathogens_Presence;

    title "Table 2: &label - Any Uropathogen";
run;


/* Candida albicans */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Candida_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Candida_Presence;

    title "Table 2: &label - Candida albicans";
run;


/* Enterococcus faecalis */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Efaecalis_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Efaecalis_Presence;

    title "Table 2: &label - Enterococcus faecalis";
run;


/* Escherichia coli */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Ecoli_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Ecoli_Presence;

    title "Table 2: &label - Escherichia coli";
run;


/* Klebsiella pneumoniae */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Kpneumoniae_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Kpneumoniae_Presence;

    title "Table 2: &label - Klebsiella pneumoniae";
run;


/* Proteus mirabilis */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Pmirabilis_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Pmirabilis_Presence;

    title "Table 2: &label - Proteus mirabilis";
run;


/* Pseudomonas aeruginosa */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Paeruginosa_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Paeruginosa_Presence;

    title "Table 2: &label - Pseudomonas aeruginosa";
run;


/* Staphylococcus saprophyticus */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Ssaprophyticus_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Ssaprophyticus_Presence;

    title "Table 2: &label - Staphylococcus saprophyticus";
run;


/* Streptococcus agalactiae */

proc logistic data=pair_data descending;
    class RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;

    model Group =
        Sagalactiae_Presence
        AGE
        BMI
        RACE
        MENOPAUSE;

    oddsratio Sagalactiae_Presence;

    title "Table 2: &label - Streptococcus agalactiae";
run;

%mend pairwise;



/* UTI vs Never Diagnosed */
%pairwise(
    group1=UTI only,
    group0=Never diagnosed,
    label=UTI vs Never Diagnosed
);


/* BV vs Never Diagnosed */
%pairwise(
    group1=BV only,
    group0=Never diagnosed,
    label=BV vs Never Diagnosed
);


/* BV&UTI vs Never Diagnosed */
%pairwise(
    group1=BV&UTI,
    group0=Never diagnosed,
    label=BV&UTI vs Never Diagnosed
);


/* UTI vs BV */
%pairwise(
    group1=UTI only,
    group0=BV only,
    label=UTI vs BV
);


/* BV&UTI vs UTI */
%pairwise(
    group1=BV&UTI,
    group0=UTI only,
    label=BV&UTI vs UTI
);


/* BV&UTI vs BV */
%pairwise(
    group1=BV&UTI,
    group0=BV only,
    label=BV&UTI vs BV
);

title;