# Biostatistical-informatics-Assignment-
There will be two assignments available in this section.
                                                               **Assignment 1**
**Background:**
This dataset (assignI.txt) consists of a group of cancer patients who have received one of two treatments (drug I or II). The dataset consists of the following variables:Age (at treatment start) (Years)Stage (at treatment start): Tumour Stage, I or IISex: Male or FemaleTreatment: Drug I or Drug II over six weeksOS: overall survival from treatment startOS status: 1 if the patient died, 0 if the patient was alive at last follow-upResponse: If the patient’s tumour had reduced at six weeks (responder), or if the patient’s tumour had not reduced (non-responder) Protein 1: a protein (as detected in blood at end of treatment ie six weeks)
                                                              
**Question 1:**
Summarise the compositionof thedata using a table and accompanying narrative (approximately one paragraph). There is no need  to use statistical testing to describe the data, only summary statistics required here.For each of the following state the mostsuitable or closest hypothesis (where appropriate), describe methods used and summarise results. Use tables and/orplots (where appropriate) within your answers.

**Question 2:**
We want to find outif there is a difference in patient composition between treatments.
2a: Is there a difference in patient age between those that received drug I and those that received drug II?
2b: Is there an association between the sex of the patient and the drug treatment that they received?
2c: Is there an association between the stage of the patient and the drug treatment that they received?

**Question 3:**
Next we want to examine which variables are associated with patient survival (use a non-parametric test)
3a: Isthere a difference in survival (OS) between Stage I and Stage II patients?
3b:Is there a difference in survival (OS) between male and female patients?
3c:Is there a difference in survival (OS) between patients receiving drug I and drug II?

**Question 4**:
Finally, we want to look at differences between patients who have responded and those that have not responded.
4a:Is there a difference in levels of protein 1 between patients who responded and those that did not respond to treatment? 
4b:Consider patientswho received drug I. Is there a difference in levels of protein 1 between patients who responded and those that did not respond to treatment?
4c:Consider patients who received drug II. Is there a difference in levels of protein 1 between patients who responded and those that did not respond to treatment?

                                                                  **Assignment 2**
 
**Background:**
This dataset (assignII2020.txt) consists  of a group of esophagealcancer patients,  who  have had surgery to  remove their tumour.  The dataset  consists  of the following variables:
Patient Id: Unique IDAge at Diagnosis:Years 
Barrett’sPrevious:Yes = previous diagnosisofBarrett’s esophagus  (see: https://gutscharity.org.uk/advice-and-information/conditions/barretts-oesophagus/) or No
Sex:Male or Female 
Grade:High Grade(well differentiatedie the  cancer cells look more likenormal cells), Low Grade(poorly  differentiated ie the cancer cells look abnormal).
Tumour Stage:1, 2 or 3(T1means the cancerhas not  grown too far, T2 indicates thatthe  cancerhas reachedthe muscle layer of the esophagealwall, T3means the cancerhas advanced beyondthe  outside  of the esophagus).
GeneA:Biomarker of interest (no units)
RFS:Recurrence-free survival, days (survival without local/non-local recurrenceor death) 
RFSevent: 0 or 1 (with 1 = event) 

**Question1:**
Summarise the composition  of the data using a table and accompanying narrative (approximately one  paragraph)There is no need  to use statistical testing to describe the data, only summary statistics required here.For the following, provide a description of methods,  summarise/interpret results, including plots  and/or table/s.

**Question 2:**
Use a non-parametric method  compare the survival (RFS) of patients  based on  a) Previous Barrett’sdiagnosis, b)Sex, c)Grade and d) Stage.

**Question 3**:
Using a semi-parametric method perform a univariate analysisfor each variable in the dataset with  respect to recurrence-freesurvival (assume linearity for continuous  variables).

**Question 4:**
Perform a full multivariate (semi-parametric) analysis for the samedataset  with respect to RFS.Question 5 Use a statistical method  to select the most  informative variables to produce  a final multivariate modelwith respect to RFS. Compare to the results in Qu 4.
