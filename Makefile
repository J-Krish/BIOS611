.PHONY: clean

clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf .created-dirs

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	touch .created-dirs
	
derived_data/clean.csv: .created-dirs pre-process.R source_data/rookie.csv
	Rscript pre-process.R

figures/prop_plot.png figures/HOFbiplot.png figures/biplot_total.png: .created-dirs derived_data/clean.csv PCA.R
	Rscript PCA.R