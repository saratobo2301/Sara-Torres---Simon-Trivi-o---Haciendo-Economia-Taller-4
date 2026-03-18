
rename Round round
rename Team player
rename Playerscontributions contribution
rename PayoffsinthisGame payoff
replace round = round[_n-1] if missing(round)
keep if round >= 1 & round <= 10

*Parte 2.1.1

collapse (mean) avg_contribution = contribution, by(round)
list round avg_contribution
twoway (connected avg_contribution round, lcolor(navy) mcolor(navy) msymbol(circle)), xlabel(1(1)10) ylabel(0(5)55) xtitle("Periodo") ytitle("Contribucion Promedio") title("Contribucion Promedio por Periodo - Clase")

*Parte 2.2

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear
rename Contributions period
list

reshape long , i(period) j(city) string

egen avg_no_punishment = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

list Period avg_no_punishment
keep Period avg_no_punishment
save "no_punishment.dta", replace

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A16:Q26) firstrow clear
egen avg_punishment = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
keep Period avg_punishment
save "punishment.dta", replace

use "no_punishment.dta", clear
merge 1:1 Period using "punishment.dta"
drop _merge
list Period avg_no_punishment avg_punishment

clear
input period avg_no_punishment avg_punishment

1 10.6 10.6
2 8.5 11.6
3 7.9 11.9
4 6.8 12.3
5 7.0 12.7
6 6.2 13.1
7 5.5 13.2
8 5.1 13.8
9 4.8 14.0
10 3.7 14.6
end

list period avg_no_punishment avg_punishment
describe



*Parte 2.2.1

twoway (connected avg_no_punishment Period, lcolor(cranberry) mcolor(cranberry) msymbol(circle)) (connected avg_punishment Period, lcolor(navy) mcolor(navy) msymbol(square)), xlabel(1(1)10) ylabel(0(2)16) xtitle("Periodo") ytitle("Contribucion Promedio") title("Comparacion de contribuciones con y sin castigo") legend(label(1 "Sin castigo") label(2 "Con castigo"))

*Parte 2.2.2

clear
input str20 experimento str12 periodo double valor
"Sin castigo" "Periodo 1" 10.6
"Sin castigo" "Periodo 10" 3.7
"Con castigo" "Periodo 1" 10.6
"Con castigo" "Periodo 10" 14.6
end
graph bar valor, over(periodo) over(experimento) blabel(bar, format(%4.1f)) ytitle("Contribucion Promedio") title("Contribucion promedio en el primer y ultimo periodo")

*Parte 2.2.3

use "no_punishment.dta", clear
merge 1:1 Period using "punishment.dta"
drop _merge

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear

egen sd_p1 = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
list Period sd_p1 if Period == 1
list Period sd_p1 if Period == 10

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A16:Q26) firstrow clear
egen sd_p1 = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
list Period sd_p1 if Period == 1
list Period sd_p1 if Period == 10

*Parte 2.2.4

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear
egen avg_no_punishment = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

summarize avg_no_punishment if Period == 1
summarize avg_no_punishment if Period == 10

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A16:Q26) firstrow clear
egen avg_punishment = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

summarize avg_punishment if Period == 1
summarize avg_punishment if Period == 10

*Parte 2.2.5

*1 sin castigo

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear
egen mean_p1 = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
egen sd_p1 = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
egen min_p1 = rowmin(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
egen max_p1 = rowmax(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
list mean_p1 sd_p1 min_p1 max_p1 if Period == 1

*10 sin castigo

egen mean_p10 = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
egen sd_p10 = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
egen min_p10 = rowmin(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
egen max_p10 = rowmax(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
list mean_p10 sd_p10 min_p10 max_p10 if Period == 10

*1 con castigo

import excel "doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A16:Q26) firstrow clear

egen mean_p1 = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
egen sd_p1 = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
egen min_p1 = rowmin(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
egen max_p1 = rowmax(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 1
list mean_p1 sd_p1 min_p1 max_p1 if Period == 1

*10 con castigo

egen mean_p10 = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
egen sd_p10 = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
egen min_p10 = rowmin(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
egen max_p10 = rowmax(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne) if Period == 10
list mean_p10 sd_p10 min_p10 max_p10 if Period == 10


*Parte 2.3

* Ingresar los datos del Período 1 de las Figuras 2A y 3
* Cada fila es una ciudad (n=16)

input sin_castigo con_castigo
  14.1029  15.4118
  10.9545   9.4773
  12.7941  11.7500
  13.6875  15.0417
   9.5385   9.2115
  10.8421  10.7632
  11.0833  13.2283
  12.9643  16.0179
  10.8500  12.0500
  10.0000   9.8958
   8.2500   9.6905
   7.9583   6.1458
  10.9286  11.3214
   8.1364   5.8182
   8.9375   6.5469
   8.2250   7.8500
end

* Test t de dos muestras independientes (bilateral)
ttest sin_castigo == con_castigo, unpaired

* Ingresar los datos del Período 10 de las Figuras 2A y 3

input sin_castigo con_castigo
   5.2941  17.0147
   8.6818  10.0682
   6.9412  11.7059
   2.9792  15.1562
   7.5192   9.0962
   5.5592  11.5724
   3.7188  16.4565
   2.9464  16.8393
   4.0000  14.6833
   2.4000  14.8125
   3.8095  17.5119
   5.8750   6.6250
   2.3929  14.6964
   5.3636   6.2045
   1.3594   7.6250
   1.3000  15.8500
end

* Test t de dos muestras independientes (bilateral)
ttest sin_castigo == con_castigo, unpaired

