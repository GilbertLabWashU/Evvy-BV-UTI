## Intro

Helper scripts used to launch LEfSe docker container, run LEfSe, and plot results

- [LEfSe repo](https://github.com/SegataLab/lefse)
- [Docker instructions](https://github.com/biobakery/biobakery/wiki/lefse#2-lefse-condadockervm)


## Script descriptions
- `run_lefse_launcher.sh`: main driver script used to launch docker container & run workflow within the image
  - Command example: `./run_lefse_launcher.sh --input-list all-files.txt --lda-values 2.0,2.5,3.0 --output-root publication-data-and-figures`
    - `all-files.txt` should specify one input file path per line. Recommend relative paths, either in the current directory or a subdirectory. Input files are transposed from "Evvy_SampleAbundance_1.xlsx" & "Evvy_SampleAbundance_2.xlsx"
- `run_lefse_script.sh`: workflow script that runs within the container.
- `patched_plot_res.py`: patched version of the built-in plotting script; sets custom color scheme and tweaks default font sizes. Running this script directly is not recommended; use the wrapper instead.
- `patched_plot_res_wrapper.sh`: wrapper that follows the convention of other provided wrapper scripts within the container to set env vars and run the patched plotting script above.
- `rerun_patched_lefse_plots.sh`: utlity script provided for convenience; allows re-plotting of LEfSe data from a previous run of `run_lefse_launcher.sh` in the event that modifications are made to `patched_plot_res.py`. Run within the container.
  - Command example: `./rerun_patched_lefse_plots.sh /data/publication-data-and-figures rerun-prefix-`

## Notes
- Recommend making all scripts executable first using `chmod +x $SCRIPT`
- Workflow is set up to use `/data` as the working directory within the container. By default, the local working directory from which `run_lefse_launcher.sh` will be mounted as `/data` by default; this is configurable. 
- Docker image is `biobakery/lefse`
