proc import datafile="/home/u63947748/A_InternLab_XinyueWang/2025-11-07 Template_QOL.xlsx"
    out=treat_data
    dbms=xlsx
    replace;
    sheet=Data;
    getnames=yes;
run;
proc import datafile="/home/u63947748/A_InternLab_XinyueWang/Table_9.12.xlsx"
    out=treat_data
    dbms=xlsx
    replace;
    sheet=Data;
    getnames=yes;
run;
proc glm data=treat_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "CST"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Total Uropathogens abundance";
run;

data bv_vs_nd;
    set treat_data;
    where Cohort in ("BV only", "Never diagnosed");
    if Cohort = "BV only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bv_vs_nd descending;
    class CST_I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class CST_II (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_II AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class CST_III (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_III AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class CST_IV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_IV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class CST_V (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_V AGE BMI RACE MENOPAUSE;
run;

data uti_vs_nd;
    set treat_data;
    where Cohort in ("UTI only", "Never diagnosed");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=uti_vs_nd descending;
    class CST_I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class CST_II (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_II AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class CST_III (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_III AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class CST_IV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_IV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class CST_V (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_V AGE BMI RACE MENOPAUSE;
run;
data bvuti_vs_nd;
    set treat_data;
    where Cohort in ("BV&UTI", "Never diagnosed");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bvuti_vs_nd descending;
    class CST_I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class CST_II (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_II AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class CST_III (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_III AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class CST_IV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_IV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class CST_V (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_V AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_bv;
    set treat_data;
    where Cohort in ("BV&UTI", "BV only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=bvuti_vs_bv descending;
    class CST_I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class CST_II (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_II AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class CST_III (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_III AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class CST_IV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_IV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class CST_V (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_V AGE BMI RACE MENOPAUSE;
run;

data bvuti_vs_uti;
    set treat_data;
    where Cohort in ("BV&UTI", "UTI only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "UTI only" then Group = 0;
run;
proc logistic data=bvuti_vs_uti descending;
    class CST_I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class CST_II (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_II AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class CST_III (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_III AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class CST_IV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_IV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class CST_V (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_V AGE BMI RACE MENOPAUSE;
run;
data uti_vs_bv;
    set treat_data;
    where Cohort in ("UTI only", "BV only");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=uti_vs_bv descending;
    class CST_I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class CST_II (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_II AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class CST_III (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_III AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class CST_IV (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_IV AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class CST_V (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = CST_V AGE BMI RACE MENOPAUSE;
run;
