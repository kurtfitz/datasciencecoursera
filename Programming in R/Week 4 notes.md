## Week 4 notes

### The str function

- Considered the most important function in R
- "str" or structure. Used to show a compact summary of an R object.
- Well suited to displaying large lists with nested lists.
- Answers the question, "What's in this object."



### Simulation

#### Generating Random numbers

The following functions can be used to generate random numbers for doing simulations.

- rnorm: generate random Normal variables with a given mean and standard deviation
- dnorm
- pnorm
- rpois: 

Probability distribution functions usually have four functions associated with them. The functions are prefixed with a

- d: for density (of probability distribution)
- r: for random number generation
- p: for cumulative distribution
- q: for quantile function

Working with Normal distributions request using these four functions (dnorm, pnorm, qnorm, rnorm). All the functions require that you specify the mean and the standard deviation because this is what specifies the actual probability distribution. The default values for these parameters are a mean of 0 and standard deviation of 1.

It's important to set a random number seed with set.seed ensure reproducibility.



### Generating Random Numbers From a Linear Model





