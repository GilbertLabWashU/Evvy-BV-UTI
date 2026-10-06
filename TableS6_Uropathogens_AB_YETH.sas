

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

data s6_base;
    merge metadata(in=a)
          diagnosis(in=b);

    by Sample;

    if a;
run;



proc freq data=s6_base;

    tables
        Cohort
        TREATMENTS_AB
        DIAGNOSES_30DAY_BV
        DIAGNOSES_30DAY_UTI
        / missing;

run;




%macro make_s6(dx=, ref=, out=);

data &out;

    set s6_base;

    length S6_Group $30;



    if Cohort = "Never diagnosed" then do;

        %if &ref = ALL %then %do;

            S6_Group = "ND";

        %end;

        %else %if &ref = NO %then %do;

            if TREATMENTS_AB = "NO"
                then S6_Group = "ND";
            else delete;

        %end;

        %else %if &ref = AB %then %do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "ND";
            else delete;

        %end;

    end;



    else if "&dx" = "YE" then do;


        /* BV */

        if Cohort = "BV only"
           and DIAGNOSES_30DAY_BV = "YE" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "BV_YE_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "BV_YE_NO";

            else delete;

        end;


        /* UTI */

        else if Cohort = "UTI only"
           and DIAGNOSES_30DAY_UTI = "YE" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "UTI_YE_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "UTI_YE_NO";

            else delete;

        end;


        /* BV & UTI: both diagnoses must be YE */

        else if Cohort = "BV&UTI"
            and DIAGNOSES_30DAY_BV = "YE"
            and DIAGNOSES_30DAY_UTI = "YE" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "BVUTI_YE_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "BVUTI_YE_NO";

            else delete;

        end;

        else delete;

    end;




    else if "&dx" = "TH" then do;


        /* BV */

        if Cohort = "BV only"
           and DIAGNOSES_30DAY_BV = "TH" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "BV_TH_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "BV_TH_NO";

            else delete;

        end;


        /* UTI */

        else if Cohort = "UTI only"
           and DIAGNOSES_30DAY_UTI = "TH" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "UTI_TH_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "UTI_TH_NO";

            else delete;

        end;


        /* BV & UTI: both diagnoses must be TH */

        else if Cohort = "BV&UTI"
            and DIAGNOSES_30DAY_BV = "TH"
            and DIAGNOSES_30DAY_UTI = "TH" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "BVUTI_TH_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "BVUTI_TH_NO";

            else delete;

        end;

        else delete;

    end;



    else if "&dx" = "ALL" then do;


        if Cohort = "BV only" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "BV_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "BV_NO";

            else delete;

        end;


        else if Cohort = "UTI only" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "UTI_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "UTI_NO";

            else delete;

        end;


        else if Cohort = "BV&UTI" then do;

            if TREATMENTS_AB = "AB"
                then S6_Group = "BVUTI_AB";

            else if TREATMENTS_AB = "NO"
                then S6_Group = "BVUTI_NO";

            else delete;

        end;

        else delete;

    end;

run;

%mend;





/*---------------- YE ----------------*/

%make_s6(dx=YE, ref=ALL, out=s6_ye_ndall);

%make_s6(dx=YE, ref=NO,  out=s6_ye_ndno);

%make_s6(dx=YE, ref=AB,  out=s6_ye_ndab);


/*---------------- TH ----------------*/

%make_s6(dx=TH, ref=ALL, out=s6_th_ndall);

%make_s6(dx=TH, ref=NO,  out=s6_th_ndno);

%make_s6(dx=TH, ref=AB,  out=s6_th_ndab);


/*---------------- ALL ----------------*/

%make_s6(dx=ALL, ref=ALL, out=s6_all_ndall);

%make_s6(dx=ALL, ref=NO,  out=s6_all_ndno);

%make_s6(dx=ALL, ref=AB,  out=s6_all_ndab);





proc freq data=s6_ye_ndall;
    tables S6_Group / missing;
run;

proc freq data=s6_th_ndall;
    tables S6_Group / missing;
run;

proc freq data=s6_all_ndall;
    tables S6_Group / missing;
run;




%macro run_glm(data=, var=, label=, section=);

proc glm data=&data;

    class S6_Group RACE MENOPAUSE;

    model &var =
        S6_Group
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans S6_Group /
        pdiff=all
        adjust=bon
        cl;

    title "Table S6 - &label - &section";

run;
quit;

%mend;




%macro S6_analysis(var=, label=);


/*================ YE =================*/

%run_glm(
    data=s6_ye_ndall,
    var=&var,
    label=&label,
    section=YE - ND ALL
);

%run_glm(
    data=s6_ye_ndno,
    var=&var,
    label=&label,
    section=YE - ND NO Antibiotics
);

%run_glm(
    data=s6_ye_ndab,
    var=&var,
    label=&label,
    section=YE - ND Antibiotics
);


/*================ TH =================*/

%run_glm(
    data=s6_th_ndall,
    var=&var,
    label=&label,
    section=TH - ND ALL
);

%run_glm(
    data=s6_th_ndno,
    var=&var,
    label=&label,
    section=TH - ND NO Antibiotics
);

%run_glm(
    data=s6_th_ndab,
    var=&var,
    label=&label,
    section=TH - ND Antibiotics
);


/*================ ALL =================*/

%run_glm(
    data=s6_all_ndall,
    var=&var,
    label=&label,
    section=ALL Diagnosis - ND ALL
);

%run_glm(
    data=s6_all_ndno,
    var=&var,
    label=&label,
    section=ALL Diagnosis - ND NO Antibiotics
);

%run_glm(
    data=s6_all_ndab,
    var=&var,
    label=&label,
    section=ALL Diagnosis - ND Antibiotics
);

%mend;





/* Total Uropathogens */

%S6_analysis(
    var=%str("Total Uropathogens abundance"n),
    label=Total Uropathogens
);


/* Candida albicans */

%S6_analysis(
    var=Candida_albicans,
    label=Candida albicans
);


/* Enterococcus faecalis */

%S6_analysis(
    var=Enterococcus_faecalis,
    label=Enterococcus faecalis
);


/* Escherichia coli */

%S6_analysis(
    var=Escherichia_coli,
    label=Escherichia coli
);


/* Klebsiella pneumoniae */

%S6_analysis(
    var=Klebsiella_pneumoniae,
    label=Klebsiella pneumoniae
);


/* Proteus mirabilis */

%S6_analysis(
    var=Proteus_mirabilis,
    label=Proteus mirabilis
);


/* Pseudomonas aeruginosa */

%S6_analysis(
    var=Pseudomonas_aeruginosa,
    label=Pseudomonas aeruginosa
);


/* Staphylococcus saprophyticus */

%S6_analysis(
    var=Staphylococcus_saprophyticus,
    label=Staphylococcus saprophyticus
);


/* Streptococcus agalactiae */

%S6_analysis(
    var=Streptococcus_agalactiae,
    label=Streptococcus agalactiae
);

title;
