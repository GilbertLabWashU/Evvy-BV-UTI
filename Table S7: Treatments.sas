proc import datafile="/home/u63947748/A_InternLab_XinyueWang/SAS_SummaryTreatmentsAdjusted.xlsx"
    out=treat_data
    dbms=xlsx
    replace;
    getnames=yes;
run;

proc freq data=treat_data;
    tables TREATMENTS_AB*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_AF*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_BA*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_FH*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_PR*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_OT*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_HR*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_HP*Cohort / chisq norow nocol nopercent;
run;
proc freq data=treat_data;
    tables TREATMENTS_Categorical*Cohort / chisq norow nocol nopercent;
run;

data bv_vs_nd;
    set treat_data;
    where Cohort in ("BV only", "Never diagnosed");
    if Cohort = "BV only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_AB (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AB AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_AF (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AF AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_BA (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_BA AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_FH (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_FH AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_OT (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_OT AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_HR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_HP (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HP AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class TREATMENTS_Categorical (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_Categorical AGE BMI RACE MENOPAUSE;
run;

data uti_vs_nd;
    set treat_data;
    where Cohort in ("UTI only", "Never diagnosed");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_AB (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AB AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_AF (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AF AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_BA (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_BA AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_FH (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_FH AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_OT (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_OT AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_HR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_HP (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HP AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class TREATMENTS_Categorical (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_Categorical AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_nd;
    set treat_data;
    where Cohort in ("BV&UTI", "Never diagnosed");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_AB (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AB AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_AF (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AF AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_BA (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_BA AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_FH (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_FH AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_OT (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_OT AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_HR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_HP (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HP AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class TREATMENTS_Categorical (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_Categorical AGE BMI RACE MENOPAUSE;
run;

data uti_vs_bv;
    set treat_data;
    where Cohort in ("UTI only", "BV only");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_AB (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AB AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_AF (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AF AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_BA (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_BA AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_FH (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_FH AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_OT (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_OT AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_HR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_HP (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HP AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class TREATMENTS_Categorical (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_Categorical AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_bv;
    set treat_data;
    where Cohort in ("BV&UTI", "BV only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_AB (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AB AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_AF (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AF AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_BA (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_BA AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_FH (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_FH AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_OT (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_OT AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_HR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_HP (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HP AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class TREATMENTS_Categorical (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_Categorical AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_uti;
    set treat_data;
    where Cohort in ("BV&UTI", "UTI only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "UTI only" then Group = 0;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_AB (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AB AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_AF (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_AF AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_BA (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_BA AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_FH (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_FH AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_PR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_PR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_OT (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_OT AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_HR (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HR AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_HP (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_HP AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class TREATMENTS_Categorical (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = TREATMENTS_Categorical AGE BMI RACE MENOPAUSE;
run;

