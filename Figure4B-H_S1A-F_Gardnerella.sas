proc import datafile="/home/u63947748/A_InternLab_XinyueWang/SAS_Gardnerella_Seperate.xlsx"
    out=gardnerella_data
    dbms=xlsx
    replace;
    getnames=yes;
run;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "total Gardnerella spp abundance"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_leopoldii"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_piotii"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spA"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spB"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spC"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=tukey cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spD"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spE"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spF"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spG"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_spH"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_swidsinskii"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;

proc glm data=gardnerella_data;
    class Cohort AGE BMI RACE MENOPAUSE;
    model "Gardnerella_vaginalis"n = Cohort AGE BMI RACE MENOPAUSE/solution;
    lsmeans Cohort / pdiff=all adjust=bon cl;
    title "Bonferroni Comparison for total Gardnerella spp abundance";
run;
quit;
