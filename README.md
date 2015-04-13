# .geo GMSH files proposal

Directory's organization is not completely defined due to specific
details of the fluid flows. However, the following criteria order is to be expected:

1. Kinematics description: Lagrangian, Eulerian, or ALE (fixed or dynamic mesh).
2. Fluid flow physics: currently, single- or two-phase.
3. Fluid flow regime: e.g., rotating disk flow (disk or sphere) and/or internal flow (Poiseuille), if single-phase; 
					  e.g., rising bubble flow, sessile drop, and/or microchannel flow, if two-phase.
4. Reference frame: FFR (fixed-frame reference) or MFR (moving-frame reference) simulations.
5. Geometry: hull's shapes and bubble shapes (several cases).
6. Boundary conditions: no-slip, free-slip, outflow, periodic, etc.

# Basilar mesh directory tree 

* 2D meshes
- singlePhase
- twoPhase
* 3D meshes
- singlePhase
- twoPhase

# Long-term goals

* Set out CAD-based meshes gathering the full capabilities of GMSH:
- Transfinite;
- Periodic;
- Layers and Recombination;
- Mesh algorithms;
