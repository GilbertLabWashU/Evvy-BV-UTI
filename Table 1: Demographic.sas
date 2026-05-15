proc import datafile="/home/u63947748/A_InternLab_XinyueWang/DemographicsCharacteristicsSAS.xlsx"
    out=demo_data
    dbms=xlsx
    replace;
    sheet="Sheet1";
    getnames=yes;
run;
proc freq data=demo_data;
    tables Cohort*RACE / chisq nopercent norow nocol;
run;
proc freq data=demo_data;
    tables Cohort*PREGNANCY / chisq nopercent norow nocol;
run;
proc freq data=demo_data;
    tables Cohort*MENOPAUSE / chisq nopercent norow nocol;
run;

proc means data=demo_data mean std maxdec=1;
    class Cohort;
    var AGE;
run;
proc anova data=demo_data;
    class Cohort;
    model AGE = Cohort;
run;
proc means data=demo_data mean std maxdec=1;
    class Cohort;
    var BMI;
run;
proc anova data=demo_data;
    class Cohort;
    model BMI = Cohort;
run;

data demo_data_clean;
    set demo_data;
    length Race_group $20;
    if RACE in ("ASIAN-WHITE", "BLACK-WHITE", "HISPANIC-WHITE") then Race_group = "BI-RACIAL";
    else if RACE in ("MULT-RACIAL") then Race_group = "MULTIRACIAL";
    else if RACE in ("OTHER-COMBINE") then Race_group = "OTHER_COMBINED";
    else if RACE = "PR" then Race_group = "HISPANIC";
    else Race_group = RACE;
run;

proc freq data=demo_data_clean;
    tables Cohort*Race_group / chisq;
run;
