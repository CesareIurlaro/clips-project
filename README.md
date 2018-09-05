# CLIPS-project
This CLIPS project has been written for the exam of Artificial Intelligence Laboratory at the University of Turin.

# Project Description

The project consists in trying to meet the needs of various Italian cities wares (product type can be A, B, C).

For simplicity it is assumed that each of the cities produces and needs only one type of product.

The following image reports the methods of production and consumption of each city: 
<p align="center">
  <img src="https://github.com/CesareIurlaro/clips-project/blob/master/stuff/initCIties.PNG"/>
</p>

We have several vehicles available: 
- 5 *vans* with capacity 4
- 2 *aircraft* with capacity 7 
- 2 *ships* with capacity 11 
(where capacity is the maximum number of wares transportable from each vehicle).

Each vehicle is located in a prior known location: 
- 3 *vans* are in Bologna and 2 are in Rome
- 1 *ship* is in Genoa and the other is in Venice
- 1 *plane* is in Palermo, the other in Milan.


Each of the means can perform three basic actions: 
- *load* (take goods) 
- *unload* (drop goods) 
- *shift* (move between linked cities)

Each of these actions has a cost dependent on one or more parameters: 
- **loads and unloads**, the parameter is the *quantity of goods* that is treated by the action chosen, 
- **shifts**, the parameters are both the *vehicle type* that performs it and the *distance* between the two cities. 

The following are the functions used to calculate each cost:


<p align="center">
<img src="http://latex.codecogs.com/gif.latex?wares%5C_%5C%20cost%28quantity%29%20%3D%20quantity%20*%2010"/>
</p>


<p align="center">
  <img src="http://latex.codecogs.com/gif.latex?travel%5C_%5C%20cost%28type%2C%20distance%29%20%3D%20%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%20distance%2C%26%20%5C%3A%20if%20%5C%3A%20type%20%3D%20%22van%22%20%5C%5C%20%5Cfrac%7B2%7D%7B3%7Ddistance%2C%26%20%5C%3A%20if%20%5C%3A%20type%20%3D%20%22ship%22%20%5C%5C%20%5Cfrac%7B5%7D%7B4%7Ddistance%2C%26%20%5C%3A%20if%20%5C%3A%20type%20%3D%20%22plane%22%20%5C%5C%20%5Cend%7Bmatrix%7D%5Cright."/>
</p>

Some journeys are not viable by all means of transport and therefore not all cities are directly connected to each other.


The following image represents the routes that can be traveled with the various types of vehicles 
(can also be found in the legend):
<p align="center">
  <img src="https://github.com/CesareIurlaro/clips-project/blob/master/stuff/route.PNG"/>
</p>

The following image represents the crow flies distances between the different cities:
<p align="center">
  <img src="https://github.com/CesareIurlaro/clips-project/blob/master/stuff/crow_flies_distances.PNG"/>
</p>

# Project management

The project, contained within the 'A-star' folder, has been divided into three main parts:
- `alghorithm`, which contains all the CLIPS modules related to the algorithm used,
- `domain`, that contains functions, facts, rules and templates used specifically for the domain,
- `knowledge_bases`, that contains the knowledge bases used for the project.


There are also three other files necessary for the correct execution of the program.
They are:
- `loads`, which contains the instructions necessary to configure the execution environment
- `projectCosts`, on which they are saved progressively the partial costs of the solution
- `run`, used to open the CLIPS shell where to run the program.

To run the program open `run.bat` file (or use the tool **CLIPSIDE**) and type `(batch loads)` command .

# Planning Algorithm
The suggested algorithms for solving the problem have been **Iterative Deepening** and **A***. 
Both have been implemented and applied to perform the research on a graph in the space of the states.

**Iterative Deepening**: the algorithm proved to be unsuitable for the resolution of the problem, as it is unable to find a solution within a reasonable time. However, it was possible to make some observations:
drastically reducing the size of the problem it was possible to conclude the computation in a short time.
However, the addition of only a few facts to the knowledge base worsened of much the performances. 

His implementation is contained within the `no_evaluation_function` folder.

Because of this, we opted for the **A*** algorithm implementation.
**A*** This one has a better behavior than the previous algorithm, either because
- of the linear spatial complexity in the depth of the deepest optimal solution
- it is helped by a heuristic
**If the heuristic is admissible, then the algorithm is optimal.**

Despite this, **even A\* can not find a solution quickly.**

## Heuristic
We have implemented an **admissible heuristic**, which means that it is *never wrong for excess* and that it is *consistent* (or *monotonic*) for graph search applications. [Artificial Intelligence: A Modern Approach, S.J. Russel & P. Norvig]

Our heuristic associates to each node a cost that depends on the sum of:
- cost of operations (load or unload) on wares,
- cost of the journey as the crow flies in the case of a move.

The algorithm will choose the optimal path based on this heuristic.

## Sub-problems
To solve the non-termination due to the great complexity of the problem, it was necessary to divide it into several sub-problems, each of which deals with satisfying one of the previously mentioned cities.

The number of sub-problems into which the original problem has been divided appears to be
equal to the number of cities to be met; some of them were further subdivided in such a way as to contain the `branching factor`.

This has precluded the possibility of finding the optimal solution of the whole problem but it guaranteed us the optimality of the sub-solutions. Therefore, the solution proposed by us turns out to be sub-optimal.

# Modeling the problem
The problem was modeled using, in combination, both ordered facts and unordered facts, contained within the `templates.clp` file, with prevalence of the first kind. The reason for this is to be found in the varied number of constructs usable only with ordered facts made available by CLIPS itself.

Where we have not considered necessary such constructs, we used not ordered facts.

## The A* implementation in CLIPS
The A* implementation in the CLIPS language was done through the subdivision in the following modules:

- **Main**, which is responsible for instantiating the initial node and printing the total cost and the costs of the individual actions of the solution
- **Expand**, that ensures the aciclicity of the graph and that there is not more than one path that leads to equal open nodes. 
In case this was not respected, then the node of the most expensive path in terms of costs, is closed
- **Check**, which deals with checking whether within the various facts `status` the desired goal is contained
- **New**, that deals both with updating the statistics (closed, worse, better) related to the algorithm and with adding nodes to the path taken into consideration.


Basic data structures are needed to implement the A* algorithm. 
To realize them in CLIPS, ordered facts has been used.

They are:
- `node`, which represent the node currently examined
- `newnode`, which expand, after making a action, the new nodes
- `state`, which configure the environment through the a priori knowledge bases
- `status`, which maintain informations about cities and means of transport. 
A precise configuration of a state of the state space is represented by the set of ordered facts `status` having the same value as the `ident` slot.

For goal modeling purpose, an ordered fact called `goal` was used.
By necessity, two goals have been modeled: one concerning cities and the other concerning means of transport.

## Knowledge Bases
The knowledge bases contain the cities and the vehicles necessary for satisfaction of the various sub-elements. 
They are contained, as described above, in an ordered fact called `state`, which represents the **root** of the graph on which we perform the search in the states space.

## Modeling sub-problems
Our sub-problems were divided into:

**1. TO**: subgraph with Turin (TO), Rome (RM) and Palermo (PA). We meet Turin object A needs by plane (`vehicle_6`) which is located in PA.

**2. MI**: subgraph with Milan (MI), Rome (RM), Naples (NA), Bari (BA) and Reggio Calabria (RC). We meet Milan object A needs using two vans (`vehicle_4` and `vehicle_5`) which are located in RM and by plane (`vehicle_7`) located in MI. The original subproblem was divided into:

**- a.** Transfer of type A goods from RC to NA,
**- b.** Transfer of 10 A goods to MI,
**- c.** Transfer of remaining 20 A goods to MI.

**3. VE**: subgraph with Venice (VE) and Bologna (BO). We meet Venice object B needs by van (`vehicle_2`) located in BO. 

**4. GE**: subgraph with Genoa (GE), Turin (TO), Milan (MI) and Bologna (BO). We meet Genoa object B need by van (`vehicle_1`) located in BO. The original subproblem was divided into:

**- a.** Shift of van (`vehicle_1`) from BO to TO,
**- b.** Transfer of B goods with `vehicle_1` from TO to GE.

**5. BO**: subgraph with Bologna (BO) and Venice (VE). We meet Bologna object C needs by van (`vehicle_2`) located in VE. 

**6. RM**: subgraph with Rome (RM), Turin (TO) and Milan (MI). We meet Rome object C needs by plane (`vehicle_6`) which is located in TO. The original subproblem was divided into:

**- a.** Transfer of type C goods from MI to TO with van (`vehicle_3`),
**- b.** Transfer by plane (`vehicle_6`) of previously displaced goods from TO to RM

**7. NA_PA**: subgraph with Naples (NA), Palermo (PA) and Genoa (GE). We meet both Naples and Genoa object needs by ship (`vehicle_8`) which is located in GE.

**8. BA**: subgraph with Bari (BA), Milano (MI) and Bologna (BO). We meet Bari object B needs by van (`vehicle_3`) located in BO and by plane (`vehicle_7`) located in MI. The original subproblem was divided into:

**- a.** Transfer of type B goods from BO to MI with van (`vehicle_3`),
**- b.** Transfer by plane (`vehicle_7`) of previously displaced goods from MI to BA.

**9. RC**: subgraph with Reggio Calabria (RC) and Naples (NA). We meet Reggio Calabria object B needs by van (`vehicle_5`) located in NA.

## Domain actions
The domain actions are contained in the `domain_rules.clp` file. 
They have been modeled using the means of transport as the subject. They are:
- apply-load-prod
- exec-load-prod 
- load-prod_newnode

- apply-load-store
- exec-load-store
- load-store_newnode

- apply-unload-need
- exec-unload-need 
- unload-need_newnode

- apply-unload-store
- exec-unload-store
- unload-store_newnode

- apply-shift 
- exec-shift
- shift_newnode 

# Utilities
They are contained within the `utils` folder.

The **functions** are contained within the `functions.clp` file.
They are:
- `travel_cost_evaluation` calculates, given the means of transport used and the distance from travel, the cost of the shift
- `find_heuristic_costs` takes care of calculating the value of the heuristic used
- `string_comparator` compares two strings passed as parameters
- `prepare_string` produces a string that concatenates all of their `status` having the same value as the `ident` slot. 
The resulting string is representative of the configuration of that state.
- `sum_up_costs` is responsible for calculating the total cost of the solution and the costs of the sub-solutions.

The **rules** are contained within the `rules.clp` file, responsible of producing facts and performing calculations, supporting the calculation of the heuristic.

The `cf_distances.clp` file contains:
- `h_distance`, ordered fact which represents the crow flies distance; used for the calculation of the heuristic
- `distance`, not ordered facts which represents the crow flies distance that can actually be traveled and the specific means of transport which can be used to do it.

# Conclusions

## Authors

* **Cesare Iurlaro** - [CesareIurlaro](https://github.com/CesareIurlaro)
* **Giuseppe Gabbia**  - [beppe95](https://github.com/beppe95)
* **Lamberto Basti**  - [lamba92](https://github.com/lamba92)
