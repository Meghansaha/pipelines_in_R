<img src="images/readme_logo.png" alt="Making Data Pipelines in R: A Story From A Self Taught Perspective Resources and Materials on a black and gray blotchy background" style="max-" width="100%"/>

# **Resources for Making Data Pipelines in R**

<br><br>

## **Working with Directories in R** 

- If you'd like to learn more about the benefit to using project files, working with directories in R, and having project-oriented workflows, I highly recommend reading the entire second chapter of the online book [*What They Forgot to Teach You About R*](https://rstats.wtf/project-oriented-workflow.html) 

- The [`here` package](https://here.r-lib.org/) by [Kirill Müller](https://twitter.com/krlmlr) and [Jenny Bryan](https://jennybryan.org/about/)

- [*Using here With Markdown*](https://here.r-lib.org/articles/rmarkdown.html)

## **Validation/Cleaning** 

As admitted in the Making Data Pipelines in R Talk, I personally learned about the importance of ensuring that my data was clean and as expected by introducing data validation late in my journey. Consequently, I am absolutely not an expert in data validation and am still learning about it. The following resources helped me figure out what I needed to at the time, but are also on my to-do list to get back to and read more thoroughly.

### ***Specific Resources for Performing Data Validations in R***

- The [`validate` package](https://github.com/data-cleaning/validate) and The [*Data Validation Cookbook*](https://data-cleaning.github.io/validate/) by [Mark van der Loo](http://www.markvanderloo.eu/)

- [*A Lightweight Data Validation Ecosystem with R, GitHub, and Slack*](https://emilyriederer.netlify.app/post/data-valid-lightweight/) by [Emily Riederer](https://emilyriederer.netlify.app/about/)

- The [`data.validator` package](https://github.com/Appsilon/data.validator) by [Appsilon](https://appsilon.com/)


### ***Specific Resources for Cleaning Data in R***

- The [`janitor` package](https://github.com/sfirke/janitor) by [Sam Firke](http://samfirke.com/)

- Various Tidyverse Packages like:

    - [dplyr](https://dplyr.tidyverse.org/)
    
    - [stringr](https://stringr.tidyverse.org/)
    
    - [tidyr](https://tidyr.tidyverse.org/)
    
### ***General Resources for Data Validation***

- [*What is Data Validation and When Do You Do It?*](https://understandingdata.com/what-is-data-validation-and-where-do-you-validate-data/) by [James Phoenix](https://understandingdata.com/author/james-phoenix/)

- [*Methodology for Data Validation*](https://ec.europa.eu/eurostat/cros/system/files/methodology_for_data_validation_v1.0_rev-2016-06_final.pdf) by Zio et. al


## **Sustainability**
As mentioned in the Talk, sustainability can look like a lot of different things depending on the context of the pipeline. In my personal case, sustainability meant being able to not only document the pipeline, but also make the code human-readable to non-programmers through non-technical documents. The following are links to versions of my own personal documents I've used, as well as future readings for things that may be helpful when thinking about the sustainability of your pipeline in R. 

- The [`dataReporter` Package](https://github.com/ekstroem/dataMaid) (formerly known as dataMaid) by [Claus Ekstrøm](https://github.com/ekstroem) and [Anne Petersen](https://github.com/annennenne)  - Useful for generating codebooks and reports on your data.

- The [`flowr` Package](https://github.com/flow-r/flowr) by [Sahil Seth](https://github.com/sahilseth)- Useful for experimenting with visualizing workflows in R 

- [Codebook Template](examples/documents/codebook_template.docx) 

- [Workflow Reference](examples/documents/workflow_reference.pdf)

- [Data Map Template](examples/documents/map_template.pptx)
