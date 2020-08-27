# graphon
Matlab library for community detection in graphons

This code accompanies the paper "Modularity maximisation for community detection in graphons" by Florian Klimm, Nick S. Jones, and Michael T. Schaub.

## Prerequisites
- Matlab (tested for version R2020a)
- [GenLouvain](https://github.com/GenLouvain/GenLouvain) for community detection (tested for version 2.2)


## How-to

### Matlab
The code in the library allows you to construct synthetic graphons and use a modularity-maximisation algorithm to obtain community structure in them. It also has some examples of graphons estimated from empirical network data.

To reproduce the figures in the manuscript, see folder *paperReproduction* `<addr>`

The code to construct synthetic graphons is available in *graphonConstruction*

Some helper functions (e.g., for plotting) are under *helperFunctions*

### Mathematica

The Mathematica notebooks demonstrate how sliver optimisation can be used to derive analytical (or pseudo-analytical) expressions of the optimal community structure for some synthetic graphons.
