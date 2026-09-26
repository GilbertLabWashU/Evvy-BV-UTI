

proc import
    datafile="/home/u63947748/A_InternLab_XinyueWang/2025-11-19 Template_0%.xlsx"
    out=metadata
    dbms=xlsx
    replace;
    sheet="MetaData";
    getnames=yes;
run;



proc import
    datafile="/home/u63947748/A_InternLab_XinyueWang/2025-11-19 Template_0%.xlsx"
    out=diagnosis
    dbms=xlsx
    replace;
    sheet="Diagnoses";
    getnames=yes;
run;




proc sort data=metadata;
    by Sample;
run;

proc sort data=diagnosis;
    by Sample;
run;

data s4_base;
    merge metadata(in=a)
          diagnosis(in=b);
    by Sample;
    if a;
run;




data s4_all;
    set s4_base;

    length S4_Group $20;

    if Cohort = "Never diagnosed" then
        S4_Group = "ND";

    else if Cohort = "BV only" then
        S4_Group = "BV_ALL";

    else if Cohort = "UTI only" then
        S4_Group = "UTI_ALL";

    else if Cohort = "BV&UTI" then
        S4_Group = "BVUTI_ALL";
run;




data s4_ye;
    set s4_base;

    length S4_Group $20;

    if Cohort = "Never diagnosed" then
        S4_Group = "ND";

    else if Cohort = "BV only"
         and DIAGNOSES_30DAY_BV = "YE" then
        S4_Group = "BV_YE";

    else if Cohort = "UTI only"
         and DIAGNOSES_30DAY_UTI = "YE" then
        S4_Group = "UTI_YE";

    else if Cohort = "BV&UTI"
         and DIAGNOSES_30DAY_BV = "YE"
         and DIAGNOSES_30DAY_UTI = "YE" then
        S4_Group = "BVUTI_YEYE";

    else delete;
run;




data s4_th;
    set s4_base;

    length S4_Group $20;

    if Cohort = "Never diagnosed" then
        S4_Group = "ND";

    else if Cohort = "BV only"
         and DIAGNOSES_30DAY_BV = "TH" then
        S4_Group = "BV_TH";

    else if Cohort = "UTI only"
         and DIAGNOSES_30DAY_UTI = "TH" then
        S4_Group = "UTI_TH";

    else if Cohort = "BV&UTI"
         and DIAGNOSES_30DAY_BV = "TH"
         and DIAGNOSES_30DAY_UTI = "TH" then
        S4_Group = "BVUTI_THTH";

    else delete;
run;




proc freq data=s4_all;
    tables S4_Group / missing;
run;

proc freq data=s4_ye;
    tables S4_Group / missing;
run;

proc freq data=s4_th;
    tables S4_Group / missing;
run;



%macro S4_analysis(var=, label=);




proc glm data=s4_all;

    class S4_Group RACE MENOPAUSE;

    model &var =
        S4_Group
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans S4_Group /
        pdiff=all
        adjust=bon
        cl;

    title "Table S4 - &label - ALL";

run;
quit;




proc glm data=s4_ye;

    class S4_Group RACE MENOPAUSE;

    model &var =
        S4_Group
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans S4_Group /
        pdiff=all
        adjust=bon
        cl;

    title "Table S4 - &label - YE";

run;
quit;



proc glm data=s4_th;

    class S4_Group RACE MENOPAUSE;

    model &var =
        S4_Group
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans S4_Group /
        pdiff=all
        adjust=bon
        cl;

    title "Table S4 - &label - TH";

run;
quit;

%mend;





/* Total uropathogens */

%S4_analysis(
    var=%str("Total Uropathogens abundance"n),
    label=Total Uropathogens
);


/* Candida albicans */

%S4_analysis(
    var=Candida_albicans,
    label=Candida albicans
);


/* Enterococcus faecalis */

%S4_analysis(
    var=Enterococcus_faecalis,
    label=Enterococcus faecalis
);


/* Escherichia coli */

%S4_analysis(
    var=Escherichia_coli,
    label=Escherichia coli
);


/* Klebsiella pneumoniae */

%S4_analysis(
    var=Klebsiella_pneumoniae,
    label=Klebsiella pneumoniae
);


/* Proteus mirabilis */

%S4_analysis(
    var=Proteus_mirabilis,
    label=Proteus mirabilis
);


/* Pseudomonas aeruginosa */

%S4_analysis(
    var=Pseudomonas_aeruginosa,
    label=Pseudomonas aeruginosa
);


/* Staphylococcus saprophyticus */

%S4_analysis(
    var=Staphylococcus_saprophyticus,
    label=Staphylococcus saprophyticus
);


/* Streptococcus agalactiae */

%S4_analysis(
    var=Streptococcus_agalactiae,
    label=Streptococcus agalactiae
);

title;