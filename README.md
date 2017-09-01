Proof-of-concept LTP-LTD simulations written in Kappa
=====================================================

Description
-----------

This is a proof-of-concept molecular model of synaptic plasticity
written in Kappa that contains the proteins calmodulin, PSD-95,
stargazin, Calcium-Calmodulin dependent kinase II (CaMII), PP3, I1 and
PP1. This model is presented with calcium stimuli of varying durations
and the synaptic strength in the model can be compared to the wild
type traces in Fig. 3 of Carlisle et al (2008), J. Physiol. 586.

![Stargazin bound to PSD-95 and the data of Carlisle et al (2008)](figs/stg-psd95.png)

How to run
----------

* Intall KaSim 4 from http://dev.executableknowledge.org/

* Run the script `run.R` from within R using `source("run.R")`
