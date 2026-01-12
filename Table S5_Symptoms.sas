proc import datafile="/home/u63947748/A_InternLab_XinyueWang/Symptoms.xlsx"
    out=symptom_data
    dbms=xlsx
    replace;
    sheet="Sheet1";
    getnames=yes;
run;

data symptom_clean;
    set symptom_data;

    array symp_vars[*] VAGINA_PAIN VULVA_PAIN VULVA_REDNESS VAGINAL_SWELLING
                       EXTERNAL_ITCHINESS INTERNAL_ITCHINESS DRYNESS
                       BURNING_SENSATION PAIN_WITH_SEX PAIN_WHILE_PEEING
                       EXCESSIVE_DISCHARGE ODOROUS_DISCHARGE;
    all_no = 1;
    do i = 1 to dim(symp_vars);
        if upcase(symp_vars[i]) = "YES" then all_no = 0;
    end;

    if all_no = 1 then NO_SYMPTOM = "YES";
    else NO_SYMPTOM = "NO";
run;

%macro symptom_table;

    %let vars = NO_SYMPTOM BURNING_SENSATION DRYNESS EXCESSIVE_DISCHARGE ODOROUS_DISCHARGE
                EXTERNAL_ITCHINESS INTERNAL_ITCHINESS PAIN_WHILE_PEEING PAIN_WITH_SEX
                VAGINA_PAIN VAGINAL_SWELLING VULVA_PAIN VULVA_REDNESS;

    %let i = 1;
    %do %while (%scan(&vars, &i) ne );
        %let var = %scan(&vars, &i);

        title "Summary for &var";
        proc freq data=symptom_clean;
            tables Cohort*&var / chisq norow nocol nopercent;
        run;

        %let i = %eval(&i + 1);
    %end;

%mend symptom_table;

%symptom_table;

data model_data;
    set symptom_clean;

    array symps[*] NO_SYMPTOM BURNING_SENSATION DRYNESS EXCESSIVE_DISCHARGE ODOROUS_DISCHARGE
                   EXTERNAL_ITCHINESS INTERNAL_ITCHINESS PAIN_WHILE_PEEING PAIN_WITH_SEX
                   VAGINA_PAIN VAGINAL_SWELLING VULVA_PAIN VULVA_REDNESS;

    do i = 1 to dim(symps);
        if upcase(symps[i]) = "YES" then symps[i] = 1;
        else if upcase(symps[i]) = "NO" then symps[i] = 0;
    end;
run;

%macro logit_symptoms;

    %let symps = NO_SYMPTOM BURNING_SENSATION DRYNESS EXCESSIVE_DISCHARGE ODOROUS_DISCHARGE
                 EXTERNAL_ITCHINESS INTERNAL_ITCHINESS PAIN_WHILE_PEEING PAIN_WITH_SEX
                 VAGINA_PAIN VAGINAL_SWELLING VULVA_PAIN VULVA_REDNESS;

    %let i = 1;
    %do %while (%scan(&symps, &i) ne );
        %let var = %scan(&symps, &i);

        title "Adjusted OR for &var by Cohort";
        proc logistic data=model_data desc;
            class Cohort (ref="Never diagnosed") 
                  RACE (ref="WHITE") 
                  MENOPAUSE (ref="NO-MENOPAUSE") / param=ref;
            model &var(event='1') = Cohort AGE BMI RACE MENOPAUSE;

            lsmeans Cohort / diff oddsratio cl adjust=tukey;
        run;

        %let i = %eval(&i + 1);
    %end;

%mend logit_symptoms;

%logit_symptoms;



