To enable widget such as sliders
jupyter nbextension enable --py --sys-prefix widgetsnbextension 
jupyter-nbextensions_configurator enable #Allows the user to config notebooks
jupyter serverextension enable --py jupyterlab --sys-prefix
jupyter lab "$@" --allow-root --NotebookApp.token=tensorchiefs
