.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs
	rm -rf report.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs

# Pre-processing data here
derived_data/clean.csv: .created-dirs pre-process.R source_data/rookie.csv
	Rscript pre-process.R

# Evaluating shape of data.
figures/exposure.png figures/aggregate.png figures/aggregate2.png figures/efficiency.png: .created-dirs derived_data/merged.csv boxplots.R
	Rscript boxplots.R

# PCA Analysis with traditional stats only
figures/prop_plot.png figures/HOFbiplot.png figures/biplot_total.png: .created-dirs derived_data/clean.csv PCA.R
	Rscript PCA.R

# Merging advanced stats from rookie year from different dataset	
derived_data/merged.csv: .created-dirs source_data/Advanced.csv derived_data/clean.csv merge.R
	Rscript merge.R
	
# Splitting merged dataset into testing and training datasets
derived_data/testing.csv derived_data/training.csv: .created-dirs derived_data/merged.csv trainortest.R
	Rscript trainortest.R

#Results of regression approaches
figures/coeftable.txt figures/cutoff.txt figures/f1score.txt figures/2x2.txt figures/compare.txt figures/fittingROC.png figures/predictingROC.png: .created-dirs derived_data/training.csv derived_data/testing.csv derived_data/merged.csv lasso.R
	Rscript lasso.R

report.pdf: .created-dirs figures/prop_plot.png figures/exposure.png figures/aggregate.png figures/aggregate2.png figures/efficiency.png figures/coeftable.txt figures/cutoff.txt figures/f1score.txt figures/2x2.txt figures/fittingROC.png figures/predictingROC.png report.rmd
	Rscript -e 'rmarkdown::render("report.rmd")'