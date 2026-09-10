

proc import
    datafile="/home/u63947748/A_InternLab_XinyueWang/2025-10-10 Template_Simpson.xlsx"
    out=diversity_data
    dbms=xlsx
    replace;

    sheet="NoThreshold";
    getnames=yes;
run;



proc freq data=diversity_data;
    tables Cohort / missing;
    title "Cohort Distribution for Alpha Diversity Analysis";
run;



proc glm data=diversity_data;

    class Cohort RACE MENOPAUSE;

    model ShannonDiv =
        Cohort
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort /
        pdiff=all
        adjust=bon
        cl;

    title "Shannon Diversity Index - Adjusted GLM";

run;
quit;




proc glm data=diversity_data;

    class Cohort RACE MENOPAUSE;

    model SimpsonD =
        Cohort
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort /
        pdiff=all
        adjust=bon
        cl;

    title "Simpson Diversity Index - Adjusted GLM";

run;
quit;

title;
