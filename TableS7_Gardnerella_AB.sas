

proc import
    datafile="/home/u63947748/A_InternLab_XinyueWang/METAdata_062425.xlsx"
    out=s7_data
    dbms=xlsx
    replace;

    sheet="MetaData";
    getnames=yes;
run;



proc freq data=s7_data;
    tables Cohort*TREATMENTS_AB / missing;
    title "Supplementary Table 7: Cohort by Antibiotic Use";
run;



data s7_nd;
    set s7_data;
    where Cohort = "Never diagnosed"
          and TREATMENTS_AB in ("AB","NO");

    length AB_Group $10;

    if TREATMENTS_AB = "AB" then AB_Group = "ND(+)";
    else if TREATMENTS_AB = "NO" then AB_Group = "ND(-)";
run;




%macro ND_AB_compare(var=, label=);

proc glm data=s7_nd;

    class AB_Group RACE MENOPAUSE;

    model &var =
        AB_Group
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans AB_Group /
        pdiff=all
        adjust=bon
        cl;

    title "Table S7: &label - ND (+) vs ND (-)";

run;
quit;

%mend;


/* Total Gardnerella */
%ND_AB_compare(
    var=%str("total Gardnerella spp abundance"n),
    label=Total Gardnerella abundance
);

/* Gardnerella species */
%ND_AB_compare(var=Gardnerella_leopoldii,
               label=Gardnerella leopoldii);

%ND_AB_compare(var=Gardnerella_piotii,
               label=Gardnerella piotii);

%ND_AB_compare(var=Gardnerella_spA,
               label=Gardnerella spA);

%ND_AB_compare(var=Gardnerella_spB,
               label=Gardnerella spB);

%ND_AB_compare(var=Gardnerella_spC,
               label=Gardnerella spC);

%ND_AB_compare(var=Gardnerella_spD,
               label=Gardnerella spD);

%ND_AB_compare(var=Gardnerella_spE,
               label=Gardnerella spE);

%ND_AB_compare(var=Gardnerella_spF,
               label=Gardnerella spF);

%ND_AB_compare(var=Gardnerella_spG,
               label=Gardnerella spG);

%ND_AB_compare(var=Gardnerella_spH,
               label=Gardnerella spH);

%ND_AB_compare(var=Gardnerella_swidsinskii,
               label=Gardnerella swidsinskii);

%ND_AB_compare(var=Gardnerella_vaginalis,
               label=Gardnerella vaginalis);




data s7_groups;
    set s7_data;

    length Cohort_AB $20;

    /* All ND participants remain together */
    if Cohort = "Never diagnosed" then
        Cohort_AB = "ND_ALL";

    /* UTI */
    else if Cohort = "UTI only"
         and TREATMENTS_AB = "NO" then
        Cohort_AB = "UTI(-)";

    else if Cohort = "UTI only"
         and TREATMENTS_AB = "AB" then
        Cohort_AB = "UTI(+)";

    /* BV */
    else if Cohort = "BV only"
         and TREATMENTS_AB = "NO" then
        Cohort_AB = "BV(-)";

    else if Cohort = "BV only"
         and TREATMENTS_AB = "AB" then
        Cohort_AB = "BV(+)";

    /* BV & UTI */
    else if Cohort = "BV&UTI"
         and TREATMENTS_AB = "NO" then
        Cohort_AB = "BV&UTI(-)";

    else if Cohort = "BV&UTI"
         and TREATMENTS_AB = "AB" then
        Cohort_AB = "BV&UTI(+)";

run;



proc freq data=s7_groups;
    tables Cohort_AB / missing;
    title "Supplementary Table 7: Analysis Groups";
run;



%macro S7_compare(var=, label=);

proc glm data=s7_groups;

    class Cohort_AB RACE MENOPAUSE;

    model &var =
        Cohort_AB
        AGE
        BMI
        RACE
        MENOPAUSE
        / solution;

    lsmeans Cohort_AB /
        pdiff=control("ND_ALL")
        adjust=bon
        cl;

    title "Table S7: &label - Antibiotic-Stratified Comparisons";

run;
quit;

%mend;




%S7_compare(
    var=%str("total Gardnerella spp abundance"n),
    label=Total Gardnerella abundance
);


/* Gardnerella species */

%S7_compare(
    var=Gardnerella_leopoldii,
    label=Gardnerella leopoldii
);

%S7_compare(
    var=Gardnerella_piotii,
    label=Gardnerella piotii
);

%S7_compare(
    var=Gardnerella_spA,
    label=Gardnerella spA
);

%S7_compare(
    var=Gardnerella_spB,
    label=Gardnerella spB
);

%S7_compare(
    var=Gardnerella_spC,
    label=Gardnerella spC
);

%S7_compare(
    var=Gardnerella_spD,
    label=Gardnerella spD
);

%S7_compare(
    var=Gardnerella_spE,
    label=Gardnerella spE
);

%S7_compare(
    var=Gardnerella_spF,
    label=Gardnerella spF
);

%S7_compare(
    var=Gardnerella_spG,
    label=Gardnerella spG
);

%S7_compare(
    var=Gardnerella_spH,
    label=Gardnerella spH
);

%S7_compare(
    var=Gardnerella_swidsinskii,
    label=Gardnerella swidsinskii
);

%S7_compare(
    var=Gardnerella_vaginalis,
    label=Gardnerella vaginalis
);

title;
