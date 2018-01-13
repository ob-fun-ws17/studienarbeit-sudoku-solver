# studienarbeit-sudoku-solver ![Travis build status](https://travis-ci.org/ob-fun-ws17/studienarbeit-sudoku-solver.svg?branch=master)

This programm reads a specified file (using [this format](#format)) and evaluates the containing
sudoku grid. After successfull evaluation, the solution will be printed on __stdout__.


## Usage:

---

### Execute
To run the programm you can use ```stack exec studienarbeit-sudoku-solver-exe path/to/sudoku_file```. You can find some sample files in the __resources__ directory.

---

#### <a name="format"></a>File format
Sudoku files must have the following format:
* Each line represents a row in the sudoku grid
* A line contains characters __'1' to '9' or '.'__ if the value is unknown
* Each line ends with __'\n'__ and empty lines are not allowed

##### Example:

* Sudoku grid

|    |    |    |    |    |    |    |    |    |    |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|    |2   |    |    |    |    |1   |    |3   |8   |
|    |    |    |    |    |    |    |    |    |5   |
|    |    |7   |    |    |    |6   |    |    |    |
|    |    |    |    |    |    |    |    |1   |3   |
|    |    |9   |8   |1   |    |    |2   |5   |7   |
|    |3   |1   |    |    |    |    |8   |    |    |
|    |9   |    |    |8   |    |    |    |2   |    |
|    |    |5   |    |    |6   |9   |7   |8   |4   |
|    |4   |    |    |2   |5   |    |    |    |&nbsp;|

* File
```
2....1.38
........5
.7...6...
.......13
.981..257
31....8..
9..8...2.
.5..69784
4..25....
```

---

### Test
For performance tests simply run ```stack test```
