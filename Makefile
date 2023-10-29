.PHONY: clean
.PHONY: .created-dirs

clean: .created-dirs
	rm -rf figures
	rm -rf derived_data

.created-dirs:
	mkdir -p figures
	mkdir -p derived_data
	
work/derived_data/rookie.csv: .created-dirs source_data/rookie.csv pre-process.R
	Rscript pre-process.R
	
work/figures/prop_plot.png work/figures/HOFbiplot.png work/figures/biplot_total.png: .created-dirs derived_data/clean.csv PCA.R
	Rscript PCA.R
