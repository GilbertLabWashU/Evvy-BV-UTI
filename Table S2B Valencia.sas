proc import datafile="/home/u63947748/A_InternLab_XinyueWang/Table_9.12.xlsx"
    out=Data
    dbms=xlsx
    replace;
    sheet=Data;
    getnames=yes;
run;
proc glm data=Data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "VALENCIA_TYPE"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Total Uropathogens abundance";
run;
quit;
data bv_vs_nd;
    set Data;
    where Cohort in ("BV only", "Never diagnosed");
    if Cohort = "BV only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bv_vs_nd descending;
    class A (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = A AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class B (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = B AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class C (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = C AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class D (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = D AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class E (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = E AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class F (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = F AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class G (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = G AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class H (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = H AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class J (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = J AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class K (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = K AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bv_vs_nd descending;
    class L (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = L AGE BMI RACE MENOPAUSE;
run;
data uti_vs_nd;
    set Data;
    where Cohort in ("UTI only", "Never diagnosed");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=uti_vs_nd descending;
    class A (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = A AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class B (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = B AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class C (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = C AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class D (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = D AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class E (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = E AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class F (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = F AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class G (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = G AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class H (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = H AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class J (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = J AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class K (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = K AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_nd descending;
    class L (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = L AGE BMI RACE MENOPAUSE;
run;
data bvuti_vs_nd;
    set Data;
    where Cohort in ("BV&UTI", "Never diagnosed");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "Never diagnosed" then Group = 0;
run;
proc logistic data=bvuti_vs_nd descending;
    class A (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = A AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class B (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = B AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class C (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = C AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class D (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = D AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class E (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = E AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class F (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = F AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class G (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = G AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class H (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = H AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class J (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = J AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class K (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = K AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_nd descending;
    class L (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = L AGE BMI RACE MENOPAUSE;
run;
data uti_vs_bv;
    set Data;
    where Cohort in ("UTI only", "BV only");
    if Cohort = "UTI only" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=uti_vs_bv descending;
    class A (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = A AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class B (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = B AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class C (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = C AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class D (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = D AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class E (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = E AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class F (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = F AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class G (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = G AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class H (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = H AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class J (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = J AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class K (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = K AGE BMI RACE MENOPAUSE;
run;
proc logistic data=uti_vs_bv descending;
    class L (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = L AGE BMI RACE MENOPAUSE;
run;
data bvuti_vs_bv;
    set Data;
    where Cohort in ("BV&UTI", "BV only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "BV only" then Group = 0;
run;
proc logistic data=bvuti_vs_bv descending;
    class A (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = A AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class B (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = B AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class C (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = C AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class D (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = D AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class E (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = E AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class F (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = F AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class G (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = G AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class H (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = H AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class J (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = J AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class K (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = K AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_bv descending;
    class L (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = L AGE BMI RACE MENOPAUSE;
run;
data bvuti_vs_uti;
    set Data;
    where Cohort in ("BV&UTI", "UTI only");
    if Cohort = "BV&UTI" then Group = 1;
    else if Cohort = "UTI only" then Group = 0;
run;
proc logistic data=bvuti_vs_uti descending;
    class A (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = A AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class B (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = B AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class C (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = C AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class D (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = D AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class E (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = E AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class F (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = F AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class G (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = G AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class H (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = H AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class I (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = I AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class J (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = J AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class K (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = K AGE BMI RACE MENOPAUSE;
run;
proc logistic data=bvuti_vs_uti descending;
    class L (ref='NO') 
          RACE (ref="WHITE")
          MENOPAUSE (ref="NO-MENOPAUSE")/ param=ref;
    model Group = L AGE BMI RACE MENOPAUSE;
run;