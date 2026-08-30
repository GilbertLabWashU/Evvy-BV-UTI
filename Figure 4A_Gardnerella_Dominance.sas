/*==========================================================
  Figure 4A
  Prevalence of Gardnerella-dominant vaginal microbiome
  Gardnerella dominance defined as >50% relative abundance
  Statistical test: two-sided Pearson chi-square test
==========================================================*/




proc import datafile="/home/u63947748/A_InternLab_XinyueWang/Evvy_METAdata_forMonica_042825.xlsx"
    out=figure4a_data
    dbms=xlsx
    replace;
    sheet="MetaData";
    getnames=yes;
run;



data figure4a_data;
    set figure4a_data;

    if "total Gardnerella spp abundance"n > 0.50 then Gardnerella_Dominant = 1;
    else if not missing("total Gardnerella spp abundance"n) then Gardnerella_Dominant = 0;

run;




proc freq data=figure4a_data;
    tables Cohort*Gardnerella_Dominant /
        norow nocol nopercent;
    title "Figure 4A: Gardnerella Dominance by Cohort";
run;



proc freq data=figure4a_data;
    tables Cohort*Gardnerella_Dominant /
        chisq;
    title "Figure 4A: Overall Pearson Chi-square Test";
run;




/* Never diagnosed vs UTI only */

proc freq data=figure4a_data;
    where Cohort in ("Never diagnosed", "UTI only");
    tables Cohort*Gardnerella_Dominant /
        chisq;
    title "Figure 4A: Never Diagnosed vs UTI Only";
run;


/* Never diagnosed vs BV only */

proc freq data=figure4a_data;
    where Cohort in ("Never diagnosed", "BV only");
    tables Cohort*Gardnerella_Dominant /
        chisq;
    title "Figure 4A: Never Diagnosed vs BV Only";
run;


/* Never diagnosed vs BV&UTI */

proc freq data=figure4a_data;
    where Cohort in ("Never diagnosed", "BV&UTI");
    tables Cohort*Gardnerella_Dominant /
        chisq;
    title "Figure 4A: Never Diagnosed vs BV&UTI";
run;


/* UTI only vs BV only */

proc freq data=figure4a_data;
    where Cohort in ("UTI only", "BV only");
    tables Cohort*Gardnerella_Dominant /
        chisq;
    title "Figure 4A: UTI Only vs BV Only";
run;


/* UTI only vs BV&UTI */

proc freq data=figure4a_data;
    where Cohort in ("UTI only", "BV&UTI");
    tables Cohort*Gardnerella_Dominant /
        chisq;
    title "Figure 4A: UTI Only vs BV&UTI";
run;


/* BV only vs BV&UTI */

proc freq data=figure4a_data;
    where Cohort in ("BV only", "BV&UTI");
    tables Cohort*Gardnerella_Dominant /
        chisq;
    title "Figure 4A: BV Only vs BV&UTI";
run;

title;