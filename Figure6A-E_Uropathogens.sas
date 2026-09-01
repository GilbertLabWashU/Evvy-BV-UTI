proc import datafile="/home/u63947748/A_InternLab_XinyueWang/SAS_Uropathogen_Seperate.xlsx"
    out=Uropathogen_data
    dbms=xlsx
    replace;
    getnames=yes;
run;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Total Uropathogens abundance"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Total Uropathogens abundance";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Candida_albicans"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Total Candida_albicans";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Enterococcus_faecalis"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Enterococcus_faecalis";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Escherichia_coli"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Escherichia_coli";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Klebsiella_pneumoniae"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=tukey cl;
    title "Bonferroni Comparison for Klebsiella_pneumoniae";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Proteus_mirabilis"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=tukey cl;
    title "Bonferroni Comparison for Proteus_mirabilis";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Pseudomonas_aeruginosa"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Pseudomonas_aeruginosa";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Staphylococcus_saprophyticus"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Staphylococcus_saprophyticus";
run;
quit;

proc glm data=Uropathogen_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Streptococcus_agalactiae"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for Streptococcus_agalactiae";
run;
quit;
