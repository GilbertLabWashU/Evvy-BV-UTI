proc import datafile="/home/u63947748/A_InternLab_XinyueWang/Table_9.3.xlsx"
    out=summary_data
    dbms=xlsx
    replace;
    getnames=yes;
run;

proc freq data=summary_data;
    tables SEXUAL_ACTIVITY_CONDOMS_EV*Cohort / chisq norow nocol nopercent;
run;
proc freq data=summary_data;
    tables SEXUAL_ACTIVITY_CONDOMS_NE*Cohort / chisq norow nocol nopercent;
run;
proc freq data=summary_data;
    tables SEXUAL_ACTIVITY_CONDOMS_PR*Cohort / chisq norow nocol nopercent;
run;
proc freq data=summary_data;
    tables SEXUAL_ACTIVITY_CONDOMS_SO*Cohort / chisq norow nocol nopercent;
run;

data bv_vs_nd;
    set summary_data;
    where Cohort in ("BV only", "Never diagnosed");
    if Cohort = "BV only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO AGE BMI RACE MENOPAUSE;
run;

data uti_vs_nd;
    set summary_data;
    where Cohort in ("UTI only", "Never diagnosed");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO;
run;

data bvuti_vs_nd;
    set summary_data;
    where Cohort in ("BV&UTI", "Never diagnosed");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO;
run;

data uti_vs_bv;
    set summary_data;
    where Cohort in ("UTI only", "BV only");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO;
run;

data bvuti_vs_bv;
    set summary_data;
    where Cohort in ("BV&UTI", "BV only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO;
run;

data bvuti_vs_uti;
    set summary_data;
    where Cohort in ("BV&UTI", "UTI only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "UTI only" then Group = 0;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO;
run;

data bv_vs_nd;
    set summary_data;
    where Cohort in ("BV only", "Never diagnosed");
    if Cohort = "BV only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR;
run;
proc logistic data=bv_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO');
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO;
run;

data uti_vs_nd;
    set summary_data;
    where Cohort in ("UTI only", "Never diagnosed");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_nd;
    set summary_data;
    where Cohort in ("BV&UTI", "Never diagnosed");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO AGE BMI RACE MENOPAUSE;
run;

data uti_vs_bv;
    set summary_data;
    where Cohort in ("UTI only", "BV only");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_bv;
    set summary_data;
    where Cohort in ("BV&UTI", "BV only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_uti;
    set summary_data;
    where Cohort in ("BV&UTI", "UTI only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "UTI only" then Group = 0;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_EV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_EV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_NE (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_NE AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class SEXUAL_ACTIVITY_CONDOMS_SO (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = SEXUAL_ACTIVITY_CONDOMS_SO AGE BMI RACE MENOPAUSE;
run;