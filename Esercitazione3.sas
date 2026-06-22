proc import 
datafile = "C:/Users/giova/Giogiò/Universita/Modelli Lineari/Philippines.txt"
out=dataset(rename=Var1=id rename=Var2=location rename=Var3=age rename=Var4=total rename=Var5=numLT5 rename=Var6=roof)
dbms=dlm
replace;
delimiter=',';
getnames=no;
run;

proc format;
value loc 1='CentralLuzon'
              2='DavaoRegion'
              3='IlocosRegion'
			  4='MetroManila'
			  5='Visayas';
run;
proc format;
value rf 1='Predominantly Light/Salvaged Material'
              2='Predominantly Strong Material';
run;

data dataset;
set dataset;
if age < 30 then fascia=1;
if 30 <= age < 45 then fascia=2;
if 45 <= age < 60 then fascia=3;
if 60 <= age < 75 then fascia=4;
if age >= 75 then fascia=5;
run;

proc format;
value fascia 1='<30'
              2='30-44'
              3='45-59'
			  4='60-74'
			  5='>=75';
run;

/*ANALISI DESCRITTIVA*/
proc freq data=dataset;
tables location numlt5 roof fascia;
format location loc.;
format roof rf.;
format fascia fascia.;
run; 

proc gchart data=dataset;
hbar roof / discrete;
hbar location / discrete;
hbar numlt5 / discrete;
hbar fascia / discrete;
format location loc.;
format roof rf.;
format fascia fascia.;
run;

proc means data=dataset;
var total;
run;

proc sort data=dataset;
by roof;
run;

proc boxplot data=dataset;
plot total*roof;
format roof rf.;
run; 

proc sort data=dataset;
by location;
run;

proc boxplot data=dataset;
plot total*location;
format location loc.;
run; 

proc sort data=dataset;
by fascia;
run;

proc boxplot data=dataset;
plot total*fascia;
format fascia fascia.;
run;

proc sort data=dataset;
by numlt5;
run;

proc boxplot data=dataset;
plot total*numlt5;
run; 

pattern1 c=red;
pattern2 c=blue;

proc gchart data=dataset;
	vbar total / group=roof discrete patternid=group;
format roof rf.;
run; 

proc gchart data=dataset;
	vbar total / group=fascia discrete patternid=group;
	format fascia fascia.;
run; 

proc gchart data=dataset;
	vbar total / group=location discrete patternid=group;
	format location loc.;
run; 

proc gchart data=dataset;
	vbar total / group=numlt5 discrete patternid=group;
run; 

/*MODELLI LINEARI GENERALIZZATI*/

/*Poisson*/
proc genmod data=dataset;
class location(ref="4") roof fascia numlt5;
model total = location roof fascia numlt5/ dist=poisson ;
output out=risultati pred=pre STDRESCHI=res_st; 
run;
proc gplot data=risultati; plot res_st*pre/vref=0; run;

/*Poisson con radice*/
data radice;
set dataset;
stotal=sqrt(total);
proc genmod data=radice;
class location(ref="4") roof fascia numlt5;
model stotal = location roof fascia numlt5/ dist=poisson ;
output out=risultati pred=pre STDRESCHI=res_st; run;
proc gplot data=risultati;
plot res_st*pre/vref=0; run;

/*Normale con radice*/
proc genmod data=radice;
class location(ref="4") roof fascia numlt5;
model stotal = location roof fascia numlt5/ dist=normal ;
output out=risultati pred=pre STDRESCHI=res_st; run;
proc gplot data=risultati;
plot res_st*pre/vref=0; run;

/*Normale con radice con interazioni*/
proc genmod data=radice;
class location(ref="4") roof fascia numlt5;
model stotal = location roof fascia numlt5 fascia*roof/ dist=normal ;
output out=risultati pred=pre STDRESCHI=res_st; run;
proc gplot data=risultati;
plot res_st*pre/vref=0; run;


