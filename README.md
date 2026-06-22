# Household Size Analysis in the Philippines

Progetto di analisi di dati familiari, realizzato attraverso modelli lineari generalizzati in SAS.

## Autori

* Giovanni Giacomo Cerasoli
* Alessandro Ricchebono
* Matteo Tacchella

## Dataset e obiettivo

Il dataset è composto da **1.500 nuclei familiari** estratti da dati raccolti dalla Philippine Statistics Authority nel 2015.

L’obiettivo è studiare il numero di componenti familiari, escluso il capofamiglia, in relazione a fattori geografici, demografici e abitativi.

Le principali variabili sono:

```r
location
age
total
numLT5
roof
```

Sono inoltre state create due variabili categoriali:

```r
fascia   = classe di età del capofamiglia
numLT5   = numero di bambini sotto i 5 anni
```

## Analisi esplorativa

La variabile risposta `total` presenta:

```r
Mean = 3.68
Standard deviation = 2.35
Min = 0
Max = 16
```

Le principali evidenze descrittive mostrano che:

* circa il 70% delle famiglie non ha bambini sotto i 5 anni;
* la maggior parte dei nuclei ha un tetto realizzato con materiali prevalentemente resistenti;
* le famiglie più numerose sono più frequenti nella regione di Visayas;
* all’aumentare del numero di bambini sotto i 5 anni aumenta anche la numerosità del nucleo familiare.

## Modelli stimati

Sono stati confrontati tre modelli:

```r
Poisson
Poisson con trasformazione sqrt(total)
Normale con trasformazione sqrt(total)
```

Il confronto è stato effettuato attraverso:

* AIC;
* devianza;
* grafici dei residui;
* valutazione dei p-value delle covariate.

## Risultati principali

Il modello Poisson con trasformazione della variabile risposta mostra un miglioramento rispetto al modello Poisson standard.

```r
AIC Poisson               = 6144.61
AIC Poisson con radice    = 4047.62
AIC Normale con radice    = 2733.90
```

Le variabili che incidono maggiormente sulla numerosità familiare sono:

* fascia di età del capofamiglia;
* numero di bambini sotto i 5 anni;
* in misura minore, la tipologia di abitazione.

## Conclusioni

L’analisi mostra che la dimensione del nucleo familiare è associata soprattutto alla struttura demografica della famiglia, in particolare all’età del capofamiglia e alla presenza di bambini piccoli. I modelli generalizzati permettono di modellare in modo efficace una variabile di conteggio come `total`.

