Data and code for:

Josefina Viejobueno, Berta de los Santos, Miguel Camacho-Sanchez, Ana Aguado, María Camacho, Sergio Miguel Salazar
**Phenotypic variability and genetic diversity of the pathogenic fungus _Macrophomina phaseolina__ from several hosts and host-specialization in strawberry**. Under review.

## Analysis on the virulence of *M. phaseolina*

Raw data on virulence is at `asdfa`. Run `code/1.models.r` to reproduce the models.
Panel **a** from Figure 4 in the manuscript was created with [code/DSR_plot.r](code/DSR_plot.r).

## Genetic analysis
### Phylogenetic analysis
Accession numbers from GenBank for the different species and genetic markers in _Macrophomina_ were scrapped from the most recent and comprensive phylogeny of _Macrophomina_, in Poudel et al. 2021 using `code/4.scrap_genbank_Poudel2021.r`and written to `data/intermediate/t1-Poudel2021.csv`.
A tidy object with all DNA sequences was produced after merging our sequencing data with Poudel et al. 2021 sequencing data using `code/5.create_tidy_seqs.r`, which produced an R object with the tidy sequence data: `data/intermediate/tidy_seqs.rds`.
Per locus DNA alignments were produced with DECIPHER using `code/6.create_dna_alignments.r` and written to phylip MSAs.
The individual MSAs were concatenated with AMAS (Borowiec 2016). Duplicated rows in the concatenated MSA were removed. Tree reconstruction was done with Maximum Likelihood in RAxML ("code/7.phyl_inference.txt") and with a Bayesian approach in BEAST.
The input DNA alignment for tree reconstructions are available for BEAST and RAxML.
The results from PartitionFinder are [here]().
Here are the outputs from BEAST and RAxML.
Here are the [best tree](``) from RAxML and the [maximum clade credibility tree]() from BEAST ().

Figure 2 with ML and Bayesian trees was generated withy `code/Fig2_plot_tree.r`

### Haplotype networks
The gene matrices used for the reconstruction of the haplotype networks are [here](/gene_matrices).

