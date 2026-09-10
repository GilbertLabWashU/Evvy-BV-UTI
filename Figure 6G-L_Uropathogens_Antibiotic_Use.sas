
proc import
    datafile="/home/u63947748/A_InternLab_XinyueWang/METAdata_062425.xlsx"
    out=uro_ab_data
    dbms=xlsx
    replace;

    sheet="MetaData";
    getnames=yes;
run;


data uro_ab_data;
    set uro_ab_data;

    length Cohort_AB_1 $20;

    if Cohort = "Never diagnosed" then
        Cohort_AB_1 = "ND";

    else if Cohort = "UTI only" and TREATMENTS_AB = "NO" then
        Cohort_AB_1 = "UTI(-)";

    else if Cohort = "UTI only" and TREATMENTS_AB = "AB" then
        Cohort_AB_1 = "UTI(+)";

    else if Cohort = "BV only" and TREATMENTS_AB = "NO" then
        Cohort_AB_1 = "BV(-)";

    else if Cohort = "BV only" and TREATMENTS_AB = "AB" then
        Cohort_AB_1 = "BV(+)";

    else if Cohort = "BV&UTI" and TREATMENTS_AB = "NO" then
        Cohort_AB_1 = "BV&UTI(-)";

    else if Cohort = "BV&UTI" and TREATMENTS_AB = "AB" then
        Cohort_AB_1 = "BV&UTI(+)";

run;



proc freq data=uro_ab_data;
    tables Cohort_AB_1 / missing;
    title "Figure 6G-L: Cohort Groups Stratified by Antibiotic Use";
run;



proc glm data=uro_ab_data;

    class Cohort_AB_1 RACE MENOPAUSE;

    model "Total Uropathogens abundance"n =
        Cohort_AB_1
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort_AB_1 /
        pdiff=all
        adjust=bon
        cl;

    title "Figure 6G: Total Uropathogen Abundance by Antibiotic Use";

run;
quit;




proc glm data=uro_ab_data;

    class Cohort_AB_1 RACE MENOPAUSE;

    model Escherichia_coli =
        Cohort_AB_1
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort_AB_1 /
        pdiff=all
        adjust=bon
        cl;

    title "Figure 6H: Escherichia coli Abundance by Antibiotic Use";

run;
quit;



proc glm data=uro_ab_data;

    class Cohort_AB_1 RACE MENOPAUSE;

    model Enterococcus_faecalis =
        Cohort_AB_1
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort_AB_1 /
        pdiff=all
        adjust=bon
        cl;

    title "Figure 6I: Enterococcus faecalis Abundance by Antibiotic Use";

run;
quit;



proc glm data=uro_ab_data;

    class Cohort_AB_1 RACE MENOPAUSE;

    model Proteus_mirabilis =
        Cohort_AB_1
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort_AB_1 /
        pdiff=all
        adjust=bon
        cl;

    title "Figure 6J: Proteus mirabilis Abundance by Antibiotic Use";

run;
quit;




proc glm data=uro_ab_data;

    class Cohort_AB_1 RACE MENOPAUSE;

    model Staphylococcus_saprophyticus =
        Cohort_AB_1
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort_AB_1 /
        pdiff=all
        adjust=bon
        cl;

    title "Figure 6K: Staphylococcus saprophyticus Abundance by Antibiotic Use";

run;
quit;



proc glm data=uro_ab_data;

    class Cohort_AB_1 RACE MENOPAUSE;

    model Streptococcus_agalactiae =
        Cohort_AB_1
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort_AB_1 /
        pdiff=all
        adjust=bon
        cl;

    title "Figure 6L: Streptococcus agalactiae Abundance by Antibiotic Use";

run;
quit;

title;